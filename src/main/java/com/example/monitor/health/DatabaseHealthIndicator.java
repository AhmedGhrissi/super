package com.example.monitor.health;

import java.util.List;
import java.util.Map;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class DatabaseHealthIndicator implements HealthIndicator {

	private final JdbcTemplate jdbcTemplate;

	public DatabaseHealthIndicator(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Health health() {
		try {
			// Vérifier la connexion à la base de données
			List<Map<String, Object>> result = jdbcTemplate.queryForList("SELECT 1 as test");

			// Vérifier les tables essentielles
			int caissesCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM caisses WHERE actif = true",
					Integer.class);
			int testsCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM tests_standard WHERE actif = true",
					Integer.class);

			return Health.up().withDetail("database", "MySQL").withDetail("caisses_actives", caissesCount)
					.withDetail("tests_actifs", testsCount).withDetail("status", "Toutes les tables sont accessibles")
					.build();

		} catch (Exception e) {
			return Health.down().withDetail("database", "MySQL").withDetail("error", e.getMessage()).build();
		}
	}
}