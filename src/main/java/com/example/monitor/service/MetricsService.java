package com.example.monitor.service;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.atomic.AtomicReference;

import org.springframework.stereotype.Service;

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

	// Nouvelles métriques pour Grafana
	private final AtomicLong disponibiliteGauge = new AtomicLong(100);
	private final AtomicInteger statutApplication = new AtomicInteger(1); // 1=UP, 0=DOWN
	private final Counter requetesHttpTotal;
	private final AtomicReference<Double> tauxReussiteRef = new AtomicReference<>(100.0);
	private final AtomicLong activeCaissesGauge = new AtomicLong(0);
	private final AtomicLong activeTestsGauge = new AtomicLong(0);
	private final AtomicLong tempsReponseMoyenGauge = new AtomicLong(0);

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

		// CORRECTION : Gauges avec Supplier
		Gauge.builder("monitor_taux_reussite_pourcent", tauxReussiteRef, ref -> ref.get() != null ? ref.get() : 100.0)
				.description("Taux de réussite en temps réel").register(registry);

		// CORRECTION : Gauges avec AtomicLong
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

	// Méthodes existantes
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

	// Getters pour les tests
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
}