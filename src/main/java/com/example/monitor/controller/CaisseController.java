package com.example.monitor.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.monitor.model.Caisse;
import com.example.monitor.service.CaisseService;

@Controller
@RequestMapping("/caisses")
public class CaisseController {

	@Autowired
	private CaisseService caisseService;

	// ✅ Liste - CHEMIN: caisses/list.jsp
	@GetMapping
	public String listCaisses(Model model) {
		List<Caisse> caisses = caisseService.findAll();
		model.addAttribute("caisses", caisses);
		return "caisses/list";
	}

//	@GetMapping("/details/{id}")
//	public String viewCaisse(@PathVariable Long id, Model model) {
//		try {
//			Caisse caisse = caisseService.findById(id);
//			model.addAttribute("caisse", caisse);
//			return "caisses/view"; // ✅ Va vers la page de détail
//		} catch (Exception e) {
//			return "redirect:/caisses?error=not_found";
//		}
//	}

	@GetMapping("/details/{id}")
	public String viewCaisse(@PathVariable Long id, Model model) {
		System.out.println("=== 🟢 CAISSE DETAILS DÉBUT ===");
		System.out.println("ID reçu: " + id);

		try {
			System.out.println("Recherche de la caisse...");
			Caisse caisse = caisseService.findById(id);
			System.out.println("Caisse trouvée: " + caisse.getCode() + " - " + caisse.getNom());

			model.addAttribute("caisse", caisse);
			System.out.println("Retour vers: caisses/view");
			System.out.println("=== ✅ CAISSE DETAILS SUCCÈS ===");
			return "caisses/view";

		} catch (Exception e) {
			System.out.println("❌ ERREUR: " + e.getMessage());
			e.printStackTrace();
			System.out.println("Redirection vers /caisses?error=not_found");
			System.out.println("=== ❌ CAISSE DETAILS ERREUR ===");
			return "redirect:/caisses?error=not_found";
		}
	}

	@GetMapping("/modifier/{id}")
	public String editCaisseForm(@PathVariable Long id, Model model) {
		try {
			Caisse caisse = caisseService.findById(id);
			model.addAttribute("caisse", caisse);
			return "caisses/edit"; // ✅ Va vers la page d'édition
		} catch (Exception e) {
			return "redirect:/caisses?error=not_found";
		}
	}

	// ✅ Créer - CHEMIN: caisses/create.jsp
	@GetMapping("/creer")
	public String createCaisseForm(Model model) {
		model.addAttribute("caisse", new Caisse());
		return "caisses/create";
	}

	// ✅ Toggle
	@GetMapping("/toggle/{id}")
	public String toggleCaisseStatus(@PathVariable Long id) {
		try {
			caisseService.toggleStatus(id);
			return "redirect:/caisses?success=status_changed";
		} catch (Exception e) {
			return "redirect:/caisses?error=toggle_failed";
		}
	}

	// ✅ POST - Créer
	@PostMapping("/creer")
	public String createCaisse(@ModelAttribute Caisse caisse) {
		caisseService.save(caisse);
		return "redirect:/caisses?success=created";
	}

	// ✅ POST - Modifier
	@PostMapping("/modifier/{id}")
	public String updateCaisse(@PathVariable Long id, @ModelAttribute Caisse caisse) {
		try {
			caisse.setId(id);
			caisseService.save(caisse);
			return "redirect:/caisses?success=updated";
		} catch (Exception e) {
			return "redirect:/caisses?error=update_failed";
		}
	}
}