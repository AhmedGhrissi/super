package com.example.monitor.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.monitor.model.AuditLog;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {

	Page<AuditLog> findByUsernameOrderByTimestampDesc(String username, Pageable pageable);

	List<AuditLog> findByTimestampBetweenOrderByTimestampDesc(LocalDateTime start, LocalDateTime end);

	Page<AuditLog> findByResourceAndActionOrderByTimestampDesc(String resource, String action, Pageable pageable);

	@Query("SELECT a FROM AuditLog a WHERE " + "LOWER(a.username) LIKE LOWER(CONCAT('%', :search, '%')) OR "
			+ "LOWER(a.resource) LIKE LOWER(CONCAT('%', :search, '%')) OR "
			+ "LOWER(a.description) LIKE LOWER(CONCAT('%', :search, '%')) " + "ORDER BY a.timestamp DESC")
	Page<AuditLog> search(String search, Pageable pageable);

	long countBySuccess(Boolean success);

	@Query("SELECT COUNT(a) FROM AuditLog a WHERE a.timestamp >= :since")
	long countSince(LocalDateTime since);

	// NOUVELLE : Recherche avancée avec tous les filtres
	@Query("SELECT a FROM AuditLog a WHERE " + "(:search IS NULL OR "
			+ " LOWER(a.description) LIKE LOWER(CONCAT('%', :search, '%')) OR "
			+ " LOWER(a.username) LIKE LOWER(CONCAT('%', :search, '%')) OR "
			+ " LOWER(a.action) LIKE LOWER(CONCAT('%', :search, '%')) OR "
			+ " LOWER(a.resource) LIKE LOWER(CONCAT('%', :search, '%')) OR "
			+ " LOWER(a.resourceId) LIKE LOWER(CONCAT('%', :search, '%')) OR "
			+ " LOWER(a.ipAddress) LIKE LOWER(CONCAT('%', :search, '%'))) AND "
			+ "(:action IS NULL OR a.action = :action) AND " + "(:resource IS NULL OR a.resource = :resource) AND "
			+ "(:success IS NULL OR a.success = :success) " + "ORDER BY a.timestamp DESC")
	Page<AuditLog> findByAdvancedFilters(@Param("search") String search, @Param("action") String action,
			@Param("resource") String resource, @Param("success") Boolean success, Pageable pageable);

	@Query("SELECT a.action, COUNT(a) FROM AuditLog a GROUP BY a.action")
	List<Object[]> countByAction();

	@Query("SELECT a.username, COUNT(a) FROM AuditLog a GROUP BY a.username ORDER BY COUNT(a) DESC LIMIT 5")
	List<Object[]> findTopUsers();

	@Query("SELECT FUNCTION('DATE', a.timestamp), COUNT(a) FROM AuditLog a WHERE a.timestamp >= :startDate GROUP BY FUNCTION('DATE', a.timestamp) ORDER BY FUNCTION('DATE', a.timestamp)")
	List<Object[]> findDailyStats(@Param("startDate") LocalDateTime startDate);
}