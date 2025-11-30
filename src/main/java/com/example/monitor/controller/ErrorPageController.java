package com.example.monitor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ErrorPageController {

	@GetMapping("/error-page")
	public String errorPage(@RequestParam(required = false) String message, Model model) {
		model.addAttribute("errorMessage", message != null ? message : "Une erreur est survenue");
		return "error";
	}
}