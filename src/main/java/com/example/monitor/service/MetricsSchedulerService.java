package com.example.monitor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class MetricsSchedulerService {

	@Autowired
	private MetricsService metricsService;

	/**
	 * Mise à jour périodique des métriques toutes les 5 minutes (synchronisé avec
	 * le cache des alertes)
	 */
	@Scheduled(fixedRate = 300000)
	public void updateMetricsPeriodically() {
		try {
			System.out.println("⏰ Mise à jour périodique des métriques...");
			metricsService.updateAllMetrics();
		} catch (Exception e) {
			System.err.println("❌ Erreur mise à jour périodique métriques: " + e.getMessage());
		}
	}

	/**
	 * Reset des compteurs quotidiens à minuit
	 */
	@Scheduled(cron = "0 0 0 * * *")
	public void resetDailyCounters() {
		try {
			System.out.println("🔄 Reset des compteurs quotidiens des métriques");
			// Logique de reset si nécessaire
		} catch (Exception e) {
			System.err.println("❌ Erreur reset compteurs: " + e.getMessage());
		}
	}
}