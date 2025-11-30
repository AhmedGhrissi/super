package com.example.monitor.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.model.AuditLog;
import com.example.monitor.repository.AuditLogRepository;

import jakarta.servlet.http.HttpServletRequest;

@Service
@Transactional
public class AuditService {

	@Autowired
	private AuditLogRepository auditLogRepository;

	@Autowired(required = false)
	private HttpServletRequest request;

	public void logAction(String action, String resource, String resourceId, String description) {
		AuditLog auditLog = new AuditLog(action, resource, resourceId, description, getCurrentUsername(),
				getCurrentUserRole());

		if (request != null) {
			auditLog.setIpAddress(getClientIpAddress());
			auditLog.setUserAgent(request.getHeader("User-Agent"));
		}

		auditLogRepository.save(auditLog);
	}

	public void logActionWithExecutionTime(String action, String resource, String resourceId, String description,
			long executionTime) {
		AuditLog auditLog = new AuditLog(action, resource, resourceId, description, getCurrentUsername(),
				getCurrentUserRole());
		auditLog.setExecutionTime(executionTime);

		if (request != null) {
			auditLog.setIpAddress(getClientIpAddress());
			auditLog.setUserAgent(request.getHeader("User-Agent"));
		}

		auditLogRepository.save(auditLog);
	}

	public void logError(String action, String resource, String resourceId, String description, String errorMessage) {
		AuditLog auditLog = new AuditLog(action, resource, resourceId, description, getCurrentUsername(),
				getCurrentUserRole());
		auditLog.setSuccess(false);
		auditLog.setErrorMessage(errorMessage);

		if (request != null) {
			auditLog.setIpAddress(getClientIpAddress());
			auditLog.setUserAgent(request.getHeader("User-Agent"));
		}

		auditLogRepository.save(auditLog);
	}

	// Récupérer un audit par ID
	public Optional<AuditLog> getAuditLogById(Long id) {
		return auditLogRepository.findById(id);
	}

	// Recherche avancée
	public Page<AuditLog> searchAuditLogsAdvanced(String search, String action, String resource, Boolean success,
			Pageable pageable) {
		return auditLogRepository.findByAdvancedFilters(search, action, resource, success, pageable);
	}

	// Méthode pour les filtres avancés
	public Page<AuditLog> getAuditLogs(Pageable pageable, String search, String action, String resource,
			Boolean success) {
		return auditLogRepository.findByAdvancedFilters(search, action, resource, success, pageable);
	}

	// Méthodes existantes
	public Page<AuditLog> getAuditLogs(Pageable pageable) {
		return auditLogRepository.findAll(pageable);
	}

	public Page<AuditLog> searchAuditLogs(String search, Pageable pageable) {
		return auditLogRepository.search(search, pageable);
	}

	public List<AuditLog> getRecentActivity(int hours) {
		LocalDateTime since = LocalDateTime.now().minusHours(hours);
		return auditLogRepository.findByTimestampBetweenOrderByTimestampDesc(since, LocalDateTime.now());
	}

	// Statistiques d'audit
	public AuditStats getAuditStats() {
		LocalDateTime last24h = LocalDateTime.now().minusHours(24);

		long totalActions = auditLogRepository.countSince(last24h);
		long successfulActions = auditLogRepository.countBySuccess(true);
		long failedActions = auditLogRepository.countBySuccess(false);

		return new AuditStats(totalActions, successfulActions, failedActions);
	}

	// NOUVELLES MÉTHODES POUR LES GRAPHIQUES (SANS MOCKING)
	public Map<String, Object> getActionDistribution() {
		try {
			List<Object[]> results = auditLogRepository.countByAction();

			List<String> labels = new ArrayList<>();
			List<Long> data = new ArrayList<>();

			for (Object[] result : results) {
				labels.add((String) result[0]);
				data.add((Long) result[1]);
			}

			return Map.of("labels", labels, "datasets",
					List.of(Map.of("data", data, "backgroundColor",
							Arrays.asList("#4361ee", "#7209b7", "#06d6a0", "#ef476f", "#ffd166", "#118ab2"),
							"borderWidth", 2, "borderColor", "#fff")));
		} catch (Exception e) {
			// Retourner une structure vide en cas d'erreur
			return Map.of("labels", List.of(), "datasets",
					List.of(Map.of("data", List.of(), "backgroundColor", List.of())));
		}
	}

