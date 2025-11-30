package com.example.monitor.config;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Timer;
import io.micrometer.core.instrument.binder.MeterBinder;

@Configuration
public class MetricsConfig {

	private final AtomicLong pendingTests = new AtomicLong(0);
	private final AtomicLong successfulTests = new AtomicLong(0);
	private final AtomicLong failedTests = new AtomicLong(0);
	private final AtomicLong totalExecutions = new AtomicLong(0);
	private final AtomicInteger activeThreads = new AtomicInteger(0);

	@Bean
	public MeterBinder testMetricsBinder() {
		return registry -> {
			// Métriques de base des tests - CORRECTION : utilisation de Lambda avec
			// Supplier
			Gauge.builder("machine_monitor.tests.pending", pendingTests, AtomicLong::get)
					.description("Nombre de tests en attente d'exécution").register(registry);

			Gauge.builder("machine_monitor.tests.active_threads", activeThreads, AtomicInteger::get)
					.description("Threads actifs d'exécution de tests").register(registry);

			Gauge.builder("machine_monitor.tests.successful.total", successfulTests, AtomicLong::get)
					.description("Total des tests réussis").register(registry);

			Gauge.builder("machine_monitor.tests.failed.total", failedTests, AtomicLong::get)
					.description("Total des tests échoués").register(registry);

			Gauge.builder("machine_monitor.tests.executions.total", totalExecutions, AtomicLong::get)
					.description("Total des exécutions de tests").register(registry);
		};
	}

	@Bean
	public Timer testExecutionTimer(MeterRegistry registry) {
		return Timer.builder("machine_monitor.test.execution.time").description("Temps d'exécution des tests")
				.publishPercentiles(0.5, 0.75, 0.95, 0.99).register(registry);
	}

	@Bean
	public CustomMetrics customMetrics() {
		return new CustomMetrics();
	}

	public class CustomMetrics {
		public void incrementPendingTests() {
			pendingTests.incrementAndGet();
		}

		public void decrementPendingTests() {
			pendingTests.decrementAndGet();
		}

		public void incrementActiveThreads() {
			activeThreads.incrementAndGet();
		}

		public void decrementActiveThreads() {
			activeThreads.decrementAndGet();
		}

		public void recordTestResult(boolean success, long duration) {
			totalExecutions.incrementAndGet();
			if (success) {
				successfulTests.incrementAndGet();
			} else {
				failedTests.incrementAndGet();
			}
			pendingTests.decrementAndGet();
		}

		public long getPendingTests() {
			return pendingTests.get();
		}

		public int getActiveThreads() {
			return activeThreads.get();
		}

		// Getters pour les métriques
		public AtomicLong getPendingTestsMetric() {
			return pendingTests;
		}

		public AtomicInteger getActiveThreadsMetric() {
			return activeThreads;
		}

		public AtomicLong getSuccessfulTestsMetric() {
			return successfulTests;
		}

		public AtomicLong getFailedTestsMetric() {
			return failedTests;
		}

		public AtomicLong getTotalExecutionsMetric() {
			return totalExecutions;
		}
	}
}