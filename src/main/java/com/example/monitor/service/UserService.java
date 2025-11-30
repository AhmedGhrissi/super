package com.example.monitor.service;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.User;
import com.example.monitor.repository.UserRepository;

@Service
@Transactional
public class UserService implements UserDetailsService {

	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public UserService(UserRepository userRepository, @Lazy PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepository.findByUsernameAndActifTrue(username).orElseThrow(() -> {
			return new UsernameNotFoundException("Utilisateur non trouvé: " + username);
		});

		logger.info("Connexion de l'utilisateur: {} - Role: {}", username, user.getRole());

		// Mettre à jour la dernière connexion
		user.setDateDerniereConnexion(LocalDateTime.now());
		userRepository.save(user);

		List<GrantedAuthority> authorities = Collections
				.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole()));

		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
				authorities);
	}

	public User createUser(String username, String plainPassword, String nomComplet, String email, String role,
			String caisseCode) {

		if (userRepository.existsByUsername(username)) {
			throw new RuntimeException("L'utilisateur existe déjà: " + username);
		}

		User user = new User();
		user.setUsername(username);
		user.setPassword(passwordEncoder.encode(plainPassword));
		user.setNomComplet(nomComplet);
		user.setEmail(email);
		user.setRole(role);
		user.setCaisseCode(caisseCode);
		user.setActif(true);

		User savedUser = userRepository.save(user);
		logger.info("Utilisateur créé: {} - Role: {}", username, role);

		return savedUser;
	}

	public Optional<User> findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	public List<User> findAllActiveUsers() {
		return userRepository.findByActifTrue();
	}

	public List<User> findAllUsers() {
		return userRepository.findAll(); // Renvoie TOUS les utilisateurs
	}

	public List<User> findUsersByCaisse(String caisseCode) {
		return userRepository.findByCaisseCode(caisseCode);
	}

	public void deactivateUser(Long userId) {
		userRepository.findById(userId).ifPresent(user -> {
			user.setActif(false);
			userRepository.save(user);
			logger.info("Utilisateur désactivé: {}", user.getUsername());
		});
	}

	public boolean changePassword(String username, String oldPassword, String newPassword) {
		return userRepository.findByUsername(username).map(user -> {
			if (passwordEncoder.matches(oldPassword, user.getPassword())) {
				user.setPassword(passwordEncoder.encode(newPassword));
				userRepository.save(user);
				logger.info("Mot de passe changé pour: {}", username);
				return true;
			}
			return false;
		}).orElse(false);
	}

	public void resetUserPassword(Long userId, String newPassword) {
		userRepository.findById(userId).ifPresent(user -> {
			user.setPassword(passwordEncoder.encode(newPassword));
			userRepository.save(user);
			logger.info("Mot de passe réinitialisé pour: {}", user.getUsername());
		});
	}

	public long getTotalUsers() {
		return userRepository.count();
	}

	public long getActiveUsersCount() {
		return userRepository.findByActifTrue().size();
	}
}