package com.example.monitor.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.TestStandard;

@Repository
public interface TestStandardRepository extends JpaRepository<TestStandard, Long> {

	// Trouver un test par son code
	Optional<TestStandard> findByCodeTest(String codeTest);

	// Trouver tous les tests actifs
	List<TestStandard> findByActifTrue();

	// Trouver les tests par catégorie
	List<TestStandard> findByCategorieId(Long categorieId);

	// Trouver les tests actifs par catégorie
	List<TestStandard> findByCategorieIdAndActifTrue(Long categorieId);

	// Trouver les tests par type
	List<TestStandard> findByTypeTest(String typeTest);

	// Recherche par nom (contient)
	List<TestStandard> findByNomTestContainingIgnoreCase(String nomTest);

	// Requête personnalisée pour les tests avec leur catégorie
	@Query("SELECT t FROM TestStandard t WHERE t.actif = true ORDER BY t.nomTest")
	List<TestStandard> findActiveTestsOrdered();

	// Compter les tests par catégorie
	@Query("SELECT t.categorieId, COUNT(t) FROM TestStandard t WHERE t.actif = true GROUP BY t.categorieId")
	List<Object[]> countActiveTestsByCategorie();

	// Trouver les tests par validation type
	List<TestStandard> findByValidationType(String validationType);

//	@Query("SELECT ts FROM TestStandard ts WHERE ts.categorieTest.codeCategorie = :codeCategorie")
//	List<TestStandard> findByCategorieTest_CodeCategorie(@Param("codeCategorie") String codeCategorie);
//
//	@Query("SELECT ts FROM TestStandard ts WHERE ts.categorieTest.codeCategorie = :codeCategorie")
//	List<TestStandard> findByCategorieTestCodeCategorie(@Param("codeCategorie") String codeCategorie);
	List<TestStandard> findByNomTestContaining(String nomTest);
}