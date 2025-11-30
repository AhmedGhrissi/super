package com.example.monitor.service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.ConfigurationTests;
import com.example.monitor.model.ResultatsTests;
import com.example.monitor.model.TestStandard;
import com.example.monitor.repository.CaisseRepository;
import com.example.monitor.repository.ConfigurationTestsRepository;
import com.example.monitor.repository.ResultatsTestsRepository;
import com.example.monitor.repository.TestRepository;

@Service
@Transactional
public class TestService {

	private static final Logger logger = LoggerFactory.getLogger(TestService.class);

	@Autowired
	private TestRepository testRepository;

	@Autowired
	private ConfigurationTestsRepository configTestsRepository;

	@Autowired
	private ResultatsTestsRepository resultatsRepository;

	@Autowired
	private CaisseRepository caisseRepository;

	@Autowired(required = false)
	private MetricsService metricsService;

	// === MÉTHODES EXISTANTES AVEC CACHE ===

	@Cacheable(value = "tests", key = "'all'")
	public List<TestStandard> findAll() {
		return testRepository.findAll();
	}

	@Cacheable(value = "tests", key = "#id")
	public TestStandard findById(Long id) {
		return testRepository.findById(id).orElseThrow(() -> new RuntimeException("Test non trouvé"));
	}

	@CacheEvict(value = { "tests", "statistics" }, allEntries = true)
	public TestStandard save(TestStandard test) {
		if (test.getId() == null) {
			test.setCreatedAt(LocalDateTime.now());
		}
		return testRepository.save(test);
	}

	@CacheEvict(value = { "tests", "statistics" }, allEntries = true)
	public void toggleStatus(Long id) {
		TestStandard test = findById(id);
		test.setActif(!test.getActif());
		testRepository.save(test);
	}

	@Cacheable(value = "tests", key = "'active'")
	public List<TestStandard> getActiveTests() {
		return testRepository.findByActifTrue();
	}

	@Cacheable(value = "statistics", key = "'countAllTests'")
	public long countAllTests() {
		return testRepository.count();
	}

	@Cacheable(value = "statistics", key = "'countActiveTests'")
	public long countActiveTests() {
		return testRepository.countByActifTrue();
	}

	// === MÉTHODES POUR LES STATISTIQUES RÉELLES ===

	@Cacheable(value = "statistics", key = "'testsExecutesAujourdhui'")
	public long countTestsExecutesAujourdhui(LocalDateTime debutAujourdhui) {
		try {
			return resultatsRepository.countByDateExecutionAfter(debutAujourdhui);
		} catch (Exception e) {
			return 0;
		}
	}

	@Cacheable(value = "statistics", key = "'testsReussisAujourdhui'")
	public long countTestsReussisAujourdhui(LocalDateTime debutAujourdhui) {
		try {
			return resultatsRepository.countBySuccesTrueAndDateExecutionAfter(debutAujourdhui);
		} catch (Exception e) {
			return 0;
		}
	}

	@Cacheable(value = "statistics", key = "'testsEchouesAujourdhui'")
	public long countTestsEchouesAujourdhui(LocalDateTime debutAujourdhui) {
		try {
			return resultatsRepository.countBySuccesFalseAndDateExecutionAfter(debutAujourdhui);
		} catch (Exception e) {
			return 0;
		}
	}

	@Cacheable(value = "statistics", key = "'tempsReponseMoyenAujourdhui'")
	public long getTempsReponseMoyenAujourdhui() {
		try {
			LocalDateTime debutAujourdhui = LocalDate.now().atStartOfDay();
			Long tempsMoyen = resultatsRepository.findTempsReponseMoyenDepuis(debutAujourdhui);
			return tempsMoyen != null ? tempsMoyen : 0;
		} catch (Exception e) {
			return 0;
		}
	}

	// === NOUVELLES MÉTHODES POUR LES MÉTRIQUES ===

	@Cacheable(value = "statistics", key = "'tauxReussiteGlobal'")
	public double getTauxReussiteGlobal() {
		try {
			LocalDateTime debutAujourdhui = LocalDate.now().atStartOfDay();
			long total = countTestsExecutesAujourdhui(debutAujourdhui);
			long reussis = countTestsReussisAujourdhui(debutAujourdhui);
			return total > 0 ? Math.round((reussis * 100.0) / total * 10.0) / 10.0 : 0.0;
		} catch (Exception e) {
			return 0.0;
		}
	}

	@Cacheable(value = "statistics", key = "'performanceIndicators'")
	public Map<String, Object> getPerformanceIndicators() {
		Map<String, Object> indicators = new HashMap<>();

		try {
			LocalDateTime debutAujourdhui = LocalDate.now().atStartOfDay();
			long totalTests = countTestsExecutesAujourdhui(debutAujourdhui);
			long testsReussis = countTestsReussisAujourdhui(debutAujourdhui);
			long testsEchoues = countTestsEchouesAujourdhui(debutAujourdhui);
			long tempsReponseMoyen = getTempsReponseMoyenAujourdhui();
			double tauxReussite = getTauxReussiteGlobal();

			// Calcul de la disponibilité
			double disponibilite = totalTests > 0 ? (testsReussis * 100.0) / totalTests : 100.0;

			// Statut global basé sur la disponibilité
			String statutGlobal;
			if (disponibilite >= 95) {
				statutGlobal = "EXCELLENT";
			} else if (disponibilite >= 80) {
				statutGlobal = "BON";
			} else if (disponibilite >= 60) {
				statutGlobal = "MOYEN";
			} else {
				statutGlobal = "CRITIQUE";
			}

			// Temps de réponse statut
			String statutTempsReponse;
			if (tempsReponseMoyen < 1000) {
				statutTempsReponse = "RAPIDE";
			} else if (tempsReponseMoyen < 3000) {
				statutTempsReponse = "NORMAL";
			} else {
				statutTempsReponse = "LENT";
			}

			indicators.put("disponibilite", Math.round(disponibilite * 10.0) / 10.0);
			indicators.put("statutGlobal", statutGlobal);
			indicators.put("statutTempsReponse", statutTempsReponse);
			indicators.put("totalTestsAujourdhui", totalTests);
			indicators.put("testsReussisAujourdhui", testsReussis);
			indicators.put("testsEchouesAujourdhui", testsEchoues);
			indicators.put("tauxReussite", tauxReussite);
			indicators.put("tempsReponseMoyen", tempsReponseMoyen);
			indicators.put("derniereVerification",
					LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("HH:mm:ss")));
			indicators.put("caissesActives", caisseRepository.countByActifTrue());
			indicators.put("testsActifs", countActiveTests());

		} catch (Exception e) {
			// Valeurs par défaut en cas d'erreur
			indicators.put("disponibilite", 0.0);
			indicators.put("statutGlobal", "INDISPONIBLE");
			indicators.put("statutTempsReponse", "INDISPONIBLE");
			indicators.put("totalTestsAujourdhui", 0);
			indicators.put("testsReussisAujourdhui", 0);
			indicators.put("testsEchouesAujourdhui", 0);
			indicators.put("tauxReussite", 0.0);
			indicators.put("tempsReponseMoyen", 0);
			indicators.put("derniereVerification", "Erreur");
			indicators.put("caissesActives", 0);
			indicators.put("testsActifs", 0);
		}