	public Map<String, Object> getUserActivityStats() {
		try {
			List<Object[]> results = auditLogRepository.findTopUsers();

			List<String> labels = new ArrayList<>();
			List<Long> data = new ArrayList<>();

			for (Object[] result : results) {
				labels.add((String) result[0]);
				data.add((Long) result[1]);
			}

			return Map.of("labels", labels, "datasets", List.of(Map.of("label", "Nombre d'actions", "data", data,
					"backgroundColor", "#4361ee", "borderColor", "#3a0ca3", "borderWidth", 2, "borderRadius", 5)));
		} catch (Exception e) {
			return Map.of("labels", List.of(), "datasets",
					List.of(Map.of("label", "Nombre d'actions", "data", List.of())));
		}
	}

	public Map<String, Object> getTimelineStats() {
		try {
			LocalDateTime startDate = LocalDateTime.now().minusDays(7);
			List<Object[]> results = auditLogRepository.findDailyStats(startDate);

			// Préparer les données pour 7 jours
			Map<String, Long> dailySuccess = new LinkedHashMap<>();
			Map<String, Long> dailyFailed = new LinkedHashMap<>();

			// Initialiser les 7 derniers jours
			for (int i = 6; i >= 0; i--) {
				String date = LocalDateTime.now().minusDays(i).toLocalDate().toString();
				dailySuccess.put(date, 0L);
				dailyFailed.put(date, 0L);
			}

			// Remplir avec les vraies données
			for (Object[] result : results) {
				String date = result[0].toString();
				Long count = (Long) result[1];
				// Pour simplifier, on suppose que c'est le total.
				// En réalité, vous devriez séparer succès/échecs
				dailySuccess.put(date, count);
			}

			return Map.of("labels", new ArrayList<>(dailySuccess.keySet()), "datasets",
					Arrays.asList(Map.of("label", "Actions", "data", new ArrayList<>(dailySuccess.values()),
							"borderColor", "#4361ee", "backgroundColor", "rgba(67, 97, 238, 0.1)", "tension", 0.4,
							"fill", true)));
		} catch (Exception e) {
			return Map.of("labels", List.of(), "datasets", List.of());
		}
	}

	// Classe interne pour les statistiques
	public static class AuditStats {
		private final long totalActions;
		private final long successfulActions;
		private final long failedActions;

		public AuditStats(long totalActions, long successfulActions, long failedActions) {
			this.totalActions = totalActions;
			this.successfulActions = successfulActions;
			this.failedActions = failedActions;
		}

		public long getTotalActions() {
			return totalActions;
		}

		public long getSuccessfulActions() {
			return successfulActions;
		}

		public long getFailedActions() {
			return failedActions;
		}

		public double getSuccessRate() {
			return totalActions > 0 ? (successfulActions * 100.0 / totalActions) : 0;
		}
	}

	// Méthodes utilitaires privées
	private String getCurrentUsername() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
			return ((UserDetails) authentication.getPrincipal()).getUsername();
		}
		return authentication != null ? authentication.getName() : "SYSTEM";
	}

	private String getCurrentUserRole() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getAuthorities().isEmpty()) {
			return authentication.getAuthorities().iterator().next().getAuthority();
		}
		return "ROLE_UNKNOWN";
	}

	private String getClientIpAddress() {
		if (request == null) {
			return "UNKNOWN";
		}

		String xfHeader = request.getHeader("X-Forwarded-For");
		if (xfHeader != null) {
			return xfHeader.split(",")[0];
		}
		return request.getRemoteAddr();
	}
}