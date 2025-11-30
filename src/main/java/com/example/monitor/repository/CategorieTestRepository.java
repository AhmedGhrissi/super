package com.example.monitor.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.CategorieTest;

@Repository
public interface CategorieTestRepository extends JpaRepository<CategorieTest, Long> {

	// Trouver une catégorie par son code
	Optional<CategorieTest> findByCodeCategorie(String codeCategorie);

	// Trouver toutes les catégories actives
	List<CategorieTest> findByActifTrue();

	// Vérifier si une catégorie existe par code
	boolean existsByCodeCategorie(String codeCategorie);
}