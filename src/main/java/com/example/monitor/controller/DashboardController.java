package com.example.monitor.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.monitor.model.MiseAJour;
import com.example.monitor.model.Serveur;
import com.example.monitor.service.CaisseService;
import com.example.monitor.service.MiseAJourService;
import com.example.monitor.service.ServeurService;
import com.example.monitor.service.TestService;

@Controller
public class DashboardController {

	@Autowired
	private CaisseService caisseService;

	@Autowired
	private TestService testService;

	@Autowired
	private ServeurService serveurService;

	@Autowired
	private MiseAJourService miseAJourService; // AJOUTÉ

	@GetMapping("/dashboard")
	@Transactional(readOnly = true)
	public String dashboardPage(Model model) {
		return loadDashboardData(model);
	}

	// === NOUVELLES MÉTHODES POUR LES ACTIONS ===

	@PostMapping("/tests/lancer-tous")
	public String lancerTousTests(RedirectAttributes redirectAttributes) {
		try {
			testService.lancerTousTestsActifs();
			redirectAttributes.addFlashAttribute("success", "Tous les tests actifs ont été lancés avec succès !");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Erreur lors du lancement des tests: " + e.getMessage());
		}
		return "redirect:/dashboard";
	}

	@PostMapping("/tests/lancer-categorie/{categorie}")
	public String lancerTestsCategorie(@PathVariable String categorie, RedirectAttributes redirectAttributes) {
		try {
			System.out.println("=== LANCER TESTS CATEGORIE ===");
			System.out.println("Catégorie reçue: " + categorie);

			testService.lancerTestsParCategorie(categorie);

			System.out.println("Tests lancés avec succès");
			redirectAttributes.addFlashAttribute("success",
					"Tests de la catégorie '" + categorie + "' lancés avec succès !");
		} catch (Exception e) {
			System.out.println("ERREUR dans lancerTestsCategorie: " + e.getMessage());
			e.printStackTrace();

			redirectAttributes.addFlashAttribute("error",
					"Erreur lors du lancement des tests de la catégorie " + categorie + ": " + e.getMessage());
		}
		return "redirect:/dashboard";
	}

	// === MÉTHODE PRIVÉE CORRIGÉE AVEC TOUTES LES DONNÉES ===

	private String loadDashboardData(Model model) {
		try {
			// === STATISTIQUES RÉELLES DES CAISSES ===
			long totalCaisses = caisseService.countAllCaisses();
			long activeCaisses = caisseService.countActiveCaisses();

			// === STATISTIQUES RÉELLES DES TESTS ===
			long totalTests = testService.countAllTests();
			long activeTests = testService.countActiveTests();

			// === STATISTIQUES RÉELLES DES SERVEURS ===
			long totalServeurs = serveurService.countTotal();
			long serveursActifs = serveurService.countActifs();

			// === STATISTIQUES RÉELLES DES MAJ ===
			long totalMAJ = miseAJourService.countTotal();
			long majPlanifiees = miseAJourService.countPlanifiees();
			long majCetteSemaine = miseAJourService.countCetteSemaine();

			// === DONNÉES RÉELLES POUR LES TABLEAUX ===
			List<Serveur> serveursActifsList = serveurService.getServeursActifs(); // À implémenter
			List<MiseAJour> prochainesMAJ = miseAJourService.getProchainesMAJ();

			// === CALCUL DES STATISTIQUES RÉELLES D'AUJOURD'HUI ===
			LocalDateTime debutAujourdhui = LocalDate.now().atStartOfDay();
			long testsAujourdhui = testService.countTestsExecutesAujourdhui(debutAujourdhui);
			long testsReussisAujourdhui = testService.countTestsReussisAujourdhui(debutAujourdhui);
			long testsEchouesAujourdhui = testService.countTestsEchouesAujourdhui(debutAujourdhui);

			// === CALCUL DU TAUX DE RÉUSSITE ===
			double tauxReussite = testsAujourdhui > 0
					? Math.round((testsReussisAujourdhui * 100.0) / testsAujourdhui * 10.0) / 10.0
					: 0.0;

			// === CALCUL TAUX DISPONIBILITÉ (simplifié) ===
			double tauxDisponibilite = testsAujourdhui > 0
					? Math.round((testsReussisAujourdhui * 100.0) / testsAujourdhui)
					: 95.0; // Valeur par défaut

			// === TEMPS DE RÉPONSE MOYEN ===
			long tempsReponseMoyen = testService.getTempsReponseMoyenAujourdhui();

			// === DERNIÈRE MIS À JOUR ===
			String derniereMaj = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));

			// === AJOUT DES ATTRIBUTS AU MODÈLE ===

			// Statistiques principales (cartes)
			model.addAttribute("totalServeurs", totalServeurs);
			model.addAttribute("serveursActifs", serveursActifs);
			model.addAttribute("totalMAJ", totalMAJ);
			model.addAttribute("majPlanifiees", majPlanifiees);
			model.addAttribute("totalTests", totalTests);
			model.addAttribute("activeTests", activeTests);
			model.addAttribute("tauxDisponibilite", tauxDisponibilite);

