package com.example.monitor.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.monitor.model.MiseAJour;
import com.example.monitor.model.Serveur;
import com.example.monitor.service.MiseAJourService;
import com.example.monitor.service.ServeurService;

@Controller
@RequestMapping("/mises-a-jour")
public class MiseAJourController {

	private final MiseAJourService miseAJourService;
	private final ServeurService serveurService;

	public MiseAJourController(MiseAJourService miseAJourService, ServeurService serveurService) {
		this.miseAJourService = miseAJourService;
		this.serveurService = serveurService;
	}

	@GetMapping
	public String listMisesAJour(Model model) {
		try {
			List<MiseAJour> misesAJour = miseAJourService.findAllWithServeur();
			model.addAttribute("misesAJour", misesAJour);
			model.addAttribute("totalMAJ", miseAJourService.countTotal());
			model.addAttribute("majPlanifiees", miseAJourService.countPlanifiees());
			model.addAttribute("majTerminees", miseAJourService.countTerminees());
			model.addAttribute("majCetteSemaine", miseAJourService.countCetteSemaine());
			model.addAttribute("majCetteSemaineList", miseAJourService.getMAJCetteSemaine());
			model.addAttribute("statsMAJ", miseAJourService.getStatsMAJ());
			model.addAttribute("prochaineMAJ", miseAJourService.getProchaineMAJ());
			model.addAttribute("statutsMAJ", MiseAJour.StatutMiseAJour.values());

		} catch (Exception e) {
			model.addAttribute("error", "Erreur lors du chargement des mises à jour: " + e.getMessage());
			// Valeurs par défaut
			model.addAttribute("totalMAJ", 0);
			model.addAttribute("majPlanifiees", 0);
			model.addAttribute("majTerminees", 0);
			model.addAttribute("majCetteSemaine", 0);
		}

		return "mises-a-jour/list";
	}

	@GetMapping("/create")
	public String createMiseAJourForm(Model model) {
		model.addAttribute("miseAJour", new MiseAJour());
		model.addAttribute("typesMAJ", MiseAJour.TypeMiseAJour.values());
		model.addAttribute("statutsMAJ", MiseAJour.StatutMiseAJour.values());
		model.addAttribute("serveurs", serveurService.findAll());
		return "mises-a-jour/create";
	}

	@PostMapping("/create")
	public String createMiseAJour(@ModelAttribute MiseAJour miseAJour, @RequestParam Long serveurId,
			RedirectAttributes redirectAttributes) {
		try {
			Optional<Serveur> serveurOpt = serveurService.findById(serveurId);
			if (serveurOpt.isPresent()) {
				miseAJour.setServeur(serveurOpt.get());
				miseAJourService.save(miseAJour);
				redirectAttributes.addFlashAttribute("success", "Mise à jour planifiée avec succès !");
				return "redirect:/mises-a-jour";
			} else {
				redirectAttributes.addFlashAttribute("error", "Serveur non trouvé !");
				return "redirect:/mises-a-jour/create";
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Erreur lors de la création: " + e.getMessage());
			return "redirect:/mises-a-jour/create";
		}
	}

	@PostMapping("/changer-statut/{id}")
	public String changerStatut(@PathVariable Long id, @RequestParam MiseAJour.StatutMiseAJour nouveauStatut,
			RedirectAttributes redirectAttributes) {
		try {
			miseAJourService.changerStatut(id, nouveauStatut);
			redirectAttributes.addFlashAttribute("success", "Statut mis à jour avec succès !");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Erreur lors du changement de statut: " + e.getMessage());
		}
		return "redirect:/mises-a-jour";
	}

	@PostMapping("/delete/{id}")
	public String deleteMiseAJour(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			miseAJourService.deleteById(id);
			redirectAttributes.addFlashAttribute("success", "Mise à jour supprimée avec succès !");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
		}
		return "redirect:/mises-a-jour";
	}

	@GetMapping("/calendrier")
	public String calendrier(Model model) {
		// Implémentez la vue calendrier si nécessaire
		return "mises-a-jour/calendrier";
	}
}