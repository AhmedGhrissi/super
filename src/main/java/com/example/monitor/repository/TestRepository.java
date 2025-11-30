package com.example.monitor.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.TestStandard;

@Repository
public interface TestRepository extends JpaRepository<TestStandard, Long> {

	// Trouver tous les tests actifs
	List<TestStandard> findByActifTrue();

	// Compter les tests actifs
	long countByActifTrue();

	// Optionnel : trouver par code
	List<TestStandard> findByCodeTest(String codeTest);

	// Optionnel : trouver par type
	List<TestStandard> findByTypeTest(String typeTest);
}