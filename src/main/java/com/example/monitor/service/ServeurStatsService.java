package com.example.monitor.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.ServeurStatistiques;
import com.example.monitor.repository.ServeurStatistiquesRepository;

@Service
@Transactional
public class ServeurStatsService {

	@Autowired
	private ServeurStatistiquesRepository serveurStatsRepository;

	// ========== MÉTHODES POUR LE DASHBOARD ==========
	public Double getDisponibiliteMoyenne() {
		try {
			Double moyenne = serveurStatsRepository.getDisponibiliteMoyenne();
			return moyenne != null ? moyenne : 95.0;
		} catch (Exception e) {
			// Calcul manuel
			List<ServeurStatistiques> toutesStats = serveurStatsRepository.findAll();
			if (toutesStats.isEmpty()) {
				return 95.0;
			}

			double somme = 0.0;
			int count = 0;
			for (ServeurStatistiques stats : toutesStats) {
				if (stats.getDisponibilitePercent() != null) {
					somme += stats.getDisponibilitePercent().doubleValue();
					count++;
				}
			}
			return count > 0 ? somme / count : 95.0;
		}
	}

	public List<ServeurStatistiques> getServeursAvecProblemes() {
		try {
			return serveurStatsRepository.findServeursAvecProblemes();
		} catch (Exception e) {
			// Alternative
			List<ServeurStatistiques> allStats = serveurStatsRepository.findAll();
			return allStats.stream().filter(stats -> stats.getDisponibilitePercent() != null)
					.filter(stats -> stats.getDisponibilitePercent().compareTo(new BigDecimal(80)) < 0).toList();
		}
	}

	// ========== MÉTHODES EXISTANTES ==========
	public List<ServeurStatistiques> getServeursCritiques() {
		return getServeursAvecProblemes();
	}

	public List<ServeurStatistiques> findAllServeursStats() {
		return serveurStatsRepository.findAll();
	}

	public Optional<ServeurStatistiques> findServeurStatsByNom(String nomServeur) {
		return serveurStatsRepository.findByServeurNom(nomServeur);
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

	public Map<String, Object> getStatistiquesGlobales() {
		Map<String, Object> stats = new java.util.HashMap<>();

		try {
			long totalServeurs = serveurStatsRepository.countTotalServeurs();
			Long totalTests = serveurStatsRepository.sumTotalTests();
			Long testsSucces = serveurStatsRepository.sumTestsSucces();
			Double disponibiliteMoyenne = serveurStatsRepository.getDisponibiliteMoyenne();

			stats.put("totalServeurs", totalServeurs);
			stats.put("totalTests", totalTests != null ? totalTests : 0);
			stats.put("testsSucces", testsSucces != null ? testsSucces : 0);
			stats.put("disponibiliteMoyenne", disponibiliteMoyenne != null ? disponibiliteMoyenne : 95.0);

		} catch (Exception e) {
			stats.put("totalServeurs", 0);
			stats.put("totalTests", 0);
			stats.put("testsSucces", 0);
			stats.put("disponibiliteMoyenne", 95.0);
		}

		return stats;
	}

	public List<ServeurStatistiques> getTopServeurs() {
		try {
			return serveurStatsRepository.findTopByDisponibilite();
		} catch (Exception e) {
			return serveurStatsRepository.findAll().stream().filter(stats -> stats.getDisponibilitePercent() != null)
					.sorted((a, b) -> b.getDisponibilitePercent().compareTo(a.getDisponibilitePercent())).limit(10)
					.toList();
		}
	}

	public List<ServeurStatistiques> getServeursCritiquesSimilaires(String typeServeur) {
		try {
			return serveurStatsRepository.findServeursCritiquesParType(typeServeur);
		} catch (Exception e) {
			return serveurStatsRepository.findByTypeServeur(typeServeur).stream()
					.filter(stats -> stats.getDisponibilitePercent() != null)
					.filter(stats -> stats.getDisponibilitePercent().compareTo(new BigDecimal(80)) < 0).toList();
		}
	}

	// ========== MÉTHODE POUR TestRapideController ==========
	public void mettreAJourStatistiques(String nomServeur, boolean succes, Long dureeExecution) {
		try {
			ServeurStatistiques stats = serveurStatsRepository.findByServeurNom(nomServeur).orElseGet(() -> {
				ServeurStatistiques newStats = new ServeurStatistiques();
				newStats.setServeurNom(nomServeur);
				newStats.setTestsTotal(0L);
				newStats.setTestsSucces(0L);
				newStats.setTestsEchec(0L);
				newStats.setDisponibilitePercent(new BigDecimal("100.00"));
				newStats.setTempsReponseMoyen(0L);
				newStats.setDateMaj(LocalDateTime.now());
				return newStats;
			});

			// Initialiser si null
			if (stats.getTestsTotal() == null) {
				stats.setTestsTotal(0L);
			}
			if (stats.getTestsSucces() == null) {
				stats.setTestsSucces(0L);
			}
			if (stats.getTestsEchec() == null) {
				stats.setTestsEchec(0L);
			}
			if (stats.getTempsReponseMoyen() == null) {
				stats.setTempsReponseMoyen(0L);
			}
			if (stats.getDisponibilitePercent() == null) {
				stats.setDisponibilitePercent(new BigDecimal("0.00"));
			}

			// Mettre à jour
			stats.setTestsTotal(stats.getTestsTotal() + 1);
			if (succes) {
				stats.setTestsSucces(stats.getTestsSucces() + 1);
			} else {
				stats.setTestsEchec(stats.getTestsEchec() + 1);
			}

			// Calculer temps de réponse moyen
			if (dureeExecution != null && stats.getTestsTotal() > 0) {
				Long totalTemps = stats.getTempsReponseMoyen() * (stats.getTestsTotal() - 1) + dureeExecution;
				stats.setTempsReponseMoyen(totalTemps / stats.getTestsTotal());
			}

			// Calculer disponibilité
			if (stats.getTestsTotal() > 0) {
				BigDecimal succesBD = new BigDecimal(stats.getTestsSucces());
				BigDecimal totalBD = new BigDecimal(stats.getTestsTotal());
				BigDecimal pourcentage = succesBD.divide(totalBD, 4, java.math.RoundingMode.HALF_UP)
						.multiply(new BigDecimal("100")).setScale(2, java.math.RoundingMode.HALF_UP);
				stats.setDisponibilitePercent(pourcentage);
			}

			stats.setDateMaj(LocalDateTime.now());
			serveurStatsRepository.save(stats);

		} catch (Exception e) {
			System.err.println("⚠️ Erreur mise à jour statistiques pour " + nomServeur + ": " + e.getMessage());
		}
	}

	public long countServeursAvecProblemes() {
		List<ServeurStatistiques> problemes = getServeursAvecProblemes();
		return problemes != null ? problemes.size() : 0;
	}

	public Double getDisponibiliteMoyenneParDate(LocalDate date) {
		// Implémentez cette méthode selon votre logique
		// Par exemple, si vous avez un historique par date
		try {
			// Exemple : chercher dans une table d'historique
			return null; // À adapter
		} catch (Exception e) {
			return null;
		}
	}
}