package com.example.monitor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.monitor.service.TestService;

@Controller
@RequestMapping("/monitoring")
public class MetricsController {

	@Autowired
	private TestService testService;

	@GetMapping("/metrics-dashboard")
	public String metricsDashboard(Model model) {
		try {
			// Récupérer les données RÉELLES
			Map<String, Object> performanceIndicators = testService.getPerformanceIndicators();
			Map<String, Object> rapports = testService.getRapportsHebdomadaires();

			// Ajouter au modèle
			model.addAttribute("performance", performanceIndicators);
			model.addAttribute("rapports", rapports);

			// S'assurer que statsParJour est bien passé
			if (rapports.containsKey("statsParJour")) {
				model.addAttribute("statsParJour", rapports.get("statsParJour"));
			} else {
				model.addAttribute("statsParJour", new HashMap<>());
			}

		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement des métriques: " + e.getMessage());
			model.addAttribute("statsParJour", new HashMap<>());
		}

		return "metrics/metrics-dashboard";
	}
}