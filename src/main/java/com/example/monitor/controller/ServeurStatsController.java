package com.example.monitor.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.monitor.model.ServeurStatistiques;
import com.example.monitor.service.CaisseService;
import com.example.monitor.service.ExportService;
import com.example.monitor.service.ServeurStatsService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/serveurs-stats")
public class ServeurStatsController {

	private final ServeurStatsService serveurStatsService;
	private final CaisseService caisseService;
	private final ExportService exportService;

	public ServeurStatsController(ServeurStatsService serveurStatsService, CaisseService caisseService,
			ExportService exportService) {
		this.serveurStatsService = serveurStatsService;
		this.caisseService = caisseService;
		this.exportService = exportService;
	}

	@GetMapping("/api/test")
	@ResponseBody
	public String testEndpoint() {
		return "✅ Endpoint /api/serveurs-stats fonctionne!";
	}

	@GetMapping("/api/critiques")
	@ResponseBody
	public List<ServeurStatistiques> getServeursCritiquesApi() {
		return serveurStatsService.getServeursAvecProblemes();
	}

	@GetMapping
	public String listServeursStats(@RequestParam(required = false) String codeCaisse,
			@RequestParam(required = false) String typeServeur, Model model) {

		try {
			List<ServeurStatistiques> serveursStats;

			// Filtrage des serveurs
			if (codeCaisse != null && !codeCaisse.isEmpty() && typeServeur != null && !typeServeur.isEmpty()) {
				serveursStats = serveurStatsService.findServeursStatsByCaisseAndType(codeCaisse, typeServeur);
			} else if (codeCaisse != null && !codeCaisse.isEmpty()) {
				serveursStats = serveurStatsService.findServeursStatsByCaisse(codeCaisse);
			} else if (typeServeur != null && !typeServeur.isEmpty()) {
				serveursStats = serveurStatsService.findServeursStatsByType(typeServeur);
			} else {
				serveursStats = serveurStatsService.findAllServeursStats();
			}

			// Statistiques globales
			var statsGlobales = serveurStatsService.getStatistiquesGlobales();

			model.addAttribute("serveursStats", serveursStats);
			model.addAttribute("statsGlobales", statsGlobales);
			model.addAttribute("codesCaisse", getCodesCaisse()); // Méthode simplifiée

			// Filtres actifs
			if (codeCaisse != null) {
				model.addAttribute("filtreCaisse", codeCaisse);
			}
			if (typeServeur != null) {
				model.addAttribute("filtreType", typeServeur);
			}

		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement des statistiques serveurs: " + e.getMessage());
		}

		return "serveurs-stats/list";
	}

	@GetMapping("/problemes")
	public String serveursAvecProblemes(Model model) {
		try {
			List<ServeurStatistiques> serveursProblemes = serveurStatsService.getServeursAvecProblemes();
			model.addAttribute("serveursProblemes", serveursProblemes);
			model.addAttribute("totalProblemes", serveursProblemes != null ? serveursProblemes.size() : 0);
		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement des serveurs avec problèmes: " + e.getMessage());
		}

		return "serveurs-stats/problemes";
	}

	@GetMapping("/top")
	public String topServeurs(Model model) {
		try {
			List<ServeurStatistiques> topServeurs = serveurStatsService.getTopServeurs();
			model.addAttribute("topServeurs", topServeurs);
		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement des top serveurs: " + e.getMessage());
		}

		return "serveurs-stats/top";
	}

	// Méthode utilitaire pour les codes de caisse
	private List<String> getCodesCaisse() {
		try {
			return caisseService.getAllCaisseCodes();
		} catch (Exception e) {
			// Retourner une liste par défaut si le service n'est pas disponible
			return List.of("IF", "AQ", "RP", "BI", "NE", "AL", "CS");
		}
	}

	private double calculerDisponibiliteMoyenne(List<ServeurStatistiques> stats) {
		if (stats.isEmpty()) {
			return 0.0;
		}
		return stats.stream().mapToDouble(s -> s.getDisponibilitePercent().doubleValue()).average().orElse(0.0);
	}

	@GetMapping("/export/{serveurNom}")
	public void exportStats(@PathVariable String serveurNom, HttpServletResponse response) {
		try {
			exportService.exportStatsExcel(serveurNom, response);
		} catch (IOException e) {
			// Gestion d'erreur
			try {
				response.sendRedirect("/serveurs-stats/" + serveurNom + "?error=Export échoué");
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}

	@GetMapping("/{nomServeur}")
	public String viewServeurStats(@PathVariable String nomServeur, Model model) {
		System.out.println("=== DEBUG VIEW SERVEUR ===");
		System.out.println("Nom serveur demandé: " + nomServeur);

		try {
			var statsOpt = serveurStatsService.findServeurStatsByNom(nomServeur);
			System.out.println("Serveur trouvé: " + statsOpt.isPresent());

			if (statsOpt.isPresent()) {
				ServeurStatistiques stats = statsOpt.get();
				System.out.println("Détails: " + stats.getServeurNom() + " | " + stats.getDisponibilitePercent() + "%");

				model.addAttribute("statistiques", stats);

				// Serveurs de la même caisse
				if (stats.getCaisseCode() != null && !"inconnu".equals(stats.getCaisseCode())) {
					List<ServeurStatistiques> serveursMemeCaisse = serveurStatsService
							.findServeursStatsByCaisse(stats.getCaisseCode());
					model.addAttribute("serveursMemeCaisse", serveursMemeCaisse);
					System.out.println("Serveurs même caisse: " + serveursMemeCaisse.size());
				}

				return "serveurs-stats/view";
			} else {
				System.out.println("❌ Serveur non trouvé dans les statistiques");
				model.addAttribute("error", "Statistiques non trouvées pour le serveur: " + nomServeur);
			}
		} catch (Exception e) {
			System.out.println("❌ Erreur: " + e.getMessage());
			model.addAttribute("error", "Erreur lors du chargement des statistiques: " + e.getMessage());
		}

		return "redirect:/serveurs-stats";
	}

	@GetMapping("/critiques")
	public List<ServeurStatistiques> getServeursCritiques() {
		return serveurStatsService.getServeursAvecProblemes();
	}
}