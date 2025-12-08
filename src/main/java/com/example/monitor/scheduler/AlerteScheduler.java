package com.example.monitor.scheduler;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.monitor.model.Alert;
import com.example.monitor.model.enums.CriticiteAlerte;
import com.example.monitor.repository.AlertRepository;
import com.example.monitor.service.ServeurService;
import com.example.monitor.service.TestService;

@Component
public class AlerteScheduler {

	@Autowired
	private AlertRepository alertRepository;

	@Autowired
	private ServeurService serveurService;

	@Autowired
	private TestService testService;

	/**
	 * Vérifier les problèmes toutes les 5 minutes
	 */
	@Scheduled(fixedRate = 300000) // 5 minutes
	public void verifierProblemes() {
		System.out.println("🔍 Vérification automatique des problèmes...");

		try {
			// 1. Vérifier les serveurs hors ligne
			verifierServeursHorsLigne();

			// 2. Vérifier les tests en échec
			verifierTestsEnEchec();

		} catch (Exception e) {
			System.err.println("❌ Erreur vérification automatique: " + e.getMessage());
		}
	}

	private void verifierServeursHorsLigne() {
		try {
			// Récupérer les serveurs avec statut
			var serveurs = serveurService.getServeursAvecStatut();

			for (var serveur : serveurs) {
				String statut = (String) serveur.get("statut");
				String criticite = (String) serveur.get("criticite");

				if ("CRITICAL".equals(criticite)) {
					// Vérifier si une alerte existe déjà pour ce serveur
					String nomServeur = (String) serveur.get("nom");

					// Méthode alternative : chercher des alertes non résolues pour ce serveur
					List<Alert> alertesExistantes = alertRepository.findByServeurCibleAndResolueFalse(nomServeur);

					if (alertesExistantes.isEmpty()) {
						// Créer une alerte
						Alert alerte = new Alert();
						alerte.setTitre("Serveur hors ligne: " + nomServeur);
						alerte.setDescription("Le serveur " + nomServeur + " est en statut " + statut);
						alerte.setCriticite(CriticiteAlerte.CRITICAL);
						alerte.setTypeAlerte("serveur");
						alerte.setServeurCible(nomServeur);
						alerte.setDateCreation(LocalDateTime.now());
						alerte.setResolue(false);

						alertRepository.save(alerte);
						System.out.println("⚠️ Alerte créée pour serveur: " + nomServeur);
					}
				}
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur vérification serveurs: " + e.getMessage());
		}
	}

	private void verifierTestsEnEchec() {
		try {
			long testsEchoues = testService.countTestsEchoues();

			if (testsEchoues > 5) { // Seuil configurable
				// Vérifier si une alerte existe déjà pour les tests en échec
				List<Alert> alertesExistantes = alertRepository.findByTitreContainingAndResolueFalse("Tests en échec");

				if (alertesExistantes.isEmpty()) {
					Alert alerte = new Alert();
					alerte.setTitre("Tests en échec: " + testsEchoues + " échecs");
					alerte.setDescription(testsEchoues + " tests ont échoué aujourd'hui");
					alerte.setCriticite(CriticiteAlerte.WARNING);
					alerte.setTypeAlerte("test");
					alerte.setServeurCible("SYSTEME");
					alerte.setDateCreation(LocalDateTime.now());
					alerte.setResolue(false);

					alertRepository.save(alerte);
					System.out.println("⚠️ Alerte créée pour tests en échec: " + testsEchoues);
				}
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur vérification tests: " + e.getMessage());
		}
	}
}