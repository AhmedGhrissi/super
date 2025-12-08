package com.example.monitor.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.monitor.model.TestStandard;
import com.example.monitor.service.TestService;

@Controller
@RequestMapping("/tests")
public class TestController {

	@Autowired
	private TestService testService;

	// ✅ Liste - CHEMIN: tests/list.jsp
	@GetMapping
	public String listTests(Model model) {
		List<TestStandard> tests = testService.findAll();
		model.addAttribute("tests", tests);
		return "tests/list";
	}

	@GetMapping("/details/{id}")
	public String viewTest(@PathVariable Long id, Model model) {
		System.out.println("=== 🟢 TEST DETAILS DÉBUT ===");
		System.out.println("ID reçu: " + id);

		try {
			System.out.println("Recherche du test...");
			TestStandard test = testService.findById(id);
			System.out.println("Test trouvé: " + test.getCodeTest() + " - " + test.getNomTest());

			model.addAttribute("test", test);
			System.out.println("Retour vers: tests/view");
			System.out.println("=== ✅ TEST DETAILS SUCCÈS ===");
			return "tests/view";

		} catch (Exception e) {
			System.out.println("❌ ERREUR: " + e.getMessage());
			e.printStackTrace();
			System.out.println("Redirection vers /tests?error=not_found");
			System.out.println("=== ❌ TEST DETAILS ERREUR ===");
			return "redirect:/tests?error=not_found";
		}
	}

	@GetMapping("/modifier/{id}")
	public String editTestForm(@PathVariable Long id, Model model) {
		try {
			TestStandard test = testService.findById(id);
			model.addAttribute("test", test);
			return "tests/edit"; // ✅ Va vers la page d'édition
		} catch (Exception e) {
			return "redirect:/tests?error=not_found";
		}
	}

	// ✅ Créer - CHEMIN: tests/create.jsp
	@GetMapping("/creer")
	public String createTestForm(Model model) {
		model.addAttribute("test", new TestStandard());
		return "tests/create";
	}

	// ✅ Toggle
	@GetMapping("/toggle/{id}")
	public String toggleTestStatus(@PathVariable Long id) {
		try {
			testService.toggleStatus(id);
			return "redirect:/tests?success=status_changed";
		} catch (Exception e) {
			return "redirect:/tests?error=toggle_failed";
		}
	}

	// ✅ POST - Créer
	@PostMapping("/creer")
	public String createTest(@ModelAttribute TestStandard test) {
		testService.save(test);
		return "redirect:/tests?success=created";
	}

	// ✅ POST - Modifier
	@PostMapping("/modifier/{id}")
	public String updateTest(@PathVariable Long id, @ModelAttribute TestStandard test) {
		try {
			test.setId(id);
			testService.save(test);
			return "redirect:/tests?success=updated";
		} catch (Exception e) {
			return "redirect:/tests?error=update_failed";
		}
	}

	// ========== NOUVEAUX ENDPOINTS POUR EXÉCUTION ==========

	// ✅ Page pour exécuter les tests
	@GetMapping("/execute")
	public String executeTestsPage(Model model) {
		List<String> categories = Arrays.asList("conformite", "processus_metier", "surveillance", "ged", "integration",
				"web");
		model.addAttribute("categories", categories);
		return "tests/execute";
	}

//	// ✅ Lancer tous les tests
//	@PostMapping("/execute/all")
//	@ResponseBody
//	public ResponseEntity<?> executeAllTests() {
//		try {
//			System.out.println("🚀 POST /tests/execute/all appelé - Lancement de tous les tests");
//
//			// Simuler l'exécution pour la démo
//			Thread.sleep(1000); // Attente de 1 sec pour simuler
//
//			// Logique réelle à implémenter :
//			// testService.executeAllActiveTests();
//
//			System.out.println("✅ Tous les tests lancés avec succès");
//
//			return ResponseEntity.ok()
//					.body(Map.of("success", true, "message", "Tous les tests ont été lancés avec succès !", "timestamp",
//							System.currentTimeMillis(), "code", "EXECUTION_STARTED"));
//
//		} catch (Exception e) {
//			System.err.println("❌ Erreur lors du lancement des tests: " + e.getMessage());
//			e.printStackTrace();
//
//			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
//					.body(Map.of("error", "Erreur lors du lancement des tests", "details", e.getMessage(), "timestamp",
//							System.currentTimeMillis()));
//		}
//	}
//
//	// ✅ Lancer tests par catégorie
//	@PostMapping("/execute/category")
//	@ResponseBody
//	public ResponseEntity<?> executeTestsByCategory(@RequestParam String categorie) {
//		try {
//			if (categorie == null || categorie.isEmpty()) {
//				return ResponseEntity.badRequest().body(Map.of("error", "Catégorie non spécifiée"));
//			}
//
//			System.out.println("🚀 POST /tests/execute/category appelé - Catégorie: " + categorie);
//
//			// Simuler l'exécution
//			Thread.sleep(1500);
//
//			// Logique réelle à implémenter :
//			// testService.executeTestsByCategory(categorie);
//
//			System.out.println("✅ Tests lancés pour catégorie: " + categorie);
//
//			return ResponseEntity.ok()
//					.body(Map.of("success", true, "message",
//							"Tests de la catégorie '" + categorie + "' lancés avec succès !", "categorie", categorie,
//							"timestamp", System.currentTimeMillis(), "code", "CATEGORY_EXECUTION_STARTED"));
//
//		} catch (Exception e) {
//			System.err.println("❌ Erreur pour catégorie " + categorie + ": " + e.getMessage());
//
//			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error",
//					"Erreur lors du lancement des tests", "details", e.getMessage(), "categorie", categorie));
//		}
//	}
}