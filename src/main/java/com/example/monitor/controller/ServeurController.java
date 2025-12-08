package com.example.monitor.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.monitor.generator.ServeurDataGenerator;
import com.example.monitor.model.Caisse;
import com.example.monitor.model.Serveur;
import com.example.monitor.service.CaisseService;
import com.example.monitor.service.MiseAJourService;
import com.example.monitor.service.ServeurService;

@Controller
@RequestMapping("/serveurs")
public class ServeurController {

	private final ServeurService serveurService;
	private final MiseAJourService miseAJourService;

	@Autowired
	private CaisseService caisseService;

	public ServeurController(ServeurService serveurService, MiseAJourService miseAJourService) {
		this.serveurService = serveurService;
		this.miseAJourService = miseAJourService;
	}

	// === AUTRES MÉTHODES (gardez-les telles quelles) ===

	@GetMapping("/create")
	public String createServeurForm(Model model) {
		model.addAttribute("serveur", new Serveur());
		model.addAttribute("typesServeur", Serveur.TypeServeur.values());
		model.addAttribute("environnements", Serveur.Environnement.values());
		model.addAttribute("statuts", Serveur.StatutServeur.values());
		model.addAttribute("caisses", serveurService.getCaissesAvecServeurs());
		return "serveurs/create";
	}

	@PostMapping("/create")
	public String createServeur(@ModelAttribute Serveur serveur, RedirectAttributes redirectAttributes) {
		try {
			serveurService.save(serveur);
			redirectAttributes.addFlashAttribute("success", "Serveur créé avec succès !");
			return "redirect:/serveurs";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Erreur lors de la création: " + e.getMessage());
			return "redirect:/serveurs/create";
		}
	}

	@GetMapping("/view/{id}")
	public String viewServeur(@PathVariable Long id, Model model) {
		Optional<Serveur> serveurOpt = serveurService.findById(id);
		if (serveurOpt.isPresent()) {
			Serveur serveur = serveurOpt.get();
			model.addAttribute("serveur", serveur);

			// Analyse du nom du serveur
			String nom = serveur.getNom();
			model.addAttribute("codeCaisse", ServeurDataGenerator.extractCodeCaisse(nom));
			model.addAttribute("numeroServeur", ServeurDataGenerator.extractNumeroServeur(nom));
			model.addAttribute("typePatron", ServeurDataGenerator.extractTypePatron(nom));
			model.addAttribute("estPrimaire", ServeurDataGenerator.isServeurPrimaire(nom));
			model.addAttribute("estSecondaire", ServeurDataGenerator.isServeurSecondaire(nom));

			model.addAttribute("misesAJour", miseAJourService.findByServeurId(id));
			return "serveurs/view";
		} else {
			return "redirect:/serveurs";
		}
	}

	@GetMapping("/edit/{id}")
	public String editServeurForm(@PathVariable Long id, Model model) {
		Optional<Serveur> serveurOpt = serveurService.findById(id);
		if (serveurOpt.isPresent()) {
			model.addAttribute("serveur", serveurOpt.get());
			model.addAttribute("typesServeur", Serveur.TypeServeur.values());
			model.addAttribute("environnements", Serveur.Environnement.values());
			model.addAttribute("statuts", Serveur.StatutServeur.values());
			model.addAttribute("caisses", serveurService.getCaissesAvecServeurs());
			return "serveurs/edit";
		} else {
			return "redirect:/serveurs";
		}
	}

	@PostMapping("/edit/{id}")
	public String editServeur(@PathVariable Long id, @ModelAttribute Serveur serveur,
			RedirectAttributes redirectAttributes) {
		try {
			serveur.setId(id);
			serveurService.save(serveur);
			redirectAttributes.addFlashAttribute("success", "Serveur modifié avec succès !");
			return "redirect:/serveurs/view/" + id;
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Erreur lors de la modification: " + e.getMessage());
			return "redirect:/serveurs/edit/" + id;
		}
	}

