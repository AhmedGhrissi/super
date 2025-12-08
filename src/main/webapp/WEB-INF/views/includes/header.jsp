<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
// FORCER UTF-8 DANS LE HEADER
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="manifest" href="/manifest.json">
	<link rel="stylesheet" href="/css/notifications.css">
	<link rel="stylesheet" href="/css/animations.css">
	<meta name="theme-color" content="#006747">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">

    <title>🏦 Supervision GEID - Crédit Agricole</title>
    <style>
        /* ========== VARIABLES COULEURS CRÉDIT AGRICOLE ========== */
        :root {
            --ca-green: #006747;
            --ca-light-green: #8DC63F;
            --ca-red: #D50032;
            --ca-orange: #F57C00;
            --ca-blue: #005BAC;
            --ca-white: #FFFFFF;
            --ca-gray-light: #F5F7FA;
            --ca-gray: #6C757D;
            --ca-gray-dark: #343A40;

            --gradient-primary: linear-gradient(135deg, var(--ca-green), var(--ca-light-green));
            --gradient-danger: linear-gradient(135deg, var(--ca-red), #FF5252);
            --gradient-warning: linear-gradient(135deg, var(--ca-orange), #FF9800);
            --gradient-success: linear-gradient(135deg, #2E7D32, #4CAF50);
            --gradient-info: linear-gradient(135deg, var(--ca-blue), #2196F3);

            --shadow: 0 4px 6px rgba(0, 103, 71, 0.1), 0 2px 4px rgba(0, 103, 71, 0.06);
            --shadow-heavy: 0 20px 40px rgba(0, 103, 71, 0.15);
            --radius: 16px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Arial', sans-serif;
            background: linear-gradient(135deg, #F5F7FA 0%, #E8F5E9 100%);
            min-height: 100vh;
            color: var(--ca-gray-dark);
        }

        /* ========== NAVIGATION MODERNE ========== */
        .navbar {
            background: var(--ca-white);
            padding: 0.75rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
            border-bottom: 4px solid var(--ca-green);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .nav-logo {
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: white;
            box-shadow: 0 4px 12px rgba(0, 103, 71, 0.2);
        }

        .nav-brand-text h1 {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.8rem;
            font-weight: 800;
            line-height: 1.2;
        }

        .nav-brand-text p {
            color: var(--ca-gray);
            font-size: 0.85rem;
            font-weight: 500;
        }

        .nav-links {
            display: flex;
            gap: 0.25rem;
            align-items: center;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            text-decoration: none;
            color: var(--ca-gray-dark);
            font-weight: 600;
            border-radius: 12px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--gradient-primary);
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
            box-shadow: 0 4px 15px rgba(0, 103, 71, 0.25);
        }

        .nav-icon {
            font-size: 1.2rem;
            transition: transform 0.3s ease;
        }

        .nav-link:hover .nav-icon {
            transform: scale(1.2);
        }

        .nav-link.active .nav-icon {
            transform: scale(1.2);
        }

        .nav-alert-badge {
            background: var(--gradient-danger);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 700;
            margin-left: 0.5rem;
            animation: pulse 2s infinite;
            min-width: 20px;
            text-align: center;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        .nav-divider {
            width: 1px;
            height: 30px;
            background: linear-gradient(to bottom, transparent, var(--ca-gray), transparent);
            margin: 0 0.5rem;
        }

        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 992px) {
            .navbar {
                padding: 0.75rem 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .nav-brand {
                width: 100%;
                justify-content: center;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                gap: 0.5rem;
            }

            .nav-link {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }

            .nav-divider {
                display: none;
            }

            .container {
                padding: 0 1rem;
            }
        }

        @media (max-width: 576px) {
            .nav-brand-text h1 {
                font-size: 1.5rem;
            }

            .nav-link span:not(.nav-icon) {
                display: none;
            }

            .nav-link {
                padding: 0.75rem;
                border-radius: 50%;
            }

            .nav-icon {
                font-size: 1.3rem;
                margin: 0;
            }

            .nav-alert-badge {
                position: absolute;
                top: -5px;
                right: -5px;
                min-width: 18px;
                height: 18px;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-brand">
            <div class="nav-logo">
                🔍
            </div>
            <div class="nav-brand-text">
                <h1>Supervision GEID</h1>
                <p>Crédit Agricole • Monitoring Temps Réel</p>
            </div>
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

            <a href="/serveurs" class="nav-link ${pageContext.request.requestURI.contains('/serveurs') && !pageContext.request.requestURI.contains('/serveurs-stats') ? 'active' : ''}">
                <span class="nav-icon">🖥️</span>
                <span>Serveurs</span>
            </a>

            <a href="/mises-a-jour" class="nav-link ${pageContext.request.requestURI.contains('/mises-a-jour') ? 'active' : ''}">
                <span class="nav-icon">🔄</span>
                <span>Mises à Jour</span>
                <c:if test="${majPlanifiees > 0}">
                    <span class="nav-alert-badge">${majPlanifiees}</span>
                </c:if>
            </a>

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

            <div class="nav-divider"></div>

            <!-- Section Monitoring -->
            <a href="/monitoring/metrics-dashboard" class="nav-link ${pageContext.request.requestURI.contains('Monitoring') ? 'active' : ''}">
                <span class="nav-icon">📡</span>
                <span>Monitoring</span>
                <c:if test="${serveursCritiquesCount > 0}">
                    <span class="nav-alert-badge" id="criticalCountBadge">${serveursCritiquesCount}</span>
                </c:if>
            </a>

            <a href="/admin/admin-dashboard" class="nav-link ${pageContext.request.requestURI.contains('admin-dashboard') ? 'active' : ''}">
                <span class="nav-icon">⚙️</span>
                <span>Admin</span>
            </a>

            <div class="nav-divider"></div>

            <!-- Notifications -->
            <button onclick="if (window.NotificationManager) {
                window.NotificationManager.requestPermission().then(success => {
                    if (success) showNotification('🔔 Notifications activées!', 'success');
                });
            }"
                    class="nav-link"
                    style="background: var(--gradient-warning); color: white;">
                <span class="nav-icon">🔔</span>
                <span>Notifications</span>
            </button>

            <div class="nav-divider"></div>

            <!-- Déconnexion -->
            <a href="/logout" class="nav-link"
               style="background: var(--gradient-danger); color: white;">
                <span class="nav-icon">🚪</span>
                <span>Déconnexion</span>
            </a>
        </div>
    </nav>
	<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🏦</text></svg>">
    <main class="container">