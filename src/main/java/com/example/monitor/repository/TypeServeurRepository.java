package com.example.monitor.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.TypeServeur;

@Repository
public interface TypeServeurRepository extends JpaRepository<TypeServeur, Long> {

	// Trouver un type par son code
	Optional<TypeServeur> findByCodeType(String codeType);

	// Trouver tous les types actifs
	List<TypeServeur> findByActifTrue();

	// Vérifier si un type existe par code
	boolean existsByCodeType(String codeType);
}