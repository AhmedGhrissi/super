package com.example.monitor.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.ResultatsTests;

@Repository
public interface ResultatsTestsRepository extends JpaRepository<ResultatsTests, Long> {

	// === MÉTHODES DE BASE PAR DATE ===
	long countByDateExecutionAfter(LocalDateTime date);

	long countBySuccesTrueAndDateExecutionAfter(LocalDateTime date);

	long countBySuccesFalseAndDateExecutionAfter(LocalDateTime date);

	// === MÉTHODES AVEC PÉRIODE (START/END) ===
	long countByDateExecutionBetween(LocalDateTime start, LocalDateTime end);

	long countBySuccesTrueAndDateExecutionBetween(LocalDateTime start, LocalDateTime end);

	long countBySuccesFalseAndDateExecutionBetween(LocalDateTime start, LocalDateTime end);

	// === MÉTHODES POUR LES STATISTIQUES TEMPS RÉEL ===

	@Query("SELECT AVG(r.tempsReponse) FROM ResultatsTests r WHERE r.dateExecution >= :date")
	Long findTempsReponseMoyenDepuis(@Param("date") LocalDateTime date);

	@Query("SELECT (COUNT(CASE WHEN r.succes = true THEN 1 END) * 100.0 / COUNT(r)) "
			+ "FROM ResultatsTests r WHERE r.dateExecution >= :dateDebut")
	Double findTauxReussiteDepuis(@Param("dateDebut") LocalDateTime dateDebut);

	// === MÉTHODES POUR LES RAPPORTS AVEC PÉRIODE ===

	@Query("SELECT AVG(r.tempsReponse) FROM ResultatsTests r WHERE r.dateExecution BETWEEN :start AND :end")
	Long findTempsReponseMoyenBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

	@Query("SELECT (COUNT(CASE WHEN r.succes = true THEN 1 END) * 100.0 / COUNT(r)) "
			+ "FROM ResultatsTests r WHERE r.dateExecution BETWEEN :start AND :end")
	Double findTauxReussiteBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

	// === MÉTHODES POUR LES GRAPHIQUES ET ANALYSES ===

	@Query("SELECT FUNCTION('DATE', r.dateExecution) as jour, COUNT(r) as total "
			+ "FROM ResultatsTests r WHERE r.dateExecution >= :dateDebut "
			+ "GROUP BY FUNCTION('DATE', r.dateExecution) " + "ORDER BY jour")
	List<Object[]> findTestsParJourDepuis(@Param("dateDebut") LocalDateTime dateDebut);

	// === MÉTHODES POUR LE MONITORING ET ALERTES ===

	List<ResultatsTests> findTop10ByOrderByDateExecutionDesc();

	@Query("SELECT r FROM ResultatsTests r WHERE r.succes = false AND r.dateExecution >= :dateDebut "
			+ "ORDER BY r.dateExecution DESC")
	List<ResultatsTests> findEchecsRecents(@Param("dateDebut") LocalDateTime dateDebut);

	// === MÉTHODES PAR CAISSE ===

	List<ResultatsTests> findByConfigTest_Caisse_IdOrderByDateExecutionDesc(Long caisseId);

	Long countByConfigTest_Caisse_Id(Long caisseId);

	Long countByConfigTest_Caisse_IdAndSuccesTrue(Long caisseId);

	@Query("SELECT AVG(r.tempsReponse) FROM ResultatsTests r WHERE r.configTest.caisse.id = :caisseId")
	Long findTempsReponseMoyenParCaisse(@Param("caisseId") Long caisseId);
}