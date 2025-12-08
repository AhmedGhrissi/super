package com.example.monitor.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.Alert;
import com.example.monitor.model.Serveur;
import com.example.monitor.model.enums.CriticiteAlerte;
import com.example.monitor.repository.AlertRepository;

@Service
@Transactional
public class AlertService {

	@Autowired
	private AlertRepository alertRepository;

	@Autowired
	private ServeurService serveurService;

	@Autowired
	private TestService testService;

	// ========== MÉTHODES DE BASE ==========

	@Transactional(readOnly = true)
	public Alert findById(Long id) {
		try {
			Optional<Alert> alerte = alertRepository.findById(id);
			return alerte.orElse(null);
		} catch (Exception e) {
			System.err.println("❌ Erreur findById: " + e.getMessage());
			return null;
		}
	}

	public Alert getAlerteById(Long id) {
		return findById(id); // Alias pour compatibilité
	}

	public Alert save(Alert alerte) {
		try {
			return alertRepository.save(alerte);
		} catch (Exception e) {
			System.err.println("❌ Erreur save: " + e.getMessage());
			return null;
		}
	}

	public void deleteById(Long id) {
		try {
			alertRepository.deleteById(id);
		} catch (Exception e) {
			System.err.println("❌ Erreur deleteById: " + e.getMessage());
		}
	}

	public void deleteAlert(Long id) {
		deleteById(id); // Alias pour compatibilité
	}

