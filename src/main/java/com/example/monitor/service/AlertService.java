package com.example.monitor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.monitor.model.ServeurStatistiques;

@Service
public class AlertService {

	@Autowired
	private ServeurStatsService statsService;

	@Autowired
	private EmailService emailService;

	// Vérifier toutes les heures
	@Scheduled(cron = "0 0 * * * *") // Toutes les heures
	public void verifierServeursCritiques() {
		System.out.println("🔍 Vérification des serveurs critiques...");

		List<ServeurStatistiques> serveursCritiques = statsService.getServeursAvecProblemes();

		if (!serveursCritiques.isEmpty()) {
			System.out.println("🚨 " + serveursCritiques.size() + " serveurs critiques détectés");

			for (ServeurStatistiques serveur : serveursCritiques) {
				try {
					emailService.envoyerAlerteCritique(serveur.getServeurNom(),
							serveur.getDisponibilitePercentAsDouble());
					System.out.println("📧 Alerte envoyée pour: " + serveur.getServeurNom());
				} catch (Exception e) {
					System.err.println("❌ Erreur envoi alerte pour " + serveur.getServeurNom() + ": " + e.getMessage());
				}
			}

			// Rapport quotidien à 8h
			if (java.time.LocalTime.now().getHour() == 8) {
				try {
					int totalServeurs = statsService.findAllServeursStats().size();
					emailService.envoyerRapportQuotidien(serveursCritiques.size(), totalServeurs);
					System.out.println("📊 Rapport quotidien envoyé");
				} catch (Exception e) {
					System.err.println("❌ Erreur envoi rapport: " + e.getMessage());
				}
			}
		} else {
			System.out.println("✅ Aucun serveur critique détecté");
		}
	}

	// Méthode pour déclencher manuellement
	public void declencherVerificationManuelle() {
		System.out.println("🔍 Vérification manuelle déclenchée...");
		verifierServeursCritiques();
	}

	public void notifierTestServeurManuel(String serveurNom, boolean succes) {
		System.out.println("🎯 TEST MANUEL - " + serveurNom + " - " + (succes ? "SUCCÈS" : "ÉCHEC"));

		if (!succes) {
			System.out.println("🚨 ENVOI ALERTE MANUELLE POUR: " + serveurNom);
			try {
				emailService.envoyerAlerteCritique(serveurNom, 50.0);
				System.out.println("📧 Alerte manuelle envoyée pour: " + serveurNom);
			} catch (Exception e) {
				System.err.println("❌ Erreur alerte manuelle: " + e.getMessage());
			}
		}
	}
}