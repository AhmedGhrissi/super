package com.example.monitor.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.service.PasswordResetService;

@RestController
public class TempController {

	private final PasswordResetService passwordResetService;

	public TempController(PasswordResetService passwordResetService) {
		this.passwordResetService = passwordResetService;
	}

	@GetMapping("/reset-passwords")
	public String resetPasswords() {
		passwordResetService.resetAllPasswords();
		return "✅ Mots de passe réinitialisés à 'Monitor123!'";
	}
}