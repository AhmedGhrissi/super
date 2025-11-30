package com.example.monitor.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.monitor.model.AuditLog;
import com.example.monitor.service.AuditService;

@Controller
@RequestMapping("/api/audit")
@PreAuthorize("hasAnyRole('SUPERVISEUR', 'TECHNICIEN', 'ADMIN')")
public class AuditController {

	@Autowired
	private AuditService auditService;

	// PAGE WEB - Retourne la vue JSP
	@GetMapping("/view")
	public String auditPage() {
		return "admin/audit-logs";
	}

	// API PAGINATION AVEC FILTRES - Retourne JSON pour le JavaScript
	@GetMapping("/page")
	@ResponseBody
	public Page<AuditLog> getAuditPage(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "20") int size, @RequestParam(required = false) String search,
			@RequestParam(required = false) String action, @RequestParam(required = false) String resource,
			@RequestParam(required = false) String status) {

		Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "timestamp"));

		// Conversion du statut
		Boolean successStatus = null;
		if ("SUCCESS".equals(status)) {
			successStatus = true;
		} else if ("FAILED".equals(status)) {
			successStatus = false;
		}

		// ✅ CORRECTION FIABLE : Utilisez searchAuditLogsAdvanced
		return auditService.searchAuditLogsAdvanced(search, action, resource, successStatus, pageable);
	}

	@GetMapping("/logs")
	@ResponseBody
	public Page<AuditLog> getAuditLogs(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "20") int size, @RequestParam(defaultValue = "timestamp") String sort,
			@RequestParam(defaultValue = "desc") String direction, @RequestParam(required = false) String search,
			@RequestParam(required = false) String action, @RequestParam(required = false) String resource,
			@RequestParam(required = false) Boolean success) {

		Sort.Direction sortDirection = direction.equalsIgnoreCase("asc") ? Sort.Direction.ASC : Sort.Direction.DESC;
		Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sort));

		return auditService.getAuditLogs(pageable, search, action, resource, success);
	}

	@GetMapping("/search")
	@ResponseBody
	public Page<AuditLog> searchAuditLogs(@RequestParam String q, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "20") int size) {

		Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "timestamp"));
		return auditService.searchAuditLogs(q, pageable);
	}

	@GetMapping("/recent")
	@ResponseBody
	public List<AuditLog> getRecentActivity(@RequestParam(defaultValue = "24") int hours) {
		return auditService.getRecentActivity(hours);
	}

	@GetMapping("/stats")
	@ResponseBody
	public AuditService.AuditStats getAuditStats() {
		return auditService.getAuditStats();
	}

	@GetMapping("/generate-test-data")
	@ResponseBody
	public String generateTestData() {
		try {
			auditService.logAction("CREATE", "SERVEUR", "SRV-001", "Création du serveur SRV-001");
			auditService.logAction("UPDATE", "TEST", "TST-001", "Modification du test TST-001");
			auditService.logAction("READ", "CAISSE", "C-001", "Consultation caisse");
			auditService.logActionWithExecutionTime("EXECUTE", "TEST", "TST-002", "Test performance", 150L);
			auditService.logError("CREATE", "SERVEUR", "SRV-002", "Échec création", "Timeout");
			return "✅ Données de test créées!";
		} catch (Exception e) {
			return "❌ Erreur: " + e.getMessage();
		}
	}

	@GetMapping("/stats/actions")
	@ResponseBody
	public Map<String, Object> getActionStats() {
		return auditService.getActionDistribution();
	}

	@GetMapping("/stats/users")
	@ResponseBody
	public Map<String, Object> getUserStats() {
		return auditService.getUserActivityStats();
	}

	@GetMapping("/stats/timeline")
	@ResponseBody
	public Map<String, Object> getTimelineStats() {
		return auditService.getTimelineStats();
	}

	@GetMapping("/{id}")
	@ResponseBody
	public AuditLog getAuditById(@PathVariable Long id) {
		return auditService.getAuditLogById(id)
				.orElseThrow(() -> new RuntimeException("Audit non trouvé avec ID: " + id));
	}
}