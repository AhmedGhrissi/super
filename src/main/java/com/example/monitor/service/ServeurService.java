package com.example.monitor.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.Caisse;
import com.example.monitor.model.Serveur;
import com.example.monitor.model.Serveur.StatutServeur;
import com.example.monitor.repository.CaisseRepository;
import com.example.monitor.repository.MiseAJourRepository;
import com.example.monitor.repository.ServeurRepository;

@Service
@Transactional
public class ServeurService {

	private final ServeurRepository serveurRepository;
	private final MiseAJourRepository miseAJourRepository;
	private final CaisseRepository caisseRepository;

	@Autowired
	private ServeurStatsService serveurStatsService;

	public ServeurService(ServeurRepository serveurRepository, MiseAJourRepository miseAJourRepository,
			CaisseRepository caisseRepository) {
		this.serveurRepository = serveurRepository;
		this.miseAJourRepository = miseAJourRepository;
		this.caisseRepository = caisseRepository;
	}

	// === MÉTHODES CRUD ===

	@CacheEvict(value = { "serveurs", "statistiquesServeurs" }, allEntries = true)
	public Serveur save(Serveur serveur) {
		return serveurRepository.save(serveur);
	}

	@Cacheable("serveurs")
	public List<Serveur> findAll() {
		return serveurRepository.findAllOrderByDateCreationDesc();
	}

	public Optional<Serveur> findById(Long id) {
		return serveurRepository.findById(id);
	}

	@CacheEvict(value = { "serveurs", "statistiquesServeurs" }, allEntries = true)
	public void deleteById(Long id) {
		serveurRepository.deleteById(id);
	}

	// === MÉTHODES DE COMPTAGE ===

	public long countTotal() {
		return serveurRepository.count();
	}

	public long countAll() {
		return serveurRepository.count();
	}

	public long countActifs() {
		return serveurRepository.countByStatut(StatutServeur.ACTIF);
	}

	public long countProduction() {
		return serveurRepository.countByEnvironnement(Serveur.Environnement.PRODUCTION);
	}

	public long countByEnvironnement(Serveur.Environnement environnement) {
		return serveurRepository.countByEnvironnement(environnement);
	}

	public long countByStatut(StatutServeur statut) {
		return serveurRepository.countByStatut(statut);
	}

