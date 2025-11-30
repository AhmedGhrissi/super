package com.example.monitor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.service.ServeurStatsService;

@RestController
@RequestMapping("/api/tests")
public class TestRapideController {

	private final ServeurStatsService statsService;

	// AJOUTEZ CE CONSTRUCTEUR
	public TestRapideController(ServeurStatsService statsService) {
		this.statsService = statsService;
	}

	@PostMapping("/rapide/{serveurNom}")
	public ResponseEntity<Map<String, Object>> testerServeur(@PathVariable String serveurNom) {
		try {
			// Simulation de test - à remplacer par la vraie logique
			boolean succes = Math.random() > 0.3; // 70% de succès
			Long tempsReponse = 100 + (long) (Math.random() * 400); // 100-500ms

			// Mettre à jour les statistiques
			statsService.mettreAJourStatistiques(serveurNom, succes, tempsReponse);

			Map<String, Object> resultat = new HashMap<>();
			resultat.put("serveur", serveurNom);
			resultat.put("succes", succes);
			resultat.put("tempsReponse", tempsReponse);
			resultat.put("message", succes ? "✅ Test réussi" : "❌ Test échoué");

			return ResponseEntity.ok(resultat);

		} catch (Exception e) {
			Map<String, Object> erreur = new HashMap<>();
			erreur.put("erreur", "Échec du test: " + e.getMessage());
			return ResponseEntity.status(500).body(erreur);
		}
	}
}
