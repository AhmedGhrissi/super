package com.example.monitor.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.ConfigurationServeurs;

@Repository
public interface ConfigurationServeursRepository extends JpaRepository<ConfigurationServeurs, Long> {

	// Trouver les configurations par caisse
	List<ConfigurationServeurs> findByCaisseId(Long caisseId);

	// Trouver les configurations actives par caisse
	List<ConfigurationServeurs> findByCaisseIdAndActifTrue(Long caisseId);

	// Trouver les configurations par type de serveur
	List<ConfigurationServeurs> findByTypeServeur(String typeServeur);

	// Trouver les configurations par caisse et type de serveur
	List<ConfigurationServeurs> findByCaisseIdAndTypeServeur(Long caisseId, String typeServeur);

	// ⭐⭐ AJOUTEZ UNIQUEMENT CETTE MÉTHODE ⭐⭐
	@Query("SELECT DISTINCT cs.serveurPrincipal FROM ConfigurationServeurs cs WHERE cs.serveurPrincipal IS NOT NULL AND cs.serveurPrincipal != '' "
			+ "UNION "
			+ "SELECT DISTINCT cs.serveurSecondaire FROM ConfigurationServeurs cs WHERE cs.serveurSecondaire IS NOT NULL AND cs.serveurSecondaire != '' "
			+ "UNION "
			+ "SELECT DISTINCT cs.serveurTertiaire FROM ConfigurationServeurs cs WHERE cs.serveurTertiaire IS NOT NULL AND cs.serveurTertiaire != '' "
			+ "UNION "
			+ "SELECT DISTINCT cs.serveurQuaternaire FROM ConfigurationServeurs cs WHERE cs.serveurQuaternaire IS NOT NULL AND cs.serveurQuaternaire != ''")
	List<String> findAllServeursUniques();
}