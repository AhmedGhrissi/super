package com.example.monitor.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.ServeurStatistiques;
import com.example.monitor.repository.ServeurStatistiquesRepository;

@Service
@Transactional
public class ServeurStatsService {

	private final ServeurStatistiquesRepository serveurStatsRepository;

	public ServeurStatsService(ServeurStatistiquesRepository serveurStatsRepository) {
		this.serveurStatsRepository = serveurStatsRepository;
	}

	// === MÉTHODES POUR LES STATISTIQUES SERVEURS ===

	public List<ServeurStatistiques> findAllServeursStats() {
		return serveurStatsRepository.findAll();
	}

	public Optional<ServeurStatistiques> findServeurStatsByNom(String serveurNom) {
		return serveurStatsRepository.findByServeurNom(serveurNom);
	}

	public List<ServeurStatistiques> findServeursStatsByCaisse(String caisseCode) {
		return serveurStatsRepository.findByCaisseCode(caisseCode);
	}

	public List<ServeurStatistiques> findServeursStatsByType(String typeServeur) {
		return serveurStatsRepository.findByTypeServeur(typeServeur);
	}

	public List<ServeurStatistiques> findServeursStatsByCaisseAndType(String caisseCode, String typeServeur) {
		return serveurStatsRepository.findByCaisseCodeAndTypeServeur(caisseCode, typeServeur);
	}

	// === MÉTHODES DE STATISTIQUES GLOBALES ===

	public Map<String, Object> getStatistiquesGlobales() {
		Map<String, Object> stats = new HashMap<>();

		long totalServeurs = serveurStatsRepository.countTotalServeurs();
		Long totalTests = serveurStatsRepository.sumTotalTests();
		Long totalSucces = serveurStatsRepository.sumTestsSucces();
		Double disponibiliteMoyenne = serveurStatsRepository.getDisponibiliteMoyenne();

		stats.put("totalServeurs", totalServeurs);
		stats.put("totalTests", totalTests != null ? totalTests : 0);
		stats.put("totalSucces", totalSucces != null ? totalSucces : 0);
		stats.put("disponibiliteMoyenne", disponibiliteMoyenne != null ? disponibiliteMoyenne : 0.0);

		// Calcul du taux de réussite global
		double tauxReussiteGlobal = 0.0;
		if (totalTests != null && totalTests > 0 && totalSucces != null) {
			tauxReussiteGlobal = (totalSucces * 100.0) / totalTests;
		}
		stats.put("tauxReussiteGlobal", Math.round(tauxReussiteGlobal * 10.0) / 10.0);

		return stats;
	}

	// === MÉTHODES DE MISE À JOUR ===

	public void mettreAJourStatistiques(String serveurNom, boolean succes, Long tempsReponse) {
		Optional<ServeurStatistiques> statsOpt = serveurStatsRepository.findByServeurNom(serveurNom);
		if (statsOpt.isPresent()) {
			ServeurStatistiques stats = statsOpt.get();
			stats.incrementerTests(succes, tempsReponse);
			serveurStatsRepository.save(stats);
		} else {
			// Créer une nouvelle entrée si le serveur n'existe pas encore
			ServeurStatistiques nouvellesStats = new ServeurStatistiques(serveurNom, "inconnu", "inconnu");
			nouvellesStats.incrementerTests(succes, tempsReponse);
			serveurStatsRepository.save(nouvellesStats);
		}
	}

	// === MÉTHODES DE RECHERCHE AVANCÉE ===

	public List<ServeurStatistiques> getServeursAvecProblemes() {
		try {
			System.out.println("🔍 getServeursAvecProblemes() appelée");

			// Utilise la méthode existante du repository
			List<ServeurStatistiques> result = serveurStatsRepository.findServeursAvecProblemes();

			System.out.println("📊 getServeursAvecProblemes() résultat: " + result.size() + " serveur(s)");

			// Log détaillé
			for (ServeurStatistiques s : result) {
				System.out.println("   - " + s.getServeurNom() + " : " + s.getDisponibilitePercent() + "%");
			}

			return result;

		} catch (Exception e) {
			System.err.println("❌ Erreur getServeursAvecProblemes: " + e.getMessage());
			return List.of();
		}
	}

	public List<ServeurStatistiques> getTopServeurs() {
		return serveurStatsRepository.findTopByDisponibilite();
	}
}