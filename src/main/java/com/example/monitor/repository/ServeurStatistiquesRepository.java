package com.example.monitor.repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.ServeurStatistiques;

@Repository
public interface ServeurStatistiquesRepository extends JpaRepository<ServeurStatistiques, Long> {

	Optional<ServeurStatistiques> findByServeurNom(String serveurNom);

	List<ServeurStatistiques> findByCaisseCode(String caisseCode);

	List<ServeurStatistiques> findByTypeServeur(String typeServeur);

	List<ServeurStatistiques> findByCaisseCodeAndTypeServeur(String caisseCode, String typeServeur);

	// Statistiques globales
	@Query("SELECT COUNT(ss) FROM ServeurStatistiques ss")
	long countTotalServeurs();

	@Query("SELECT SUM(ss.testsTotal) FROM ServeurStatistiques ss")
	Long sumTotalTests();

	@Query("SELECT SUM(ss.testsSucces) FROM ServeurStatistiques ss")
	Long sumTestsSucces();

	@Query("SELECT AVG(ss.disponibilitePercent) FROM ServeurStatistiques ss WHERE ss.testsTotal > 0")
	Double getDisponibiliteMoyenne();

	// Top serveurs par disponibilité
	@Query("SELECT ss FROM ServeurStatistiques ss WHERE ss.testsTotal > 0 ORDER BY ss.disponibilitePercent DESC")
	List<ServeurStatistiques> findTopByDisponibilite();

	// Serveurs avec problèmes
	@Query("SELECT ss FROM ServeurStatistiques ss WHERE ss.disponibilitePercent < 80 AND ss.testsTotal > 0")
	List<ServeurStatistiques> findServeursAvecProblemes();

	// Compter par type de serveur
	@Query("SELECT ss.typeServeur, COUNT(ss) FROM ServeurStatistiques ss GROUP BY ss.typeServeur")
	List<Object[]> countByTypeServeurGrouped();

	// Ajoute cette méthode dans le repository
	List<ServeurStatistiques> findByDisponibilitePercentLessThan(BigDecimal seuil);

	@Query("SELECT DISTINCT s.typeServeur FROM ServeurStatistiques s")
	List<String> findAllTypesDistincts();

	// Nouvelle méthode pour les serveurs critiques similaires
	@Query("SELECT s FROM ServeurStatistiques s WHERE s.typeServeur = :typeServeur AND s.disponibilitePercent < 80.0 ORDER BY s.disponibilitePercent ASC")
	List<ServeurStatistiques> findServeursCritiquesParType(String typeServeur);

}