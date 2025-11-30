package com.example.monitor.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.service.TestService;

@RestController
@RequestMapping("/api/grafana")
public class GrafanaController {

	private final TestService testService;

	public GrafanaController(TestService testService) {
		this.testService = testService;
	}

	@GetMapping("/metrics")
	public ResponseEntity<Map<String, Object>> getGrafanaMetrics() {
		try {
			Map<String, Object> metrics = new HashMap<>();
			Map<String, Object> indicators = testService.getPerformanceIndicators();

			// Métriques de base
			metrics.put("timestamp", System.currentTimeMillis());
			metrics.put("disponibilite", safeGetDouble(indicators, "disponibilite"));
			metrics.put("taux_reussite", safeGetDouble(indicators, "tauxReussite"));
			metrics.put("temps_reponse_moyen", safeGetLong(indicators, "tempsReponseMoyen"));
			metrics.put("tests_actifs", safeGetLong(indicators, "testsActifs"));
			metrics.put("caisses_actives", safeGetLong(indicators, "caissesActives"));
			metrics.put("statut_global", safeGetString(indicators, "statutGlobal"));

			// Métriques additionnelles
			metrics.put("total_tests", safeGetLong(indicators, "totalTestsAujourdhui"));
			metrics.put("tests_reussis", safeGetLong(indicators, "testsReussisAujourdhui"));
			metrics.put("tests_echoues", safeGetLong(indicators, "testsEchouesAujourdhui"));

			return ResponseEntity.ok(metrics);

		} catch (Exception e) {
			Map<String, Object> error = new HashMap<>();
			error.put("error", "Erreur lors de la récupération des métriques");
			error.put("message", e.getMessage());
			error.put("timestamp", System.currentTimeMillis());
			return ResponseEntity.status(500).body(error);
		}
	}

	@GetMapping("/advanced-metrics")
	public ResponseEntity<Map<String, Object>> getAdvancedMetrics() {
		try {
			Map<String, Object> metrics = new HashMap<>();
			Map<String, Object> indicators = testService.getPerformanceIndicators();

			// Métriques de base
			metrics.put("timestamp", System.currentTimeMillis());
			metrics.put("application", "machine-monitor");
			metrics.put("version", "1.0.0");
			metrics.put("environment", "production");

			// Métriques de performance pour Grafana
			Map<String, Object> metricsData = new HashMap<>();
			metricsData.put("disponibilite", Map.of("value", safeGetDouble(indicators, "disponibilite"), "unit", "%"));
			metricsData.put("taux_reussite", Map.of("value", safeGetDouble(indicators, "tauxReussite"), "unit", "%"));
			metricsData.put("temps_reponse_moyen",
					Map.of("value", safeGetLong(indicators, "tempsReponseMoyen"), "unit", "ms"));
			metricsData.put("tests_actifs", Map.of("value", safeGetLong(indicators, "testsActifs"), "unit", "count"));
			metricsData.put("caisses_actives",
					Map.of("value", safeGetLong(indicators, "caissesActives"), "unit", "count"));
			metricsData.put("total_tests",
					Map.of("value", safeGetLong(indicators, "totalTestsAujourdhui"), "unit", "count"));
			metricsData.put("tests_reussis",
					Map.of("value", safeGetLong(indicators, "testsReussisAujourdhui"), "unit", "count"));
			metricsData.put("tests_echoues",
					Map.of("value", safeGetLong(indicators, "testsEchouesAujourdhui"), "unit", "count"));

			metrics.put("metrics", metricsData);

			// Statuts
			Map<String, Object> statusData = new HashMap<>();
			statusData.put("global", safeGetString(indicators, "statutGlobal"));
			statusData.put("temps_reponse", safeGetString(indicators, "statutTempsReponse"));
			statusData.put("health", "UP");

			metrics.put("status", statusData);

			// Timestamps
			Map<String, Object> timestampsData = new HashMap<>();
			timestampsData.put("generation", System.currentTimeMillis());
			timestampsData.put("derniere_verification", safeGetString(indicators, "derniereVerification"));

			metrics.put("timestamps", timestampsData);

			return ResponseEntity.ok(metrics);

		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(Map.of("error", "Erreur lors de la récupération des métriques avancées", "message",
							e.getMessage(), "timestamp", System.currentTimeMillis()));
		}
	}

	@GetMapping("/health")
	public ResponseEntity<Map<String, Object>> getHealthStatus() {
		Map<String, Object> health = new HashMap<>();
		health.put("status", "UP");
		health.put("timestamp", System.currentTimeMillis());
		health.put("version", "1.0.0");
		health.put("service", "Machine Monitor");
		return ResponseEntity.ok(health);
	}

	@GetMapping("/test")
	public ResponseEntity<Map<String, Object>> testEndpoint() {
		Map<String, Object> response = new HashMap<>();
		response.put("message", "API Grafana fonctionnelle");
		response.put("timestamp", LocalDateTime.now().toString());
		response.put("status", "OK");
		return ResponseEntity.ok(response);
	}

	// Méthodes utilitaires pour éviter les NullPointerException
	private Double safeGetDouble(Map<String, Object> map, String key) {
		Object value = map.get(key);
		if (value instanceof Number) {
			return ((Number) value).doubleValue();
		}
		return 0.0;
	}

	private Long safeGetLong(Map<String, Object> map, String key) {
		Object value = map.get(key);
		if (value instanceof Number) {
			return ((Number) value).longValue();
		}
		return 0L;
	}

	private String safeGetString(Map<String, Object> map, String key) {
		Object value = map.get(key);
		return value != null ? value.toString() : "N/A";
	}
}