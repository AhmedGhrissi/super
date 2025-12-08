<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🏦 Dashboard - Supervision GEID</title>

    <!-- CSS Commun (header/footer) -->
    <link rel="stylesheet" href="css/common.css">

    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- CSS Spécifique Dashboard -->
    <style>
        /* ========== STYLES SPÉCIFIQUES DASHBOARD ========== */

        /* Container principal dashboard */
        .dashboard-container {
            padding: 1rem;
        }

        /* Header du dashboard */
        .dashboard-header-modern {
            background: linear-gradient(135deg, rgba(0, 103, 71, 0.1), rgba(141, 198, 63, 0.1));
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            border: 2px solid rgba(0, 103, 71, 0.2);
            box-shadow: 0 10px 30px rgba(0, 103, 71, 0.1);
        }

        .dashboard-header-content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .dashboard-title {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 0.5rem;
        }

        .dashboard-title h1 {
            color: #006747;
            font-size: 2.2rem;
            font-weight: 800;
            margin: 0;
        }

        .dashboard-badge {
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
        }

        .dashboard-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }

        .header-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .stat-item {
            background: white;
            padding: 1.2rem;
            border-radius: 16px;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 103, 71, 0.1);
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 103, 71, 0.15);
        }

        .stat-icon {
            font-size: 2rem;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, rgba(0, 103, 71, 0.1), rgba(141, 198, 63, 0.1));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #006747;
            line-height: 1;
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 0.25rem;
        }

        /* État du système */
        .system-status-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .system-status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f8f9fa;
        }

        .system-status-header h3 {
            color: #006747;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 0;
        }

        .system-status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .system-status-item {
            padding: 1rem;
            border-radius: 12px;
            background: #f8f9fa;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .system-status-label {
            color: #6c757d;
            font-weight: 600;
        }

        .system-status-value {
            font-weight: 700;
            padding: 0.4rem 0.8rem;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .system-status-value.success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .system-status-value.error {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .system-status-value.warning {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        /* Alertes */
        .alerts-section-modern {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .alerts-header-modern {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .alerts-title {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.4rem;
            font-weight: 700;
            color: #006747;
        }

        .badge-tests {
            background: linear-gradient(135deg, #d50032, #ff5252);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .alerts-count {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6c757d;
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
            transition: all 0.3s ease;
            font-weight: 700;
        }

        .alerts-refresh-btn:hover {
            background: #005738;
            transform: rotate(180deg);
        }

        /* Cartes de statistiques */
        .stats-section-modern {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card-modern {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            border-top: 4px solid;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
        }

        .stat-card-modern:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 103, 71, 0.15);
        }

        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-card-icon {
            font-size: 2rem;
        }

        .stat-card-trend {
            font-size: 0.8rem;
            font-weight: 700;
            padding: 0.3rem 0.6rem;
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
            font-size: 2.2rem;
            font-weight: 800;
            color: #006747;
            line-height: 1;
            margin: 0.5rem 0;
        }

        .stat-card-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .stat-card-progress {
            height: 8px;
            background: #f8f9fa;
            border-radius: 4px;
            overflow: hidden;
        }

        .stat-card-progress-bar {
            height: 100%;
            border-radius: 4px;
            transition: width 1s ease;
        }

        /* Actions rapides */
        .quick-actions-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .quick-actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .quick-action-card {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 1.5rem;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .quick-action-card:hover {
            border-color: #006747;
            background: white;
            transform: translateY(-5px);
        }

        .quick-action-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .quick-action-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #006747;
            margin-bottom: 0.5rem;
        }

        .quick-action-description {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .btn-quick-action {
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .btn-quick-action:hover {
            background: linear-gradient(135deg, #005738, #7CB839);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 103, 71, 0.3);
            color: white;
            text-decoration: none;
        }

        /* Graphiques */
        .charts-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .chart-card {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 1.5rem;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .chart-card:hover {
            border-color: #006747;
            background: white;
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .chart-header h4 {
            color: #006747;
            font-size: 1.1rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .chart-badge {
            background: #006747;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .chart-container {
            height: 250px;
            position: relative;
        }

        /* Compte à rebours */
        .countdown-timer {
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 0.2rem 0.5rem;
            border-radius: 6px;
            font-weight: 700;
            color: #006747;
        }

        .refresh-dashboard-btn {
            cursor: pointer;
            color: #006747;
            font-weight: 600;
        }

        .refresh-dashboard-btn:hover {
            text-decoration: underline;
        }

        /* Serveurs actifs */
        .servers-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .servers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .server-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .server-card:hover {
            background: white;
            border-color: #006747;
            transform: translateY(-3px);
        }

        .server-status {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }

        .server-status.online {
            background: #28a745;
            box-shadow: 0 0 10px rgba(40, 167, 69, 0.5);
        }

        .server-status.offline {
            background: #dc3545;
            box-shadow: 0 0 10px rgba(220, 53, 69, 0.5);
        }

        .server-status.warning {
            background: #ffc107;
            box-shadow: 0 0 10px rgba(255, 193, 7, 0.5);
        }

        .server-name {
            font-weight: 700;
            color: #006747;
        }

        .server-type {
            font-size: 0.8rem;
            color: #6c757d;
        }

        /* Chatbot */
        .chatbot-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }

        .chatbot-button {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(0, 103, 71, 0.3);
            transition: all 0.3s ease;
        }

        .chatbot-button:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 25px rgba(0, 103, 71, 0.4);
        }

        .chatbot-window {
            position: absolute;
            bottom: 70px;
            right: 0;
            width: 350px;
            height: 500px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            display: none;
            flex-direction: column;
            overflow: hidden;
        }

        .chatbot-header {
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chatbot-messages {
            flex: 1;
            padding: 1rem;
            overflow-y: auto;
            background: #f8f9fa;
        }

        .chatbot-input {
            padding: 1rem;
            background: white;
            border-top: 1px solid #dee2e6;
            display: flex;
            gap: 0.5rem;
        }

        .chatbot-input input {
            flex: 1;
            padding: 0.75rem;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            font-size: 0.9rem;
        }

        .chatbot-input button {
            background: #006747;
            color: white;
            border: none;
            padding: 0.75rem 1rem;
            border-radius: 10px;
            cursor: pointer;
        }

        .message {
            margin-bottom: 1rem;
            max-width: 80%;
        }

        .message.bot {
            align-self: flex-start;
        }

        .message.user {
            align-self: flex-end;
            margin-left: auto;
        }

        .message-content {
            padding: 0.75rem;
            border-radius: 15px;
            font-size: 0.9rem;
            line-height: 1.4;
        }

        .message.bot .message-content {
            background: white;
            border: 1px solid #dee2e6;
        }

        .message.user .message-content {
            background: linear-gradient(135deg, #006747, #8DC63F);
            color: white;
        }

        /* Animation spinner */
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .spinner {
            animation: spin 1s linear infinite;
            display: inline-block;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-stats,
            .system-status-grid,
            .stats-section-modern,
            .quick-actions-grid,
            .charts-grid,
            .servers-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-header-modern {
                padding: 1.5rem;
            }

            .dashboard-title h1 {
                font-size: 1.8rem;
            }

            .system-status-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }

            .chatbot-window {
                width: calc(100vw - 40px);
                height: 400px;
                right: -10px;
            }
        }
    </style>
</head>
<body>
    <!-- Inclure le header -->
    <jsp:include page="includes/header.jsp" />

    <!-- Main Content -->
    <main class="container">
        <div class="dashboard-container">

            <!-- Header principal -->
            <header class="dashboard-header-modern">
                <div class="dashboard-header-content">
                    <div class="dashboard-title">
                        <h1>Tableau de Bord</h1>
                        <span class="dashboard-badge">
                            <c:choose>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'EXCELLENT'}">
                                    🏆 EXCELLENT
                                </c:when>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'BON'}">
                                    👍 BON
                                </c:when>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'STABLE'}">
                                    ✅ STABLE
                                </c:when>
                                <c:otherwise>
                                    ⚠️ DÉGRADÉ
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <p class="dashboard-subtitle">
                        Vue d'ensemble de l'infrastructure et supervision en temps réel
                        <br>
                        <small>Dernière mise à jour:
                            <span id="last-update-display">
                                <c:choose>
                                    <c:when test="${not empty derniereMaj}">
                                        <c:out value="${derniereMaj}" />
                                    </c:when>
                                    <c:otherwise>
                                        <script>
                                            document.write(new Date().toLocaleString('fr-FR'));
                                        </script>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </small>
                    </p>

                    <div class="header-stats">
                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-server"></i></div>
                            <div>
                                <div class="stat-value" data-stat="serveursActifs">
                                    <c:choose>
                                        <c:when test="${not empty serveursActifs and not empty totalServeurs}">
                                            <c:out value="${serveursActifs}" />/<c:out value="${totalServeurs}" />
                                        </c:when>
                                        <c:otherwise>0/0</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Serveurs actifs</div>
                            </div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                            <div>
                                <div class="stat-value" data-stat="disponibilite">
                                    <c:choose>
                                        <c:when test="${not empty tauxDisponibilite}">
                                            <c:out value="${tauxDisponibilite}" />%
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Disponibilité</div>
                            </div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-bell"></i></div>
                            <div>
                                <div class="stat-value">
                                    <c:choose>
                                        <c:when test="${not empty statsAlertes and not empty statsAlertes.critical}">
                                            <c:out value="${statsAlertes.critical}" />
                                        </c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Alertes critiques</div>
                            </div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-icon"><i class="fas fa-sync-alt"></i></div>
                            <div>
                                <div class="stat-value last-update-time">
                                    <c:choose>
                                        <c:when test="${not empty derniereMaj}">
                                            <c:out value="${derniereMaj}" />
                                        </c:when>
                                        <c:otherwise>--:--:--</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="stat-label">Dernière mise à jour</div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- État du système -->
            <section class="system-status-section">
                <div class="system-status-header">
                    <h3><span><i class="fas fa-chart-line"></i></span> État du Système</h3>
                    <div style="display: flex; align-items: center; gap: 1rem;">
                        <div style="font-size: 0.9rem; color: #6c757d;">
                            <span id="current-time">--:--</span>
                        </div>
                        <div style="font-size: 0.9rem; color: #006747; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                            <span><i class="fas fa-sync-alt"></i></span> Rafraîchissement dans
                            <span id="refresh-countdown-header" class="countdown-timer">5:00</span>
                        </div>
                    </div>
                </div>

                <div class="system-status-grid">
                    <div class="system-status-item">
                        <span class="system-status-label">Statut global</span>
                        <span class="system-status-value
                            <c:choose>
                                <c:when test="${not empty performanceIndicators and (performanceIndicators.statutGlobal == 'EXCELLENT' or performanceIndicators.statutGlobal == 'BON')}">success</c:when>
                                <c:when test="${not empty performanceIndicators and performanceIndicators.statutGlobal == 'STABLE'}">success</c:when>
                                <c:otherwise>error</c:otherwise>
                            </c:choose>">
                            <c:choose>
                                <c:when test="${not empty performanceIndicators}">
                                    <c:out value="${performanceIndicators.statutGlobal}" />
                                </c:when>
                                <c:otherwise>CHARGEMENT...</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="system-status-item">
                        <span class="system-status-label">Prochaine MAJ</span>
                        <span class="system-status-value warning">
                            <c:choose>
                                <c:when test="${not empty prochaineMAJDate}">
                                    <c:out value="${prochaineMAJDate}" />
                                </c:when>
                                <c:otherwise>
                                    <script>
                                        const demain = new Date();
                                        demain.setDate(demain.getDate() + 1);
                                        demain.setHours(2, 0, 0, 0);
                                        const options = { day: '2-digit', month: '2-digit', hour: '2-digit', minute: '2-digit' };
                                        document.write(demain.toLocaleDateString('fr-FR', options).replace(',', ''));
                                    </script>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="system-status-item">
                        <span class="system-status-label">Disponibilité</span>
                        <span class="system-status-value">
                            <c:choose>
                                <c:when test="${not empty tauxDisponibilite}">
                                    <c:out value="${tauxDisponibilite}" />%
                                </c:when>
                                <c:otherwise>0%</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="system-status-item">
                        <span class="system-status-label">Alertes critiques</span>
                        <span class="system-status-value error">
                            <c:choose>
                                <c:when test="${not empty statsAlertes and not empty statsAlertes.critical}">
                                    <c:out value="${statsAlertes.critical}" />
                                </c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </section>

            <!-- Section des serveurs actifs -->
            <section class="servers-section">
                <h3 style="margin-bottom: 1.5rem; color: #006747; display: flex; align-items: center; gap: 0.5rem;">
                    <span><i class="fas fa-server"></i></span> Serveurs Actifs
                    <a href="/serveurs" style="margin-left: auto; font-size: 0.9rem; text-decoration: none; color: #006747; font-weight: 600;">
                        Voir tous <i class="fas fa-arrow-right"></i>
                    </a>
                </h3>

                <div class="servers-grid">
                    <c:choose>
                        <c:when test="${not empty serveurs and !serveurs.isEmpty()}">
                            <c:forEach var="serveur" items="${serveurs}" varStatus="status" end="5">
                                <div class="server-card">
                                    <div class="server-status
                                        <c:choose>
                                            <c:when test="${serveur.statut == 'ONLINE'}">online</c:when>
                                            <c:when test="${serveur.statut == 'OFFLINE'}">offline</c:when>
                                            <c:otherwise>warning</c:otherwise>
                                        </c:choose>">
                                    </div>
                                    <div style="flex: 1;">
                                        <div class="server-name"><c:out value="${serveur.nom}" /></div>
                                        <div class="server-type"><c:out value="${serveur.type}" /></div>
                                    </div>
                                    <div style="font-size: 0.8rem; color: #6c757d;">
                                        <c:choose>
                                            <c:when test="${not empty serveur.chargeCPU}">
                                                CPU: <c:out value="${serveur.chargeCPU}" />%
                                            </c:when>
                                            <c:otherwise>CPU: N/A</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 2rem; color: #6c757d;">
                                <i class="fas fa-server" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.3;"></i>
                                <p>Aucun serveur disponible</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${not empty serveurs and serveurs.size() > 6}">
                    <div style="text-align: center; margin-top: 1.5rem;">
                        <a href="/serveurs" class="btn-quick-action" style="text-decoration: none;">
                            <i class="fas fa-list"></i> Voir tous les serveurs (<c:out value="${serveurs.size()}" />)
                        </a>
                    </div>
                </c:if>
            </section>

            <!-- Section des alertes -->
            <section class="alerts-section-modern">
                <div class="alerts-header-modern">
                    <div class="alerts-title">
                        <span><i class="fas fa-bell"></i></span> Alertes Actives
                        <c:if test="${not empty statsAlertes and not empty statsAlertes.critical and statsAlertes.critical > 0}">
                            <span class="badge-tests"><c:out value="${statsAlertes.critical}" /> CRITIQUES</span>
                        </c:if>
                    </div>

                    <div class="alerts-count">
                        <span class="alert-count-critical">
                            <c:choose>
                                <c:when test="${not empty statsAlertes and not empty statsAlertes.critical}">
                                    <c:out value="${statsAlertes.critical}" /> critiques
                                </c:when>
                                <c:otherwise>0 critiques</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="alert-count-warning">
                            /
                            <c:choose>
                                <c:when test="${not empty statsAlertes and not empty statsAlertes.warning}">
                                    <c:out value="${statsAlertes.warning}" /> warnings
                                </c:when>
                                <c:otherwise>0 warnings</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="alerts-refresh-btn" title="Rafraîchir les alertes" onclick="rafraichirAlertes()">
                            <i class="fas fa-sync-alt"></i>
                        </span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty alertesCritiques and !alertesCritiques.isEmpty()}">
                        <!-- Tableau des alertes -->
                        <div style="overflow-x: auto;">
                            <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 12px;">
                                <thead style="background: #f8f9fa;">
                                    <tr>
                                        <th style="padding: 12px; text-align: left;">Type</th>
                                        <th style="padding: 12px; text-align: left;">Description</th>
                                        <th style="padding: 12px; text-align: left;">Serveur</th>
                                        <th style="padding: 12px; text-align: left;">Date</th>
                                        <th style="padding: 12px; text-align: left;">Statut</th>
                                        <th style="padding: 12px; text-align: left;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="alerte" items="${alertesCritiques}" varStatus="status" end="4">
                                        <tr style="border-bottom: 1px solid #f1f3f4;">
                                            <td style="padding: 12px;">
                                                <span style="color:
                                                    <c:choose>
                                                        <c:when test="${alerte.criticite == 'CRITICAL'}">#d50032</c:when>
                                                        <c:when test="${alerte.criticite == 'WARNING'}">#ffc107</c:when>
                                                        <c:otherwise>#2196F3</c:otherwise>
                                                    </c:choose>;">
                                                    <c:choose>
                                                        <c:when test="${alerte.criticite == 'CRITICAL'}"><i class="fas fa-exclamation-circle"></i></c:when>
                                                        <c:when test="${alerte.criticite == 'WARNING'}"><i class="fas fa-exclamation-triangle"></i></c:when>
                                                        <c:otherwise><i class="fas fa-info-circle"></i></c:otherwise>
                                                    </c:choose>
                                                    <strong><c:out value="${alerte.criticite}" /></strong>
                                                </span>
                                            </td>
                                            <td style="padding: 12px;">
                                                <strong><c:out value="${alerte.nom}" /></strong>
                                                <c:if test="${not empty alerte.description}">
                                                    <div style="font-size: 0.9rem; color: #666; margin-top: 4px;">
                                                        <c:out value="${alerte.description}" />
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td style="padding: 12px;">
                                                <c:if test="${not empty alerte.serveurCible}">
                                                    <span style="background: #e9ecef; padding: 4px 8px; border-radius: 4px; font-size: 0.9rem;">
                                                        <c:out value="${alerte.serveurCible}" />
                                                    </span>
                                                </c:if>
                                            </td>
                                            <td style="padding: 12px;">
                                                <c:choose>
                                                    <c:when test="${not empty alerte.timestampDisplay}">
                                                        <c:out value="${alerte.timestampDisplay}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatDate value="${alerte.dateCreation}" pattern="dd/MM/yyyy HH:mm" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="padding: 12px;">
                                                <span style="background:
                                                    <c:choose>
                                                        <c:when test="${alerte.criticite == 'CRITICAL'}">#d50032</c:when>
                                                        <c:when test="${alerte.criticite == 'WARNING'}">#ffc107</c:when>
                                                        <c:otherwise>#2196F3</c:otherwise>
                                                    </c:choose>;
                                                    color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.9rem;">
                                                    <c:choose>
                                                        <c:when test="${not empty alerte.statutCourt}">
                                                            <c:out value="${alerte.statutCourt}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${alerte.criticite == 'CRITICAL'}">Critique</c:when>
                                                                <c:otherwise>Normal</c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td style="padding: 12px;">
                                                <button onclick="voirAlerteDetail('${alerte.id}')" style="background: #006747; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 0.9rem;">
                                                    <i class="fas fa-eye"></i> Voir
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div style="margin-top: 1.5rem; text-align: center; display: flex; gap: 1rem; justify-content: center;">
                            <a href="/alertes" class="btn-quick-action" style="text-decoration: none;">
                                <i class="fas fa-list"></i> Voir toutes les alertes
                            </a>
                            <button onclick="rafraichirAlertes()" class="btn-quick-action" style="background: #6c757d;">
                                <i class="fas fa-sync-alt"></i> Rafraîchir
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 3rem; background: #f8f9fa; border-radius: 12px;">
                            <div style="font-size: 4rem; margin-bottom: 1rem; color: #28a745;">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <h4 style="color: #006747;">Aucune alerte critique</h4>
                            <p style="color: #6c757d;">Tous les systèmes fonctionnent normalement</p>
                            <div style="margin-top: 1.5rem;">
                                <a href="/alertes" class="btn-quick-action" style="text-decoration: none;">
                                    <i class="fas fa-history"></i> Voir l'historique
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Cartes de statistiques -->
            <section class="stats-section-modern">
                <!-- Carte 1 : Disponibilité -->
                <div class="stat-card-modern" style="border-top-color: #006747;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-chart-line"></i></div>
                        <div class="stat-card-trend up">+2.5%</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty tauxDisponibilite}">
                                <c:out value="${tauxDisponibilite}" />%
                            </c:when>
                            <c:otherwise>98.7%</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Taux de disponibilité mensuel</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #006747; width:
                            <c:choose>
                                <c:when test="${not empty tauxDisponibilite}">
                                    <c:out value="${tauxDisponibilite}" />%
                                </c:when>
                                <c:otherwise>98.7%</c:otherwise>
                            </c:choose>;"></div>
                    </div>
                </div>

                <!-- Carte 2 : Tests réussis -->
                <div class="stat-card-modern" style="border-top-color: #28a745;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-check-circle"></i></div>
                        <div class="stat-card-trend up">+8%</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty statsTests and not empty statsTests.reussisPourcentage}">
                                <c:out value="${statsTests.reussisPourcentage}" />%
                            </c:when>
                            <c:otherwise>96.2%</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Tests réussis (24h)</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #28a745; width:
                            <c:choose>
                                <c:when test="${not empty statsTests and not empty statsTests.reussisPourcentage}">
                                    <c:out value="${statsTests.reussisPourcentage}" />%
                                </c:when>
                                <c:otherwise>96.2%</c:otherwise>
                            </c:choose>;"></div>
                    </div>
                </div>

                <!-- Carte 3 : Temps réponse moyen -->
                <div class="stat-card-modern" style="border-top-color: #ffc107;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-bolt"></i></div>
                        <div class="stat-card-trend down">-15ms</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty performanceIndicators and not empty performanceIndicators.tempsReponseMoyen}">
                                <c:out value="${performanceIndicators.tempsReponseMoyen}" />ms
                            </c:when>
                            <c:otherwise>124ms</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Temps de réponse moyen</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #ffc107; width: 85%;"></div>
                    </div>
                </div>

                <!-- Carte 4 : Incidents résolus -->
                <div class="stat-card-modern" style="border-top-color: #17a2b8;">
                    <div class="stat-card-header">
                        <div class="stat-card-icon"><i class="fas fa-wrench"></i></div>
                        <div class="stat-card-trend up">+12</div>
                    </div>
                    <div class="stat-card-value">
                        <c:choose>
                            <c:when test="${not empty incidentsResolus}">
                                <c:out value="${incidentsResolus}" />
                            </c:when>
                            <c:otherwise>142</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-card-label">Incidents résolus (7j)</div>
                    <div class="stat-card-progress">
                        <div class="stat-card-progress-bar" style="background: #17a2b8; width: 92%;"></div>
                    </div>
                </div>
            </section>

            <!-- Actions rapides -->
            <section class="quick-actions-section">
                <h3 style="margin-bottom: 1.5rem; color: #006747; display: flex; align-items: center; gap: 0.5rem;">
                    <span><i class="fas fa-bolt"></i></span> Actions Rapides
                </h3>

                <div class="quick-actions-grid">
                    <!-- Lancer Tous les Tests -->
                    <div class="quick-action-card">
                        <div class="quick-action-icon"><i class="fas fa-play-circle"></i></div>
                        <div class="quick-action-title">Lancer Tous les Tests</div>
                        <div class="quick-action-description">Exécute tous les tests actifs sur l'ensemble des serveurs</div>
                        <button type="button" onclick="lancerTousTests()" class="btn-quick-action btn-test-all">
                            <i class="fas fa-play"></i> Exécuter
                        </button>
                    </div>

                    <!-- Tests par Catégorie -->
                    <div class="quick-action-card">
                        <div class="quick-action-icon"><i class="fas fa-filter"></i></div>
                        <div class="quick-action-title">Tests par Catégorie</div>
                        <div class="quick-action-description">Exécute des tests ciblés par catégorie</div>
                        <div style="margin-bottom: 1rem;">
                            <select id="categorieSelectDashboard" style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 8px; background: white; font-size: 0.9rem;">
                                <option value="">Choisir une catégorie</option>
                                <option value="conformite">Conformité</option>
                                <option value="processus_metier">Processus Métier</option>
                                <option value="surveillance">Surveillance</option>
                                <option value="ged">GED</option>
                                <option value="integration">Intégration</option>
                                <option value="web">Applications Web</option>
                            </select>
                        </div>
                        <button type="button" onclick="dashboardLancerTestsCategorie()" class="btn-quick-action btn-test-category">
                            <i class="fas fa-play"></i> Lancer
                        </button>
                    </div>

                    <!-- Planifier MAJ -->
                    <div class="quick-action-card">
                        <div class="quick-action-icon"><i class="fas fa-calendar-plus"></i></div>
                        <div class="quick-action-title">Planifier une MAJ</div>
                        <div class="quick-action-description">Programmer une mise à jour de l'infrastructure</div>
                        <a href="/mises-a-jour/create" class="btn-quick-action btn-schedule-maj">
                            <i class="fas fa-plus"></i> Nouvelle MAJ
                        </a>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <!-- Chatbot -->
    <div class="chatbot-container">
        <div class="chatbot-window" id="chatbotWindow">
            <div class="chatbot-header">
                <div>
                    <strong><i class="fas fa-robot"></i> Assistant GEID</strong>
                    <div style="font-size: 0.8rem; opacity: 0.8;">Vous aide avec le dashboard</div>
                </div>
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
                <input type="text" id="chatbotInput" placeholder="Posez votre question..." onkeypress="handleChatbotKeypress(event)">
                <button onclick="sendChatbotMessage()">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>
        <button class="chatbot-button" onclick="toggleChatbot()">
            <i class="fas fa-robot"></i>
        </button>
    </div>

    <!-- Inclure le footer -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Chart.js pour les graphiques -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- JavaScript du dashboard -->
    <script>
        // Variables globales
        let countdownInterval;
        let timeLeft = 5 * 60; // 5 minutes en secondes
        let cpuChart = null;
        let memoryChart = null;

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            console.log('📊 Dashboard initialisé');

            // Démarrer le compte à rebours
            startCountdown();

            // Mettre à jour l'horloge
            updateClock();
            setInterval(updateClock, 60000);

            // Bouton de rafraîchissement manuel
            setupRefreshButtons();

            // Initialiser les graphiques
            initCharts();

            // Animation des cartes de statistiques
            animateStats();

            // Initialiser le chatbot
            initChatbot();
        });

        // ========== COMPTE À REBOURS ==========
        function startCountdown() {
            clearInterval(countdownInterval);
            timeLeft = 5 * 60;

            function updateCountdownDisplay() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;

                // Mettre à jour TOUTES les occurrences du compte à rebours
                const countdownElements = document.querySelectorAll('.countdown-timer, #refresh-countdown, #refresh-countdown-header');
                countdownElements.forEach(element => {
                    if (element) {
                        element.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;
                    }
                });

                if (timeLeft <= 0) {
                    timeLeft = 5 * 60; // Reset
                    console.log('🔄 Compte à rebours terminé, rafraîchissement automatique');
                    refreshDashboard(); // Rafraîchir automatiquement
                } else {
                    timeLeft--;
                }
            }

            // Mettre à jour immédiatement
            updateCountdownDisplay();

            // Puis toutes les secondes
            countdownInterval = setInterval(updateCountdownDisplay, 1000);
        }

        function refreshDashboard() {
            console.log('🔄 Rafraîchissement du dashboard');

            // Animation du bouton
            const refreshBtn = document.querySelector('.alerts-refresh-btn');
            if (refreshBtn) {
                refreshBtn.style.animation = 'spin 1s ease-in-out';
                setTimeout(() => {
                    refreshBtn.style.animation = '';
                }, 1000);
            }

            // Redémarrer le compte à rebours
            startCountdown();

            // Mettre à jour l'affichage de la dernière MAJ
            const lastUpdateElement = document.getElementById('last-update-display');
            if (lastUpdateElement) {
                const now = new Date();
                lastUpdateElement.textContent = now.toLocaleString('fr-FR');
            }

            // Rafraîchir la page
            location.reload();
        }

        function setupRefreshButtons() {
            const refreshBtns = document.querySelectorAll('.refresh-dashboard-btn');
            refreshBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('🔄 Rafraîchissement manuel');
                    refreshDashboard();
                });
            });
        }

        function updateClock() {
            const now = new Date();
            const timeStr = now.toLocaleTimeString('fr-FR', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            const dateStr = now.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            const clockElement = document.getElementById('current-time');
            if (clockElement) {
                clockElement.innerHTML = `<strong>${timeStr}</strong> - ${dateStr}`;
            }
        }

        // ========== ALERTES ==========
        function rafraichirAlertes() {
            console.log('🔄 Rafraîchissement des alertes');

            const btn = document.querySelector('.btn-quick-action[onclick="rafraichirAlertes()"]');
            if (btn) {
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Rafraîchissement...';
                btn.disabled = true;

                setTimeout(() => {
                    location.reload();
                }, 1500);
            }
        }

        function voirAlerteDetail(alerteId) {
            console.log(`👁️ Affichage du détail de l'alerte ${alerteId}`);
            window.location.href = `/alertes/detail?id=${alerteId}`;
        }

        // ========== FONCTIONS POUR LES TESTS ==========
        async function lancerTousTests() {
            console.log('🚀 Lancement de tous les tests');

            const confirmed = confirm('Voulez-vous lancer tous les tests ?');
            if (!confirmed) return;

            const btn = document.querySelector('.btn-test-all');
            if (btn) {
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Lancement...';
                btn.disabled = true;

                try {
                    const response = await fetch('/tests/execute/all', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        }
                    });

                    const data = await response.json();

                    if (response.ok && data.success) {
                        alert('✅ ' + (data.message || 'Tests lancés avec succès !'));
                        setTimeout(() => {
                            location.reload();
                        }, 2000);
                    } else {
                        alert('❌ Erreur: ' + (data.message || 'Échec du lancement des tests'));
                        btn.innerHTML = originalText;
                        btn.disabled = false;
                    }
                } catch (error) {
                    console.error('Erreur:', error);
                    alert('❌ Erreur réseau: ' + error.message);
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            }
        }

        async function dashboardLancerTestsCategorie() {
            const categorieSelect = document.getElementById('categorieSelectDashboard');
            const categorie = categorieSelect.value;

            if (!categorie) {
                alert('⚠️ Veuillez sélectionner une catégorie');
                return;
            }

            console.log(`📁 Lancement des tests pour la catégorie: ${categorie}`);

            const confirmed = confirm(`Voulez-vous lancer les tests de la catégorie "${categorie}" ?`);
            if (!confirmed) return;

            const btn = document.querySelector('.btn-test-category');
            if (btn) {
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Lancement...';
                btn.disabled = true;

                try {
                    const response = await fetch('/tests/execute/category', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json'
                        },
                        body: JSON.stringify({ categorie: categorie })
                    });

                    const data = await response.json();

                    if (response.ok && data.success) {
                        alert('✅ ' + (data.message || `Tests de la catégorie ${categorie} lancés avec succès !`));
                        setTimeout(() => {
                            location.reload();
                        }, 2000);
                    } else {
                        alert('❌ Erreur: ' + (data.message || 'Échec du lancement des tests'));
                        btn.innerHTML = originalText;
                        btn.disabled = false;
                    }
                } catch (error) {
                    console.error('Erreur:', error);
                    alert('❌ Erreur réseau: ' + error.message);
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            }
        }

        // ========== GRAPHIQUES ==========
        function initCharts() {
            // Données pour le graphique CPU
            const cpuCtx = document.getElementById('cpuChart');
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
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 100,
                                ticks: {
                                    callback: function(value) {
                                        return value + '%';
                                    }
                                }
                            }
                        }
                    }
                });
            }

            // Données pour le graphique Mémoire
            const memoryCtx = document.getElementById('memoryChart');
            if (memoryCtx) {
                memoryChart = new Chart(memoryCtx.getContext('2d'), {
                    type: 'bar',
                    data: {
                        labels: ['Serveur 1', 'Serveur 2', 'Serveur 3', 'Serveur 4', 'Serveur 5'],
                        datasets: [{
                            label: 'Utilisation Mémoire (%)',
                            data: [65, 72, 58, 81, 45],
                            backgroundColor: 'rgba(141, 198, 63, 0.8)',
                            borderColor: 'rgba(141, 198, 63, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 100,
                                ticks: {
                                    callback: function(value) {
                                        return value + '%';
                                    }
                                }
                            }
                        }
                    }
                });
            }
        }

        // ========== ANIMATIONS ==========
        function animateStats() {
            // Animation des barres de progression
            const progressBars = document.querySelectorAll('.stat-card-progress-bar');
            progressBars.forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';

                setTimeout(() => {
                    bar.style.width = width;
                }, 300);
            });

            // Animation des cartes de statistiques
            const statCards = document.querySelectorAll('.stat-card-modern');
            statCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';

                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100 * index);
            });
        }

        // Mettre à jour les graphiques périodiquement
        function updateCharts() {
            if (cpuChart) {
                // Simuler une mise à jour des données CPU
                const newData = cpuChart.data.datasets[0].data;
                newData.shift();
                newData.push(Math.floor(Math.random() * 60) + 20); // 20-80%
                cpuChart.update('none');
            }

            if (memoryChart) {
                // Simuler une mise à jour des données mémoire
                const newMemoryData = memoryChart.data.datasets[0].data;
                newMemoryData.forEach((_, i) => {
                    newMemoryData[i] = Math.min(100, Math.max(0, newMemoryData[i] + (Math.random() * 10 - 5)));
                });
                memoryChart.update('none');
            }
        }

        // Mettre à jour les graphiques toutes les 10 secondes
        setInterval(updateCharts, 10000);

        // ========== CHATBOT ==========
        function initChatbot() {
            console.log('🤖 Chatbot initialisé');
        }

        function toggleChatbot() {
            const chatbotWindow = document.getElementById('chatbotWindow');
            if (chatbotWindow.style.display === 'flex') {
                chatbotWindow.style.display = 'none';
            } else {
                chatbotWindow.style.display = 'flex';
            }
        }

        function handleChatbotKeypress(event) {
            if (event.key === 'Enter') {
                sendChatbotMessage();
            }
        }

        function sendChatbotMessage() {
            const input = document.getElementById('chatbotInput');
            const message = input.value.trim();

            if (!message) return;

            // Ajouter le message de l'utilisateur
            addChatMessage(message, 'user');
            input.value = '';

            // Réponse du chatbot
            setTimeout(() => {
                const response = getChatbotResponse(message);
                addChatMessage(response, 'bot');
            }, 500);
        }

        function addChatMessage(message, sender) {
            const messagesContainer = document.getElementById('chatbotMessages');
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${sender}`;
            messageDiv.innerHTML = `<div class="message-content">${message}</div>`;
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        function getChatbotResponse(message) {
            const lowerMessage = message.toLowerCase();

            if (lowerMessage.includes('bonjour') || lowerMessage.includes('salut') || lowerMessage.includes('hello')) {
                return 'Bonjour ! Comment puis-je vous aider avec le tableau de bord ?';
            } else if (lowerMessage.includes('alerte') || lowerMessage.includes('critique')) {
                const criticalCount = document.querySelector('.alert-count-critical') ?
                    document.querySelector('.alert-count-critical').textContent : '0';
                return `Il y a actuellement ${criticalCount} alertes critiques. Vous pouvez cliquer sur "Voir toutes les alertes" pour plus de détails.`;
            } else if (lowerMessage.includes('serveur') || lowerMessage.includes('actif')) {
                const serversActive = document.querySelector('[data-stat="serveursActifs"]') ?
                    document.querySelector('[data-stat="serveursActifs"]').textContent : '0/0';
                return `Actuellement, ${serversActive} serveurs sont actifs.`;
            } else if (lowerMessage.includes('disponibilité') || lowerMessage.includes('dispo')) {
                const disponibility = document.querySelector('[data-stat="disponibilite"]') ?
                    document.querySelector('[data-stat="disponibilite"]').textContent : '0%';
                return `Le taux de disponibilité actuel est de ${disponibility}.`;
            } else if (lowerMessage.includes('test') || lowerMessage.includes('lancer')) {
                return 'Vous pouvez lancer des tests via les boutons "Exécuter" dans la section "Actions Rapides".';
            } else if (lowerMessage.includes('mise à jour') || lowerMessage.includes('maj')) {
                const prochaineMAJElement = document.querySelector('.system-status-value.warning');
                const prochaineMAJ = prochaineMAJElement ? prochaineMAJElement.textContent : 'Non définie';
                return `La prochaine mise à jour est prévue pour ${prochaineMAJ}.`;
            } else if (lowerMessage.includes('aide') || lowerMessage.includes('help')) {
                return 'Je peux vous aider avec :<br>• Les alertes et incidents<br>• L\'état des serveurs<br>• Les tests et vérifications<br>• Les mises à jour<br>• Les statistiques générales';
            } else {
                return 'Je suis votre assistant pour le tableau de bord. Vous pouvez me demander des informations sur les alertes, serveurs, tests ou mises à jour.';
            }
        }

        // ========== UTILITAIRES ==========
        // Rafraîchissement manuel avec F5
        document.addEventListener('keydown', function(e) {
            if (e.key === 'F5' || (e.ctrlKey && e.key === 'r')) {
                e.preventDefault();
                refreshDashboard();
            }
        });

        // Mettre à jour l'heure toutes les secondes
        setInterval(updateClock, 1000);
    </script>
</body>
</html>