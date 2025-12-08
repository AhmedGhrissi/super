<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🏦 Supervision GEID - Connexion</title>

    <!-- Inclure le CSRF token pour Spring Security -->
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <style>
        :root {
            --ca-green: #006747;
            --ca-light-green: #8DC63F;
            --ca-red: #D50032;
            --ca-blue: #005BAC;
            --ca-white: #FFFFFF;
            --ca-gray-light: #F5F7FA;
            --ca-gray: #6C757D;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Arial', sans-serif;
            background: linear-gradient(135deg, var(--ca-gray-light) 0%, #E8F5E9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: var(--ca-white);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 103, 71, 0.15);
            width: 100%;
            max-width: 450px;
            padding: 3rem;
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--ca-green), var(--ca-light-green));
        }

        .bank-logo {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .bank-logo h1 {
            background: linear-gradient(135deg, var(--ca-green), var(--ca-light-green));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .bank-logo p {
            color: var(--ca-gray);
            font-size: 1rem;
            font-weight: 500;
        }

        /* Message d'erreur - CACHÉ par défaut */
        .alert-error {
            background: rgba(213, 0, 50, 0.1);
            color: var(--ca-red);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--ca-red);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            display: none; /* Caché par défaut */
        }

        .alert-error.show {
            display: flex; /* Affiché seulement quand on ajoute la classe "show" */
        }

        .alert-error::before {
            content: '⚠️';
            font-size: 1.2rem;
        }

        /* Message de succès pour logout */
        .alert-success {
            background: rgba(0, 103, 71, 0.1);
            color: var(--ca-green);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--ca-light-green);
            display: none; /* Caché par défaut */
        }

        .alert-success.show {
            display: flex; /* Affiché seulement quand on ajoute la classe "show" */
        }

        .alert-success::before {
            content: '✅';
            font-size: 1.2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--ca-green);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-input {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 2px solid #E0E0E0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--ca-white);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--ca-light-green);
            box-shadow: 0 0 0 3px rgba(141, 198, 63, 0.1);
        }

        .login-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--ca-green), var(--ca-light-green));
            color: var(--ca-white);
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 103, 71, 0.2);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .test-accounts {
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #F0F0F0;
        }

        .test-accounts h3 {
            color: var(--ca-green);
            font-size: 1rem;
            margin-bottom: 0.75rem;
            text-align: center;
        }

        .account-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0.75rem;
        }

        .account-card {
            background: var(--ca-gray-light);
            padding: 0.75rem;
            border-radius: 8px;
            font-size: 0.85rem;
            text-align: center;
            border-left: 3px solid var(--ca-light-green);
        }

        .account-card strong {
            display: block;
            color: var(--ca-green);
            margin-bottom: 0.25rem;
            font-weight: 600;
        }

        .account-card span {
            color: var(--ca-gray);
            font-family: monospace;
        }

        .security-note {
            margin-top: 1.5rem;
            text-align: center;
            color: var(--ca-gray);
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 2rem;
                margin: 1rem;
            }

            .account-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="bank-logo">
            <h1>🏦 Supervision GEID</h1>
            <p>Crédit Agricole - Système de Supervision</p>
        </div>

        <!-- Messages d'erreur/succès - Gérés par JavaScript -->
        <div id="errorMessage" class="alert-error">
            Identifiant ou mot de passe incorrect
        </div>

        <div id="logoutMessage" class="alert-success">
            Déconnexion réussie
        </div>

        <!-- Formulaire de connexion Spring Security -->
        <form method="post" action="/login" id="loginForm">
            <div class="form-group">
                <label for="username" class="form-label">Identifiant</label>
                <input type="text" id="username" name="username"
                       class="form-input" placeholder="Votre identifiant"
                       required autofocus value="admin">
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Mot de passe</label>
                <input type="password" id="password" name="password"
                       class="form-input" placeholder="Votre mot de passe"
                       required value="Monitor123!">
            </div>

            <!-- CSRF Token obligatoire pour Spring Security -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <button type="submit" class="login-btn">
                <span>🔐</span> Se connecter
            </button>
        </form>

        <div class="test-accounts">
            <h3>Comptes de démonstration</h3>
            <div class="account-grid" align="center">
                <div class="account-card" align="center">
                    <strong>Administrateur</strong>
                    <span>admin / Monitor123!</span>
                </div>
<!--                <div class="account-card">-->
<!--                    <strong>Opérateur Aquitaine</strong>-->
<!--                    <span>operateur.aq / Monitor123!</span>-->
<!--                </div>-->
<!--                <div class="account-card">-->
<!--                    <strong>Technicien IDF</strong>-->
<!--                    <span>technicien.idf / Monitor123!</span>-->
<!--                </div>-->
<!--                <div class="account-card">-->
<!--                    <strong>Superviseur</strong>-->
<!--                    <span>superviseur / Monitor123!</span>-->
<!--                </div>-->
            </div>
        </div>

        <div class="security-note">
            <span>🔒</span> Système sécurisé - Accès restreint
        </div>
    </div>

    <!-- Script pour gérer les messages d'erreur -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const errorMessage = document.getElementById('errorMessage');
        const logoutMessage = document.getElementById('logoutMessage');

        // Afficher l'erreur uniquement après une tentative de connexion échouée
        if (urlParams.has('error')) {
            // Vérifier si c'est une vraie erreur (après soumission du formulaire)
            const hasSubmitted = sessionStorage.getItem('loginSubmitted');

            if (hasSubmitted === 'true') {
                errorMessage.classList.add('show');
                // Effacer le flag après affichage
                sessionStorage.removeItem('loginSubmitted');
            }
        }

        // Afficher le message de déconnexion
        if (urlParams.has('logout')) {
            logoutMessage.classList.add('show');
        }

        // Marquer la soumission du formulaire
        document.getElementById('loginForm').addEventListener('submit', function() {
            sessionStorage.setItem('loginSubmitted', 'true');
        });

        // Optionnel: Effacer le message d'erreur après quelques secondes
        if (errorMessage.classList.contains('show')) {
            setTimeout(() => {
                errorMessage.classList.remove('show');
            }, 5000);
        }

        // Optionnel: Effacer le message de déconnexion après quelques secondes
        if (logoutMessage.classList.contains('show')) {
            setTimeout(() => {
                logoutMessage.classList.remove('show');
            }, 3000);
        }
    });
    </script>
</body>
</html>