package com.example.monitor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.monitor.model.Alert;
import com.example.monitor.model.enums.CriticiteAlerte;
import com.example.monitor.service.AlertService;

@Controller
@RequestMapping("/alertes")
public class AlertController {

	@Autowired
	private AlertService alertService;

	// ========== PAGES HTML ==========

	@GetMapping
	public String listAlertes(Model model, @RequestParam(required = false) String criticite) {
		try {
			List<Alert> alertes;

			if (criticite != null && !criticite.isEmpty()) {
				CriticiteAlerte criticiteEnum = CriticiteAlerte.valueOf(criticite.toUpperCase());
				alertes = alertService.getAlertesByCriticite(criticiteEnum);
			} else {
				alertes = alertService.getAllAlertes();
			}

			model.addAttribute("alertes", alertes);
			model.addAttribute("criticite", criticite);

			return "alertes/list";
		} catch (Exception e) {
			model.addAttribute("error", "Erreur: " + e.getMessage());
			return "alertes/list";
		}
	}

	// Route pour /alertes/view/ (sans ID) - redirige vers la liste
	@GetMapping("/view/")
	public String viewAlerteNoId() {
		return "redirect:/alertes";
	}

	// Route pour /alertes/view/{id} (avec ID)
	@GetMapping("/view/{id}")
	public String viewAlerte(@PathVariable Long id, Model model) {
		try {
			Alert alerte = alertService.findById(id);
			if (alerte == null) {
				model.addAttribute("error", "Alerte non trouvée");
				return "alertes/not-found";
			}
			model.addAttribute("alerte", alerte);
			return "alertes/view";
		} catch (Exception e) {
			model.addAttribute("error", "Erreur: " + e.getMessage());
			return "alertes/error";
		}
	}

	// ========== API POUR DASHBOARD ==========

	@GetMapping("/api/actives")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> getAlertesActivesApi() {
		try {
			List<Map<String, Object>> alertes = alertService.getAlertesPourAPI();
			return ResponseEntity.ok(alertes);
		} catch (Exception e) {
			return ResponseEntity.ok(List.of());
		}
	}

	@GetMapping("/api/stats")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getAlertesStatsApi() {
		try {
			Map<String, Integer> statsInteger = alertService.getStatsAlertes();
			Map<String, Object> statsObject = new HashMap<>();
			statsObject.put("critical", statsInteger.getOrDefault("critical", 0));
			statsObject.put("warning", statsInteger.getOrDefault("warning", 0));
			statsObject.put("info", statsInteger.getOrDefault("info", 0));
			statsObject.put("total", statsInteger.getOrDefault("total", 0));
			return ResponseEntity.ok(statsObject);
		} catch (Exception e) {
			Map<String, Object> defaultStats = new HashMap<>();
			defaultStats.put("critical", 0);
			defaultStats.put("warning", 0);
			defaultStats.put("info", 0);
			defaultStats.put("total", 0);
			return ResponseEntity.ok(defaultStats);
		}
	}

	@PostMapping("/resoudre/{id}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> resoudreAlerte(@PathVariable Long id) {
		try {
			alertService.resolveAlert(id);
			return ResponseEntity.ok(Map.of("success", true, "message", "Alerte résolue"));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Erreur: " + e.getMessage()));
		}
	}

	@PostMapping("/supprimer/{id}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> supprimerAlerte(@PathVariable Long id) {
		try {
			alertService.deleteById(id);
			return ResponseEntity.ok(Map.of("success", true, "message", "Alerte supprimée"));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Erreur: " + e.getMessage()));
		}
	}

	@GetMapping("/api/alertes")
	@ResponseBody
	public ResponseEntity<List<Alert>> getAlertesApi() {
		try {
			List<Alert> alertes = alertService.getAllAlertes();
			return ResponseEntity.ok(alertes);
		} catch (Exception e) {
			return ResponseEntity.ok(List.of());
		}
	}

	@GetMapping("/api/alertes/{id}")
	@ResponseBody
	public ResponseEntity<Alert> getAlerteApi(@PathVariable Long id) {
		try {
			Alert alerte = alertService.findById(id);
			if (alerte == null) {
				return ResponseEntity.notFound().build();
			}
			return ResponseEntity.ok(alerte);
		} catch (Exception e) {
			return ResponseEntity.notFound().build();
		}
	}
}