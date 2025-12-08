<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles pour les statistiques serveurs */
.rapports-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.rapports-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.rapports-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.rapports-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.rapports-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.rapports-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

.period-badge {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    padding: 0.5rem 1.5rem;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 600;
}

/* Cartes de statistiques */
.stats-grid-rapports {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card-rapports {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    text-align: center;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    transition: transform 0.3s ease;
}

.stat-card-rapports:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}

.stat-icon-rapports {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.stat-value-rapports {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.stat-label-rapports {
    font-size: 1.1rem;
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
}

.stat-period-rapports {
    font-size: 0.9rem;
    color: #6c757d;
}

/* Section filtres */
.filters-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.filters-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.filters-header-rapports h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.filters-grid-rapports {
    padding: 1.5rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
}

.filter-group-rapports {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.filter-label-rapports {
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
}

.filter-select-rapports {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 0.9rem;
    background: white;
    cursor: pointer;
    transition: all 0.3s ease;
}

.filter-select-rapports:focus {
    outline: none;
    border-color: #006747;
    box-shadow: 0 0 0 3px rgba(0, 103, 71, 0.1);
}

/* Tableau moderne */
.table-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.table-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.table-header-rapports h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.table-container-rapports {
    overflow-x: auto;
    padding: 1.5rem;
}

.data-table-rapports {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.9rem;
}

.data-table-rapports thead {
    background: #006747;
    color: white;
}

.data-table-rapports th {
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    white-space: nowrap;
}

.data-table-rapports th:first-child {
    border-radius: 8px 0 0 0;
}

.data-table-rapports th:last-child {
    border-radius: 0 8px 0 0;
}

.data-table-rapports td {
    padding: 1rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.data-table-rapports tbody tr {
    transition: all 0.2s ease;
}

.data-table-rapports tbody tr:hover {
    background: #f8f9fa;
}

/* Badges */
.badge-success {
    background: rgba(40, 167, 69, 0.1);
    color: #28a745;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-warning {
    background: rgba(255, 193, 7, 0.1);
    color: #ffc107;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-danger {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-info {
    background: rgba(23, 162, 184, 0.1);
    color: #17a2b8;
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 500;
}

/* Barre de progression */
.progress-bar-container {
    width: 100px;
    height: 20px;
    background: #e9ecef;
    border-radius: 10px;
    overflow: hidden;
    position: relative;
}

.progress-bar-fill {
    height: 100%;
    border-radius: 10px;
    transition: width 0.5s ease;
}

.progress-bar-text {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.7rem;
    font-weight: 600;
    color: white;
    text-shadow: 0 1px 1px rgba(0,0,0,0.2);
}

/* Boutons d'action dans le tableau */
.btn-table-action {
    padding: 0.4rem 0.8rem;
    border: none;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    font-size: 0.75rem;
    transition: all 0.3s ease;
}

.btn-view {
    background: rgba(0, 103, 71, 0.1);
    color: #006747;
}

.btn-view:hover {
    background: #006747;
    color: white;
    transform: translateY(-1px);
}

.btn-test {
    background: rgba(6, 214, 160, 0.1);
    color: #06d6a0;
}

.btn-test:hover {
    background: #06d6a0;
    color: white;
    transform: translateY(-1px);
}

/* Actions */
.actions-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
}

.actions-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.actions-header-rapports h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.actions-grid-rapports {
    padding: 1.5rem;
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
}

.action-button-rapports {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    border-radius: 12px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
}

.action-button-rapports.primary {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
}

.action-button-rapports.secondary {
    background: linear-gradient(135deg, #4361ee, #3a0ca3);
    color: white;
}

.action-button-rapports.warning {
    background: linear-gradient(135deg, #ff9e00, #ff6b6b);
    color: white;
}

.action-button-rapports:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.2);
    text-decoration: none;
}

/* Back button */
.back-button-rapports {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    background: #6c757d;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    margin-top: 2rem;
}

.back-button-rapports:hover {
    background: #5a6268;
    transform: translateY(-2px);
    text-decoration: none;
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .rapports-container {
        padding: 1rem;
    }

    .rapports-title-section {
        flex-direction: column;
    }

    .stats-grid-rapports {
        grid-template-columns: 1fr;
    }

    .filters-grid-rapports {
        grid-template-columns: 1fr;
    }

    .actions-grid-rapports {
        flex-direction: column;
    }

    .action-button-rapports {
        width: 100%;
        justify-content: center;
    }

    .table-container-rapports {
        overflow-x: auto;
    }

    .data-table-rapports {
        min-width: 800px;
    }
}

@media print {
    .action-button-rapports,
    .back-button-rapports {
        display: none;
    }
}
</style>

<div class="rapports-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="rapports-header-modern">
        <div class="rapports-title-section">
            <div>
                <div class="rapports-title">
                    <h1>📊 Statistiques des Serveurs</h1>
                </div>
                <p class="rapports-subtitle">Analyse détaillée des performances et de la disponibilité</p>
            </div>
            <div class="period-badge">
                <c:choose>
                    <c:when test="${not empty serveursStats and serveursStats.size() > 0}">
                        📊 ${serveursStats.size()} serveurs
                    </c:when>
                    <c:otherwise>
                        📊 Aucun serveur
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- ========== CARTES DE STATISTIQUES ========== -->
    <div class="stats-grid-rapports">
        <!-- Serveurs totaux -->
        <div class="stat-card-rapports animate-fade-in-up">
            <div class="stat-icon-rapports">🖥️</div>
            <div class="stat-value-rapports" style="color: #006747;">${statsGlobales.totalServeurs}</div>
            <div class="stat-label-rapports">Serveurs Totaux</div>
            <div class="stat-period-rapports">Système</div>
        </div>

        <!-- Disponibilité -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.1s;">
            <div class="stat-icon-rapports">📈</div>
            <div class="stat-value-rapports" style="color: #28a745;">
                <fmt:formatNumber value="${statsGlobales.disponibiliteMoyenne}" pattern="0.0"/>%
            </div>
            <div class="stat-label-rapports">Disponibilité</div>
            <div class="stat-period-rapports">Moyenne</div>
        </div>

        <!-- Tests exécutés -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.2s;">
            <div class="stat-icon-rapports">🧪</div>
            <div class="stat-value-rapports" style="color: #ffc107;">${statsGlobales.totalTests}</div>
            <div class="stat-label-rapports">Tests Exécutés</div>
            <div class="stat-period-rapports">Total</div>
        </div>

        <!-- Taux de réussite -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.3s; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white;">
            <div class="stat-icon-rapports">✅</div>
            <div class="stat-value-rapports">
                <fmt:formatNumber value="${statsGlobales.tauxReussiteGlobal}" pattern="0.0"/>%
            </div>
            <div class="stat-label-rapports">Taux Réussite</div>
            <div class="stat-period-rapports" style="color: rgba(255,255,255,0.9);">Global</div>
        </div>
    </div>

    <!-- ========== FILTRES ========== -->
    <div class="filters-section-rapports">
        <div class="filters-header-rapports">
            <h2>🔍 Filtres</h2>
        </div>
        <form method="get" action="/serveurs-stats">
            <div class="filters-grid-rapports">
                <div class="filter-group-rapports">
                    <label class="filter-label-rapports">🏦 Code Caisse</label>
                    <select class="filter-select-rapports" name="codeCaisse">
                        <option value="">Toutes les caisses</option>
                        <option value="IF">IF - Paris-Ile-de-France</option>
                        <option value="AQ">AQ - Aquitaine</option>
                        <option value="RP">RP - Sud Rhône-Alpes</option>
                        <option value="BI">BI - Brie-Picardie</option>
                    </select>
                </div>

                <div class="filter-group-rapports">
                    <label class="filter-label-rapports">🖥️ Type de Serveur</label>
                    <select class="filter-select-rapports" name="typeServeur">
                        <option value="">Tous les types</option>
                        <option value="frontal">Frontal</option>
                        <option value="backoffice">BackOffice</option>
                        <option value="betaweb">BetaWeb</option>
                    </select>
                </div>

                <div class="filter-group-rapports">
                    <label class="filter-label-rapports">📊 Statut</label>
                    <select class="filter-select-rapports" name="status">
                        <option value="">Tous les statuts</option>
                        <option value="excellent">Excellent (≥95%)</option>
                        <option value="bon">Bon (80-94%)</option>
                        <option value="critique">Critique (<80%)</option>
                    </select>
                </div>
            </div>

            <div style="padding: 0 1.5rem 1.5rem 1.5rem; display: flex; justify-content: space-between; align-items: center;">
                <div style="color: #6c757d; font-weight: 600;">
                    📊 ${serveursStats.size()} serveurs trouvés
                </div>
                <div style="display: flex; gap: 0.75rem;">
                    <button type="submit" class="action-button-rapports primary">
                        <span>🔍</span>
                        <span>Appliquer</span>
                    </button>
                    <a href="/serveurs-stats" class="action-button-rapports warning">
                        <span>🔄</span>
                        <span>Réinitialiser</span>
                    </a>
                </div>
            </div>
        </form>
    </div>

    <!-- ========== TABLEAU ========== -->
    <div class="table-section-rapports">
        <div class="table-header-rapports">
            <h2>📋 Détail des Serveurs</h2>
        </div>
        <div class="table-container-rapports">
            <table class="data-table-rapports">
                <thead>
                    <tr>
                        <th>Serveur</th>
                        <th>Type</th>
                        <th>Caisse</th>
                        <th>Tests</th>
                        <th>Taux Réussite</th>
                        <th>Temps Réponse</th>
                        <th>Disponibilité</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty serveursStats and serveursStats.size() > 0}">
                            <c:forEach var="stats" items="${serveursStats}">
                                <tr>
                                    <td>
                                        <div style="font-weight: 600; color: #343a40;">${stats.serveurNom}</div>
                                        <c:if test="${stats.testsTotal > 0}">
                                            <c:choose>
                                                <c:when test="${stats.disponibilitePercent >= 95}">
                                                    <span class="badge-success">Excellent</span>
                                                </c:when>
                                                <c:when test="${stats.disponibilitePercent >= 80}">
                                                    <span class="badge-warning">Bon</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-danger">Critique</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </td>

                                    <td>
                                        <span class="badge-info">${stats.typeServeur}</span>
                                    </td>

                                    <td>${stats.caisseCode}</td>

                                    <td>
                                        <div style="display: flex; flex-direction: column; gap: 0.25rem;">
                                            <div style="display: flex; align-items: center; gap: 0.5rem;">
                                                <span style="color: #28a745;">✅ ${stats.testsSucces}</span>
                                                <span style="color: #dc3545;">❌ ${stats.testsEchec}</span>
                                            </div>
                                            <div style="font-size: 0.8rem; color: #6c757d;">
                                                Total: ${stats.testsTotal}
                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <c:if test="${stats.testsTotal > 0}">
                                            <div class="progress-bar-container">
                                                <div class="progress-bar-fill"
                                                     style="width: ${(stats.testsSucces * 100.0 / stats.testsTotal)}%;
                                                            background:
                                                            <c:choose>
                                                                <c:when test="${(stats.testsSucces * 100.0 / stats.testsTotal) >= 90}">#28a745</c:when>
                                                                <c:when test="${(stats.testsSucces * 100.0 / stats.testsTotal) >= 70}">#ffc107</c:when>
                                                                <c:otherwise>#dc3545</c:otherwise>
                                                            </c:choose>;">
                                                    <div class="progress-bar-text">
                                                        <fmt:formatNumber value="${(stats.testsSucces * 100.0 / stats.testsTotal)}" pattern="0"/>%
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${stats.testsTotal == 0}">
                                            <span style="color: #6c757d;">N/A</span>
                                        </c:if>
                                    </td>

                                    <td>
                                        <c:if test="${stats.tempsReponseMoyen > 0}">
                                            <div style="font-weight: 600; color: #343a40;">
                                                ${stats.tempsReponseMoyen}ms
                                            </div>
                                        </c:if>
                                        <c:if test="${stats.tempsReponseMoyen == 0}">
                                            <span style="color: #6c757d;">-</span>
                                        </c:if>
                                    </td>

                                    <td>
                                        <div class="progress-bar-container">
                                            <div class="progress-bar-fill"
                                                 style="width: ${stats.disponibilitePercent}%;
                                                        background:
                                                        <c:choose>
                                                            <c:when test="${stats.disponibilitePercent >= 95}">#28a745</c:when>
                                                            <c:when test="${stats.disponibilitePercent >= 80}">#ffc107</c:when>
                                                            <c:otherwise>#dc3545</c:otherwise>
                                                        </c:choose>;">
                                                <div class="progress-bar-text">
                                                    <fmt:formatNumber value="${stats.disponibilitePercent}" pattern="0"/>%
                                                </div>
                                            </div>
                                        </div>
                                    </td>

                                    <td style="text-align: center;">
                                        <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                            <a href="/serveurs-stats/${stats.serveurNom}"
                                               class="btn-table-action btn-view">
                                                📈 Détails
                                            </a>
                                            <button onclick="testerServeur('${stats.serveurNom}')"
                                                    class="btn-table-action btn-test">
                                                🚀 Tester
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 3rem;">
                                    <div style="font-size: 4rem; margin-bottom: 1rem; opacity: 0.3;">📊</div>
                                    <h4 style="color: #6c757d; margin-bottom: 1rem;">Aucune statistique disponible</h4>
                                    <p style="color: #8d99ae; margin-bottom: 2rem;">
                                        Les statistiques des serveurs apparaîtront après l'exécution des tests.
                                    </p>
                                    <a href="/tests/execute" class="action-button-rapports primary">
                                        <span>🧪</span>
                                        <span>Exécuter des tests</span>
                                    </a>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ========== ACTIONS ========== -->
    <div class="actions-section-rapports">
        <div class="actions-header-rapports">
            <h2>🚀 Actions</h2>
        </div>
        <div class="actions-grid-rapports">
            <a href="/serveurs-stats/problemes" class="action-button-rapports warning">
                <span>⚠️</span>
                <span>Serveurs en difficulté</span>
            </a>

            <a href="/serveurs-stats/top" class="action-button-rapports primary">
                <span>🏆</span>
                <span>Top Serveurs</span>
            </a>

            <a href="/dashboard" class="action-button-rapports secondary">
                <span>🏠</span>
                <span>Retour au Dashboard</span>
            </a>
        </div>
    </div>

    <!-- ========== BOUTON RETOUR ========== -->
    <a href="/dashboard" class="back-button-rapports">
        ← Retour au Dashboard
    </a>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('Statistiques serveurs page initialisée');

    // Animation des cartes
    const cards = document.querySelectorAll('.stat-card-rapports');
    cards.forEach((card, index) => {
        card.style.animationDelay = (index * 0.1) + 's';
    });
});

// Fonction pour tester un serveur
function testerServeur(serveurNom) {
    console.log('Test du serveur:', serveurNom);

    // Afficher une notification
    showNotification('Test du serveur', 'Lancement du test pour ' + serveurNom + '...', 'info');

    // Simulation d'un test
    setTimeout(function() {
        showNotification('Test terminé', 'Résultats pour ' + serveurNom + ' disponibles', 'success');
    }, 2000);
}

// Fonction de notification simple
function showNotification(message, type) {
    // Pas de conditions complexes avec ===
    var icon = 'ℹ️';
    if (type == 'success') icon = '✅';
    if (type == 'error') icon = '❌';
    if (type == 'warning') icon = '⚠️';

    alert(icon + ' ' + message);
}
</script>

<jsp:include page="../includes/footer.jsp" />