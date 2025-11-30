package com.example.monitor.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.service.EmailService;

@RestController
@RequestMapping("/api/email-logs")
public class EmailLogController {

	@Autowired
	private EmailService emailService;

	@GetMapping
	public List<Map<String, Object>> getEmailLogs(@RequestParam(defaultValue = "50") int limit) {
		return emailService.getEmailLogs(limit);
	}

	@GetMapping("/recent")
	public List<Map<String, Object>> getRecentEmailLogs() {
		return emailService.getRecentEmailLogsFormatted();
	}

	@GetMapping("/statistiques")
	public Map<String, Object> getEmailStats() {
		return emailService.getEmailStatistics();
	}

	@GetMapping("/test")
	public String testEmailLogs() {
		try {
			// Tester la connexion à la table
			List<Map<String, Object>> logs = emailService.getEmailLogs(5);
			return "✅ Email logs fonctionnel - " + logs.size() + " entrées trouvées";
		} catch (Exception e) {
			return "❌ Erreur email logs: " + e.getMessage();
		}
	}
}