package com.example.monitor.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.generator.ServeurDataGenerator;
import com.example.monitor.model.Serveur;
import com.example.monitor.repository.MiseAJourRepository;
import com.example.monitor.repository.ServeurRepository;

import jakarta.annotation.PostConstruct;

@Service
@Transactional
public class ServeurService {

	private final ServeurRepository serveurRepository;
	private final MiseAJourRepository miseAJourRepository;

	public ServeurService(ServeurRepository serveurRepository, MiseAJourRepository miseAJourRepository) {
		this.serveurRepository = serveurRepository;
		this.miseAJourRepository = miseAJourRepository;
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

	public long countActifs() {
		return serveurRepository.countByStatut(Serveur.StatutServeur.ACTIF);
	}

	public long countProduction() {
		return serveurRepository.countByEnvironnement(Serveur.Environnement.PRODUCTION);
	}

	public long countByEnvironnement(Serveur.Environnement environnement) {
		return serveurRepository.countByEnvironnement(environnement);
	}

	public long countByStatut(Serveur.StatutServeur statut) {
		return serveurRepository.countByStatut(statut);
	}

	// === MÉTHODES DE STATISTIQUES ===

	public double calculerTauxDisponibilite() {
		long totalServeurs = countTotal();
		long serveursActifs = countActifs();
		return totalServeurs > 0 ? Math.round((serveursActifs * 100.0) / totalServeurs * 10.0) / 10.0 : 0.0;
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
		stats.put("serveursMaintenance", countByStatut(Serveur.StatutServeur.MAINTENANCE));
		stats.put("serveursHorsLigne", countByStatut(Serveur.StatutServeur.HORS_LIGNE));
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

	// === MÉTHODES DE RECHERCHE ===

	public List<Serveur> findByCaisseCode(String caisseCode) {
		return serveurRepository.findByCaisseCode(caisseCode);
	}

	public List<Serveur> findByEnvironnement(Serveur.Environnement environnement) {
		return serveurRepository.findByEnvironnement(environnement);
	}

	public List<Serveur> findByStatut(Serveur.StatutServeur statut) {
		return serveurRepository.findByStatut(statut);
	}

	public List<String> getCaissesAvecServeurs() {
		return serveurRepository.findDistinctCaisseCodes();
	}

	// === MÉTHODES DE VÉRIFICATION ===

	public boolean existsByNom(String nom) {
		return serveurRepository.existsByNom(nom);
	}

	public boolean existsByAdresseIP(String adresseIP) {
		return serveurRepository.existsByAdresseIP(adresseIP);
	}

	@PostConstruct
	public void initializeServeurs() {
		if (serveurRepository.count() == 0) {
			List<Serveur> serveurs = ServeurDataGenerator.generateAllServeurs();
			serveurRepository.saveAll(serveurs);
			System.out.println("✅ " + serveurs.size() + " serveurs initialisés avec la nomenclature");
		}
	}

	/**
	 * Trouve les serveurs par code caisse
	 */
	public List<Serveur> findByCodeCaisse(String codeCaisse) {
		return ServeurDataGenerator.filterByCaisse(findAll(), codeCaisse);
	}

	/**
	 * Trouve les serveurs par type de patron
	 */
	public List<Serveur> findByTypePatron(String typePatron) {
		return ServeurDataGenerator.filterByType(findAll(), typePatron);
	}

	/**
	 * Obtient le serveur primaire d'une caisse
	 */
	public Optional<Serveur> findServeurPrimaireByCaisse(String codeCaisse) {
		return findByCodeCaisse(codeCaisse).stream().filter(s -> ServeurDataGenerator.isServeurPrimaire(s.getNom()))
				.findFirst();
	}

	/**
	 * Obtient le serveur secondaire d'une caisse
	 */
	public Optional<Serveur> findServeurSecondaireByCaisse(String codeCaisse) {
		return findByCodeCaisse(codeCaisse).stream().filter(s -> ServeurDataGenerator.isServeurSecondaire(s.getNom()))
				.findFirst();
	}

	/**
	 * Statistiques par type de serveur
	 */
	public Map<String, Long> getStatsParTypePatron() {
		List<Serveur> serveurs = findAll();
		Map<String, Long> stats = new HashMap<>();

		stats.put("PAGEDC", serveurs.stream()
				.filter(s -> "PAGEDC".equals(ServeurDataGenerator.extractTypePatron(s.getNom()))).count());

		stats.put("PD1SQL", serveurs.stream()
				.filter(s -> "PD1SQL".equals(ServeurDataGenerator.extractTypePatron(s.getNom()))).count());

		stats.put("PAB93003", serveurs.stream()
				.filter(s -> "PAB93003".equals(ServeurDataGenerator.extractTypePatron(s.getNom()))).count());

		return stats;
	}

	/**
	 * Liste de tous les codes de caisse disponibles
	 */
	public List<String> getAllCodesCaisse() {
		return Arrays.asList(ServeurDataGenerator.CODES_CAISSES);
	}

	public List<Serveur> getServeursActifs() {
		return serveurRepository.findByStatut(Serveur.StatutServeur.ACTIF);
	}

}