package com.example.monitor.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.User;
import com.example.monitor.repository.UserRepository;

@Service
@Transactional
public class PasswordResetService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public PasswordResetService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	public String resetAllPasswords() {
		StringBuilder result = new StringBuilder();
		result.append("🔧 RÉINITIALISATION DES MOTS DE PASSE\n\n");

		String rawPassword = "Monitor123!";

		List<User> users = userRepository.findAll();
		if (users.isEmpty()) {
			return "❌ Aucun utilisateur trouvé dans la base de données";
		}

		for (User user : users) {
			String oldPassword = user.getPassword();
			String newPasswordHash = passwordEncoder.encode(rawPassword);

			user.setPassword(newPasswordHash);
			userRepository.save(user);

			result.append("✅ ").append(user.getUsername()).append("\n   Ancien: ").append(oldPassword)
					.append("\n   Nouveau: ").append(newPasswordHash).append("\n\n");
		}

		result.append("🎯 MAINTENANT TESTE LA CONNEXION AVEC:\n");
		result.append("👉 Utilisateur: admin\n");
		result.append("👉 Mot de passe: Monitor123!\n");

		return result.toString();
	}
}