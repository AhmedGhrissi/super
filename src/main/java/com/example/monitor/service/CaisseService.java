package com.example.monitor.service;

import java.util.List;
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
}