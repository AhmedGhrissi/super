package com.example.monitor.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.atomic.AtomicReference;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.example.monitor.repository.ResultatsTestsRepository;
import com.example.monitor.repository.TestRepository;

import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Timer;

@Service
public class MetricsService {

	private final Counter testsExecutesCounter;
	private final Counter testsReussisCounter;
	private final Counter testsEchouesCounter;
	private final Timer testDurationTimer;

	// Métriques pour alertes
	private final Counter alertesCritiquesCounter;
	private final Counter alertesTotalCounter;
	private final AtomicInteger alertesActivesGauge;
	private final AtomicLong testsEnErreur24hGauge;
	private final AtomicInteger serveursCritiquesGauge;

	// Métriques existantes
	private final AtomicLong disponibiliteGauge = new AtomicLong(100);
	private final AtomicInteger statutApplication = new AtomicInteger(1);
	private final Counter requetesHttpTotal;
	private final AtomicReference<Double> tauxReussiteRef = new AtomicReference<>(100.0);
	private final AtomicLong activeCaissesGauge = new AtomicLong(0);
	private final AtomicLong activeTestsGauge = new AtomicLong(0);
	private final AtomicLong tempsReponseMoyenGauge = new AtomicLong(0);

	// Pour stocker les métriques par type et criticité
	private final Map<String, AtomicInteger> alertesParType = new HashMap<>();
	private final Map<String, AtomicInteger> alertesParCriticite = new HashMap<>();

	// Injections pour les services
	@Autowired(required = false)
	@Lazy
	private AlertService alertService;

	@Autowired(required = false)
	@Lazy
	private ServeurService serveurService;

	@Autowired(required = false)
	@Lazy
	private TestService testService;

	@Autowired(required = false)
	@Lazy
	private CaisseService caisseService;

	@Autowired
	private ResultatsTestsRepository resultatsRepository;

	@Autowired
	private TestRepository testRepository;

	public MetricsService(MeterRegistry registry) {
		// Counters existants
		this.testsExecutesCounter = Counter.builder("monitor_tests_executes_total")
				.description("Nombre total de tests exécutés").register(registry);

		this.testsReussisCounter = Counter.builder("monitor_tests_reussis_total")
				.description("Nombre total de tests réussis").register(registry);

		this.testsEchouesCounter = Counter.builder("monitor_tests_echoues_total")
				.description("Nombre total de tests échoués").register(registry);

		// Timer
		this.testDurationTimer = Timer.builder("monitor_test_duration_seconds")
				.description("Durée d'exécution des tests").register(registry);

		// Nouvelles métriques pour Grafana
		this.requetesHttpTotal = Counter.builder("monitor_http_requests_total").description("Total des requêtes HTTP")
				.register(registry);

		// Métriques pour alertes
		this.alertesCritiquesCounter = Counter.builder("monitor_alertes_critiques_total")
				.description("Nombre total d'alertes critiques générées").register(registry);

		this.alertesTotalCounter = Counter.builder("monitor_alertes_total")
				.description("Nombre total d'alertes générées").register(registry);

		// Gauges pour l'état actuel
		this.alertesActivesGauge = new AtomicInteger(0);
		Gauge.builder("monitor_alertes_actives", alertesActivesGauge, AtomicInteger::get)
				.description("Nombre d'alertes actives").register(registry);

		this.testsEnErreur24hGauge = new AtomicLong(0);
		Gauge.builder("monitor_tests_en_erreur_24h", testsEnErreur24hGauge, AtomicLong::get)
				.description("Nombre de tests en erreur (24h)").register(registry);

		this.serveursCritiquesGauge = new AtomicInteger(0);
		Gauge.builder("monitor_serveurs_critiques", serveursCritiquesGauge, AtomicInteger::get)
				.description("Nombre de serveurs en état critique").register(registry);

		// Initialiser les métriques par type
		initAlertesParType(registry);
		initAlertesParCriticite(registry);

		// Gauges avec Supplier
		Gauge.builder("monitor_taux_reussite_pourcent", tauxReussiteRef, ref -> ref.get() != null ? ref.get() : 100.0)
				.description("Taux de réussite en temps réel").register(registry);

		// Gauges avec AtomicLong
		Gauge.builder("monitor_application_up", statutApplication, AtomicInteger::get)
				.description("État de l'application (1=UP, 0=DOWN)").register(registry);

		Gauge.builder("monitor_disponibilite_pourcent", disponibiliteGauge, AtomicLong::get)
				.description("Disponibilité de l'application en %").register(registry);

		Gauge.builder("monitor_caisses_actives", activeCaissesGauge, AtomicLong::get)
				.description("Nombre de caisses actives").register(registry);

		Gauge.builder("monitor_tests_actifs", activeTestsGauge, AtomicLong::get).description("Nombre de tests actifs")
				.register(registry);

		Gauge.builder("monitor_temps_reponse_moyen_ms", tempsReponseMoyenGauge, AtomicLong::get)
				.description("Temps de réponse moyen en millisecondes").register(registry);
	}

