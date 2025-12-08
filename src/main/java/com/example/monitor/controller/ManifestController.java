package com.example.monitor.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletResponse;

@RestController
public class ManifestController {

	@GetMapping(value = "/manifest.json", produces = MediaType.APPLICATION_JSON_VALUE)
	public String getManifest(HttpServletResponse response) {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		return """
				{
				  "name": "Supervision GEID",
				  "short_name": "GEID Monitor",
				  "description": "Système de supervision bancaire Crédit Agricole",
				  "start_url": "/dashboard",
				  "display": "standalone",
				  "background_color": "#006747",
				  "theme_color": "#006747",
				  "icons": [
				    {
				      "src": "/images/icon-192.png",
				      "sizes": "192x192",
				      "type": "image/png"
				    },
				    {
				      "src": "/images/icon-512.png",
				      "sizes": "512x512",
				      "type": "image/png"
				    }
				  ],
				  "orientation": "portrait-primary"
				}
				""";
	}
}