package com.example.monitor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.service.AlertService;
import com.example.monitor.service.EmailService;
import com.example.monitor.service.ServeurStatsService;

@RestController
@RequestMapping("/api/alertes")
public class AlertController {

	@Autowired
	private AlertService alertService;

	@Autowired
	private ServeurStatsService serveurStatsService;

	@Autowired
	private EmailService emailService;

	@PostMapping("/verifier")
	public String declencherVerification() {
		try {
			alertService.declencherVerificationManuelle();
			return "🔍 Vérification des serveurs critiques déclenchée!";
		} catch (Exception e) {
			return "❌ Erreur: " + e.getMessage();
		}
	}

	@GetMapping("/statut")
	public String getStatutAlertes() {
		try {
			int serveursCritiques = serveurStatsService.getServeursAvecProblemes().size();
			return "🚨 Serveurs critiques: " + serveursCritiques;
		} catch (Exception e) {
			return "❌ Erreur: " + e.getMessage();
		}
	}

	@PostMapping("/test-email")
	public String testEmail() {
		try {
			// Simuler un serveur critique pour tester
			alertService.declencherVerificationManuelle();
			return "📧 Test d'alerte email déclenché! Vérifie tes emails.";
		} catch (Exception e) {
			return "❌ Erreur test email: " + e.getMessage();
		}
	}

	@PostMapping("/notifier-test-manuel")
	public String notifierTestManuel(@RequestParam String serveurNom, @RequestParam boolean succes) {
		try {
			System.out.println("🎯 === NOTIFIER TEST MANUEL ===");
			System.out.println("📝 Serveur: " + serveurNom);
			System.out.println("📝 Succès: " + succes);

			if (!succes) {
				System.out.println("🚨 ENVOI ALERTE CRITIQUE POUR: " + serveurNom);
				emailService.envoyerAlerteCritique(serveurNom, 50.0);
				System.out.println("✅ Alerte envoyée");
				return "🚨 Alerte envoyée pour " + serveurNom;
			}

			System.out.println("✅ Test réussi - Pas d'alerte");
			return "✅ Test réussi - Pas d'alerte nécessaire";

		} catch (Exception e) {
			System.err.println("❌ ERREUR: " + e.getMessage());
			e.printStackTrace();
			return "❌ Erreur: " + e.getMessage();
		}
	}
}