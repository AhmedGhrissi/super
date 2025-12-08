package com.example.monitor.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.Alert;
import com.example.monitor.model.enums.CriticiteAlerte;

@Repository
public interface AlertRepository extends JpaRepository<Alert, Long> {

	List<Alert> findByResolueFalseOrderByDateCreationDesc();

	List<Alert> findByResolueFalse();

	List<Alert> findByResolueFalseAndDateCreationBefore(LocalDateTime date);

	Optional<Alert> findTopByOrderByDateCreationDesc();

	List<Alert> findByCriticiteAndResolueFalseOrderByDateCreationDesc(CriticiteAlerte criticite);

	List<Alert> findAllByOrderByDateCreationDesc();

	@Query("SELECT COUNT(a) FROM Alert a WHERE a.resolue = false")
	long countActiveAlertes();

//	@Query("SELECT COUNT(a) FROM Alert a WHERE a.resolue = false AND a.criticite = :criticite")
//	long countByCriticiteAndResolueFalse(CriticiteAlerte criticite);

	@Query("SELECT a FROM Alert a WHERE a.dateCreation >= :startDate AND a.dateCreation <= :endDate ORDER BY a.dateCreation DESC")
	List<Alert> findByDateCreationBetween(LocalDateTime startDate, LocalDateTime endDate);

	List<Alert> findByServeurCibleAndResolueFalse(String serveurCible);

	/**
	 * Chercher les alertes dont le titre contient un mot et non résolues
	 */
	List<Alert> findByTitreContainingAndResolueFalse(String titre);

	/**
	 * Vérifier si une alerte existe avec un titre contenant un mot et non résolue
	 */
	@Query("SELECT COUNT(a) > 0 FROM Alert a WHERE LOWER(a.titre) LIKE LOWER(CONCAT('%', :motCle, '%')) AND a.resolue = false")
	boolean existsByTitreContainingAndResolueFalse(@Param("motCle") String motCle);

	/**
	 * Chercher les alertes créées après une certaine date
	 */
	List<Alert> findByDateCreationAfter(LocalDateTime date);

	/**
	 * Compter les alertes non résolues par criticité
	 */
	@Query("SELECT COUNT(a) FROM Alert a WHERE a.criticite = :criticite AND a.resolue = false")
	long countByCriticiteAndResolueFalse(@Param("criticite") CriticiteAlerte criticite);

	/**
	 * Chercher les alertes par type et non résolues
	 */
	List<Alert> findByTypeAlerteAndResolueFalse(String typeAlerte);

	// Si elle n'existe pas, créez-la
	@Query("SELECT a FROM Alert a WHERE a.resolue = false ORDER BY a.dateCreation DESC")
	List<Alert> findActiveAlerts();
}