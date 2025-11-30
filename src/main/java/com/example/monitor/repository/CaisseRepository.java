package com.example.monitor.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.Caisse;

@Repository
public interface CaisseRepository extends JpaRepository<Caisse, Long> {

	// Trouver une caisse par son code
	Optional<Caisse> findByCode(String code);

	// Trouver toutes les caisses actives
	List<Caisse> findByActifTrue();

	// Trouver les caisses par code partition
	List<Caisse> findByCodePartition(String codePartition);

	// Trouver les caisses par code CR
	List<Caisse> findByCodeCr(String codeCr);

	// Recherche par nom (contient)
	List<Caisse> findByNomContainingIgnoreCase(String nom);

	// Requête personnalisée pour compter les caisses actives
	@Query("SELECT COUNT(c) FROM Caisse c WHERE c.actif = true")
	Long countActiveCaisses();

	// Requête pour trouver les caisses avec leurs serveurs (si vous avez la
	// relation)
	@Query("SELECT c FROM Caisse c LEFT JOIN FETCH c.configurationServeurs WHERE c.id = ?1")
	Optional<Caisse> findByIdWithServeurs(Long id);

	long countByActifTrue();

}