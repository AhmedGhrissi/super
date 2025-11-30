package com.example.monitor.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@PreAuthorize("hasAnyRole('SUPERVISEUR', 'TECHNICIEN', 'ADMIN')")
public class AuditPageController {

	// ✅ PAGE : Journal d'audit
	@GetMapping("/admin/audit-logs")
	public String auditLogsPage(Model model) {
		model.addAttribute("pageTitle", "Journal d'Audit");
		model.addAttribute("appName", "Machine Monitor");
		model.addAttribute("timestamp", java.time.LocalDateTime.now());
		return "admin/audit-logs";
	}
}