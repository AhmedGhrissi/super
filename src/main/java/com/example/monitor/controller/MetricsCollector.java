package com.example.monitor.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.monitor.service.AlertService;
import com.example.monitor.service.CaisseService;
import com.example.monitor.service.MetricsService;
import com.example.monitor.service.ServeurService;
import com.example.monitor.service.TestService;

@Service
public class MetricsCollector {

	@Autowired
	private AlertService alertService;

	@Autowired
	private MetricsService metricsService;

	@Autowired
	private ServeurService serveurService;

	@Autowired
	private TestService testService;

	@Autowired
	private CaisseService caisseService;

	@Scheduled(fixedRate = 300000) // Toutes les 5 minutes
	public void collectAndUpdateAllMetrics() {
		try {
			System.out.println("📊 Collecte et mise à jour des métriques...");

			// 1. Collecter les données
			Map<String, Integer> alertStats = alertService.getStatsAlertes();
			long testsEnErreur = alertService.getTestsEnErreurCount();
			double disponibilite = serveurService.calculerTauxDisponibilite();
			long caissesActives = caisseService.countActiveCaisses();
			long activeTests = testService.countActiveTests();
			double tauxReussite = testService.getTauxReussiteGlobal();
			long tempsReponseMoyen = testService.getTempsReponseMoyenAujourdhui();

			// 2. Extraire les valeurs des alertStats
			int alertesActives = 0;
			int alertesCritiques = 0;

			if (alertStats != null) {
				alertesActives = alertStats.getOrDefault("total", 0);
				alertesCritiques = alertStats.getOrDefault("critical", 0);
			}

			// 3. Mettre à jour MetricsService
			metricsService.updateAlertesMetrics(alertesActives, (int) testsEnErreur, alertesCritiques);

			// 4. Mettre à jour les autres métriques
			metricsService.setDisponibilite(disponibilite);
			metricsService.updateMetrics(caissesActives, activeTests, tauxReussite, tempsReponseMoyen);

			System.out.println("✅ Métriques collectées avec succès");

		} catch (Exception e) {
			System.err.println("❌ Erreur collecte métriques: " + e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * Mise à jour rapide des métriques (toutes les minutes)
	 */
	@Scheduled(fixedRate = 60000)
	public void updateQuickMetrics() {
		try {
			// Mettre à jour les métriques essentielles rapidement
			metricsService.updateAllMetrics();
		} catch (Exception e) {
			System.err.println("❌ Erreur mise à jour rapide: " + e.getMessage());
		}
	}
}