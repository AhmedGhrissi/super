package com.example.monitor.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

	Optional<User> findByUsername(String username);

	Optional<User> findByUsernameAndActifTrue(String username);

	List<User> findByCaisseCode(String caisseCode);

	List<User> findByRole(String role);

	List<User> findByActifTrue();

	@Query("SELECT u FROM User u WHERE u.role = 'OPERATEUR' AND u.caisseCode = :caisseCode")
	List<User> findOperateursByCaisse(@Param("caisseCode") String caisseCode);

	boolean existsByUsername(String username);
}