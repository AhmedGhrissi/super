package com.example.monitor.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
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

	// ========== MÉTHODES POUR LE DASHBOARD ==========
	public long countAll() {
		return miseAJourRepository.count();
	}

	public long countCetteSemaine() {
		LocalDate now = LocalDate.now();
		LocalDate startOfWeek = now.with(DayOfWeek.MONDAY);
		LocalDate endOfWeek = startOfWeek.plusDays(7);

		try {
			return miseAJourRepository.findByDateApplicationBetween(startOfWeek, endOfWeek).size();
		} catch (Exception e) {
			// Alternative
			List<MiseAJour> toutesMAJ = miseAJourRepository.findAll();
			return toutesMAJ.stream().filter(maj -> maj.getDateCreation() != null).filter(maj -> {
				LocalDate dateMaj = maj.getDateCreation().toLocalDate();
				return !dateMaj.isBefore(startOfWeek) && !dateMaj.isAfter(now);
			}).count();
		}
	}

	public long countPlanifiees() {
		try {
			return miseAJourRepository.countByStatut(MiseAJour.StatutMiseAJour.PLANIFIEE);
		} catch (Exception e) {
			// Alternative
			List<MiseAJour> toutesMAJ = miseAJourRepository.findAll();
			return toutesMAJ.stream().filter(maj -> maj.getStatut() == MiseAJour.StatutMiseAJour.PLANIFIEE).count();
		}
	}

	// ========== MÉTHODES EXISTANTES ==========
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

	public long countEnCours() {
		return miseAJourRepository.countByStatut(MiseAJour.StatutMiseAJour.EN_COURS);
	}

	public long countTerminees() {
		return miseAJourRepository.countByStatut(MiseAJour.StatutMiseAJour.TERMINEE);
	}

	public MiseAJour getProchaineMAJ() {
		List<MiseAJour> prochaines = getProchainesMisesAJour();
		return prochaines.isEmpty() ? null : prochaines.get(0);
	}

	public Optional<MiseAJour> getProchaineMAJOptional() {
		List<MiseAJour> prochaines = getProchainesMisesAJour();
		return prochaines.isEmpty() ? Optional.empty() : Optional.of(prochaines.get(0));
	}

	public Map<MiseAJour.StatutMiseAJour, Long> getStatsMAJ() {
		Map<MiseAJour.StatutMiseAJour, Long> stats = new java.util.HashMap<>();
		for (MiseAJour.StatutMiseAJour statut : MiseAJour.StatutMiseAJour.values()) {
			stats.put(statut, miseAJourRepository.countByStatut(statut));
		}
		return stats;
	}

	public List<MiseAJour> getMisesAJourRecentes() {
		LocalDate debut = LocalDate.now().minusDays(7);
		LocalDate fin = LocalDate.now();
		return miseAJourRepository.findByDateApplicationBetween(debut, fin);
	}

	public List<MiseAJour> getRecentUpdates() {
		return getMisesAJourRecentes();
	}
}