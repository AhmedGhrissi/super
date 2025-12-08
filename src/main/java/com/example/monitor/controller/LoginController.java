package com.example.monitor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

	@GetMapping("/")
	public String home() {
		return "redirect:/login";
	}

	@GetMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			@RequestParam(value = "registered", required = false) String registered, Model model) {

		// Ne montrer l'erreur QUE si c'est une vraie erreur de connexion
		boolean showError = false;
		boolean showLogout = false;

		if (error != null) {
			// Vérifier si c'est une erreur réelle (pas la première visite)
			// On peut vérifier via la session ou un paramètre supplémentaire
			String errorType = (String) model.getAttribute("errorType");
			if ("auth".equals(errorType)) {
				showError = true;
			}
		}

		if (logout != null) {
			showLogout = true;
		}

		model.addAttribute("showError", showError);
		model.addAttribute("showLogout", showLogout);

		// Comptes de test pour affichage
		String[][] testAccounts = { { "Administrateur", "admin / Monitor123!" },
				{ "Opérateur Aquitaine", "operateur.aq / Monitor123!" },
				{ "Technicien IDF", "technicien.idf / Monitor123!" }, { "Superviseur", "superviseur / Monitor123!" } };

		model.addAttribute("testAccounts", testAccounts);
		model.addAttribute("appName", "Supervision GEID");
		model.addAttribute("bankName", "Crédit Agricole");

		return "login";
	}
}