package com.example.monitor.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.Caisse;
import com.example.monitor.model.Serveur;

@Repository
public interface ServeurRepository extends JpaRepository<Serveur, Long> {

	// Tri par date de création décroissante
	@Query("SELECT s FROM Serveur s ORDER BY s.dateCreation DESC")
	List<Serveur> findAllOrderByDateCreationDesc();

	// Recherche par code caisse
	List<Serveur> findByCaisseCode(String caisseCode);

	// Recherche par environnement
	List<Serveur> findByEnvironnement(Serveur.Environnement environnement);

	// Recherche par statut
	List<Serveur> findByStatut(Serveur.StatutServeur statut);

	// Comptage par environnement
	long countByEnvironnement(Serveur.Environnement environnement);

	// Comptage par statut
	long countByStatut(Serveur.StatutServeur statut);

	// Vérification d'existence
	boolean existsByNom(String nom);

	boolean existsByAdresseIP(String adresseIP);

	// Codes de caisse distincts
	@Query("SELECT DISTINCT s.caisseCode FROM Serveur s WHERE s.caisseCode IS NOT NULL")
	List<String> findDistinctCaisseCodes();
	// Caisses distinctes associées aux serveurs actifs

	@Query("SELECT DISTINCT c FROM Caisse c WHERE c.code IN (SELECT DISTINCT s.caisseCode FROM Serveur s) AND c.actif = true")

	List<Caisse> findDistinctCaisses();

	// List<Serveur> findByStatutNot(Serveur.StatutServeur statut);

	@Query("SELECT s FROM Serveur s WHERE s.statut <> :statut ORDER BY s.dateCreation DESC")
	List<Serveur> findByStatutNot(@Param("statut") Serveur.StatutServeur statut);

	@Query("SELECT AVG(s.tempsReponse) FROM Serveur s WHERE s.tempsReponse IS NOT NULL")
	Double findAverageResponseTime();

}