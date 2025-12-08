<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/global-styles.css">
<div class="container">
    <!-- En-tête de page -->
    <div class="page-header">
        <h2>⚠️ Serveurs en Difficulté</h2>
        <div class="action-buttons">
            <a href="/serveurs-stats" class="btn btn-secondary">
                <span>←</span> Retour aux statistiques
            </a>
        </div>
    </div>

    <!-- Résumé -->
    <div class="alert alert-warning">
        <h5><i class="bi bi-exclamation-triangle"></i> Alertes de disponibilité</h5>
        <p class="mb-0">
            <strong>${totalProblemes} serveur(s)</strong> avec une disponibilité inférieure à 80%
        </p>
    </div>

    <!-- Tableau des serveurs en difficulté -->
    <div class="card">
        <div class="card-header bg-warning text-dark">
            <h5 class="card-title mb-0">
                <i class="bi bi-server"></i> Serveurs nécessitant une attention
            </h5>
        </div>
        <div class="card-body">
            <c:if test="${not empty serveursProblemes}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Serveur</th>
                                <th>Type</th>
                                <th>Caisse</th>
                                <th>Disponibilité</th>
                                <th>Tests Réussis/Total</th>
                                <th>Taux Réussite</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="serveur" items="${serveursProblemes}">
                                <tr>
                                    <td>
                                        <strong>${serveur.serveurNom}</strong>
                                        <span class="status-badge inactive">Critique</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">${serveur.typeServeur}</span>
                                    </td>
                                    <td>${serveur.caisseCode}</td>
                                    <td>
                                        <div class="progress" style="height: 20px; width: 120px;">
                                            <div class="progress-bar bg-danger" style="width: ${serveur.disponibilitePercent}%">
                                                <fmt:formatNumber value="${serveur.disponibilitePercent}" pattern="0.0"/>%
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="text-success">${serveur.testsSucces}</span> /
                                        <span class="text-danger">${serveur.testsEchec}</span> /
                                        <strong>${serveur.testsTotal}</strong>
                                    </td>
                                    <td>
                                        <c:if test="${serveur.testsTotal > 0}">
                                            <fmt:formatNumber value="${serveur.testsSucces * 100.0 / serveur.testsTotal}" pattern="0.0"/>%
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="/serveurs-stats/${serveur.serveurNom}" class="btn btn-primary btn-sm">
                                            <span>🔍</span> Analyser
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty serveursProblemes}">
                <div class="text-center py-5">
                    <i class="bi bi-check-circle fs-1 text-success"></i>
                    <h4 class="text-success mt-3">Aucun serveur en difficulté</h4>
                    <p class="text-muted">Tous les serveurs maintiennent une bonne disponibilité.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />