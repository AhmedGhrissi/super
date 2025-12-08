package com.example.monitor.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.monitor.model.ResultatsTests;
import com.example.monitor.repository.ResultatsTestsRepository;
import com.example.monitor.service.ServeurStatsService;

@Controller
@RequestMapping("/test-rapide")
public class TestRapideController {

	@Autowired
	private ResultatsTestsRepository resultatsTestsRepository;

	@Autowired
	private ServeurStatsService serveurStatsService;

	@GetMapping("")
	public String testRapidePage() {
		return "test-rapide";
	}

	@PostMapping("/executer")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> executerTestRapide(@RequestParam String nomServeur,
			@RequestParam boolean succes, @RequestParam(required = false) String message) {

		Map<String, Object> response = new HashMap<>();

		try {
			System.out.println("🧪 Test rapide pour " + nomServeur + " - Succès: " + succes);

			// 1. Créer et sauvegarder le résultat du test selon VOTRE modèle
			ResultatsTests resultat = new ResultatsTests();

			// ⭐⭐ SETTERS EXACTS selon votre modèle ResultatsTests.java ⭐⭐
			resultat.setServeurCible(nomServeur); // VOTRE CHAMP EST "serveurCible"
			resultat.setSucces(succes);
			resultat.setMessage(message != null ? message : (succes ? "Test réussi" : "Test échoué"));
			resultat.setDateExecution(LocalDateTime.now());
			resultat.setTempsReponse(150L); // VOTRE CHAMP EST "tempsReponse"
			resultat.setCodeStatut(succes ? 200 : 500); // HTTP 200 OK ou 500 Error

			// Optionnel: Définir caisseCode et typeServeur si vous les avez
			// resultat.setCaisseCode("DEFAULT");
			// resultat.setTypeServeur("APPLICATION");

			// Sauvegarder
			ResultatsTests savedResult = resultatsTestsRepository.save(resultat);
			System.out.println("✅ Test enregistré avec ID: " + savedResult.getId());

			// 2. Mettre à jour les statistiques du serveur
			serveurStatsService.mettreAJourStatistiques(nomServeur, succes, 150L);

			response.put("success", true);
			response.put("message", "Test exécuté avec succès");
			response.put("testId", savedResult.getId());
			response.put("serveur", nomServeur);
			response.put("succes", succes);

			return ResponseEntity.ok(response);

		} catch (Exception e) {
			System.err.println("❌ Erreur test rapide: " + e.getMessage());
			e.printStackTrace();

			// Même en cas d'erreur, on essaie de mettre à jour les stats
			try {
				serveurStatsService.mettreAJourStatistiques(nomServeur, succes, 150L);
				System.out.println("✅ Statistiques mises à jour malgré l'erreur d'enregistrement");
			} catch (Exception e2) {
				System.err.println("⚠️ Impossible de mettre à jour les stats: " + e2.getMessage());
			}

			response.put("success", false);
			response.put("message", "Erreur: " + e.getMessage());
			return ResponseEntity.badRequest().body(response);
		}
	}

	@GetMapping("/simuler")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> simulerTests() {
		Map<String, Object> response = new HashMap<>();

		try {
			System.out.println("🎯 Simulation de tests pour plusieurs serveurs");

			// Serveurs de test
			String[] serveurs = { "SRV-PROD-01", "SRV-PROD-02", "SRV-TEST-01", "SRV-DB-01", "SRV-WEB-01",
					"SRV-API-01" };

			int totalTests = 0;
			int testsReussis = 0;

			for (String serveur : serveurs) {
				// 80% de chance de succès pour la simulation
				boolean succes = Math.random() > 0.2;
				Long tempsReponse = (long) (Math.random() * 300 + 50); // 50-350ms

				// Créer le résultat
				ResultatsTests resultat = new ResultatsTests();
				resultat.setServeurCible(serveur);
				resultat.setSucces(succes);
				resultat.setMessage("Test simulé - " + (succes ? "Réussi" : "Échoué"));
				resultat.setDateExecution(LocalDateTime.now());
				resultat.setTempsReponse(tempsReponse);
				resultat.setCodeStatut(succes ? 200 : 500);

				// Optionnel
				resultat.setCaisseCode("SIM");
				resultat.setTypeServeur("SIMULATION");

				// Sauvegarder
				resultatsTestsRepository.save(resultat);

				// Mettre à jour les stats
				serveurStatsService.mettreAJourStatistiques(serveur, succes, tempsReponse);

				if (succes) {
					testsReussis++;
				}
				totalTests++;
			}

			double tauxReussite = totalTests > 0 ? (testsReussis * 100.0) / totalTests : 0;

			response.put("success", true);
			response.put("message", "Simulation terminée - " + totalTests + " tests effectués");
			response.put("totalTests", totalTests);
			response.put("testsReussis", testsReussis);
			response.put("tauxReussite", String.format("%.1f", tauxReussite) + "%");
			response.put("serveurs", serveurs);

			return ResponseEntity.ok(response);

		} catch (Exception e) {
			System.err.println("❌ Erreur simulation: " + e.getMessage());
			response.put("success", false);
			response.put("message", "Erreur simulation: " + e.getMessage());
			return ResponseEntity.badRequest().body(response);
		}
	}

	@GetMapping("/stats-test")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getTestStats() {
		Map<String, Object> response = new HashMap<>();

		try {
			// Compter les tests dans la base
			long totalTests = resultatsTestsRepository.count();

			// Tests aujourd'hui
			long testsAujourdhui = resultatsTestsRepository
					.countByDateExecutionAfter(LocalDateTime.now().withHour(0).withMinute(0).withSecond(0));

			// Tests réussis aujourd'hui
			long testsReussisAujourdhui = resultatsTestsRepository.countBySuccesTrueAndDateExecutionAfter(
					LocalDateTime.now().withHour(0).withMinute(0).withSecond(0));

			response.put("success", true);
			response.put("totalTests", totalTests);
			response.put("testsAujourdhui", testsAujourdhui);
			response.put("testsReussisAujourdhui", testsReussisAujourdhui);
			response.put("tauxReussiteAujourdhui",
					testsAujourdhui > 0
							? String.format("%.1f", (testsReussisAujourdhui * 100.0) / testsAujourdhui) + "%"
							: "N/A");

			return ResponseEntity.ok(response);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Erreur stats: " + e.getMessage());
			return ResponseEntity.internalServerError().body(response);
		}
	}
}