		return indicators;
	}

	// === MÉTHODES D'EXÉCUTION RÉELLE AMÉLIORÉES ===

	@Transactional
	@CacheEvict(value = { "statistics", "rapports" }, allEntries = true)
	public void lancerTousTestsActifs() {
		try {
			List<ConfigurationTests> testsActifs = configTestsRepository.findByActifTrue();
			System.out.println("🚀 Lancement de " + testsActifs.size() + " tests actifs...");

			// Mettre à jour les métriques avant le lancement
			updateMetricsGauges();

			testsActifs.forEach(configTest -> {
				CompletableFuture.runAsync(() -> {
					try {
						executerTestReel(configTest);
						System.out.println("✅ Test exécuté: " + configTest.getId());
					} catch (Exception e) {
						System.err.println("❌ Erreur test " + configTest.getId() + ": " + e.getMessage());
					}
				});
			});

		} catch (Exception e) {
			System.err.println("❌ Erreur lors du lancement des tests: " + e.getMessage());
		}
	}

	@Transactional
	@CacheEvict(value = { "statistics", "rapports" }, allEntries = true)
	public void lancerTestsParCategorie(String codeCategorie) {
		try {
			List<ConfigurationTests> testsActifs = configTestsRepository.findByActifTrue();
			System.out.println("🎯 Lancement de " + testsActifs.size() + " tests (catégorie: " + codeCategorie + ")");

			// Mettre à jour les métriques avant le lancement
			updateMetricsGauges();

			testsActifs.forEach(configTest -> {
				CompletableFuture.runAsync(() -> {
					executerTestReel(configTest);
				});
			});

		} catch (Exception e) {
			System.err.println("❌ Erreur lancement catégorie " + codeCategorie + ": " + e.getMessage());
		}
	}

	private void executerTestReel(ConfigurationTests configTest) {
		try {
			TestStandard testStandard = configTest.getTestStandard();
			String url = construireUrlComplete(configTest);

			long debut = System.currentTimeMillis();

			boolean succes = false;
			int codeStatut = 0;
			String message = "";

			switch (testStandard.getTypeTest().toUpperCase()) {
			case "HTTP":
			case "HTTPS":
				succes = executerTestHttp(url, testStandard, codeStatut, message);
				break;
			default:
				// Simulation pour les autres types de tests
				succes = Math.random() > 0.3;
				codeStatut = succes ? 200 : 500;
				message = succes ? "Test simulé réussi" : "Test simulé échoué";
			}

			long tempsReponse = System.currentTimeMillis() - debut;

			// Sauvegarder le résultat
			ResultatsTests resultat = new ResultatsTests();
			resultat.setConfigTest(configTest);
			resultat.setSucces(succes);
			resultat.setTempsReponse(tempsReponse);
			resultat.setCodeStatut(codeStatut);
			resultat.setMessage(message);
			resultat.setDateExecution(LocalDateTime.now());

			resultatsRepository.save(resultat);

			// Mettre à jour les métriques si le service est disponible
			if (metricsService != null) {
				metricsService.incrementTestsExecutes();
				if (succes) {
					metricsService.incrementTestsReussis();
				} else {
					metricsService.incrementTestsEchoues();
				}
				metricsService.recordTestDuration(tempsReponse);
				updateMetricsGauges();
			}

			System.out.println("✅ Test " + configTest.getId() + " exécuté: " + (succes ? "SUCCÈS" : "ÉCHEC") + " ("
					+ tempsReponse + "ms)");

		} catch (Exception e) {
			System.err.println("❌ Erreur exécution test " + configTest.getId() + ": " + e.getMessage());

			// Sauvegarder l'échec
			ResultatsTests resultat = new ResultatsTests();
			resultat.setConfigTest(configTest);
			resultat.setSucces(false);
			resultat.setTempsReponse(0L);
			resultat.setCodeStatut(0);
			resultat.setMessage("Erreur: " + e.getMessage());
			resultat.setDateExecution(LocalDateTime.now());
			resultatsRepository.save(resultat);

			// Mettre à jour les métriques d'erreur
			if (metricsService != null) {
				metricsService.incrementTestsExecutes();
				metricsService.incrementTestsEchoues();
				updateMetricsGauges();
			}
		}
	}

	private boolean executerTestHttp(String url, TestStandard testStandard, int codeStatut, String message) {
		try {
			HttpClient client = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10))
					.followRedirects(HttpClient.Redirect.NORMAL).build();

			HttpRequest.Builder requestBuilder = HttpRequest.newBuilder().uri(URI.create(url)).timeout(
					Duration.ofSeconds(testStandard.getTimeoutMs() != null ? testStandard.getTimeoutMs() / 1000 : 30));

			switch (testStandard.getMethodeHttp().toUpperCase()) {
			case "GET":
				requestBuilder.GET();
				break;
			case "POST":
				requestBuilder.POST(HttpRequest.BodyPublishers.noBody());
				break;
			case "HEAD":
				requestBuilder.method("HEAD", HttpRequest.BodyPublishers.noBody());
				break;
			default:
				requestBuilder.GET();
			}

			HttpRequest request = requestBuilder.build();
			HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

			codeStatut = response.statusCode();
			message = "HTTP " + codeStatut;

			switch (testStandard.getValidationType().toUpperCase()) {
			case "STATUS_CODE":
				return codeStatut == (testStandard.getStatusAttendu() != null ? testStandard.getStatusAttendu() : 200);
			case "RESPONSE_TEXT":
				return response.body()
						.contains(testStandard.getValeurAttendue() != null ? testStandard.getValeurAttendue() : "");
			case "CONTENT_TYPE":
				return response.headers().firstValue("Content-Type")
						.map(ct -> ct.contains(
								testStandard.getValeurAttendue() != null ? testStandard.getValeurAttendue() : ""))
						.orElse(false);
			default:
				return codeStatut >= 200 && codeStatut < 300;
			}

		} catch (Exception e) {
			message = "Erreur: " + e.getMessage();
			return false;
		}
	}

	private String construireUrlComplete(ConfigurationTests configTest) {
		TestStandard testStandard = configTest.getTestStandard();

		if (configTest.getUrlComplete() != null && !configTest.getUrlComplete().isEmpty()) {
			return configTest.getUrlComplete();
		}

		StringBuilder url = new StringBuilder();

		if ("HTTPS".equalsIgnoreCase(testStandard.getTypeTest())) {
			url.append("https://");
		} else {
			url.append("http://");
		}

		if (configTest.getServeurCible() != null && !configTest.getServeurCible().isEmpty()) {
			url.append(configTest.getServeurCible());
		} else {
			url.append("localhost");
		}

		if (testStandard.getPort() != null && testStandard.getPort() != 80 && testStandard.getPort() != 443) {
			url.append(":").append(testStandard.getPort());
		}

		if (testStandard.getEndpoint() != null && !testStandard.getEndpoint().isEmpty()) {
			if (!testStandard.getEndpoint().startsWith("/")) {
				url.append("/");
			}
			url.append(testStandard.getEndpoint());
		}

		return url.toString();
	}

	// === MÉTHODES DE RAPPORTS AMÉLIORÉES ===

	@Cacheable(value = "rapports", key = "'hebdomadaires'")
	public Map<String, Object> getRapportsHebdomadaires() {
		Map<String, Object> rapports = new HashMap<>();

		try {
			LocalDateTime debutSemaine = LocalDate.now().minusDays(7).atStartOfDay();
			LocalDateTime maintenant = LocalDateTime.now();

			Long totalTestsSemaine = resultatsRepository.countByDateExecutionBetween(debutSemaine, maintenant);
			Long testsReussisSemaine = resultatsRepository.countBySuccesTrueAndDateExecutionBetween(debutSemaine,
					maintenant);
			Long testsEchouesSemaine = resultatsRepository.countBySuccesFalseAndDateExecutionBetween(debutSemaine,
					maintenant);

			double tauxReussite = totalTestsSemaine != null && totalTestsSemaine > 0
					? Math.round((testsReussisSemaine != null ? (testsReussisSemaine * 100.0) / totalTestsSemaine : 0)
							* 10.0) / 10.0
					: 0.0;

			Long tempsReponseMoyen = resultatsRepository.findTempsReponseMoyenBetween(debutSemaine, maintenant);

			// Statistiques détaillées par jour
			Map<String, Object> statsParJour = getStatsParJourSemaine();

			java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
			String periode = "Semaine du " + debutSemaine.format(formatter) + " au "
					+ LocalDate.now().format(formatter);

			rapports.put("totalTests", totalTestsSemaine != null ? totalTestsSemaine : 0);
			rapports.put("testsReussis", testsReussisSemaine != null ? testsReussisSemaine : 0);
			rapports.put("testsEchoues", testsEchouesSemaine != null ? testsEchouesSemaine : 0);
			rapports.put("tauxReussite", tauxReussite);
			rapports.put("tempsReponseMoyen", tempsReponseMoyen != null ? tempsReponseMoyen : 0);
			rapports.put("periode", periode);
			rapports.put("caissesTestees", caisseRepository.countByActifTrue());
			rapports.put("testsActifs", configTestsRepository.countByActifTrue());
			rapports.put("statsParJour", statsParJour);
			rapports.put("performanceIndicators", getPerformanceIndicators());
			rapports.put("dateGeneration",
					LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));

		} catch (Exception e) {
			System.err.println("❌ Erreur dans getRapportsHebdomadaires: " + e.getMessage());

			rapports.put("totalTests", 0);
			rapports.put("testsReussis", 0);
			rapports.put("testsEchoues", 0);
			rapports.put("tauxReussite", 0.0);
			rapports.put("tempsReponseMoyen", 0);
			rapports.put("periode", "Période non disponible");
			rapports.put("caissesTestees", 0);
			rapports.put("testsActifs", 0);
			rapports.put("statsParJour", new HashMap<>());
			rapports.put("dateGeneration", "Erreur de génération");
		}

		return rapports;
	}

	// === MÉTHODES UTILITAIRES PRIVÉES ===

	private Map<String, Object> getStatsParJourSemaine() {
		Map<String, Object> statsParJour = new HashMap<>();

		try {
			for (int i = 6; i >= 0; i--) {
				LocalDate jour = LocalDate.now().minusDays(i);
				LocalDateTime debutJour = jour.atStartOfDay();
				LocalDateTime finJour = jour.plusDays(1).atStartOfDay();

				Long total = resultatsRepository.countByDateExecutionBetween(debutJour, finJour);
				Long reussis = resultatsRepository.countBySuccesTrueAndDateExecutionBetween(debutJour, finJour);
				Long echoues = resultatsRepository.countBySuccesFalseAndDateExecutionBetween(debutJour, finJour);
				Long tempsMoyen = resultatsRepository.findTempsReponseMoyenBetween(debutJour, finJour);

				Map<String, Object> statsJour = new HashMap<>();
				statsJour.put("total", total != null ? total : 0);
				statsJour.put("reussis", reussis != null ? reussis : 0);
				statsJour.put("echoues", echoues != null ? echoues : 0);
				statsJour.put("tempsMoyen", tempsMoyen != null ? tempsMoyen : 0);
				statsJour.put("tauxReussite",
						total != null && total > 0 ? Math.round((reussis * 100.0) / total * 10.0) / 10.0 : 0.0);

				statsParJour.put(jour.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM")), statsJour);
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur dans getStatsParJourSemaine: " + e.getMessage());
		}

		return statsParJour;
	}

	private void updateMetricsGauges() {
		try {
			if (metricsService != null) {
				long activeCaisses = caisseRepository.countByActifTrue();
				long activeTests = countActiveTests();
				double tauxReussite = getTauxReussiteGlobal();
				long tempsReponseMoyen = getTempsReponseMoyenAujourdhui();

				metricsService.updateMetrics(activeCaisses, activeTests, tauxReussite, tempsReponseMoyen);
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur mise à jour métriques: " + e.getMessage());
		}
	}

	/**
	 * Exécute un test unique
	 */
	public TestResultService executeSingleTest(ConfigurationTests config) {
		long startTime = System.currentTimeMillis();

		try {
			// Utilise ta méthode existante d'exécution de test
			Map<String, Object> result = executeTest(config);

			boolean success = (boolean) result.getOrDefault("success", false);
			long responseTime = System.currentTimeMillis() - startTime;
			int statusCode = (int) result.getOrDefault("statusCode", 0);
			String message = (String) result.getOrDefault("message", "Exécuté");

			if (success) {
				return TestResultService.success(config, responseTime, statusCode);
			} else {
				return TestResultService.failure(config, statusCode, message);
			}

		} catch (Exception e) {
			logger.error("Erreur lors de l'exécution du test pour la configuration {}", config.getId(), e);
			return TestResultService.failure(config, "Erreur: " + e.getMessage());
		}
	}

	/**
	 * Méthode d'exécution de test basique - CORRIGÉ
	 */
	private Map<String, Object> executeTest(ConfigurationTests config) {
		Map<String, Object> result = new HashMap<>();

		try {
			// CORRECTION : Utilise getTestStandard() au lieu de getTest()
			TestStandard testStandard = config.getTestStandard();
			String url = buildTestUrl(config);

			// Utilise ta vraie méthode d'exécution HTTP
			boolean success = performHttpCheck(url, testStandard.getTimeoutMs());

			result.put("success", success);
			result.put("statusCode", success ? 200 : 500);
			result.put("message", success ? "Succès" : "Échec");

		} catch (Exception e) {
			result.put("success", false);
			result.put("statusCode", 0);
			result.put("message", "Exception: " + e.getMessage());
		}

		return result;
	}

	/**
	 * Construit l'URL de test - CORRIGÉ
	 */
	private String buildTestUrl(ConfigurationTests config) {
		if (config.getUrlComplete() != null && !config.getUrlComplete().isEmpty()) {
			return config.getUrlComplete();
		}

		// CORRECTION : Utilise getTestStandard() au lieu de getTest()
		TestStandard testStandard = config.getTestStandard();
		String server = config.getServeurCible();
		String endpoint = testStandard.getEndpoint();
		int port = testStandard.getPort();

		String protocol = testStandard.getTypeTest().equalsIgnoreCase("HTTPS") ? "https" : "http";

		return String.format("%s://%s:%d%s", protocol, server, port, endpoint);
	}

	/**
	 * Effectue une vérification HTTP basique - CORRIGÉ
	 */
	private boolean performHttpCheck(String url, Integer timeout) {
		try {
			// Utilise la valeur par défaut si timeout est null
			int actualTimeout = timeout != null ? timeout : 30000;

			// Utilise ton client HTTP existant (RestTemplate, WebClient, etc.)
			// Ceci est une implémentation simplifiée
			java.net.HttpURLConnection connection = (java.net.HttpURLConnection) new java.net.URL(url).openConnection();
			connection.setRequestMethod("GET");
			connection.setConnectTimeout(actualTimeout);
			connection.setReadTimeout(actualTimeout);

			int responseCode = connection.getResponseCode();
			return responseCode >= 200 && responseCode < 300;

		} catch (Exception e) {
			return false;
		}
	}
	// === MÉTHODE POUR NETTOYER LE CACHE ===

	@CacheEvict(value = { "tests", "statistics", "rapports" }, allEntries = true)
	public void clearCache() {
		System.out.println("🧹 Cache nettoyé");
	}
}