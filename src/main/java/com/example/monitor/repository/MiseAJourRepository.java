package com.example.monitor.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.MiseAJour;

@Repository
public interface MiseAJourRepository extends JpaRepository<MiseAJour, Long> {

	// Trouver les mises à jour par serveur
	List<MiseAJour> findByServeurId(Long serveurId);

	// Trouver les mises à jour par statut
	List<MiseAJour> findByStatut(MiseAJour.StatutMiseAJour statut);

	// Trouver les mises à jour planifiées pour une période
	List<MiseAJour> findByDateApplicationBetween(LocalDate debut, LocalDate fin);

	// Trouver les mises à jour critiques
	List<MiseAJour> findByTypeMiseAJour(MiseAJour.TypeMiseAJour type);

	// Compter par statut
	long countByStatut(MiseAJour.StatutMiseAJour statut);

	// Récupère toutes les MAJ avec les serveurs
	@Query("SELECT m FROM MiseAJour m LEFT JOIN FETCH m.serveur")
	List<MiseAJour> findAllWithServeur();

	@Query("SELECT m FROM MiseAJour m JOIN FETCH m.serveur WHERE m.dateApplication >= CURRENT_DATE ORDER BY m.dateApplication ASC")
	List<MiseAJour> findProchainesMisesAJour();

	// ⭐ NOUVELLE MÉTHODE - Avec JOIN FETCH pour cette semaine
	@Query("SELECT m FROM MiseAJour m LEFT JOIN FETCH m.serveur WHERE m.dateApplication BETWEEN :debut AND :fin")
	List<MiseAJour> findCetteSemaineWithServeur(@Param("debut") LocalDate debut, @Param("fin") LocalDate fin);

}