	@PostMapping("/delete/{id}")
	public String deleteServeur(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			serveurService.deleteById(id);
			redirectAttributes.addFlashAttribute("success", "Serveur supprimé avec succès !");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
		}
		return "redirect:/serveurs";
	}

	@GetMapping
	public String listServeurs(@RequestParam(required = false) String codeCaisse,
			@RequestParam(required = false) String typePatron, @RequestParam(required = false) String environnement,
			@RequestParam(required = false) String statut, Model model) {

		System.out.println("=== DEBUG CONTRÔLEUR ===");
		System.out.println("Filtres reçus:");
		System.out.println("- codeCaisse: " + codeCaisse);
		System.out.println("- typePatron: " + typePatron);
		System.out.println("- environnement: " + environnement);
		System.out.println("- statut: " + statut);

		try {
			List<Serveur> serveurs = serveurService.findAll();
			System.out.println("1. Serveurs depuis service: " + serveurs.size());

			// Filtrage
			if (codeCaisse != null && !codeCaisse.isEmpty()) {
				serveurs = ServeurDataGenerator.filterByCaisse(serveurs, codeCaisse);
				System.out.println("2. Après filtre caisse: " + serveurs.size());
			}

			if (typePatron != null && !typePatron.isEmpty()) {
				serveurs = ServeurDataGenerator.filterByType(serveurs, typePatron);
				System.out.println("3. Après filtre type: " + serveurs.size());
			}

			// NOUVEAUX FILTRES
			if (environnement != null && !environnement.isEmpty()) {
				serveurs = serveurs.stream()
						.filter(s -> s.getEnvironnement() != null && s.getEnvironnement().name().equals(environnement))
						.collect(Collectors.toList());
				System.out.println("4. Après filtre environnement: " + serveurs.size());
			}

			if (statut != null && !statut.isEmpty()) {
				serveurs = serveurs.stream().filter(s -> s.getStatut() != null && s.getStatut().name().equals(statut))
						.collect(Collectors.toList());
				System.out.println("5. Après filtre statut: " + serveurs.size());
			}

			// Données pour les filtres
			List<String> codesCaisse = serveurService.getAllCodesCaisse();
			Map<String, Long> statsParType = serveurService.getStatsParType();

			// NOUVEAUX : Récupérer les listes d'environnements et statuts
			List<String> environnements = Arrays.stream(Serveur.Environnement.values()).map(Enum::name)
					.collect(Collectors.toList());

			List<String> statuts = Arrays.stream(Serveur.StatutServeur.values()).map(Enum::name)
					.collect(Collectors.toList());

			System.out.println("6. Codes caisse: " + codesCaisse);
			System.out.println("7. Stats type: " + statsParType);
			System.out.println("8. Environnements: " + environnements);
			System.out.println("9. Statuts: " + statuts);

			model.addAttribute("serveurs", serveurs);
			model.addAttribute("codesCaisse", codesCaisse);
			model.addAttribute("statsParType", statsParType);
			model.addAttribute("environnements", environnements);
			model.addAttribute("statuts", statuts);
			model.addAttribute("totalServeurs", serveurService.countTotal());
			model.addAttribute("serveursActifs", serveurService.countActifs());
			model.addAttribute("tauxDisponibilite", serveurService.calculerTauxDisponibilite());
			model.addAttribute("serveursProduction", serveurService.countProduction());

		} catch (Exception e) {
			System.out.println("❌ ERREUR: " + e.getMessage());
			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}

		return "serveurs/list";
	}

	@ModelAttribute("allCaisses")

	public List<Caisse> getAllCaisses() {
		return caisseService.findAll();
	}

//	// === VERSION UNIQUE AVEC FILTRES OPTIONNELS ===
//	@GetMapping
//	public String listServeurs(@RequestParam(required = false) String codeCaisse,
//			@RequestParam(required = false) String typePatron, Model model) {
//		try {
//			List<Serveur> serveurs = serveurService.findAll();
//
//			// Filtrage
//			if (codeCaisse != null && !codeCaisse.isEmpty()) {
//				serveurs = ServeurDataGenerator.filterByCaisse(serveurs, codeCaisse);
//				model.addAttribute("filtreCaisse", codeCaisse);
//			}
//
//			if (typePatron != null && !typePatron.isEmpty()) {
//				serveurs = ServeurDataGenerator.filterByType(serveurs, typePatron);
//				model.addAttribute("filtreType", typePatron);
//			}
//
//			model.addAttribute("serveurs", serveurs);
//			model.addAttribute("totalServeurs", serveurService.countTotal());
//			model.addAttribute("serveursActifs", serveurService.countActifs());
//			model.addAttribute("tauxDisponibilite", serveurService.calculerTauxDisponibilite());
//			model.addAttribute("serveursProduction", serveurService.countProduction());
//			model.addAttribute("prochainesMAJ", miseAJourService.getProchainesMisesAJour());
//			model.addAttribute("statsParType", serveurService.getStatsParType());
//			model.addAttribute("codesCaisse", serveurService.getAllCodesCaisse());
//
//		} catch (Exception e) {
//			model.addAttribute("error", "Erreur lors du chargement des serveurs: " + e.getMessage());
//			// Valeurs par défaut
//			model.addAttribute("totalServeurs", 0);
//			model.addAttribute("serveursActifs", 0);
//			model.addAttribute("tauxDisponibilite", 0.0);
//			model.addAttribute("serveursProduction", 0);
//		}
//
//		return "serveurs/list";
//	}
}