	private void initAlertesParType(MeterRegistry registry) {
		String[] types = { "test", "serveur", "statistique" };
		for (String type : types) {
			AtomicInteger counter = new AtomicInteger(0);
			alertesParType.put(type, counter);
			Gauge.builder("monitor_alertes_type_" + type, counter, AtomicInteger::get)
					.description("Alertes de type " + type).register(registry);
		}
	}

	private void initAlertesParCriticite(MeterRegistry registry) {
		String[] criticites = { "critical", "warning", "info" };
		for (String criticite : criticites) {
			AtomicInteger counter = new AtomicInteger(0);
			alertesParCriticite.put(criticite, counter);
			Gauge.builder("monitor_alertes_criticite_" + criticite, counter, AtomicInteger::get)
					.description("Alertes avec criticité " + criticite).register(registry);
		}
	}

	// ========== MÉTHODES EXISTANTES ==========

	public void incrementTestsExecutes() {
		testsExecutesCounter.increment();
		updateTauxReussite();
	}

	public void incrementTestsReussis() {
		testsReussisCounter.increment();
		updateTauxReussite();
	}

	public void incrementTestsEchoues() {
		testsEchouesCounter.increment();
		updateTauxReussite();
	}

	public void recordTestDuration(long durationMs) {
		testDurationTimer.record(durationMs, TimeUnit.MILLISECONDS);
	}

	public void incrementHttpRequests() {
		requetesHttpTotal.increment();
	}

	public void setDisponibilite(double disponibilite) {
		disponibiliteGauge.set((long) disponibilite);
	}

	public void setApplicationUp(boolean up) {
		statutApplication.set(up ? 1 : 0);
	}

	public void updateMetrics(long caissesActives, long testsActifs, double tauxReussite, long tempsReponseMoyen) {
		activeCaissesGauge.set(caissesActives);
		activeTestsGauge.set(testsActifs);
		tauxReussiteRef.set(tauxReussite);
		tempsReponseMoyenGauge.set(tempsReponseMoyen);
	}

	private void updateTauxReussite() {
		double total = testsExecutesCounter.count();
		double reussis = testsReussisCounter.count();
		double taux = total > 0 ? (reussis / total) * 100 : 100;
		tauxReussiteRef.set(taux);
	}

	// ========== MÉTHODES POUR ALERTES ==========

	public void incrementAlertesCritiques() {
		alertesCritiquesCounter.increment();
	}

	public void incrementAlertesTotal() {
		alertesTotalCounter.increment();
	}

	public void updateAlertesMetrics(int alertesActives, int testsEnErreur24h, int serveursCritiques) {
		alertesActivesGauge.set(alertesActives);
		testsEnErreur24hGauge.set(testsEnErreur24h);
		serveursCritiquesGauge.set(serveursCritiques);
	}

	public void updateAlertesParType(Map<String, Integer> stats) {
		if (stats == null) {
			return;
		}

		for (Map.Entry<String, Integer> entry : stats.entrySet()) {
			String type = entry.getKey().toLowerCase();
			AtomicInteger counter = alertesParType.get(type);
			if (counter != null) {
				counter.set(entry.getValue());
			}
		}
	}

	public void updateAlertesParCriticite(Map<String, Integer> stats) {
		if (stats == null) {
			return;
		}

		for (Map.Entry<String, Integer> entry : stats.entrySet()) {
			String criticite = entry.getKey().toLowerCase();
			AtomicInteger counter = alertesParCriticite.get(criticite);
			if (counter != null) {
				counter.set(entry.getValue());
			}
		}
	}

	// ========== MÉTHODE DE MISE À JOUR COMPLÈTE ==========

