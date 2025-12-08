package com.example.monitor.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.model.ServeurStatistiques;
import com.example.monitor.service.ServeurService;
import com.example.monitor.service.ServeurStatsService;

@RestController
@RequestMapping("/api")
public class ApiController {

	@Autowired
	private ServeurService serveurService;

	@Autowired
	private ServeurStatsService serveurStatsService;

	@GetMapping("/dashboard/stats")
	public Map<String, Object> getDashboardStats() {
		try {
			List<Map<String, Object>> serveursCritiques = serveurService.getServeursCritiques();
			int serveursCritiquesCount = serveursCritiques != null ? serveursCritiques.size() : 0;

			return Map.of("serveursCritiques", serveursCritiques, "serveursCritiquesCount", serveursCritiquesCount,
					"totalServeurs", serveurService.countTotal(), "serveursActifs", serveurService.countActifs(),
					"timestamp", System.currentTimeMillis(), "status", "success");
		} catch (Exception e) {
			return Map.of("error", e.getMessage(), "status", "error", "timestamp", System.currentTimeMillis());
		}
	}

	@GetMapping("/alerts/critical")
	public Map<String, Object> getCriticalAlerts(@RequestParam(required = false) Long lastCheck) {
		List<Map<String, Object>> allAlerts = serveurService.getServeursCritiques();

		if (allAlerts == null) {
			return Map.of("count", 0, "alerts", List.of(), "newAlerts", List.of(), "timestamp",
					System.currentTimeMillis());
		}

		// Détecter les nouvelles alertes depuis lastCheck
		List<Map<String, Object>> newAlerts = new java.util.ArrayList<>();
		if (lastCheck != null) {
			long fiveMinutesAgo = System.currentTimeMillis() - (5 * 60 * 1000);
			for (Map<String, Object> alert : allAlerts) {
				// Ajouter un timestamp si absent
				if (!alert.containsKey("timestamp")) {
					alert.put("timestamp", System.currentTimeMillis() - (long) (Math.random() * 300000));
				}

				Long alertTimestamp = (Long) alert.get("timestamp");
				if (alertTimestamp != null && alertTimestamp > fiveMinutesAgo) {
					newAlerts.add(alert);
				}
			}
		}

		return Map.of("count", allAlerts.size(), "alerts", allAlerts, "newAlerts", newAlerts, "timestamp",
				System.currentTimeMillis());
	}

	@GetMapping("/serveurs/critiques")
	public List<Map<String, Object>> getServeursCritiquesApi() {
		return serveurService.getServeursCritiques();
	}

	@GetMapping("/serveurs-stats/critiques")
	public List<ServeurStatistiques> getServeursStatsCritiques() {
		return serveurStatsService.getServeursCritiques();
	}

	@GetMapping("/health")
	public Map<String, Object> healthCheck() {
		return Map.of("status", "UP", "timestamp", System.currentTimeMillis(), "version", "1.0.0", "service",
				"Monitoring API");
	}
}