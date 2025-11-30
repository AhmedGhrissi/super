package com.example.monitor.controller;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LoginController {

	private void showLoginPage(HttpServletResponse response, String error) throws IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		out.write("""
				<!DOCTYPE html>
				<html>
				<head>
				    <title>Machine Monitor - Connexion</title>
				    <meta charset="UTF-8">
				    <style>
				        body {
				            font-family: Arial, sans-serif;
				            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
				            height: 100vh;
				            display: flex;
				            align-items: center;
				            justify-content: center;
				            margin: 0;
				        }
				        .login-container {
				            background: white;
				            padding: 2rem;
				            border-radius: 10px;
				            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
				            width: 100%;
				            max-width: 400px;
				        }
				        .error {
				            color: red;
				            text-align: center;
				            margin-bottom: 1rem;
				            padding: 0.5rem;
				            background: #ffe6e6;
				            border-radius: 5px;
				        }
				        h1 {
				            text-align: center;
				            color: #333;
				            margin-bottom: 0.5rem;
				        }
				        .form-group {
				            margin-bottom: 1rem;
				        }
				        label {
				            display: block;
				            margin-bottom: 0.5rem;
				            color: #333;
				            font-weight: bold;
				        }
				        input[type="text"],
				        input[type="password"] {
				            width: 100%;
				            padding: 0.75rem;
				            border: 1px solid #ddd;
				            border-radius: 5px;
				            box-sizing: border-box;
				        }
				        button {
				            width: 100%;
				            padding: 0.75rem;
				            background: #007bff;
				            color: white;
				            border: none;
				            border-radius: 5px;
				            cursor: pointer;
				            font-size: 1rem;
				        }
				        button:hover {
				            background: #0056b3;
				        }
				        .test-accounts {
				            margin-top: 2rem;
				            text-align: center;
				            font-size: 0.9rem;
				            color: #666;
				            border-top: 1px solid #eee;
				            padding-top: 1rem;
				        }
				    </style>
				</head>
				<body>
				    <div class="login-container">
				        <h1>🔧 Machine Monitor</h1>
				        <p class="subtitle">Système de Supervision</p>

				""");

		// Affiche l'erreur si présente
		if ("true".equals(error)) {
			out.write("""
					    <div class="error">
					        <strong>❌ Erreur de connexion !</strong><br>
					        Vérifiez le nom d'utilisateur et le mot de passe.
					    </div>
					""");
		}

		out.write("""
				            <form method="post" action="/login">
				                <div class="form-group">
				                    <label for="username">Nom d'utilisateur :</label>
				                    <input type="text" id="username" name="username" value="admin" required>
				                </div>

				                <div class="form-group">
				                    <label for="password">Mot de passe :</label>
				                    <input type="password" id="password" name="password" value="Monitor123!" required>
				                </div>

				                <button type="submit">Se connecter</button>
				            </form>

				            <div class="test-accounts">
				                <p><strong>Comptes de test :</strong></p>
				                <p>admin / Monitor123!</p>
				                <p>operateur.aq / Monitor123!</p>
				                <p>technicien.idf / Monitor123!</p>
				            </div>
				        </div>
				    </body>
				    </html>
				""");
		out.flush();
	}

	@GetMapping("/")
	public void home(HttpServletResponse response) throws IOException {
		showLoginPage(response, null);
	}

	@GetMapping("/login")
	public void login(HttpServletResponse response, @RequestParam(value = "error", required = false) String error)
			throws IOException {
		showLoginPage(response, error);
	}
}