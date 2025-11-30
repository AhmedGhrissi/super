<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <!-- En-tête de page -->
    <div class="page-header">
        <h2>📊 Statistiques des Serveurs</h2>
        <div class="action-buttons">
            <a href="/serveurs-stats/problemes" class="btn btn-warning">
                <span>⚠️</span> Serveurs en difficulté
            </a>
            <a href="/serveurs-stats/top" class="btn btn-success">
                <span>🏆</span> Top Serveurs
            </a>
        </div>
    </div>

    <!-- Messages flash -->
    <c:if test="${not empty success}">
        <div class="alert alert-success" style="background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 2rem;">
            ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error" style="background: linear-gradient(135deg, #ef476f, #ff6b6b); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 2rem;">
            ${error}
        </div>
    </c:if>

    <!-- Statistiques globales -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value">${statsGlobales.totalServeurs}</div>
            <div class="stat-label">Total Serveurs</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">
                <fmt:formatNumber value="${statsGlobales.disponibiliteMoyenne}" pattern="0.0"/>%
            </div>
            <div class="stat-label">Disponibilité Moyenne</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${statsGlobales.totalTests}</div>
            <div class="stat-label">Total Tests</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">
                <fmt:formatNumber value="${statsGlobales.tauxReussiteGlobal}" pattern="0.0"/>%
            </div>
            <div class="stat-label">Taux Réussite</div>
        </div>
    </div>

    <!-- Filtres -->
    <form method="get" action="/serveurs-stats">
        <div class="filters" style="margin-bottom: 2rem; display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
            <!-- Code Caisse -->
            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                <label style="font-weight: 600; color: #495057; font-size: 0.9rem;">Code Caisse</label>
                <select id="codeCaisse" name="codeCaisse"
                        style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer; min-width: 180px;">
                    <option value="">Toutes les caisses</option>
                    <option value="IF">IF - Paris-Ile-de-France</option>
                    <option value="AQ">AQ - Aquitaine</option>
                    <option value="RP">RP - Sud Rhône-Alpes</option>
                    <option value="BI">BI - Brie-Picardie</option>
                </select>
            </div>

            <!-- Type de Serveur -->
            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                <label style="font-weight: 600; color: #495057; font-size: 0.9rem;">Type de Serveur</label>
                <select id="typeServeur" name="typeServeur"
                        style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer; min-width: 180px;">
                    <option value="">Tous les types</option>
                    <option value="frontal">Frontal</option>
                    <option value="backoffice">BackOffice</option>
                    <option value="betaweb">BetaWeb</option>
                </select>
            </div>

            <!-- Boutons -->
            <div style="display: flex; flex-direction: column; gap: 0.5rem; margin-left: auto;">
                <label style="font-weight: 600; color: #495057; font-size: 0.9rem; opacity: 0;">Actions</label>
                <div style="display: flex; gap: 0.5rem;">
                    <button type="submit"
                            style="padding: 0.75rem 1.5rem; border: none; border-radius: 25px; background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                        🔍 Filtrer
                    </button>
                    <a href="/serveurs-stats"
                       style="padding: 0.75rem 1.5rem; border: 2px solid #6c757d; border-radius: 25px; background: white; color: #6c757d; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 0.5rem; text-decoration: none;">
                        🔄 Reset
                    </a>
                </div>
            </div>

            <!-- Compteur -->
            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                <label style="font-weight: 600; color: #495057; font-size: 0.9rem; opacity: 0;">Résultats</label>
                <div style="color: #6c757d; font-weight: 600; padding: 0.75rem 0;">
                    📊 ${serveursStats.size()} serveurs trouvés
                </div>
            </div>
        </div>
    </form>

    <!-- Tableau des statistiques serveurs -->
    <div class="card">
        <h3 style="color: #4361ee; margin-bottom: 1.5rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
            Détail des Serveurs
        </h3>

        <div class="data-table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Serveur</th>
                        <th>Type</th>
                        <th>Caisse</th>
                        <th>Tests Total</th>
                        <th>Tests Réussis</th>
                        <th>Taux Réussite</th>
                        <th>Temps Réponse</th>
                        <th>Disponibilité</th>
                        <th>Actions</th>
                        <th>Test Rapide</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="stats" items="${serveursStats}">
                        <tr>
                            <td>
                                <strong>${stats.serveurNom}</strong>
                                <c:if test="${stats.testsTotal > 0}">
                                    <c:choose>
                                        <c:when test="${stats.disponibilitePercent >= 95}">
                                            <span class="status-badge active">Excellent</span>
                                        </c:when>
                                        <c:when test="${stats.disponibilitePercent >= 80}">
                                            <span class="status-badge" style="background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-weight: 600;">Bon</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge inactive">Critique</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </td>
                            <td>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${stats.typeServeur == 'frontal'}">badge-category-integration</c:when>
                                        <c:when test="${stats.typeServeur == 'backoffice'}">badge-category-processus_metier</c:when>
                                        <c:otherwise>badge-category-web</c:otherwise>
                                    </c:choose>">
                                    ${stats.typeServeur}
                                </span>
                            </td>
                            <td>${stats.caisseCode}</td>
                            <td>${stats.testsTotal}</td>
                            <td>
                                <span class="text-success">${stats.testsSucces}</span> /
                                <span class="text-danger">${stats.testsEchec}</span>
                            </td>
                            <td>
                                <c:if test="${stats.testsTotal > 0}">
                                    <fmt:formatNumber value="${stats.testsSucces * 100.0 / stats.testsTotal}" pattern="0.0"/>%
                                </c:if>
                                <c:if test="${stats.testsTotal == 0}">
                                    <span class="text-muted">N/A</span>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${stats.tempsReponseMoyen > 0}">
                                    ${stats.tempsReponseMoyen}ms
                                </c:if>
                                <c:if test="${stats.tempsReponseMoyen == 0}">
                                    <span class="text-muted">-</span>
                                </c:if>
                            </td>
                            <td>
                                <div class="progress" style="height: 20px; width: 100px;">
                                    <div class="progress-bar
                                        <c:choose>
                                            <c:when test="${stats.disponibilitePercent >= 95}">bg-success</c:when>
                                            <c:when test="${stats.disponibilitePercent >= 80}">bg-warning</c:when>
                                            <c:otherwise>bg-danger</c:otherwise>
                                        </c:choose>"
                                        style="width: ${stats.disponibilitePercent}%">
                                        <fmt:formatNumber value="${stats.disponibilitePercent}" pattern="0"/>%
                                    </div>
                                </div>
                            </td>
                            <td>
                                <a href="/serveurs-stats/${stats.serveurNom}" class="btn btn-primary btn-sm">
                                    <span>📈</span> Détails
                                </a>
                            </td>
                            <td style="text-align: center;">
                                <button onclick="console.log('Bouton cliqué, serveurNom:', '${stats.serveurNom}'); testerServeur('${stats.serveurNom}')"
                                        class="btn btn-success btn-sm"
                                        style="padding: 0.25rem 0.5rem; font-size: 0.7rem;">
                                    🚀 Tester
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Message si aucun serveur -->
        <c:if test="${empty serveursStats}">
            <div class="text-center py-5">
                <div style="font-size: 4rem;">📊</div>
                <h4 class="text-muted mt-3">Aucune statistique disponible</h4>
                <p class="text-muted">Les statistiques des serveurs apparaîtront après l'exécution des tests.</p>
            </div>
        </c:if>
    </div>

    <!-- Légende -->
    <div class="card mt-4">
        <div class="card-body">
            <h6>Légende :</h6>
            <div class="d-flex flex-wrap gap-3">
                <span class="badge bg-success">Excellent (≥95%)</span>
                <span class="badge bg-warning">Bon (80-94%)</span>
                <span class="badge bg-danger">Critique (<80%)</span>
                <span class="badge badge-category-integration">Frontal</span>
                <span class="badge badge-category-processus_metier">BackOffice</span>
                <span class="badge badge-category-web">BetaWeb</span>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />