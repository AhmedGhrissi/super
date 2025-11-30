package com.example.monitor.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.ConfigurationTests;

@Repository
public interface ConfigurationTestsRepository extends JpaRepository<ConfigurationTests, Long> {

	// === MÉTHODES EXISTANTES ===
	List<ConfigurationTests> findByCaisseId(Long caisseId);

	List<ConfigurationTests> findByCaisseIdAndActifTrue(Long caisseId);

	@Query("SELECT ct FROM ConfigurationTests ct WHERE ct.testStandard.id = :testId")
	List<ConfigurationTests> findByTestId(@Param("testId") Long testId);

	@Query("SELECT ct FROM ConfigurationTests ct WHERE ct.caisse.id = :caisseId AND ct.testStandard.id = :testId")
	Optional<ConfigurationTests> findByCaisseIdAndTestId(@Param("caisseId") Long caisseId,
			@Param("testId") Long testId);

	@Query("SELECT ct FROM ConfigurationTests ct WHERE ct.caisse.id = :caisseId AND ct.actif = true ORDER BY ct.ordreExecution")
	List<ConfigurationTests> findActiveByCaisseOrdered(@Param("caisseId") Long caisseId);

	// === MÉTHODES POUR LES ACTIONS RAPIDES ===
	List<ConfigurationTests> findByActifTrue();

	long countByActifTrue();

	@Query("SELECT ct FROM ConfigurationTests ct WHERE ct.actif = true")
	List<ConfigurationTests> findByActifTrueAndCategorie(@Param("codeCategorie") String codeCategorie);

	@Query("SELECT ct FROM ConfigurationTests ct WHERE ct.actif = true AND ct.caisse.code = :codeCaisse")
	List<ConfigurationTests> findByActifTrueAndCaisse_Code(@Param("codeCaisse") String codeCaisse);

	@Query("SELECT ct FROM ConfigurationTests ct JOIN FETCH ct.caisse JOIN FETCH ct.testStandard WHERE ct.actif = true")
	List<ConfigurationTests> findActiveWithRelations();

	@Query("SELECT ct.caisse.code, COUNT(ct) FROM ConfigurationTests ct WHERE ct.actif = true GROUP BY ct.caisse.code")
	List<Object[]> countActiveTestsByCaisse();
}