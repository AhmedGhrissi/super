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

	// CORRECTION : Renommer pour éviter les conflits
	@Query("SELECT r FROM ResultatsTests r WHERE r.dateExecution > :date")
	List<ResultatsTests> findTestsAfterDate(@Param("date") LocalDateTime date);

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

	@Query("SELECT r FROM ResultatsTests r WHERE r.succes = false AND r.dateExecution >= :dateDebut "
			+ "ORDER BY r.dateExecution DESC")
	List<ResultatsTests> findEchecsRecents(@Param("dateDebut") LocalDateTime dateDebut);

	// === MÉTHODES PAR CAISSE ===

	List<ResultatsTests> findByConfigTest_Caisse_IdOrderByDateExecutionDesc(Long caisseId);

	Long countByConfigTest_Caisse_Id(Long caisseId);

	Long countByConfigTest_Caisse_IdAndSuccesTrue(Long caisseId);

	@Query("SELECT AVG(r.tempsReponse) FROM ResultatsTests r WHERE r.configTest.caisse.id = :caisseId")
	Long findTempsReponseMoyenParCaisse(@Param("caisseId") Long caisseId);

	// AJOUTER cette méthode
	@Query("SELECT r FROM ResultatsTests r ORDER BY r.dateExecution DESC")
	List<ResultatsTests> findAllOrderByDateExecutionDesc();

	// OU utiliser la méthode Spring Data avec une limite
	List<ResultatsTests> findFirst10ByOrderByDateExecutionDesc();

	// ... méthodes existantes ...

	// AJOUTER si manquant
	List<ResultatsTests> findByDateExecutionBetween(LocalDateTime start, LocalDateTime end);

	// CORRECTION : Utiliser le bon nom de champ "tempsReponse" pas "tempsExecution"
	@Query("SELECT AVG(r.tempsReponse) FROM ResultatsTests r WHERE r.dateExecution >= :date")
	Double findAverageResponseTimeSince(@Param("date") LocalDateTime date);

	// CORRECTION : Ajouter méthode countByStatut manquante
	// Note: Votre modèle n'a pas de champ "statut", il a "succes" (boolean)
	// Utilisez plutôt countBySuccesTrue() et countBySuccesFalse()

	// Pour compatibilité avec le code existant, créez une méthode qui simule
	// "statut"
	@Query("SELECT COUNT(r) FROM ResultatsTests r WHERE r.succes = :succes")
	long countBySuccessStatus(@Param("succes") boolean succes);

	// Derniers tests exécutés
	List<ResultatsTests> findTop10ByOrderByDateExecutionDesc();

	// CORRECTION : Méthode native pour éviter les problèmes
	@Query(value = "SELECT AVG(temps_reponse) FROM resultats_tests WHERE date_execution >= :date", nativeQuery = true)
	Double findAverageResponseTimeNative(@Param("date") LocalDateTime date);

	// NOUVELLE : Méthode pour récupérer les statuts (compatibilité)
	@Query(value = "SELECT " + "SUM(CASE WHEN succes = true THEN 1 ELSE 0 END) as success_count, "
			+ "SUM(CASE WHEN succes = false THEN 1 ELSE 0 END) as failed_count "
			+ "FROM resultats_tests WHERE date_execution >= :date", nativeQuery = true)
	List<Object[]> getStatsByDate(@Param("date") LocalDateTime date);

	// NOUVELLE : Méthode native pour récupérer les tests après une date
	@Query(value = "SELECT * FROM resultats_tests WHERE date_execution >= :date", nativeQuery = true)
	List<ResultatsTests> findTestsAfterDateNative(@Param("date") LocalDateTime date);

	@Override
	long count(); // Existe déjà dans JpaRepository

	// ⭐⭐ AJOUTEZ CETTE MÉTHODE POUR LES GRAPHIQUES RÉELS :
	@Query("SELECT FUNCTION('DATE', r.dateExecution), COUNT(r), " + "SUM(CASE WHEN r.succes = true THEN 1 ELSE 0 END) "
			+ "FROM ResultatsTests r " + "WHERE r.dateExecution >= :startDate "
			+ "GROUP BY FUNCTION('DATE', r.dateExecution) " + "ORDER BY FUNCTION('DATE', r.dateExecution)")
	List<Object[]> findDailyStats(@Param("startDate") LocalDateTime startDate);

}