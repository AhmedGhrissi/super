package com.example.monitor.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.monitor.config.ChromeDevToolsConfig;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/.well-known/appspecific")
public class ChromeDevToolsController {

	private static final Logger logger = LoggerFactory.getLogger(ChromeDevToolsController.class);

	private final ChromeDevToolsConfig config;

	public ChromeDevToolsController(ChromeDevToolsConfig config) {
		this.config = config;
	}

	/**
	 * Endpoint pour la configuration Chrome DevTools Compatible avec toutes les
	 * versions de Chrome
	 */
	@GetMapping("/com.chrome.devtools.json")
	public ResponseEntity<Map<String, String>> getChromeDevToolsConfig(HttpServletRequest request) {
		try {
			logger.debug("Chrome DevTools config requested from: {}", request.getRemoteAddr());

			if (!config.isEnabled()) {
				logger.warn("Chrome DevTools config is disabled");
				return ResponseEntity.notFound().build();
			}

			Map<String, String> response = new HashMap<>();

			// URL de base selon l'environnement
			String baseUrl = getBaseUrl(request);
			response.put("web_url", baseUrl);
			response.put("crx_url", "");
			response.put("devtools_frontend_url", "");
			response.put("favicon_url", "");
			response.put("environment", config.getEnvironment());
			response.put("version", "1.0");

			logger.info("Chrome DevTools config served for environment: {}, URL: {}", config.getEnvironment(), baseUrl);

			return ResponseEntity.ok(response);

		} catch (Exception e) {
			logger.error("Error generating Chrome DevTools config", e);
			return ResponseEntity.internalServerError().build();
		}
	}

	/**
	 * Détermine l'URL de base selon l'environnement
	 */
	private String getBaseUrl(HttpServletRequest request) {
		// Priorité 1: Configuration explicite
		if (config.getWebUrl() != null && !config.getWebUrl().isBlank()) {
			return config.getWebUrl();
		}

		// Priorité 2: Détection automatique selon l'environnement
		String environment = config.getEnvironment();
		if ("prod".equalsIgnoreCase(environment) || "production".equalsIgnoreCase(environment)) {
			return "https://machine-monitor.votre-domaine.com";
		} else if ("dev".equalsIgnoreCase(environment) || "development".equalsIgnoreCase(environment)) {
			return "https://dev.machine-monitor.votre-domaine.com";
		} else {
			// Priorité 3: Détection automatique depuis la requête
			return buildBaseUrlFromRequest(request);
		}
	}

	/**
	 * Construit l'URL de base depuis la requête HTTP
	 */
	private String buildBaseUrlFromRequest(HttpServletRequest request) {
		String scheme = request.getScheme();
		String serverName = request.getServerName();
		int serverPort = request.getServerPort();

		StringBuilder url = new StringBuilder();
		url.append(scheme).append("://").append(serverName);

		// Ajouter le port seulement si nécessaire
		if (("http".equals(scheme) && serverPort != 80) || ("https".equals(scheme) && serverPort != 443)) {
			url.append(":").append(serverPort);
		}

		return url.toString();
	}
}