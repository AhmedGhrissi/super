package com.example.monitor.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.MiseAJour;
import com.example.monitor.repository.MiseAJourRepository;

@Service
@Transactional
public class MiseAJourService {

	private final MiseAJourRepository miseAJourRepository;

	public MiseAJourService(MiseAJourRepository miseAJourRepository) {
		this.miseAJourRepository = miseAJourRepository;
	}

	// === MÉTHODES EXISTANTES - GARDEZ TOUT ===
	public List<MiseAJour> findAllWithServeur() {
		return miseAJourRepository.findAllWithServeur();
	}

	public MiseAJour save(MiseAJour miseAJour) {
		return miseAJourRepository.save(miseAJour);
	}

	public List<MiseAJour> findAll() {
		return miseAJourRepository.findAll();
	}

	public Optional<MiseAJour> findById(Long id) {
		return miseAJourRepository.findById(id);
	}

	public void deleteById(Long id) {
		miseAJourRepository.deleteById(id);
	}

	public List<MiseAJour> findByServeurId(Long serveurId) {
		return miseAJourRepository.findByServeurId(serveurId);
	}

	public List<MiseAJour> findByStatut(MiseAJour.StatutMiseAJour statut) {
		return miseAJourRepository.findByStatut(statut);
	}

	public List<MiseAJour> getProchainesMisesAJour() {
		return miseAJourRepository.findProchainesMisesAJour();
	}

	public List<MiseAJour> getMisesAJourCetteSemaine() {
		LocalDate debut = LocalDate.now();
		LocalDate fin = debut.plusDays(7);
		return miseAJourRepository.findByDateApplicationBetween(debut, fin);
	}

	public void changerStatut(Long id, MiseAJour.StatutMiseAJour nouveauStatut) {
		Optional<MiseAJour> miseAJourOpt = findById(id);
		if (miseAJourOpt.isPresent()) {
			MiseAJour miseAJour = miseAJourOpt.get();
			miseAJour.setStatut(nouveauStatut);
			save(miseAJour);
		}
	}

	public long countTotal() {
		return miseAJourRepository.count();
	}

	public long countPlanifiees() {
		return miseAJourRepository.countByStatut(MiseAJour.StatutMiseAJour.PLANIFIEE);
	}

	public long countEnCours() {
		return miseAJourRepository.countByStatut(MiseAJour.StatutMiseAJour.EN_COURS);
	}

	public long countTerminees() {
		return miseAJourRepository.countByStatut(MiseAJour.StatutMiseAJour.TERMINEE);
	}

	public long countCetteSemaine() {
		LocalDate debut = LocalDate.now();
		LocalDate fin = debut.plusDays(7);
		return miseAJourRepository.findByDateApplicationBetween(debut, fin).size();
	}

	// ⭐⭐ SEULE CHANGEMENT - REMPLACEZ CETTE MÉTHODE :
	public List<MiseAJour> getMAJCetteSemaine() {
		LocalDate debut = LocalDate.now();
		LocalDate fin = debut.plusDays(7);
		return miseAJourRepository.findCetteSemaineWithServeur(debut, fin);
	}

	// ⭐ CORRIGEZ CETTE MÉTHODE - Retourne MiseAJour directement
	public MiseAJour getProchaineMAJ() {
		List<MiseAJour> prochaines = getProchainesMisesAJour();
		return prochaines.isEmpty() ? null : prochaines.get(0);
	}

	// ⭐ GARDEZ AUSSI L'OPTIONAL POUR LA COMPATIBILITÉ SI BESOIN
	public Optional<MiseAJour> getProchaineMAJOptional() {
		List<MiseAJour> prochaines = getProchainesMisesAJour();
		return prochaines.isEmpty() ? Optional.empty() : Optional.of(prochaines.get(0));
	}

	public java.util.Map<MiseAJour.StatutMiseAJour, Long> getStatsMAJ() {
		java.util.Map<MiseAJour.StatutMiseAJour, Long> stats = new java.util.HashMap<>();
		for (MiseAJour.StatutMiseAJour statut : MiseAJour.StatutMiseAJour.values()) {
			stats.put(statut, miseAJourRepository.countByStatut(statut));
		}
		return stats;
	}

	public List<MiseAJour> getProchainesMAJ() {
		return getProchainesMisesAJour();
	}
}