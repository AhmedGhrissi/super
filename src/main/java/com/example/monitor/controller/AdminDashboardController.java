package com.example.monitor.controller;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminDashboardController {

	@GetMapping("/admin/admin-dashboard")
	public String adminDashboard(Model model) {
		Map<String, String> monitoringLinks = new HashMap<>();

		// Liens Prometheus/Grafana
		monitoringLinks.put("Prometheus Metrics", "/monitoring/prometheus");
		monitoringLinks.put("Grafana API", "/api/grafana/advanced-metrics");
		monitoringLinks.put("Health Check", "/monitoring/health");
		monitoringLinks.put("Application Info", "/monitoring/info");

		// Liens de débogage
		monitoringLinks.put("Générer Données Test", "/debug/fix-metrics");
		monitoringLinks.put("Réinitialiser Métriques", "/debug/reset-metrics");
		monitoringLinks.put("Voir Métriques Actuelles", "/debug/current-metrics");

		// Liens API
		monitoringLinks.put("Test API", "/api/grafana/test");
		monitoringLinks.put("Métriques Simple", "/api/grafana/metrics");

		model.addAttribute("links", monitoringLinks);
		model.addAttribute("appName", "Machine Monitor");
		model.addAttribute("timestamp", java.time.LocalDateTime.now());

		return "admin/admin-dashboard";
	}

	@GetMapping("/admin/download-documentation")
	public ResponseEntity<Resource> downloadDocumentation() {
		String documentation = createCompleteDocumentation();

		ByteArrayResource resource = new ByteArrayResource(documentation.getBytes(StandardCharsets.UTF_8));

		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=machine-monitor-documentation.md")
				.contentType(MediaType.TEXT_PLAIN).contentLength(resource.contentLength()).body(resource);
	}

	@GetMapping("/admin/download-dashboards")
	public ResponseEntity<Resource> downloadDashboards() {
		String dashboardsJson = createDashboardsJson();

		ByteArrayResource resource = new ByteArrayResource(dashboardsJson.getBytes(StandardCharsets.UTF_8));

		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=grafana-dashboards.json")
				.contentType(MediaType.APPLICATION_JSON).contentLength(resource.contentLength()).body(resource);
	}

	private String createCompleteDocumentation() {
		StringBuilder doc = new StringBuilder();
		doc.append("# MACHINE MONITOR - DOCUMENTATION COMPLÈTE\n");
		doc.append("## Application de Supervision et Monitoring\n\n");
		doc.append("## 📋 TABLE DES MATIÈRES\n");
		doc.append("1. Configuration Application\n");
		doc.append("2. Monitoring avec Prometheus/Grafana\n");
		doc.append("3. Procédure Ngrok\n");
		doc.append("4. API Endpoints\n");
		doc.append("5. Débogage et Maintenance\n\n");

		doc.append("## 🚀 CONFIGURATION APPLICATION\n\n");
		doc.append("### URLs Principales\n");
		doc.append("- Application: http://localhost:8080\n");
		doc.append("- Admin Dashboard: http://localhost:8080/admin/admin-dashboard\n");
		doc.append("- Prometheus: http://localhost:8080/monitoring/prometheus\n");
		doc.append("- Health Check: http://localhost:8080/monitoring/health\n\n");

		doc.append("### Commandes de Démarrage\n");
		doc.append("```bash\n");
		doc.append("# Développement\n");
		doc.append("./mvnw spring-boot:run\n\n");
		doc.append("# Production\n");
		doc.append("./mvnw spring-boot:run -Dspring-boot.run.profiles=prod\n");
		doc.append("```\n\n");

		doc.append("## 🔧 MONITORING AVEC PROMETHEUS/GRAFANA\n\n");
		doc.append("### Configuration Prometheus\n");
		doc.append("L'application expose automatiquement les métriques au format Prometheus sur:\n");
		doc.append("`/monitoring/prometheus`\n\n");

		doc.append("### Métriques Disponibles\n");
		doc.append("- monitor_tests_executes_total\n");
		doc.append("- monitor_tests_reussis_total\n");
		doc.append("- monitor_tests_echoues_total\n");
		doc.append("- monitor_taux_reussite_pourcent\n");
		doc.append("- monitor_disponibilite_pourcent\n");
		doc.append("- monitor_temps_reponse_moyen_ms\n\n");

		doc.append("## 🌐 PROCÉDURE NGROK POUR GRAFANA CLOUD\n\n");
		doc.append("### Étape 1: Installation Ngrok\n");
		doc.append("1. Télécharger depuis https://ngrok.com/\n");
		doc.append("2. S'inscrire (compte gratuit)\n");
		doc.append("3. Récupérer le token d'authentification\n\n");

		doc.append("### Étape 2: Configuration\n");
		doc.append("```bash\n");
		doc.append("# Ajouter le token\n");
		doc.append("ngrok config add-authtoken VOTRE_TOKEN_ICI\n\n");
		doc.append("# Lancer le tunnel\n");
		doc.append("ngrok http 8080\n");
		doc.append("```\n\n");

		doc.append("### Étape 3: Récupération URL\n");
		doc.append("Ngrok fournira une URL comme:\n");
		doc.append("`https://abc123-def4-567.ngrok.io`\n\n");

		doc.append("### Étape 4: Configuration Grafana Cloud\n");
		doc.append("1. Aller sur https://grafana.com/\n");
		doc.append("2. Data Sources → Add Prometheus\n");
		doc.append("3. URL: https://abc123-def4-567.ngrok.io/monitoring/prometheus\n");
		doc.append("4. Save & Test\n\n");

		doc.append("### Étape 5: Alternative si Ngrok bloqué\n");
		doc.append("```bash\n");
		doc.append("# Utiliser Serveo (pas d'installation)\n");
		doc.append("ssh -R 80:localhost:8080 serveo.net\n");
		doc.append("```\n\n");

		doc.append("## 📊 ENDPOINTS API\n\n");
		doc.append("### Monitoring\n");
		doc.append("- `/api/grafana/metrics` - Métriques basiques\n");
		doc.append("- `/api/grafana/advanced-metrics` - Métriques détaillées\n");
		doc.append("- `/api/grafana/test` - Test de l'API\n");
		doc.append("- `/api/grafana/health` - Statut de santé\n\n");

		doc.append("### Débogage\n");
		doc.append("- `/debug/fix-metrics` - Génère des données de test\n");
		doc.append("- `/debug/reset-metrics` - Réinitialise les métriques\n");
		doc.append("- `/debug/current-metrics` - Affiche les métriques actuelles\n\n");

		doc.append("## 🛠️ MAINTENANCE\n\n");
		doc.append("### Vérification Base de Données\n");
		doc.append("```sql\n");
		doc.append("-- Tests configurés\n");
		doc.append("SELECT * FROM configuration_tests WHERE actif = 1;\n\n");
		doc.append("-- Résultats récents\n");
		doc.append("SELECT * FROM resultats_tests ORDER BY date_execution DESC LIMIT 10;\n");
		doc.append("```\n\n");

		doc.append("### Logs\n");
		doc.append("Les logs sont disponibles dans:\n");
		doc.append("- `logs/machine-monitor.log` (développement)\n");
		doc.append("- `/var/log/machine-monitor/application.log` (production)\n\n");

		doc.append("## 🚨 DÉPANNAGE\n\n");
		doc.append("### Problèmes Courants\n");
		doc.append("1. **Base vide**: Utiliser `/debug/fix-metrics`\n");
		doc.append("2. **Prometheus inaccessible**: Vérifier le profil (dev/prod)\n");
		doc.append("3. **Ngrok bloqué**: Utiliser Serveo en alternative\n");
		doc.append("4. **Données incohérentes**: Réinitialiser avec `/debug/reset-metrics`\n\n");

		doc.append("### Contacts Support\n");
		doc.append("- Email: support@company.com\n");
		doc.append("- Équipe: DevOps\n\n");
		doc.append("---\n");
		doc.append("*Document généré automatiquement - Machine Monitor v1.0.0*\n");

		return doc.toString();
	}

	private String createDashboardsJson() {
		return "{\n" + "  \"dashboards\": [\n" + "    {\n" + "      \"name\": \"Machine Monitor - Vue d'ensemble\",\n"
				+ "      \"description\": \"Dashboard principal avec indicateurs clés\",\n"
				+ "      \"panels\": [\"Disponibilité\", \"Taux Réussite\", \"Tests Exécutés\", \"Temps Réponse\"]\n"
				+ "    },\n" + "    {\n" + "      \"name\": \"Machine Monitor - Détails Performance\", \n"
				+ "      \"description\": \"Vue détaillée des performances et métriques\",\n"
				+ "      \"panels\": [\"Caisses Actives\", \"Tests Actifs\", \"Distribution Temps\", \"Évolution Tests\"]\n"
				+ "    }\n" + "  ],\n" + "  \"metrics_available\": [\n" + "    \"monitor_tests_executes_total\",\n"
				+ "    \"monitor_tests_reussis_total\",\n" + "    \"monitor_tests_echoues_total\", \n"
				+ "    \"monitor_taux_reussite_pourcent\",\n" + "    \"monitor_disponibilite_pourcent\",\n"
				+ "    \"monitor_temps_reponse_moyen_ms\",\n" + "    \"monitor_caisses_actives\",\n"
				+ "    \"monitor_tests_actifs\"\n" + "  ],\n"
				+ "  \"import_instructions\": \"Dans Grafana: Create → Import → Coller le JSON\"\n" + "}";
	}
}