	/**
	 * Récupérer toutes les caisses avec leurs serveurs
	 */
	public List<Caisse> getCaissesAvecServeurs() {
		try {
			List<Caisse> caisses = caisseRepository.findAll();

			// Pour chaque caisse, récupérer ses serveurs
			for (Caisse caisse : caisses) {
				List<Serveur> serveurs = serveurRepository.findByCaisseCode(caisse.getCode());
				caisse.setServeurs(serveurs); // Si votre modèle Caisse a cette relation
			}

			return caisses;
		} catch (Exception e) {
			System.err.println("❌ Erreur getCaissesAvecServeurs: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	/**
	 * Alternative : Récupérer les codes de caisse distincts avec le nombre de
	 * serveurs
	 */
	public Map<String, Long> getCaissesAvecNbServeurs() {
		try {
			List<Serveur> serveurs = findAll();
			Map<String, Long> result = new HashMap<>();

			for (Serveur serveur : serveurs) {
				String codeCaisse = serveur.getCaisseCode();
				if (codeCaisse != null && !codeCaisse.isEmpty()) {
					result.put(codeCaisse, result.getOrDefault(codeCaisse, 0L) + 1);
				}
			}

			return result;
		} catch (Exception e) {
			System.err.println("❌ Erreur getCaissesAvecNbServeurs: " + e.getMessage());
			return new HashMap<>();
		}
	}

	/**
	 * Récupérer tous les serveurs groupés par caisse
	 */
	public Map<String, List<Serveur>> getServeursParCaisse() {
		try {
			List<Serveur> serveurs = findAll();
			Map<String, List<Serveur>> result = new HashMap<>();

			for (Serveur serveur : serveurs) {
				String codeCaisse = serveur.getCaisseCode();
				if (codeCaisse != null && !codeCaisse.isEmpty()) {
					result.computeIfAbsent(codeCaisse, k -> new ArrayList<>()).add(serveur);
				}
			}

			return result;
		} catch (Exception e) {
			System.err.println("❌ Erreur getServeursParCaisse: " + e.getMessage());
			return new HashMap<>();
		}
	}

	// === MÉTHODES DE STATISTIQUES ===

	public double calculerTauxDisponibilite() {
		try {
			// Utiliser le service de statistiques
			Double moyenne = serveurStatsService.getDisponibiliteMoyenne();
			return moyenne != null ? moyenne : 95.0;
		} catch (Exception e) {
			System.err.println("⚠️ Erreur calcul disponibilité: " + e.getMessage());
			return 95.0; // Valeur par défaut
		}
	}

	@Cacheable("statistiquesServeurs")
	public Map<String, Object> getStatistiques() {
		Map<String, Object> stats = new HashMap<>();

		List<Serveur> serveurs = findAll();
		long totalServeurs = countTotal();
		long serveursActifs = countActifs();
		long serveursProduction = countProduction();

		stats.put("totalServeurs", totalServeurs);
		stats.put("serveursActifs", serveursActifs);
		stats.put("serveursProduction", serveursProduction);
		stats.put("serveursMaintenance", countByStatut(StatutServeur.MAINTENANCE));
		stats.put("serveursHorsLigne", countByStatut(StatutServeur.HORS_LIGNE));
		stats.put("tauxDisponibilite", calculerTauxDisponibilite());

		// Statistiques par type
		stats.put("statsParType", getStatsParType());

		return stats;
	}

	public Map<String, Long> getStatsParType() {
		Map<String, Long> stats = new HashMap<>();
		List<Serveur> serveurs = findAll();

		for (Serveur.TypeServeur type : Serveur.TypeServeur.values()) {
			long count = serveurs.stream().filter(s -> s.getTypeServeur() == type).count();
			stats.put(type.name(), count);
		}

		return stats;
	}

	// === NOUVELLES MÉTHODES POUR SERVEURS CRITIQUES ===

	public List<Map<String, Object>> getServeursCritiques() {
		try {
			System.out.println("🔍 getServeursCritiques() appelée dans ServeurService");

			// Récupérer tous les serveurs
			List<Serveur> serveurs = findAll();

			// Filtrer les serveurs critiques (non actifs ou avec statut problématique)
			return serveurs.stream().filter(serveur -> !serveur.getStatut().equals(StatutServeur.ACTIF))
					.map(serveur -> {
						Map<String, Object> map = new HashMap<>();
						map.put("id", serveur.getId());
						map.put("nom", serveur.getNom());
						map.put("adresseIP", serveur.getAdresseIP());
						map.put("statut", serveur.getStatut().name());
						map.put("environnement", serveur.getEnvironnement().name());
						map.put("typeServeur", serveur.getTypeServeur().name());
						map.put("caisseCode", serveur.getCaisseCode());
						map.put("dateCreation", serveur.getDateCreation());

						// Déterminer le niveau de criticité
						String criticite = "WARNING";
						String icone = "⚠️";
						String message = "Serveur " + serveur.getStatut().name();

						if (serveur.getStatut().equals(StatutServeur.HORS_LIGNE)) {
							criticite = "CRITICAL";
							icone = "🔴";
							message = "Serveur hors ligne";
						} else if (serveur.getStatut().equals(StatutServeur.MAINTENANCE)) {
							criticite = "MAINTENANCE";
							icone = "🟡";
							message = "En maintenance";
						} else if (serveur.getStatut().equals(StatutServeur.ERREUR)) {
							criticite = "ERROR";
							icone = "🔴";
							message = "Erreur serveur";
						}

						map.put("criticite", criticite);
						map.put("icone", icone);
						map.put("message", message);
						map.put("timestamp", System.currentTimeMillis());

						return map;
					}).toList();

		} catch (Exception e) {
			System.err.println("❌ Erreur dans getServeursCritiques: " + e.getMessage());
			e.printStackTrace();
			return List.of();
		}
	}

	// ... garder tout le début du fichier jusqu'à la méthode getServeursAvecStatut
	// ...

	// === NOUVELLE MÉTHODE POUR ALERTES ===

	public List<Map<String, Object>> getServeursAvecStatut() {
		try {
			List<Serveur> serveurs = findAll();
			List<Map<String, Object>> result = new ArrayList<>();

			for (Serveur serveur : serveurs) {
				Map<String, Object> map = new HashMap<>();
				map.put("id", serveur.getId());
				map.put("nom", serveur.getNom());
				map.put("adresseIP", serveur.getAdresseIP());
				map.put("statut", serveur.getStatut().name());
				// map.put("dernierCheck", serveur.getDernierCheck()); // Retirer si non
				// existant
				map.put("typeServeur", serveur.getTypeServeur().name());
				map.put("environnement", serveur.getEnvironnement().name());

				// Déterminer la criticité
				String criticite = "INFO";
				if (serveur.getStatut() == StatutServeur.HORS_LIGNE) {
					criticite = "CRITICAL";
				} else if (serveur.getStatut() == StatutServeur.ERREUR) {
					criticite = "WARNING";
				} else if (serveur.getStatut() == StatutServeur.MAINTENANCE) {
					criticite = "WARNING";
				}

				map.put("criticite", criticite);
				result.add(map);
			}

			return result;
		} catch (Exception e) {
			System.err.println("❌ Erreur getServeursAvecStatut: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	// ... continuer avec le reste du fichier ...

	// Corriger la méthode getAllCodesCaisse
	public List<String> getAllCodesCaisse() {
		try {
			return serveurRepository.findAll().stream().map(Serveur::getCaisseCode).distinct()
					.filter(code -> code != null && !code.isEmpty()).toList();
		} catch (Exception e) {
			System.err.println("❌ Erreur getAllCodesCaisse: " + e.getMessage());
			return List.of();
		}
	}

	// Corriger la méthode verifierTousLesServeurs
	public void verifierTousLesServeurs() {
		try {
			System.out.println("🔍 Vérification manuelle de tous les serveurs...");
			List<Serveur> serveurs = findAll();

			// Logique de vérification simple
			for (Serveur serveur : serveurs) {
				if (serveur.getStatut() == StatutServeur.HORS_LIGNE) {
					System.out.println("⚠️ Serveur hors ligne: " + serveur.getNom());
				}
			}

			System.out.println("✅ Vérification des serveurs terminée");
		} catch (Exception e) {
			System.err.println("❌ Erreur verifierTousLesServeurs: " + e.getMessage());
		}
	}

	public Double getTempsReponseMoyen() {
		try {
			// Si vous n'avez pas getAverageResponseTime(), utilisez une autre méthode
			// Option 1: Implémentation simple
			List<com.example.monitor.model.Serveur> serveurs = serveurRepository.findAll();
			if (serveurs.isEmpty()) {
				return 50.0;
			}

			double totalTemps = 0.0;
			int count = 0;
			for (com.example.monitor.model.Serveur serveur : serveurs) {
				// Récupérer le temps de réponse depuis les métriques
				// Adaptez selon votre modèle
				if (serveur.getTempsReponse() != null && serveur.getTempsReponse() > 0) {
					totalTemps += serveur.getTempsReponse();
					count++;
				}
			}

			return count > 0 ? totalTemps / count : 50.0;

		} catch (Exception e) {
			return 50.0; // Valeur par défaut
		}
	}
}