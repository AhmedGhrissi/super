package com.example.monitor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.service.EmailService;

@RestController
@RequestMapping("/api/test")
public class TestEmailController {

	@Autowired
	private EmailService emailService;

	// GET pour tester dans le navigateur
	@GetMapping("/email")
	public String testEmailGet() {
		try {
			emailService.envoyerTestEmail();
			return "✅ Email de test envoyé avec succès! Vérifie ta boîte mail.";
		} catch (Exception e) {
			return "❌ Erreur envoi email: " + e.getMessage()
					+ "\n🔧 Vérifie ta configuration SMTP dans application.yaml";
		}
	}

	// POST pour les appels programmatiques
	@PostMapping("/email")
	public String testEmailPost() {
		return testEmailGet();
	}

	@GetMapping("/email/config")
	public String checkEmailConfig() {
		try {
			boolean configOk = emailService.estConfigure();
			String destinataires = String.join(", ", emailService.getDestinataires());

			return "📧 Configuration Email:\n" + "• SMTP Configuré: " + configOk + "\n" + "• Destinataires: "
					+ destinataires + "\n" + "• Test: GET/POST /api/test/email";
		} catch (Exception e) {
			return "❌ Erreur configuration: " + e.getMessage();
		}
	}
}