<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Supervision GEID</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* STYLES CORRIGÉS - RESPONSIVE */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            width: 100%;
            flex: 1;
        }

        /* Header Dashboard */
        .dashboard-header-modern {
            background: linear-gradient(135deg, #006747 0%, #8DC63F 100%);
            color: white;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(0, 103, 71, 0.2);
        }

        .dashboard-title {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .dashboard-title h1 {
            font-size: 24px;
            font-weight: 800;
        }

        .dashboard-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 16px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 13px;
        }

        .dashboard-subtitle {
            opacity: 0.9;
            margin-bottom: 20px;
            font-size: 15px;
        }

        /* Header Stats */
        .header-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        @media (max-width: 1024px) {
            .header-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .header-stats {
                grid-template-columns: 1fr;
            }
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.15);
            padding: 18px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .stat-icon {
            width: 45px;
            height: 45px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 800;
            line-height: 1;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 13px;
            opacity: 0.8;
        }

        /* System Status */
        .system-status-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .system-status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f3f4;
            flex-wrap: wrap;
            gap: 15px;
        }

        .system-status-header h3 {
            color: #006747;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .system-status-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
        }

        @media (max-width: 1024px) {
            .system-status-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .system-status-grid {
                grid-template-columns: 1fr;
            }
        }

        .system-status-item {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .system-status-label {
            color: #666;
            font-weight: 600;
            font-size: 14px;
        }

        .system-status-value {
            font-weight: 700;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 14px;
        }

        .system-status-value.success {
            background: #d4edda;
            color: #155724;
        }

        .system-status-value.warning {
            background: #fff3cd;
            color: #856404;
        }

        .system-status-value.error {
            background: #f8d7da;
            color: #721c24;
        }

        /* Countdown */
        .countdown-timer {
            font-family: monospace;
            background: #f8f9fa;
            padding: 4px 10px;
            border-radius: 4px;
            font-weight: 700;
            color: #006747;
            font-size: 14px;
        }

        /* Servers Section */
        .servers-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .servers-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin: 20px 0;
        }

        @media (max-width: 1024px) {
            .servers-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .servers-grid {
                grid-template-columns: 1fr;
            }
        }

        .server-card {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-left: 4px solid #006747;
        }

        .server-status {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            flex-shrink: 0;
        }

        .server-status.online {
            background: #28a745;
        }

        .server-status.offline {
            background: #dc3545;
        }

        .server-status.warning {
            background: #ffc107;
        }

        .server-name {
            font-weight: 700;
            color: #006747;
            font-size: 15px;
        }

        .server-type {
            font-size: 13px;
            color: #666;
        }

        /* Alerts Section */
        .alerts-section-modern {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .alerts-header-modern {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .alerts-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 18px;
            font-weight: 700;
            color: #006747;
        }

        .badge-tests {
            background: #dc3545;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .alerts-count {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #666;
            font-size: 14px;
        }

        .alert-count-critical {
            color: #d50032;
            font-weight: 700;
        }

        .alert-count-warning {
            color: #ffc107;
            font-weight: 700;
        }

        .alerts-refresh-btn {
            background: #006747;
            color: white;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: none;
            font-size: 14px;
        }

        /* Stats Cards */
        .stats-section-modern {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            .stats-section-modern {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .stats-section-modern {
                grid-template-columns: 1fr;
            }
        }

        .stat-card-modern {
            background: white;
            border-radius: 12px;
            padding: 18px;
            border-top: 4px solid #006747;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .stat-card-icon {
            font-size: 22px;
            color: #006747;
        }

        .stat-card-trend {
            font-size: 12px;
            font-weight: 700;
            padding: 4px 8px;
            border-radius: 20px;
        }

        .stat-card-trend.up {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .stat-card-trend.down {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .stat-card-value {
            font-size: 28px;
            font-weight: 800;
            color: #006747;
            line-height: 1;
            margin: 8px 0;
        }

        .stat-card-label {
            color: #666;
            font-size: 13px;
            margin-bottom: 12px;
        }

        .stat-card-progress {
            height: 6px;
            background: #f8f9fa;
            border-radius: 4px;
            overflow: hidden;
        }

        .stat-card-progress-bar {
            height: 100%;
            border-radius: 4px;
        }

        /* Quick Actions */
        .quick-actions-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .quick-actions-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        @media (max-width: 1024px) {
            .quick-actions-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .quick-actions-grid {
                grid-template-columns: 1fr;
            }
        }

        .quick-action-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 18px;
        }

        .quick-action-icon {
            font-size: 28px;
            color: #006747;
            margin-bottom: 12px;
        }

        .quick-action-title {
            font-size: 16px;
            font-weight: 700;
            color: #006747;
            margin-bottom: 8px;
        }

        .quick-action-description {
            color: #666;
            font-size: 13px;
            margin-bottom: 15px;
            line-height: 1.4;
        }

        /* Buttons */
        .btn-quick-action {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #006747;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            font-size: 13px;
            transition: background 0.2s;
        }

        .btn-quick-action:hover {
            background: #005738;
        }

        /* Charts */
        .charts-section {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .charts-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .charts-grid {
                grid-template-columns: 1fr;
            }
        }

        .chart-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 18px;
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .chart-header h4 {
            color: #006747;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .chart-badge {
            background: #006747;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }

        .chart-container {
            height: 220px;
        }

        /* Chatbot */
        .chatbot-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }

        .chatbot-button {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: #006747;
            color: white;
            border: none;
            font-size: 22px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0, 103, 71, 0.3);
            position: relative;
        }

        .chatbot-window {
            position: absolute;
            bottom: 65px;
            right: 0;
            width: 320px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            display: none;
            flex-direction: column;
            height: 420px;
            border: 2px solid #006747;
        }

        .chatbot-header {
            background: #006747;
            color: white;
            padding: 15px;
            border-radius: 14px 14px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chatbot-messages {
            flex: 1;
            padding: 15px;
            overflow-y: auto;
            background: #f8f9fa;
        }

        .chatbot-input {
            padding: 15px;
            background: white;
            border-top: 1px solid #dee2e6;
            display: flex;
            gap: 10px;
        }

        .chatbot-input input {
            flex: 1;
            padding: 10px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            font-size: 14px;
        }

        .chatbot-input button {
            background: #006747;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            cursor: pointer;
        }

        .message {
            margin-bottom: 12px;
        }

        .message.bot {
            text-align: left;
        }

        .message.user {
            text-align: right;
        }

        .message-content {
            display: inline-block;
            padding: 10px 14px;
            border-radius: 15px;
            max-width: 85%;
            font-size: 14px;
        }

        .message.bot .message-content {
            background: white;
            border: 1px solid #dee2e6;
        }

        .message.user .message-content {
            background: #006747;
            color: white;
        }

        .chatbot-quick-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin: 12px 0;
        }

        .chatbot-quick-btn {
            background: #e9ecef;
            border: none;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            cursor: pointer;
        }

        .alert-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* Custom Popup ISO Style */
        .popup-iso {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 9999;
            align-items: center;
            justify-content: center;
        }

        .popup-content {
            background: white;
            border-radius: 12px;
            padding: 25px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: 2px solid #006747;
        }

        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f3f4;
        }

        .popup-header h3 {
            color: #006747;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .popup-close {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: #666;
        }

        .popup-body {
            margin-bottom: 20px;
        }

        .popup-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        /* Notification fix */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            z-index: 9998;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideIn 0.3s ease;
        }

        .notification.success {
            background: #28a745;
            color: white;
        }

        .notification.error {
            background: #dc3545;
            color: white;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* Responsive fixes */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .dashboard-header-modern {
                padding: 20px;
            }

            .dashboard-title h1 {
                font-size: 22px;
            }

            .system-status-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .alerts-header-modern {
                flex-direction: column;
                align-items: flex-start;
            }

            .chatbot-window {
                width: calc(100vw - 30px);
                right: 5px;
                height: 380px;
            }

            .popup-content {
                width: 95%;
                padding: 20px;
            }
        }

        @media (max-width: 480px) {
            .stat-value {
                font-size: 20px;
            }

            .stat-card-value {
                font-size: 24px;
            }

            .btn-quick-action {
                padding: 8px 16px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="includes/header.jsp" />

    <!-- Main Content -->
    <main class="container">
        <!-- Dashboard Header -->
        <header class="dashboard-header-modern">
            <div class="dashboard-title">
                <h1><i class="fas fa-tachometer-alt"></i> Tableau de Bord</h1>
                <span class="dashboard-badge" id="statutGlobal">STABLE</span>
            </div>

            <p class="dashboard-subtitle">
                Vue d'ensemble de l'infrastructure et supervision en temps réel
                <br>
                <small>Dernière mise à jour: <span id="last-update-display">--:--:--</span></small>
            </p>

            <div class="header-stats">
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-server"></i></div>
                    <div>
                        <div class="stat-value" id="serveursActifs">8/12</div>
                        <div class="stat-label">Serveurs actifs</div>
                    </div>
                </div>

                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                    <div>
                        <div class="stat-value" id="disponibilite">98.7%</div>
                        <div class="stat-label">Disponibilité</div>
                    </div>
                </div>

                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-bell"></i></div>
                    <div>
                        <div class="stat-value" id="alertesCritiques">3</div>
                        <div class="stat-label">Alertes critiques</div>
                    </div>
                </div>

                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-sync-alt"></i></div>
                    <div>
                        <div class="stat-value">
                            <span id="last-update-time">--:--:--</span>
                        </div>
                        <div class="stat-label">Dernière mise à jour</div>
                    </div>
                </div>
            </div>
        </header>

        <!-- System Status -->
        <section class="system-status-section">
            <div class="system-status-header">
                <h3><i class="fas fa-chart-line"></i> État du Système</h3>
                <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
                    <div style="font-size: 14px; color: #6c757d;">
                        <span id="current-time">--:--:--</span>
                    </div>
                    <div style="font-size: 14px; color: #006747; font-weight: 600; display: flex; align-items: center; gap: 8px;">
                        <i class="fas fa-sync-alt"></i> Rafraîchissement dans
                        <span id="refresh-countdown-header" class="countdown-timer">5:00</span>
                    </div>
                </div>
            </div>

            <div class="system-status-grid">
                <div class="system-status-item">
                    <span class="system-status-label">Statut global</span>
                    <span class="system-status-value success" id="statutGlobalValue">STABLE</span>
                </div>

                <div class="system-status-item">
                    <span class="system-status-label">Prochaine MAJ</span>
                    <span class="system-status-value warning" id="prochaineMAJ">--/-- --:--</span>
                </div>

                <div class="system-status-item">
                    <span class="system-status-label">Disponibilité</span>
                    <span class="system-status-value" id="disponibiliteValue">98.7%</span>
                </div>

                <div class="system-status-item">
                    <span class="system-status-label">Alertes critiques</span>
                    <span class="system-status-value error" id="alertesCritiquesValue">3</span>
                </div>
            </div>
        </section>

        <!-- Active Servers -->
        <section class="servers-section">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h3 style="color: #006747; font-size: 18px; display: flex; align-items: center; gap: 10px;">
                    <i class="fas fa-server"></i> Serveurs Actifs
                </h3>
                <a href="/serveurs" style="font-size: 14px; text-decoration: none; color: #006747; font-weight: 600;">
                    Voir tous <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <div class="servers-grid" id="serveursGrid">
                <!-- Filled by JavaScript -->
            </div>

            <div style="text-align: center; margin-top: 20px;">
                <a href="/serveurs" class="btn-quick-action">
                    <i class="fas fa-list"></i> Voir tous les serveurs
                </a>
            </div>
        </section>

        <!-- Alerts -->
        <section class="alerts-section-modern">
            <div class="alerts-header-modern">
                <div class="alerts-title">
                    <i class="fas fa-bell"></i> Alertes Actives
                    <span class="badge-tests" id="alertesBadge">3 CRITIQUES</span>
                </div>

                <div class="alerts-count">
                    <span class="alert-count-critical" id="alertesCritiquesCount">3 critiques</span>
                    <span class="alert-count-warning" id="alertesWarningCount">/ 2 warnings</span>
                    <button class="alerts-refresh-btn" onclick="rafraichirAlertes()">
                        <i class="fas fa-sync-alt"></i>
                    </button>
                </div>
            </div>

            <div id="alertesContainer">
                <!-- Filled by JavaScript -->
            </div>
        </section>

        <!-- Stats Cards -->
        <section class="stats-section-modern">
            <div class="stat-card-modern" style="border-top-color: #006747;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="stat-card-trend up">+2.5%</div>
                </div>
                <div class="stat-card-value" id="statsDisponibilite">98.7%</div>
                <div class="stat-card-label">Taux de disponibilité mensuel</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressDisponibilite" style="width: 98.7%; background: #006747;"></div>
                </div>
            </div>

            <div class="stat-card-modern" style="border-top-color: #28a745;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-check-circle"></i></div>
                    <div class="stat-card-trend up">+8%</div>
                </div>
                <div class="stat-card-value" id="statsTestsReussis">96.2%</div>
                <div class="stat-card-label">Tests réussis (24h)</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressTests" style="width: 96.2%; background: #28a745;"></div>
                </div>
            </div>

            <div class="stat-card-modern" style="border-top-color: #ffc107;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-bolt"></i></div>
                    <div class="stat-card-trend down">-15ms</div>
                </div>
                <div class="stat-card-value" id="statsTempsReponse">124ms</div>
                <div class="stat-card-label">Temps de réponse moyen</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressTemps" style="width: 85%; background: #ffc107;"></div>
                </div>
            </div>

            <div class="stat-card-modern" style="border-top-color: #17a2b8;">
                <div class="stat-card-header">
                    <div class="stat-card-icon"><i class="fas fa-wrench"></i></div>
                    <div class="stat-card-trend up">+12</div>
                </div>
                <div class="stat-card-value" id="statsIncidentsResolus">142</div>
                <div class="stat-card-label">Incidents résolus (7j)</div>
                <div class="stat-card-progress">
                    <div class="stat-card-progress-bar" id="progressIncidents" style="width: 92%; background: #17a2b8;"></div>
                </div>
            </div>
        </section>

        <!-- Quick Actions -->
        <section class="quick-actions-section">
            <h3 style="color: #006747; font-size: 18px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                <i class="fas fa-bolt"></i> Actions Rapides
            </h3>

            <div class="quick-actions-grid">
                <div class="quick-action-card">
                    <div class="quick-action-icon"><i class="fas fa-play-circle"></i></div>
                    <div class="quick-action-title">Lancer Tous les Tests</div>
                    <div class="quick-action-description">Exécute tous les tests actifs sur l'ensemble des serveurs</div>
                    <button class="btn-quick-action" onclick="lancerTousTestsPopup()">
                        <i class="fas fa-play"></i> Exécuter
                    </button>
                </div>

                <div class="quick-action-card">
                    <div class="quick-action-icon"><i class="fas fa-filter"></i></div>
                    <div class="quick-action-title">Tests par Catégorie</div>
                    <div class="quick-action-description">Exécute des tests ciblés par catégorie</div>
                    <select id="categorieSelectDashboard" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 15px; font-size: 14px;">
                        <option value="">Choisir une catégorie</option>
                        <option value="conformite">Conformité</option>
                        <option value="processus_metier">Processus Métier</option>
                        <option value="surveillance">Surveillance</option>
                        <option value="ged">GED</option>
                        <option value="integration">Intégration</option>
                        <option value="web">Applications Web</option>
                    </select>
                    <button class="btn-quick-action" onclick="dashboardLancerTestsCategoriePopup()">
                        <i class="fas fa-play"></i> Lancer
                    </button>
                </div>

                <div class="quick-action-card">
                    <div class="quick-action-icon"><i class="fas fa-calendar-plus"></i></div>
                    <div class="quick-action-title">Planifier une MAJ</div>
                    <div class="quick-action-description">Programmer une mise à jour de l'infrastructure</div>
                    <a href="/mises-a-jour/create" class="btn-quick-action">
                        <i class="fas fa-plus"></i> Nouvelle MAJ
                    </a>
                </div>
            </div>
        </section>

        <!-- Charts -->
        <section class="charts-section">
            <h3 style="color: #006747; font-size: 18px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                <i class="fas fa-chart-line"></i> Métriques en Temps Réel
            </h3>

            <div class="charts-grid">
                <div class="chart-card">
                    <div class="chart-header">
                        <h4><i class="fas fa-microchip"></i> Utilisation CPU</h4>
                        <span class="chart-badge">EN TEMPS RÉEL</span>
                    </div>
                    <div class="chart-container">
                        <canvas id="cpuChart"></canvas>
                    </div>
                </div>

                <div class="chart-card">
                    <div class="chart-header">
                        <h4><i class="fas fa-memory"></i> Utilisation Mémoire</h4>
                        <span class="chart-badge">24H</span>
                    </div>
                    <div class="chart-container">
                        <canvas id="memoryChart"></canvas>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Popup ISO Style -->
    <div class="popup-iso" id="popupIso">
        <div class="popup-content">
            <div class="popup-header">
                <h3><i class="fas fa-info-circle"></i> <span id="popupTitle"></span></h3>
                <button class="popup-close" onclick="closePopup()">&times;</button>
            </div>
            <div class="popup-body" id="popupBody">
                <!-- Content will be inserted here -->
            </div>
            <div class="popup-footer">
                <button class="btn-quick-action" onclick="closePopup()">Fermer</button>
            </div>
        </div>
    </div>

    <!-- Chatbot -->
    <div class="chatbot-container">
        <div class="chatbot-window" id="chatbotWindow">
            <div class="chatbot-header">
                <strong><i class="fas fa-robot"></i> Assistant GEID</strong>
                <button onclick="toggleChatbot()" style="background: none; border: none; color: white; cursor: pointer;">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="chatbot-messages" id="chatbotMessages">
                <div class="message bot">
                    <div class="message-content">
                        Bonjour ! Je suis l'assistant GEID. Comment puis-je vous aider avec le tableau de bord ?
                    </div>
                </div>
            </div>
            <div class="chatbot-input">
                <input type="text" id="chatbotInput" placeholder="Posez votre question...">
                <button onclick="sendChatbotMessage()">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>
        <button class="chatbot-button" onclick="toggleChatbot()">
            <i class="fas fa-robot"></i>
            <span class="alert-badge" id="chatbotAlertBadge">3</span>
        </button>
    </div>

    <!-- Footer -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- JavaScript CORRIGÉ -->
    <script>
        // Données d'exemple
        var dashboardData = {
            serveurs: [
                { id: 1, nom: "SRV-PROD-01", type: "Production", statut: "ONLINE", chargeCPU: 45 },
                { id: 2, nom: "SRV-PROD-02", type: "Production", statut: "ONLINE", chargeCPU: 32 },
                { id: 3, nom: "SRV-TEST-01", type: "Test", statut: "ONLINE", chargeCPU: 28 },
                { id: 4, nom: "SRV-DB-01", type: "Base de données", statut: "WARNING", chargeCPU: 78 },
                { id: 5, nom: "SRV-WEB-01", type: "Web", statut: "ONLINE", chargeCPU: 22 },
                { id: 6, nom: "SRV-BACKUP-01", type: "Backup", statut: "OFFLINE", chargeCPU: 0 }
            ],
            alertes: [
                { id: 1, nom: "CPU élevé", description: "Utilisation CPU > 80%", serveurCible: "SRV-DB-01", criticite: "CRITICAL", date: "15/12 10:30" },
                { id: 2, nom: "Mémoire insuffisante", description: "Mémoire disponible < 10%", serveurCible: "SRV-PROD-01", criticite: "WARNING", date: "15/12 09:45" },
                { id: 3, nom: "Service arrêté", description: "Service Apache arrêté", serveurCible: "SRV-WEB-01", criticite: "CRITICAL", date: "15/12 08:15" },
                { id: 4, nom: "Disque plein", description: "Espace disque < 5%", serveurCible: "SRV-BACKUP-01", criticite: "CRITICAL", date: "14/12 22:30" },
                { id: 5, nom: "Latence réseau", description: "Latence > 200ms", criticite: "WARNING", date: "14/12 21:00" }
            ],
            stats: {
                serveursActifs: "8/12",
                disponibilite: "98.7%",
                alertesCritiques: 3,
                alertesWarning: 2,
                statutGlobal: "STABLE",
                tauxDisponibilite: 98.7,
                testsReussis: 96.2,
                tempsReponse: 124,
                incidentsResolus: 142
            }
        };

        // Variables globales
        var countdownInterval;
        var timeLeft = 5 * 60;
        var cpuChart = null;
        var memoryChart = null;
        var currentNotification = null;

        // Initialisation au chargement
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Dashboard initialisé');

            initDashboardData();
            startCountdown();
            updateClock();
            setInterval(updateClock, 1000);
            initCharts();
            updateProchaineMAJ();
            initChatbot();
            setupProgressBars();
        });

        // Initialiser les données
        function initDashboardData() {
            // Mettre à jour les stats
            document.getElementById('serveursActifs').textContent = dashboardData.stats.serveursActifs;
            document.getElementById('disponibilite').textContent = dashboardData.stats.disponibilite;
            document.getElementById('alertesCritiques').textContent = dashboardData.stats.alertesCritiques;
            document.getElementById('statutGlobal').textContent = dashboardData.stats.statutGlobal;
            document.getElementById('statutGlobalValue').textContent = dashboardData.stats.statutGlobal;
            document.getElementById('disponibiliteValue').textContent = dashboardData.stats.disponibilite;
            document.getElementById('alertesCritiquesValue').textContent = dashboardData.stats.alertesCritiques;

            // Mettre à jour les cartes de stats
            document.getElementById('statsDisponibilite').textContent = dashboardData.stats.disponibilite;
            document.getElementById('statsTestsReussis').textContent = dashboardData.stats.testsReussis + '%';
            document.getElementById('statsTempsReponse').textContent = dashboardData.stats.tempsReponse + 'ms';
            document.getElementById('statsIncidentsResolus').textContent = dashboardData.stats.incidentsResolus;

            // Afficher les serveurs
            displayServeurs();

            // Afficher les alertes
            displayAlertes();

            // Mettre à jour la dernière MAJ
            updateLastUpdate();

            // Mettre à jour le badge du chatbot
            updateChatbotBadge();
        }

        // Afficher les serveurs
        function displayServeurs() {
            var grid = document.getElementById('serveursGrid');
            grid.innerHTML = '';

            dashboardData.serveurs.forEach(function(serveur) {
                var statusClass = serveur.statut === 'ONLINE' ? 'online' :
                                serveur.statut === 'OFFLINE' ? 'offline' : 'warning';

                var card = document.createElement('div');
                card.className = 'server-card';
                card.innerHTML = '<div class="server-status ' + statusClass + '"></div>' +
                               '<div style="flex: 1;">' +
                               '<div class="server-name">' + serveur.nom + '</div>' +
                               '<div class="server-type">' + serveur.type + '</div>' +
                               '</div>' +
                               '<div style="font-size: 13px; color: #666;">CPU: ' + serveur.chargeCPU + '%</div>';
                grid.appendChild(card);
            });
        }

        // Afficher les alertes
        function displayAlertes() {
            var container = document.getElementById('alertesContainer');
            var alertesCritiques = dashboardData.alertes.filter(function(a) { return a.criticite === 'CRITICAL'; }).length;
            var alertesWarning = dashboardData.alertes.filter(function(a) { return a.criticite === 'WARNING'; }).length;

            // Mettre à jour les compteurs
            document.getElementById('alertesBadge').textContent = alertesCritiques + ' CRITIQUES';
            document.getElementById('alertesCritiquesCount').textContent = alertesCritiques + ' critiques';
            document.getElementById('alertesWarningCount').textContent = '/ ' + alertesWarning + ' warnings';

            if (dashboardData.alertes.length > 0) {
                var html = '<div style="overflow-x: auto;">' +
                          '<table style="width: 100%; border-collapse: collapse; background: white; border-radius: 12px;">' +
                          '<thead style="background: #f8f9fa;">' +
                          '<tr>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Type</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Description</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Serveur</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Date</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Statut</th>' +
                          '<th style="padding: 12px; text-align: left; font-size: 14px;">Actions</th>' +
                          '</tr>' +
                          '</thead>' +
                          '<tbody>';

                dashboardData.alertes.forEach(function(alerte) {
                    var color, icon, bgColor, statutText;

                    if (alerte.criticite === 'CRITICAL') {
                        color = '#d50032';
                        icon = 'fa-exclamation-circle';
                        bgColor = '#d50032';
                        statutText = 'Critique';
                    } else if (alerte.criticite === 'WARNING') {
                        color = '#ffc107';
                        icon = 'fa-exclamation-triangle';
                        bgColor = '#ffc107';
                        statutText = 'Alerte';
                    } else {
                        color = '#2196F3';
                        icon = 'fa-info-circle';
                        bgColor = '#2196F3';
                        statutText = 'Normal';
                    }

                    html += '<tr style="border-bottom: 1px solid #f1f3f4;">' +
                           '<td style="padding: 12px;">' +
                           '<span style="color: ' + color + ';">' +
                           '<i class="fas ' + icon + '"></i>' +
                           '<strong style="font-size: 13px;">' + alerte.criticite + '</strong>' +
                           '</span>' +
                           '</td>' +
                           '<td style="padding: 12px;">' +
                           '<strong style="font-size: 14px;">' + alerte.nom + '</strong>' +
                           '<div style="font-size: 13px; color: #666; margin-top: 4px;">' + alerte.description + '</div>' +
                           '</td>' +
                           '<td style="padding: 12px;">';

                    if (alerte.serveurCible) {
                        html += '<span style="background: #e9ecef; padding: 4px 8px; border-radius: 4px; font-size: 13px;">' + alerte.serveurCible + '</span>';
                    } else {
                        html += '<span style="color: #999; font-size: 13px;">N/A</span>';
                    }

                    html += '</td>' +
                           '<td style="padding: 12px; font-size: 13px;">' + alerte.date + '</td>' +
                           '<td style="padding: 12px;">' +
                           '<span style="background: ' + bgColor + '; color: white; padding: 4px 8px; border-radius: 4px; font-size: 13px;">' + statutText + '</span>' +
                           '</td>' +
                           '<td style="padding: 12px;">' +
                           '<button onclick="voirAlerteDetailPopup(' + alerte.id + ')" style="background: #006747; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 13px;">' +
                           '<i class="fas fa-eye"></i> Voir' +
                           '</button>' +
                           '</td>' +
                           '</tr>';
                });

                html += '</tbody>' +
                       '</table>' +
                       '</div>' +
                       '<div style="margin-top: 20px; text-align: center; display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">' +
                       '<a href="/alertes" class="btn-quick-action" style="text-decoration: none;">' +
                       '<i class="fas fa-list"></i> Voir toutes les alertes' +
                       '</a>' +
                       '<button onclick="rafraichirAlertes()" class="btn-quick-action" style="background: #6c757d;">' +
                       '<i class="fas fa-sync-alt"></i> Rafraîchir' +
                       '</button>' +
                       '</div>';

                container.innerHTML = html;
            } else {
                container.innerHTML = '<div style="text-align: center; padding: 40px; background: #f8f9fa; border-radius: 12px;">' +
                                     '<div style="font-size: 48px; margin-bottom: 15px; color: #28a745;">' +
                                     '<i class="fas fa-check-circle"></i>' +
                                     '</div>' +
                                     '<h4 style="color: #006747;">Aucune alerte critique</h4>' +
                                     '<p style="color: #6c757d;">Tous les systèmes fonctionnent normalement</p>' +
                                     '</div>';
            }
        }

        // Configurer les barres de progression
        function setupProgressBars() {
            setTimeout(function() {
                document.getElementById('progressDisponibilite').style.width = '98.7%';
                document.getElementById('progressDisponibilite').style.background = '#006747';

                document.getElementById('progressTests').style.width = '96.2%';
                document.getElementById('progressTests').style.background = '#28a745';

                document.getElementById('progressTemps').style.width = '85%';
                document.getElementById('progressTemps').style.background = '#ffc107';

                document.getElementById('progressIncidents').style.width = '92%';
                document.getElementById('progressIncidents').style.background = '#17a2b8';
            }, 300);
        }

        // Compte à rebours
        function startCountdown() {
            clearInterval(countdownInterval);
            timeLeft = 5 * 60;

            function updateCountdownDisplay() {
                var minutes = Math.floor(timeLeft / 60);
                var seconds = timeLeft % 60;

                var countdownElement = document.getElementById('refresh-countdown-header');
                if (countdownElement) {
                    countdownElement.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
                }

                if (timeLeft <= 0) {
                    timeLeft = 5 * 60;
                    refreshDashboard();
                } else {
                    timeLeft--;
                }
            }

            updateCountdownDisplay();
            countdownInterval = setInterval(updateCountdownDisplay, 1000);
        }

        // Horloge
        function updateClock() {
            var now = new Date();
            var timeStr = now.toLocaleTimeString('fr-FR', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            var dateStr = now.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            document.getElementById('current-time').innerHTML = '<strong>' + timeStr + '</strong> - ' + dateStr;
        }

        // Prochaine MAJ dynamique
        function updateProchaineMAJ() {
            var now = new Date();
            var tomorrow = new Date(now);
            tomorrow.setDate(tomorrow.getDate() + 1);
            tomorrow.setHours(2, 0, 0, 0);

            var formattedDate = tomorrow.toLocaleDateString('fr-FR', {
                day: '2-digit',
                month: '2-digit',
                hour: '2-digit',
                minute: '2-digit'
            }).replace(',', '');

            document.getElementById('prochaineMAJ').textContent = formattedDate;
        }

        // Dernière mise à jour
        function updateLastUpdate() {
            var now = new Date();
            var timeStr = now.toLocaleTimeString('fr-FR', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
            var dateStr = now.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            document.getElementById('last-update-display').textContent = timeStr + ' - ' + dateStr;
            document.getElementById('last-update-time').textContent = timeStr;
        }

        // Badge chatbot
        function updateChatbotBadge() {
            document.getElementById('chatbotAlertBadge').textContent = dashboardData.stats.alertesCritiques;
        }

        // ========== FONCTIONS AVEC POPUP ISO ==========

        function showPopup(title, content) {
            document.getElementById('popupTitle').textContent = title;
            document.getElementById('popupBody').innerHTML = content;
            document.getElementById('popupIso').style.display = 'flex';
        }

        function closePopup() {
            document.getElementById('popupIso').style.display = 'none';
        }

        // Alertes avec popup
        function rafraichirAlertes() {
            console.log('Rafraîchissement des alertes');

            // Animer le bouton
            var refreshBtn = document.querySelector('.alerts-refresh-btn i');
            if (refreshBtn) {
                refreshBtn.style.animation = 'spin 1s linear';
                setTimeout(function() { refreshBtn.style.animation = ''; }, 1000);
            }

            // Simuler le rafraîchissement
            setTimeout(function() {
                dashboardData.alertes.reverse();
                displayAlertes();
                updateChatbotBadge();
                showNotification('Alertes rafraîchies avec succès', 'success');
            }, 800);
        }

        function voirAlerteDetailPopup(id) {
            var alerte = dashboardData.alertes.find(function(a) { return a.id == id; });
            if (alerte) {
                var content = '<div style="font-size: 14px; line-height: 1.6;">' +
                            '<p><strong>Nom de l\'alerte:</strong> ' + alerte.nom + '</p>' +
                            '<p><strong>Description:</strong> ' + alerte.description + '</p>' +
                            '<p><strong>Serveur concerné:</strong> ' + (alerte.serveurCible || 'N/A') + '</p>' +
                            '<p><strong>Date de détection:</strong> ' + alerte.date + '</p>' +
                            '<p><strong>Criticité:</strong> <span style="color: ' + (alerte.criticite === 'CRITICAL' ? '#d50032' : '#ffc107') + '; font-weight: bold;">' +
                            (alerte.criticite === 'CRITICAL' ? 'CRITIQUE' : 'ALERTE') + '</span></p>' +
                            '</div>';

                showPopup('Détail de l\'alerte #' + id, content);
            }
        }

        // Tests avec popup
        function lancerTousTestsPopup() {
            var content = '<div style="font-size: 14px; line-height: 1.6;">' +
                        '<p><strong>Action:</strong> Lancer tous les tests</p>' +
                        '<p><strong>Portée:</strong> Tous les serveurs actifs</p>' +
                        '<p><strong>Nombre de serveurs:</strong> ' + dashboardData.stats.serveursActifs + '</p>' +
                        '<p><strong>Durée estimée:</strong> 2-3 minutes</p>' +
                        '<p style="color: #006747; font-weight: bold; margin-top: 15px;">Confirmez-vous le lancement de tous les tests ?</p>' +
                        '</div>';

            showPopup('Lancer tous les tests', content);

            // Ajouter un bouton de confirmation
            var popupFooter = document.querySelector('.popup-footer');
            popupFooter.innerHTML = '<button class="btn-quick-action" style="background: #6c757d;" onclick="closePopup()">Annuler</button>' +
                                  '<button class="btn-quick-action" onclick="executeLancerTousTests()">Confirmer</button>';
        }

        function executeLancerTousTests() {
            closePopup();

            // Simuler le lancement des tests
            showNotification('Tous les tests ont été lancés avec succès', 'success');

            // Simuler un délai court pour éviter la violation
            setTimeout(function() {
                console.log('Tests lancés');
            }, 100);
        }

        function dashboardLancerTestsCategoriePopup() {
            var categorieSelect = document.getElementById('categorieSelectDashboard');
            var categorie = categorieSelect.value;

            if (!categorie) {
                showPopup('Erreur de sélection', '<p style="color: #d50032; font-weight: bold;">Veuillez sélectionner une catégorie de tests.</p>');
                return;
            }

            var categorieNoms = {
                'conformite': 'Conformité',
                'processus_metier': 'Processus Métier',
                'surveillance': 'Surveillance',
                'ged': 'GED',
                'integration': 'Intégration',
                'web': 'Applications Web'
            };

            var nomCategorie = categorieNoms[categorie] || categorie;

            var content = '<div style="font-size: 14px; line-height: 1.6;">' +
                        '<p><strong>Action:</strong> Lancer les tests par catégorie</p>' +
                        '<p><strong>Catégorie sélectionnée:</strong> ' + nomCategorie + '</p>' +
                        '<p><strong>Portée:</strong> Tous les serveurs concernés</p>' +
                        '<p><strong>Durée estimée:</strong> 1-2 minutes</p>' +
                        '<p style="color: #006747; font-weight: bold; margin-top: 15px;">Confirmez-vous le lancement des tests de la catégorie "' + nomCategorie + '" ?</p>' +
                        '</div>';

            showPopup('Tests par catégorie', content);

            // Ajouter un bouton de confirmation
            var popupFooter = document.querySelector('.popup-footer');
            popupFooter.innerHTML = '<button class="btn-quick-action" style="background: #6c757d;" onclick="closePopup()">Annuler</button>' +
                                  '<button class="btn-quick-action" onclick="executeTestsCategorie(\'' + categorie + '\', \'' + nomCategorie + '\')">Confirmer</button>';
        }

        function executeTestsCategorie(categorie, nomCategorie) {
            closePopup();

            // Simuler le lancement des tests
            showNotification('Tests de la catégorie "' + nomCategorie + '" lancés avec succès', 'success');

            // Simuler un délai court
            setTimeout(function() {
                console.log('Tests de catégorie ' + categorie + ' lancés');
            }, 100);
        }

        // ========== NOTIFICATION UNIQUE ==========

        function showNotification(message, type) {
            // Supprimer l'ancienne notification si elle existe
            if (currentNotification) {
                currentNotification.remove();
            }

            var notification = document.createElement('div');
            notification.className = 'notification ' + type;
            notification.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check' : 'exclamation') + '-circle"></i> ' + message;

            document.body.appendChild(notification);
            currentNotification = notification;

            setTimeout(function() {
                if (notification.parentNode) {
                    notification.remove();
                    currentNotification = null;
                }
            }, 3000);
        }

        // ========== GRAPHIQUES ==========

        function initCharts() {
            // Graphique CPU
            var cpuCtx = document.getElementById('cpuChart');
            if (cpuCtx) {
                cpuChart = new Chart(cpuCtx.getContext('2d'), {
                    type: 'line',
                    data: {
                        labels: ['00h', '04h', '08h', '12h', '16h', '20h'],
                        datasets: [{
                            label: 'Utilisation CPU (%)',
                            data: [35, 42, 38, 55, 48, 40],
                            borderColor: '#006747',
                            backgroundColor: 'rgba(0, 103, 71, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } }
                    }
                });
            }

            // Graphique Mémoire
            var memoryCtx = document.getElementById('memoryChart');
            if (memoryCtx) {
                memoryChart = new Chart(memoryCtx.getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: ['Serveur 1', 'Serveur 2', 'Serveur 3', 'Serveur 4', 'Serveur 5'],
                        datasets: [{
                            label: 'Utilisation Mémoire (%)',
                            data: [65, 72, 58, 81, 45],
                            backgroundColor: 'rgba(141, 198, 63, 0.8)'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } }
                    }
                });
            }
        }

        // ========== CHATBOT ==========

        function initChatbot() {
            var quickActions = document.createElement('div');
            quickActions.className = 'chatbot-quick-actions';
            quickActions.innerHTML = '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'alertes\')">📊 Alertes</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'serveurs\')">🖥️ Serveurs</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'tests\')">🧪 Tests</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'stats\')">📈 Statistiques</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'maj\')">🔄 MAJ</button>' +
                                   '<button class="chatbot-quick-btn" onclick="chatbotQuickAction(\'aide\')">❓ Aide</button>';
            document.getElementById('chatbotMessages').appendChild(quickActions);

            document.getElementById('chatbotInput').addEventListener('keypress', function(event) {
                if (event.key === 'Enter') {
                    sendChatbotMessage();
                }
            });
        }

        function toggleChatbot() {
            var chatbotWindow = document.getElementById('chatbotWindow');
            if (chatbotWindow.style.display === 'flex') {
                chatbotWindow.style.display = 'none';
            } else {
                chatbotWindow.style.display = 'flex';
                document.getElementById('chatbotInput').focus();
            }
        }

        function sendChatbotMessage() {
            var input = document.getElementById('chatbotInput');
            var message = input.value.trim();

            if (!message) return;

            addChatMessage(message, 'user');
            input.value = '';

            setTimeout(function() {
                var response = getChatbotResponse(message);
                addChatMessage(response, 'bot');
            }, 500);
        }

        function addChatMessage(message, sender) {
            var messagesContainer = document.getElementById('chatbotMessages');
            var messageDiv = document.createElement('div');
            messageDiv.className = 'message ' + sender;
            messageDiv.innerHTML = '<div class="message-content">' + message + '</div>';
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        function chatbotQuickAction(action) {
            var messages = {
                'alertes': 'Combien d\'alertes critiques ?',
                'serveurs': 'État des serveurs ?',
                'tests': 'Comment lancer des tests ?',
                'stats': 'Statistiques du système',
                'maj': 'Prochaine mise à jour',
                'aide': 'Que peux-tu faire ?'
            };

            document.getElementById('chatbotInput').value = messages[action];
            sendChatbotMessage();
        }

        function getChatbotResponse(message) {
            var lowerMessage = message.toLowerCase();

            if (lowerMessage.includes('bonjour') || lowerMessage.includes('salut')) {
                return 'Bonjour ! Je suis l\'assistant GEID. Comment puis-je vous aider avec le tableau de bord ?';
            } else if (lowerMessage.includes('alerte') || lowerMessage.includes('critique')) {
                return 'Il y a actuellement <strong>' + dashboardData.stats.alertesCritiques + ' alertes critiques</strong>.';
            } else if (lowerMessage.includes('serveur') || lowerMessage.includes('actif')) {
                return 'Actuellement, <strong>' + dashboardData.stats.serveursActifs + '</strong> serveurs sont actifs.';
            } else if (lowerMessage.includes('disponibilité')) {
                return 'Disponibilité: <strong>' + dashboardData.stats.disponibilite + '</strong>';
            } else if (lowerMessage.includes('test') || lowerMessage.includes('lancer')) {
                return 'Utilisez les boutons "Lancer Tous les Tests" ou "Tests par Catégorie" dans les Actions Rapides.';
            } else if (lowerMessage.includes('mise à jour') || lowerMessage.includes('maj')) {
                var prochaineMAJ = document.getElementById('prochaineMAJ').textContent;
                return 'Prochaine MAJ: <strong>' + prochaineMAJ + '</strong>';
            } else {
                return 'Je peux vous aider avec les alertes, serveurs, tests, statistiques et mises à jour.';
            }
        }

        // ========== UTILITAIRES ==========

        function refreshDashboard() {
            console.log('Rafraîchissement du dashboard');

            startCountdown();
            updateLastUpdate();

            showNotification('Dashboard rafraîchi avec succès', 'success');
        }

        // Rafraîchissement F5
        document.addEventListener('keydown', function(e) {
            if (e.key === 'F5') {
                e.preventDefault();
                refreshDashboard();
            }
        });
    </script>
</body>
</html>