	// ========== MÉTHODES POUR LE DASHBOARD ==========

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getAlertesPourDashboard() {
		System.out.println("=== 🔍 getAlertesPourDashboard - VRAIES DONNÉES ===");

		List<Map<String, Object>> alertes = new ArrayList<>();

		try {
			// 1. Récupérer les alertes ACTIVES de la base
			List<Alert> alertesDB = alertRepository.findByResolueFalseOrderByDateCreationDesc();

			for (Alert alerte : alertesDB) {
				Map<String, Object> map = new HashMap<>();
				map.put("id", alerte.getId());
				map.put("nom", alerte.getTitre());
				map.put("icone", getIconForCriticite(alerte.getCriticite()));
				map.put("criticite", alerte.getCriticite().name());
				map.put("description", alerte.getDescription());
				map.put("type", alerte.getTypeAlerte() != null ? alerte.getTypeAlerte() : "GENERAL");
				map.put("timestampDisplay", alerte.getDateCreation().format(DateTimeFormatter.ofPattern("HH:mm")));
				map.put("statutCourt", "Actif");
				map.put("serveurCible", alerte.getServeurCible());

				alertes.add(map);
			}

			System.out.println("✅ Alertes trouvées dans la base: " + alertes.size());

			// 2. Si aucune alerte, vérifier les serveurs critiques
			if (alertes.isEmpty()) {
				System.out.println("🔍 Vérification des serveurs critiques...");
				alertes.addAll(getAlertesFromServeursCritiques());
			}

		} catch (Exception e) {
			System.err.println("❌ ERREUR getAlertesPourDashboard: " + e.getMessage());
		}

		return alertes;
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getAlertesPourAPI() {
		try {
			List<Alert> alertes = getAlertesNonResolues();
			List<Map<String, Object>> result = new ArrayList<>();

			for (Alert alerte : alertes) {
				Map<String, Object> map = new HashMap<>();
				map.put("id", alerte.getId());
				map.put("nom", alerte.getTitre());
				map.put("icone", getIconForCriticite(alerte.getCriticite()));
				map.put("criticite", alerte.getCriticite().name());
				map.put("description", alerte.getDescription());
				map.put("type", alerte.getTypeAlerte() != null ? alerte.getTypeAlerte() : "GENERAL");
				map.put("timestampDisplay", alerte.getDateCreation().format(DateTimeFormatter.ofPattern("HH:mm")));
				map.put("statutCourt", alerte.getResolue() ? "Résolue" : "Active");
				map.put("serveurCible", alerte.getServeurCible());
				map.put("timestamp", alerte.getDateCreation());

				result.add(map);
			}

			return result;
		} catch (Exception e) {
			System.err.println("❌ Erreur getAlertesPourAPI: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	@Transactional(readOnly = true)
	public Map<String, Integer> getStatsAlertes() {
		Map<String, Integer> stats = new HashMap<>();

		try {
			List<Alert> alertesNonResolues = getAlertesNonResolues();

			long critical = alertesNonResolues.stream().filter(a -> a.getCriticite() == CriticiteAlerte.CRITICAL)
					.count();
			long warning = alertesNonResolues.stream().filter(a -> a.getCriticite() == CriticiteAlerte.WARNING).count();
			long info = alertesNonResolues.stream().filter(a -> a.getCriticite() == CriticiteAlerte.INFO).count();

			stats.put("total", alertesNonResolues.size());
			stats.put("critical", (int) critical);
			stats.put("warning", (int) warning);
			stats.put("info", (int) info);

		} catch (Exception e) {
			System.err.println("❌ Erreur getStatsAlertes: " + e.getMessage());
			stats.put("total", 0);
			stats.put("critical", 0);
			stats.put("warning", 0);
			stats.put("info", 0);
		}

		return stats;
	}

	// ========== MÉTHODES POUR LES LISTES ==========

	@Transactional(readOnly = true)
	public List<Alert> getAllAlertes() {
		try {
			return alertRepository.findAllByOrderByDateCreationDesc();
		} catch (Exception e) {
			System.err.println("❌ Erreur getAllAlertes: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	@Transactional(readOnly = true)
	public Page<Alert> getAllAlertes(Pageable pageable) {
		try {
			List<Alert> alertes = getAllAlertes();
			return new PageImpl<>(alertes, pageable, alertes.size());
		} catch (Exception e) {
			System.err.println("❌ Erreur getAllAlertes(pageable): " + e.getMessage());
			return Page.empty();
		}
	}

	@Transactional(readOnly = true)
	public List<Alert> getAlertesByCriticite(CriticiteAlerte criticite) {
		try {
			return alertRepository.findByCriticiteAndResolueFalseOrderByDateCreationDesc(criticite);
		} catch (Exception e) {
			System.err.println("❌ Erreur getAlertesByCriticite: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	@Transactional(readOnly = true)
	public Page<Alert> getAlertesByCriticite(CriticiteAlerte criticite, Pageable pageable) {
		try {
			List<Alert> alertes = getAlertesByCriticite(criticite);
			return new PageImpl<>(alertes, pageable, alertes.size());
		} catch (Exception e) {
			System.err.println("❌ Erreur getAlertesByCriticite(pageable): " + e.getMessage());
			return Page.empty();
		}
	}

	@Transactional(readOnly = true)
	public List<Alert> getAlertesNonResolues() {
		try {
			return alertRepository.findByResolueFalseOrderByDateCreationDesc();
		} catch (Exception e) {
			System.err.println("❌ Erreur getAlertesNonResolues: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	@Transactional(readOnly = true)
	public List<Alert> getAlertesCritiques() {
		try {
			return getAlertesByCriticite(CriticiteAlerte.CRITICAL);
		} catch (Exception e) {
			System.err.println("❌ Erreur getAlertesCritiques: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	@Transactional(readOnly = true)
	public List<Alert> getAlertesActives() {
		return getAlertesNonResolues(); // Alias
	}

	// ========== MÉTHODES POUR CRÉATION/RÉSOLUTION ==========

	public Alert createAlert(String titre, String description, CriticiteAlerte criticite, String type,
			String serveurCible) {
		try {
			Alert alerte = new Alert();
			alerte.setTitre(titre);
			alerte.setDescription(description);
			alerte.setCriticite(criticite);
			alerte.setTypeAlerte(type);
			alerte.setServeurCible(serveurCible);
			alerte.setDateCreation(LocalDateTime.now());
			alerte.setResolue(false);

			return alertRepository.save(alerte);
		} catch (Exception e) {
			System.err.println("❌ Erreur createAlert: " + e.getMessage());
			return null;
		}
	}

	public void resolveAlert(Long id) {
		try {
			Alert alerte = findById(id);
			if (alerte != null) {
				alerte.setResolue(true);
				alerte.setDateResolution(LocalDateTime.now());
				alertRepository.save(alerte);
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur resolveAlert: " + e.getMessage());
		}
	}

	// ========== MÉTHODES POUR MAINTENANCE ==========

	public void rafraichirCacheAlertes() {
		try {
			LocalDateTime seuil = LocalDateTime.now().minusHours(24);
			List<Alert> vieillesAlertes = alertRepository.findByResolueFalseAndDateCreationBefore(seuil);

			for (Alert alerte : vieillesAlertes) {
				alerte.setResolue(true);
				alerte.setDateResolution(LocalDateTime.now());
			}

			if (!vieillesAlertes.isEmpty()) {
				alertRepository.saveAll(vieillesAlertes);
				System.out.println("🔄 " + vieillesAlertes.size() + " alertes archivées");
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur rafraichirCacheAlertes: " + e.getMessage());
		}
	}

	public void declencherVerificationManuelle() {
		try {
			System.out.println("🔍 Déclenchement vérification manuelle...");

			// Vérifier les serveurs
			if (serveurService != null) {
				serveurService.verifierTousLesServeurs();
			}

			// Vérifier les tests
			if (testService != null) {
				testService.executerTestsPrioritaires();
			}

			System.out.println("✅ Vérification manuelle exécutée");
		} catch (Exception e) {
			System.err.println("❌ Erreur declencherVerificationManuelle: " + e.getMessage());
		}
	}

	// ========== MÉTHODES UTILITAIRES ==========

	private List<Map<String, Object>> getAlertesFromServeursCritiques() {
		List<Map<String, Object>> alertes = new ArrayList<>();

		try {
			if (serveurService != null) {
				List<Serveur> serveurs = serveurService.findAll();

				for (Serveur serveur : serveurs) {
					if (serveur.getStatut() != Serveur.StatutServeur.ACTIF) {
						Map<String, Object> alerte = new HashMap<>();
						alerte.put("id", "serveur-" + serveur.getId());
						alerte.put("nom", "Serveur: " + serveur.getNom());
						alerte.put("icone", "🔴");
						alerte.put("criticite", "CRITICAL");
						alerte.put("description", "Serveur " + serveur.getNom() + " en statut " + serveur.getStatut());
						alerte.put("type", "serveur");
						alerte.put("timestampDisplay",
								LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm")));
						alerte.put("statutCourt", serveur.getStatut().name());
						alerte.put("serveurCible", serveur.getNom());

						alertes.add(alerte);
					}
				}
			}
		} catch (Exception e) {
			System.err.println("❌ Erreur getAlertesFromServeursCritiques: " + e.getMessage());
		}

		return alertes;
	}

	@Transactional(readOnly = true)
	public long getTestsEnErreurCount() {
		try {
			if (testService != null) {
				return testService.countTestsEchoues();
			}
			return 0;
		} catch (Exception e) {
			System.err.println("❌ Erreur getTestsEnErreurCount: " + e.getMessage());
			return 0;
		}
	}

	private String getIconForCriticite(CriticiteAlerte criticite) {
		if (criticite == null) {
			return "⚪";
		}

		switch (criticite) {
		case CRITICAL:
			return "🔴";
		case WARNING:
			return "🟡";
		case INFO:
			return "🔵";
		default:
			return "⚪";
		}
	}
}