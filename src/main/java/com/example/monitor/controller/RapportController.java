package com.example.monitor.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.monitor.service.CaisseService;
import com.example.monitor.service.PdfReportService;
import com.example.monitor.service.TestService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/rapports")
public class RapportController {

	@Autowired
	private TestService testService;

	@Autowired
	private CaisseService caisseService;

	@Autowired
	private PdfReportService pdfReportService;

	@GetMapping
	public String rapports(Model model) {
		try {
			Map<String, Object> rapports = testService.getRapportsHebdomadaires();
			model.addAttribute("rapports", rapports);
		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement des rapports: " + e.getMessage());
		}
		return "rapports/list";
	}

	@GetMapping("/hebdomadaire")
	public String rapportHebdomadaire(Model model) {
		try {
			Map<String, Object> rapports = testService.getRapportsHebdomadaires();
			model.addAttribute("rapports", rapports);
			model.addAttribute("detailView", true);
		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement du rapport détaillé");
		}
		return "rapports/hebdomadaire";
	}

	@GetMapping("/hebdomadaire/pdf")
	public void genererPdfHebdomadaire(HttpServletResponse response) {
		try {
			Map<String, Object> rapports = testService.getRapportsHebdomadaires();

			byte[] pdfBytes = pdfReportService.generateRapportHebdomadairePdf(rapports);

			// Configuration de la réponse HTTP
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename=rapport-hebdomadaire-"
					+ LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + ".pdf");
			response.setContentLength(pdfBytes.length);

			// Écriture du PDF dans la réponse
			response.getOutputStream().write(pdfBytes);
			response.getOutputStream().flush();

		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			try {
				response.getWriter().write("Erreur lors de la génération du PDF: " + e.getMessage());
			} catch (IOException ex) {
				throw new RuntimeException(ex);
			}
		}
	}

	@GetMapping("/metrics")
	@ResponseBody
	public Map<String, Object> getCustomMetrics() {
		Map<String, Object> metrics = new HashMap<>();

		try {
			// Récupérer les métriques actuelles
			long activeCaisses = caisseService.countActiveCaisses();
			long activeTests = testService.countActiveTests();
			double tauxReussite = testService.getTauxReussiteGlobal();
			long tempsReponseMoyen = testService.getTempsReponseMoyenAujourdhui();

			metrics.put("active_caisses", activeCaisses);
			metrics.put("active_tests", activeTests);
			metrics.put("taux_reussite", tauxReussite);
			metrics.put("temps_reponse_moyen", tempsReponseMoyen);
			metrics.put("timestamp", LocalDateTime.now().toString());
			metrics.put("status", "healthy");

		} catch (Exception e) {
			metrics.put("status", "error");
			metrics.put("error", e.getMessage());
		}

		return metrics;
	}
}