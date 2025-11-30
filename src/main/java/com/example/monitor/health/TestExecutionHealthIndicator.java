package com.example.monitor.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

import com.example.monitor.config.MetricsConfig.CustomMetrics;

@Component
public class TestExecutionHealthIndicator implements HealthIndicator {

	private final CustomMetrics metrics;

	public TestExecutionHealthIndicator(CustomMetrics metrics) {
		this.metrics = metrics;
	}

	@Override
	public Health health() {
		int activeThreads = metrics.getActiveThreads();
		long pendingTests = metrics.getPendingTests();

		Health.Builder statusBuilder;

		if (activeThreads > 80 || pendingTests > 5000) {
			statusBuilder = Health.down();
		} else if (activeThreads > 50 || pendingTests > 2000) {
			statusBuilder = Health.outOfService();
		} else {
			statusBuilder = Health.up();
		}

		return statusBuilder.withDetail("active_threads", activeThreads).withDetail("pending_tests", pendingTests)
				.build();
	}
}