	public void updateAllMetrics() {
		try {
			if (alertService != null && serveurService != null && testService != null && caisseService != null) {
				// 1. Métriques d'alertes
				Map<String, Integer> statsAlertes = alertService.getStatsAlertes();

				int alertesActives = extractIntValueFromIntegerMap(statsAlertes, "total");
				int testsEnErreur = (int) alertService.getTestsEnErreurCount();
				int alertesCritiques = extractIntValueFromIntegerMap(statsAlertes, "critical");

				updateAlertesMetrics(alertesActives, testsEnErreur, alertesCritiques);

				// Mettre à jour par type et criticité
				updateAlertesParType(statsAlertes);
				updateAlertesParCriticite(statsAlertes);

				// 2. Métriques de serveurs
				setDisponibilite(serveurService.calculerTauxDisponibilite());

				// 3. Métriques de tests et caisses
				long activeTests = testService.countActiveTests();
				double tauxReussite = testService.getTauxReussiteGlobal();
				long caissesActives = caisseService.countActiveCaisses();

				updateMetrics(caissesActives, activeTests, tauxReussite, testService.getTempsReponseMoyenAujourdhui());

				System.out.println("📊 Métriques mises à jour avec succès");
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur mise à jour métriques: " + e.getMessage());
		}
	}

	// ========== MÉTHODE pour collecter toutes les métriques ==========

	public Map<String, Object> collecterMetriquesCompletes() {
		try {
			Map<String, Object> metriques = new HashMap<>();
			metriques.put("timestamp", System.currentTimeMillis());

			// Serveurs
			metriques.put("serveursActifs", serveurService != null ? serveurService.countActifs() : 0);
			metriques.put("serveursTotaux", serveurService != null ? serveurService.countTotal() : 0);

			// Alertes
			if (alertService != null) {
				Map<String, Integer> statsAlertes = alertService.getStatsAlertes();
				metriques.put("alertesCritiques", statsAlertes.getOrDefault("critical", 0));
				metriques.put("alertesTotal", statsAlertes.getOrDefault("total", 0));
				metriques.put("alertesActives", statsAlertes.getOrDefault("total", 0));
			} else {
				metriques.put("alertesCritiques", 0);
				metriques.put("alertesTotal", 0);
				metriques.put("alertesActives", 0);
			}

			// Tests
			metriques.put("tauxReussite", testService != null ? testService.getTauxReussiteGlobal() : 0.0);
			metriques.put("activeTests", testService != null ? testService.countActiveTests() : 0);

			// Caisses
			metriques.put("caissesActives", caisseService != null ? caisseService.countActiveCaisses() : 0);

			// Disponibilité et temps de réponse
			metriques.put("disponibilite", serveurService != null ? serveurService.calculerTauxDisponibilite() : 100.0);
			metriques.put("tempsReponseMoyen", testService != null ? testService.getTempsReponseMoyenAujourdhui() : 0);

			return metriques;

		} catch (Exception e) {
			System.err.println("❌ Erreur collecterMetriquesCompletes: " + e.getMessage());
			return new HashMap<>();
		}
	}

	// ========== MÉTHODES UTILITAIRES ==========

	private int extractIntValueFromIntegerMap(Map<String, Integer> map, String key) {
		try {
			if (map != null && map.containsKey(key)) {
				Integer value = map.get(key);
				return value != null ? value : 0;
			}
		} catch (Exception e) {
			System.err.println("⚠️ Erreur extractIntValueFromIntegerMap: " + e.getMessage());
		}
		return 0;
	}

	// ========== GETTERS ==========

	public double getTauxReussite() {
		return tauxReussiteRef.get() != null ? tauxReussiteRef.get() : 100.0;
	}

	public double getDisponibilite() {
		return disponibiliteGauge.get();
	}

	public long getTestsExecutesCount() {
		return (long) testsExecutesCounter.count();
	}

	public long getTestsReussisCount() {
		return (long) testsReussisCounter.count();
	}

	public long getTestsEchouesCount() {
		return (long) testsEchouesCounter.count();
	}

	public int getAlertesActives() {
		return alertesActivesGauge.get();
	}

	public long getTestsEnErreur24h() {
		return testsEnErreur24hGauge.get();
	}

	public int getServeursCritiques() {
		return serveursCritiquesGauge.get();
	}

	// ========== MÉTHODES POUR GRAFANA ==========

	public List<Double> getSuccessRates(int days) {
		// Implémenter la logique pour récupérer les taux de succès sur X jours
		return Arrays.asList(85.0, 92.0, 78.0, 95.0, 88.0, 91.0, 86.0);
	}

	public List<Integer> getSuccessCounts(int days) {
		// Logique pour nombre de tests réussis
		return Arrays.asList(120, 150, 95, 180, 135, 165, 140);
	}

	public List<Integer> getResponseTimes(int days) {
		// Logique pour temps de réponse
		return Arrays.asList(450, 380, 520, 350, 420, 390, 440);
	}

	public List<Integer> getFailureCounts(int days) {
		List<Integer> failures = new ArrayList<>();
		for (int i = 0; i < days; i++) {
			failures.add(2 + i % 3);
		}
		return failures;
	}

	public Map<String, Object> getLiveMetrics() {
		Map<String, Object> metrics = new HashMap<>();
		metrics.put("timestamp", System.currentTimeMillis());
		metrics.put("activeTests", testService != null ? testService.countActiveTests() : 0);
		metrics.put("successRate", getTauxReussite());
		metrics.put("responseTime", tempsReponseMoyenGauge.get());
		return metrics;
	}

	public double getCurrentAvailability() {
		return getDisponibilite();
	}

	public double getCurrentSuccessRate() {
		return getTauxReussite();
	}
}