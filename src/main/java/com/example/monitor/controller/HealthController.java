package com.example.monitor.controller;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/health")
public class HealthController {

	@GetMapping("/chrome-devtools")
	public ResponseEntity<Map<String, Object>> checkChromeDevTools() {
		Map<String, Object> health = new HashMap<>();
		health.put("status", "UP");
		health.put("endpoint", "/.well-known/appspecific/com.chrome.devtools.json");
		health.put("timestamp", Instant.now());
		return ResponseEntity.ok(health);
	}
}