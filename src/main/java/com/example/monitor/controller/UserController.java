package com.example.monitor.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.monitor.model.User;
import com.example.monitor.repository.UserRepository;
import com.example.monitor.service.UserService;

@Controller
@RequestMapping("/admin/users")
@PreAuthorize("hasRole('SUPERVISEUR')")
public class UserController {

	private final UserService userService;
	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public UserController(UserService userService, UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userService = userService;
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	@GetMapping
	public String listUsers(Model model) {
		try {
			// List<User> users = userService.findAllActiveUsers();
			List<User> users = userService.findAllUsers();
			model.addAttribute("users", users);
			model.addAttribute("totalUsers", userService.getTotalUsers());
			model.addAttribute("activeUsers", userService.getActiveUsersCount());
			return "admin/users";
		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement: " + e.getMessage());
			return "admin/users";
		}
	}

	// ✅ UNE SEULE MÉTHODE CREATE
	@PostMapping("/create")
	public String createUser(@RequestParam String username, @RequestParam String password,
			@RequestParam String nomComplet, @RequestParam String email, @RequestParam String role,
			@RequestParam(required = false) String caisseCode) {

		try {
			userService.createUser(username, password, nomComplet, email, role, caisseCode);
			return "redirect:/admin/users?success=created";
		} catch (Exception e) {
			return "redirect:/admin/users?error=create_failed";
		}
	}

	@PostMapping("/{id}/deactivate")
	public String deactivateUser(@PathVariable Long id) {
		try {
			userService.deactivateUser(id);
			return "redirect:/admin/users?success=deactivated";
		} catch (Exception e) {
			return "redirect:/admin/users?error=deactivate_failed";
		}
	}

	@PostMapping("/{id}/activate")
	public String activateUser(@PathVariable Long id) {
		try {
			userRepository.findById(id).ifPresent(user -> {
				user.setActif(true);
				userRepository.save(user);
			});
			return "redirect:/admin/users?success=activated";
		} catch (Exception e) {
			return "redirect:/admin/users?error=activate_failed";
		}
	}

	@PostMapping("/{id}/reset-password")
	public String resetPassword(@PathVariable Long id, @RequestParam String newPassword) {
		try {
			userService.resetUserPassword(id, newPassword);
			return "redirect:/admin/users?success=password_reset";
		} catch (Exception e) {
			return "redirect:/admin/users?error=password_reset_failed";
		}
	}

	@PostMapping("/update")
	public String updateUser(@RequestParam Long id, @RequestParam String nomComplet, @RequestParam String email,
			@RequestParam String role, @RequestParam(required = false) String caisseCode, @RequestParam boolean actif) {

		try {
			userRepository.findById(id).ifPresent(user -> {
				user.setNomComplet(nomComplet);
				user.setEmail(email);
				user.setRole(role);
				user.setCaisseCode(caisseCode);
				user.setActif(actif);
				userRepository.save(user);
			});
			return "redirect:/admin/users?success=updated";
		} catch (Exception e) {
			return "redirect:/admin/users?error=update_failed";
		}
	}
}