			// Données pour les tableaux
			model.addAttribute("serveursActifsList", serveursActifsList);
			model.addAttribute("prochainesMAJ", prochainesMAJ);
			model.addAttribute("majCetteSemaine", majCetteSemaine);

			// Autres statistiques
			model.addAttribute("activeCaisses", activeCaisses);
			model.addAttribute("totalCaisses", totalCaisses);
			model.addAttribute("testsReussis", testsReussisAujourdhui);
			model.addAttribute("testsEchoues", testsEchouesAujourdhui);
			model.addAttribute("tauxReussite", tauxReussite);
			model.addAttribute("tempsReponseMoyen", tempsReponseMoyen + "ms");
			model.addAttribute("testsExecutesAujourdhui", testsAujourdhui);
			model.addAttribute("derniereMaj", derniereMaj);

			// Listes pour compatibilité
			model.addAttribute("recentCaisses", caisseService.getActiveCaisses().stream().limit(5).toList());
			model.addAttribute("recentTests", testService.getActiveTests().stream().limit(5).toList());
			model.addAttribute("allActiveCaisses", caisseService.getActiveCaisses());
			model.addAttribute("allActiveTests", testService.getActiveTests());

			// Indicateurs de performance
			model.addAttribute("performanceIndicators", getPerformanceIndicators());

		} catch (Exception e) {
			// Gestion d'erreur robuste avec valeurs par défaut
			handleDashboardError(model, e);
		}

		return "dashboard";
	}

	// === MÉTHODES UTILITAIRES ===

	/**
	 * Gestion des erreurs du dashboard avec valeurs par défaut
	 */
	private void handleDashboardError(Model model, Exception e) {
		System.err.println("❌ Erreur dans loadDashboardData: " + e.getMessage());
		model.addAttribute("error", "Erreur lors du chargement des données: " + e.getMessage());

		// Valeurs par défaut pour préserver l'affichage
		model.addAttribute("activeCaisses", 0);
		model.addAttribute("totalCaisses", 0);
		model.addAttribute("activeTests", 0);
		model.addAttribute("totalTests", 0);
		model.addAttribute("totalServeurs", 0);
		model.addAttribute("serveursActifs", 0);
		model.addAttribute("totalMAJ", 0);
		model.addAttribute("majPlanifiees", 0);
		model.addAttribute("majCetteSemaine", 0);
		model.addAttribute("tauxDisponibilite", 0);
		model.addAttribute("testsReussis", 0);
		model.addAttribute("testsEchoues", 0);
		model.addAttribute("tauxReussite", "0.0");
		model.addAttribute("tempsReponseMoyen", "0ms");
		model.addAttribute("testsExecutesAujourdhui", 0);
		model.addAttribute("derniereMaj", "Non disponible");

		// Listes vides
		model.addAttribute("serveursActifsList", java.util.Collections.emptyList());
		model.addAttribute("prochainesMAJ", java.util.Collections.emptyList());
		model.addAttribute("recentCaisses", java.util.Collections.emptyList());
		model.addAttribute("recentTests", java.util.Collections.emptyList());
		model.addAttribute("allActiveCaisses", java.util.Collections.emptyList());
		model.addAttribute("allActiveTests", java.util.Collections.emptyList());
	}

	/**
	 * Calcule les indicateurs de performance
	 */
	private java.util.Map<String, Object> getPerformanceIndicators() {
		java.util.Map<String, Object> indicators = new java.util.HashMap<>();

		try {
			// Indicateur de disponibilité (basé sur les tests réussis aujourd'hui)
			long testsTotalAujourdhui = testService.countTestsExecutesAujourdhui(LocalDate.now().atStartOfDay());
			long testsReussisAujourdhui = testService.countTestsReussisAujourdhui(LocalDate.now().atStartOfDay());

			double disponibilite = testsTotalAujourdhui > 0
					? Math.round((testsReussisAujourdhui * 100.0) / testsTotalAujourdhui * 10.0) / 10.0
					: 100.0;

			// Statut global
			String statutGlobal = disponibilite >= 95 ? "🟢 Excellent" : disponibilite >= 80 ? "🟡 Bon" : "🔴 Critique";

			indicators.put("disponibilite", disponibilite);
			indicators.put("statutGlobal", statutGlobal);
			indicators.put("testsTotalAujourdhui", testsTotalAujourdhui);
			indicators.put("derniereVerification", LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm")));

		} catch (Exception e) {
			// Valeurs par défaut en cas d'erreur
			indicators.put("disponibilite", 0.0);
			indicators.put("statutGlobal", "🟠 Indisponible");
			indicators.put("testsTotalAujourdhui", 0);
			indicators.put("derniereVerification", "Erreur");
		}

		return indicators;
	}
}