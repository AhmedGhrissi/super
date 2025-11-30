<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Machine Monitor</title>
	<style>
	    /* Reset et variables */
	    :root {
	        --primary: #4361ee;
	        --secondary: #3a0ca3;
	        --success: #4cc9f0;
	        --warning: #f72585;
	        --info: #7209b7;
	        --light: #f8f9fa;
	        --dark: #212529;
	        --text: #2b2d42;
	        --text-light: #8d99ae;
	        --gradient: linear-gradient(135deg, #4361ee, #3a0ca3);
	        --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
	        --radius: 12px;
	    }

	    * {
	        margin: 0;
	        padding: 0;
	        box-sizing: border-box;
	    }

	    body {
	        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	        min-height: 100vh;
	        color: var(--text);
	    }

	    /* Navigation */
	    .navbar {
	        background: rgba(255, 255, 255, 0.95);
	        backdrop-filter: blur(10px);
	        padding: 1rem 2rem;
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        box-shadow: var(--shadow);
	        border-bottom: 3px solid var(--primary);
	    }

	    .nav-brand h1 {
	        background: var(--gradient);
	        -webkit-background-clip: text;
	        -webkit-text-fill-color: transparent;
	        background-clip: text;
	        font-size: 1.8rem;
	        font-weight: 700;
	    }

	    .nav-links {
	        display: flex;
	        gap: 0.5rem;
	        align-items: center;
	        flex-wrap: wrap;
	    }

	    .nav-link {
	        display: flex;
	        align-items: center;
	        gap: 0.5rem;
	        color: var(--text);
	        text-decoration: none;
	        padding: 0.75rem 1.25rem;
	        border-radius: 25px;
	        font-weight: 600;
	        transition: all 0.3s ease;
	        position: relative;
	        overflow: hidden;
	        font-size: 0.9rem;
	    }

	    .nav-link::before {
	        content: '';
	        position: absolute;
	        top: 0;
	        left: -100%;
	        width: 100%;
	        height: 100%;
	        background: var(--gradient);
	        transition: left 0.3s ease;
	        z-index: -1;
	    }

	    .nav-link:hover::before,
	    .nav-link.active::before {
	        left: 0;
	    }

	    .nav-link:hover,
	    .nav-link.active {
	        color: white;
	        transform: translateY(-2px);
	        box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
	    }

	    .nav-icon {
	        font-size: 1.1rem;
	        transition: transform 0.3s ease;
	    }

	    .nav-link:hover .nav-icon {
	        transform: scale(1.2);
	    }

	    .nav-link.active .nav-icon {
	        transform: scale(1.2);
	    }

	    .nav-divider {
	        color: rgba(67, 97, 238, 0.3);
	        font-weight: 300;
	        margin: 0 0.25rem;
	        font-size: 1.2rem;
	    }

	    .nav-badge {
	        background: linear-gradient(135deg, #f72585, #7209b7);
	        color: white;
	        padding: 0.2rem 0.6rem;
	        border-radius: 12px;
	        font-size: 0.7rem;
	        font-weight: 700;
	        margin-left: 0.5rem;
	        animation: pulse 2s infinite;
	    }

	    @keyframes pulse {
	        0% { transform: scale(1); }
	        50% { transform: scale(1.05); }
	        100% { transform: scale(1); }
	    }

	    /* Layout */
	    .container {
	        max-width: 1400px;
	        margin: 2rem auto;
	        padding: 0 2rem;
	    }

	    .page-header {
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        margin-bottom: 2rem;
	        flex-wrap: wrap;
	        gap: 1rem;
	    }

	    .page-header h2 {
	        background: var(--gradient);
	        -webkit-background-clip: text;
	        -webkit-text-fill-color: transparent;
	        background-clip: text;
	        font-size: 2.5rem;
	        font-weight: 800;
	    }

	    .action-buttons {
	        display: flex;
	        gap: 1rem;
	        flex-wrap: wrap;
	    }

	    /* Cartes */
	    .card {
	        background: rgba(255, 255, 255, 0.95);
	        backdrop-filter: blur(10px);
	        border-radius: var(--radius);
	        padding: 2rem;
	        box-shadow: var(--shadow);
	        border: 1px solid rgba(255, 255, 255, 0.2);
	        transition: transform 0.3s ease, box-shadow 0.3s ease;
	    }

	    .card:hover {
	        transform: translateY(-5px);
	        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	    }

	    /* Boutons */
	    .btn {
	        display: inline-flex;
	        align-items: center;
	        gap: 0.5rem;
	        padding: 0.75rem 1.5rem;
	        border: none;
	        border-radius: 25px;
	        font-weight: 600;
	        text-decoration: none;
	        cursor: pointer;
	        transition: all 0.3s ease;
	        font-size: 0.9rem;
	    }

	    .btn-primary { background: var(--gradient); color: white; }
	    .btn-secondary { background: var(--text-light); color: white; }
	    .btn-success { background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; }
	    .btn-warning { background: linear-gradient(135deg, #f72585, #7209b7); color: white; }
	    .btn-danger { background: linear-gradient(135deg, #ef476f, #ffd166); color: white; }
	    .btn-info { background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; }

	    .btn:hover {
	        transform: translateY(-2px);
	        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
	    }

	    .btn-sm {
	        padding: 0.25rem 0.5rem;
	        font-size: 0.7rem;
	        border-radius: 15px;
	        text-decoration: none;
	        display: inline-flex;
	        align-items: center;
	        gap: 0.25rem;
	    }

	    /* Tableaux */
	    .data-table {
	        width: 100%;
	        background: white;
	        border-radius: var(--radius);
	        overflow: hidden;
	        box-shadow: var(--shadow);
	    }

	    .data-table th {
	        background: var(--gradient);
	        color: white;
	        padding: 1.25rem;
	        text-align: left;
	        font-weight: 600;
	        text-transform: uppercase;
	        letter-spacing: 0.5px;
	    }

	    .data-table td {
	        padding: 0.75rem;
	        border-bottom: 1px solid #e9ecef;
	        vertical-align: top;
	    }

	    .data-table tr:hover {
	        background: rgba(67, 97, 238, 0.05);
	    }

	    /* Badges */
	    .badge {
	        padding: 0.25rem 0.75rem;
	        border-radius: 15px;
	        font-size: 0.8rem;
	        font-weight: 600;
	        display: inline-block;
	    }

	    .badge-category-conformite { background: linear-gradient(135deg, #ef476f, #ffd166); color: white; }
	    .badge-category-processus_metier { background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; }
	    .badge-category-surveillance { background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; }
	    .badge-category-ged { background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; }
	    .badge-category-integration { background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; }
	    .badge-category-web { background: linear-gradient(135deg, #ff6b6b, #ff9e00); color: white; }

	    .status-badge {
	        display: inline-block;
	        padding: 0.25rem 0.75rem;
	        border-radius: 15px;
	        font-size: 0.8rem;
	        font-weight: 600;
	        text-align: center;
	        white-space: nowrap;
	    }

	    .status-badge.active {
	        background: #06d6a0;
	        color: white;
	    }

	    .status-badge.inactive {
	        background: #ef476f;
	        color: white;
	    }

	    /* Statistiques */
	    .stats-grid {
	        display: grid;
	        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	        gap: 1.5rem;
	        margin: 2rem 0;
	    }

	    .stat-card {
	        background: rgba(255, 255, 255, 0.95);
	        backdrop-filter: blur(10px);
	        padding: 2rem;
	        border-radius: var(--radius);
	        text-align: center;
	        box-shadow: var(--shadow);
	        transition: transform 0.3s ease;
	    }

	    .stat-card:hover {
	        transform: translateY(-5px);
	    }

	    .stat-value {
	        font-size: 3rem;
	        font-weight: 800;
	        background: var(--gradient);
	        -webkit-background-clip: text;
	        -webkit-text-fill-color: transparent;
	        background-clip: text;
	        margin-bottom: 0.5rem;
	    }

	    .stat-label {
	        color: var(--text-light);
	        font-weight: 600;
	        text-transform: uppercase;
	        letter-spacing: 1px;
	        font-size: 0.9rem;
	    }

	    /* Responsive */
	    @media (max-width: 768px) {
	        .navbar {
	            flex-direction: column;
	            gap: 1rem;
	            padding: 1rem;
	        }

	        .nav-links {
	            flex-wrap: wrap;
	            justify-content: center;
	            gap: 0.25rem;
	        }

	        .nav-link {
	            padding: 0.6rem 1rem;
	            font-size: 0.8rem;
	        }

	        .nav-divider {
	            display: none;
	        }

	        .container {
	            padding: 0 1rem;
	        }

	        .page-header {
	            flex-direction: column;
	            text-align: center;
	        }
	    }

	    @media (max-width: 480px) {
	        .nav-link span:not(.nav-icon) {
	            display: none;
	        }

	        .nav-link {
	            padding: 0.75rem;
	            border-radius: 50%;
	        }

	        .nav-icon {
	            font-size: 1.2rem;
	            margin: 0;
	        }
	    }
	</style>
	<!-- SCRIPT GLOBAL POUR LES UTILISATEURS -->

</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <h1>🚀 Machine Monitor</h1>
        </div>

		<div class="nav-links">
		    <!-- Section Principale -->
		    <a href="/dashboard" class="nav-link ${pageContext.request.requestURI.contains('dashboard') && !pageContext.request.requestURI.contains('admin') ? 'active' : ''}">
		        <span class="nav-icon">📊</span>
		        <span>Dashboard</span>
		    </a>

		    <a href="/caisses" class="nav-link ${pageContext.request.requestURI.contains('caisses') ? 'active' : ''}">
		        <span class="nav-icon">🏦</span>
		        <span>Caisses</span>
		    </a>

			<!-- Serveurs -->
			<a href="/serveurs" class="nav-link ${pageContext.request.requestURI.contains('/serveurs') && !pageContext.request.requestURI.contains('/serveurs-stats') ? 'active' : ''}">
			    <span class="nav-icon">🖥️</span>
			    <span>Serveurs</span>
			</a>

		    <!-- NOUVEAU : Mises à Jour -->
			<a href="/mises-a-jour" class="nav-link ${pageContext.request.requestURI.contains('/mises-a-jour') ? 'active' : ''}">
			    <span class="nav-icon">🔄</span>
			    <span>Mises à Jour</span>
			</a>

		    <!-- Stats Serveurs -->
			<a href="/serveurs-stats" class="nav-link ${pageContext.request.requestURI.contains('/serveurs-stats') ? 'active' : ''}">
			      <span class="nav-icon">📈</span>
			      <span>Stats Serveurs</span>
			  </a>

		    <a href="/tests" class="nav-link ${pageContext.request.requestURI.contains('tests') ? 'active' : ''}">
		        <span class="nav-icon">🧪</span>
		        <span>Tests</span>
		    </a>

		    <a href="/rapports" class="nav-link ${pageContext.request.requestURI.contains('Rapports') ? 'active' : ''}">
		        <span class="nav-icon">📈</span>
		        <span>Rapports</span>
		    </a>

		    <!-- Séparateur visuel -->
		    <div class="nav-divider">|</div>

		    <!-- Section Monitoring -->
		    <a href="/monitoring/metrics-dashboard" class="nav-link ${pageContext.request.requestURI.contains('Monitoring') ? 'active' : ''}">
		        <span class="nav-icon">📊</span>
		        <span>Monitoring</span>
		    </a>

		    <a href="/admin/admin-dashboard" class="nav-link ${pageContext.request.requestURI.contains('admin-dashboard') ? 'active' : ''}">
		        <span class="nav-icon">⚙️</span>
		        <span>Admin</span>
		    </a>

			<!-- Séparateur visuel -->
			<div class="nav-divider">|</div>

			<!-- Bouton Notifications -->
			<button onclick="if (window.NotificationManager) {
			    window.NotificationManager.requestPermission().then(success => {
			        if (success) showNotification('🔔 Notifications activées!', 'success');
			    });
			}"
			        class="nav-link"
			        style="background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white;">
			    <span class="nav-icon">🔔</span>
			    <span>Notifications</span>
			</button>

		    <!-- Séparateur visuel -->
		    <div class="nav-divider">|</div>

		    <!-- Déconnexion -->
		    <a href="/logout" class="nav-link"
		       style="background: linear-gradient(135deg, #ef476f, #ff6b6b); color: white;"
		       onmouseover="this.style.background='linear-gradient(135deg, #e63946, #ff4757)';"
		       onmouseout="this.style.background='linear-gradient(135deg, #ef476f, #ff6b6b)';">
		        <span class="nav-icon">🚪</span>
		        <span>Déconnexion</span>
		    </a>
		</div>
    </nav>

    <main class="container">