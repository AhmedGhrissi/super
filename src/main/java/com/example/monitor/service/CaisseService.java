package com.example.monitor.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.Caisse;
import com.example.monitor.repository.CaisseRepository;

@Service
@Transactional
public class CaisseService {

	@Autowired
	private CaisseRepository caisseRepository;

	public List<Caisse> findAll() {
		return caisseRepository.findAll();
	}

	public Caisse findById(Long id) {
		return caisseRepository.findById(id).orElseThrow(() -> new RuntimeException("Caisse non trouvée"));
	}

	public Caisse save(Caisse caisse) {
		return caisseRepository.save(caisse);
	}

	public void toggleStatus(Long id) {
		Caisse caisse = findById(id);
		caisse.setActif(!caisse.getActif());
		caisseRepository.save(caisse);
	}

//	public List<Caisse> getActiveCaisses() {
//		return caisseRepository.findByActifTrue();
//	}
//
//	public long countAllCaisses() {
//		return caisseRepository.count();
//	}
//
//	public long countActiveCaisses() {
//		return caisseRepository.countByActifTrue();
//	}
	/**
	 * Compte toutes les caisses
	 */
	public long countAllCaisses() {
		try {
			return caisseRepository.count();
		} catch (Exception e) {
			System.err.println("❌ Erreur countAllCaisses: " + e.getMessage());
			return 0;
		}
	}

	/**
	 * Compte les caisses actives
	 */
	public long countActiveCaisses() {
		try {
			return caisseRepository.countByActifTrue();
		} catch (Exception e) {
			System.err.println("❌ Erreur countActiveCaisses: " + e.getMessage());
			return 0;
		}
	}

	/**
	 * Récupère les caisses actives
	 */
	public java.util.List<Caisse> getActiveCaisses() {
		try {
			return caisseRepository.findByActifTrue();
		} catch (Exception e) {
			System.err.println("❌ Erreur getActiveCaisses: " + e.getMessage());
			return new java.util.ArrayList<>();
		}
	}

	/**
	 * Obtient tous les codes de caisse
	 */
	public List<String> getAllCaisseCodes() {
		// return caisseRepository.findAllActiveCodes();
		// Ou si cette méthode n'existe pas, utilisez :
		return caisseRepository.findAll().stream().map(Caisse::getCode).collect(Collectors.toList());
	}

	/**
	 * Récupère les statistiques par caisse
	 */
	public List<Map<String, Object>> getStatistiquesParCaisse() {
		try {
			List<Caisse> caisses = findAll();
			return caisses.stream().map(caisse -> {
				Map<String, Object> stats = new HashMap<>();
				stats.put("code", caisse.getCode());
				stats.put("nom", caisse.getNom());
				stats.put("actif", caisse.getActif());
				stats.put("nombreServeurs", 0); // À remplacer par vrai comptage si disponible
				return stats;
			}).collect(Collectors.toList());
		} catch (Exception e) {
			System.err.println("❌ Erreur getStatistiquesParCaisse: " + e.getMessage());
			return new ArrayList<>();
		}
	}

	/**
	 * Récupère les statistiques globales des caisses
	 */
	public Map<String, Object> getStatistiquesGlobales() {
		Map<String, Object> stats = new HashMap<>();

		try {
			long totalCaisses = countAllCaisses();
			long caissesActives = countActiveCaisses();

			stats.put("totalCaisses", totalCaisses);
			stats.put("caissesActives", caissesActives);
			stats.put("caissesInactives", totalCaisses - caissesActives);
			stats.put("tauxActivation",
					totalCaisses > 0 ? Math.round((caissesActives * 100.0) / totalCaisses * 10.0) / 10.0 : 0.0);
			stats.put("derniereMaj", LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));

		} catch (Exception e) {
			System.err.println("❌ Erreur getStatistiquesGlobales: " + e.getMessage());
			stats.put("totalCaisses", 0);
			stats.put("caissesActives", 0);
			stats.put("caissesInactives", 0);
			stats.put("tauxActivation", 0.0);
		}

		return stats;
	}
}