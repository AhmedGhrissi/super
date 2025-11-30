<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <!-- En-tête de page -->
    <div class="page-header">
        <h2>🏆 Top Serveurs</h2>
        <div class="action-buttons">
            <a href="/serveurs-stats" class="btn btn-secondary">
                <span>←</span> Retour aux statistiques
            </a>
        </div>
    </div>

    <!-- Message d'information -->
    <div class="alert alert-info">
        <h5><i class="bi bi-trophy"></i> Classement par performance</h5>
        <p class="mb-0">
            Classement des serveurs par taux de disponibilité et performance
        </p>
    </div>

    <!-- Tableau des top serveurs -->
    <div class="card">
        <div class="card-header bg-success text-white">
            <h5 class="card-title mb-0">
                <i class="bi bi-award"></i> Serveurs les plus performants
            </h5>
        </div>
        <div class="card-body">
            <c:if test="${not empty topServeurs}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Position</th>
                                <th>Serveur</th>
                                <th>Type</th>
                                <th>Caisse</th>
                                <th>Disponibilité</th>
                                <th>Tests Réussis/Total</th>
                                <th>Temps Réponse</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="serveur" items="${topServeurs}" varStatus="status">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${status.index == 0}">
                                                <span class="badge bg-warning text-dark">🥇 1er</span>
                                            </c:when>
                                            <c:when test="${status.index == 1}">
                                                <span class="badge bg-secondary">🥈 2ème</span>
                                            </c:when>
                                            <c:when test="${status.index == 2}">
                                                <span class="badge bg-warning">🥉 3ème</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-dark">#${status.index + 1}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <strong>${serveur.serveurNom}</strong>
                                        <span class="status-badge active">Excellent</span>
                                    </td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${serveur.typeServeur == 'frontal'}">badge-category-integration</c:when>
                                                <c:when test="${serveur.typeServeur == 'backoffice'}">badge-category-processus_metier</c:when>
                                                <c:otherwise>badge-category-web</c:otherwise>
                                            </c:choose>">
                                            ${serveur.typeServeur}
                                        </span>
                                    </td>
                                    <td>${serveur.caisseCode}</td>
                                    <td>
                                        <div class="progress" style="height: 20px; width: 120px;">
                                            <div class="progress-bar bg-success" style="width: ${serveur.disponibilitePercent}%">
                                                <fmt:formatNumber value="${serveur.disponibilitePercent}" pattern="0.0"/>%
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="text-success fw-bold">${serveur.testsSucces}</span> /
                                        <span class="text-muted">${serveur.testsTotal}</span>
                                        <br>
                                        <small class="text-success">
                                            <fmt:formatNumber value="${serveur.testsSucces * 100.0 / serveur.testsTotal}" pattern="0.0"/>% de réussite
                                        </small>
                                    </td>
                                    <td>
                                        <c:if test="${serveur.tempsReponseMoyen > 0}">
                                            <span class="fw-bold">${serveur.tempsReponseMoyen}ms</span>
                                        </c:if>
                                        <c:if test="${serveur.tempsReponseMoyen == 0}">
                                            <span class="text-muted">-</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="/serveurs-stats/${serveur.serveurNom}" class="btn btn-primary btn-sm">
                                            <span>📈</span> Détails
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty topServeurs}">
                <div class="text-center py-5">
                    <i class="bi bi-graph-up fs-1 text-muted"></i>
                    <h4 class="text-muted mt-3">Aucune donnée de performance disponible</h4>
                    <p class="text-muted">Les données de performance apparaîtront après l'exécution des tests.</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Légende des performances -->
    <div class="card mt-4">
        <div class="card-body">
            <h6>📊 Échelle de performance :</h6>
            <div class="row text-center">
                <div class="col-md-3">
                    <div class="p-3 border rounded bg-success text-white">
                        <h5>95-100%</h5>
                        <p class="mb-0">Excellente</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 border rounded bg-warning text-dark">
                        <h5>90-94%</h5>
                        <p class="mb-0">Bonne</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 border rounded bg-danger text-white">
                        <h5>80-89%</h5>
                        <p class="mb-0">Moyenne</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 border rounded bg-dark text-white">
                        <h5>&lt;80%</h5>
                        <p class="mb-0">Critique</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />