<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="page-header">
        <h2>📅 Calendrier des Mises à Jour</h2>
        <div class="action-buttons">
            <a href="/mises-a-jour" class="btn btn-secondary">
                <span>←</span> Retour à la liste
            </a>
            <a href="/mises-a-jour/create" class="btn btn-primary">
                <span>📅</span> Planifier une MAJ
            </a>
        </div>
    </div>

    <!-- Vue calendrier simplifiée -->
    <div class="card">
        <h3 style="color: #4361ee; margin-bottom: 1.5rem;">Vue Mensuelle</h3>

        <div style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 0.5rem; margin-bottom: 2rem;">
            <!-- En-têtes des jours -->
            <div style="text-align: center; font-weight: 600; padding: 1rem; background: #f8f9fa; border-radius: 8px;">Lun</div>
            <div style="text-align: center; font-weight: 600; padding: 1rem; background: #f8f9fa; border-radius: 8px;">Mar</div>
            <div style="text-align: center; font-weight: 600; padding: 1rem; background: #f8f9fa; border-radius: 8px;">Mer</div>
            <div style="text-align: center; font-weight: 600; padding: 1rem; background: #f8f9fa; border-radius: 8px;">Jeu</div>
            <div style="text-align: center; font-weight: 600; padding: 1rem; background: #f8f9fa; border-radius: 8px;">Ven</div>
            <div style="text-align: center; font-weight: 600; padding: 1rem; background: #f8f9fa; border-radius: 8px;">Sam</div>
            <div style="text-align: center; font-weight: 600; padding: 1rem; background: #f8f9fa; border-radius: 8px;">Dim</div>

            <!-- Jours du mois (exemple statique) -->
            <c:forEach begin="1" end="35" var="day">
                <div style="border: 1px solid #e9ecef; padding: 0.5rem; min-height: 80px; border-radius: 8px; background: white;">
                    <div style="font-weight: 600; margin-bottom: 0.5rem;">${day}</div>
                    <!-- Exemple de MAJ pour certains jours -->
                    <c:if test="${day % 5 == 0}">
                        <div style="background: #4361ee; color: white; padding: 0.2rem; border-radius: 4px; font-size: 0.8rem; margin-bottom: 0.2rem;">
                            MAJ Serveur
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Liste des MAJ à venir -->
    <div class="card">
        <h3 style="color: #4361ee; margin-bottom: 1.5rem;">Mises à Jour à Venir</h3>

        <div class="data-table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Serveur</th>
                        <th>Type</th>
                        <th>Statut</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="maj" items="${misesAJour}">
                        <tr>
                            <td>
                                <strong>
                                    <fmt:formatDate value="${maj.dateApplication}" pattern="dd/MM/yyyy"/>
                                </strong>
                                <c:if test="${maj.heurePrevue != null}">
                                    <br><small><fmt:formatDate value="${maj.heurePrevue}" pattern="HH:mm"/></small>
                                </c:if>
                            </td>
                            <td>${maj.description}</td>
                            <td>
                                <a href="/serveurs/view/${maj.serveur.id}" style="color: #4361ee;">
                                    ${maj.serveur.nom}
                                </a>
                            </td>
                            <td>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${maj.typeMiseAJour == 'CRITIQUE'}">badge-category-conformite</c:when>
                                        <c:when test="${maj.typeMiseAJour == 'SECURITE'}">badge-category-surveillance</c:when>
                                        <c:otherwise>badge-category-integration</c:otherwise>
                                    </c:choose>">
                                    ${maj.typeMiseAJour}
                                </span>
                            </td>
                            <td>
                                <span class="status-badge
                                    <c:choose>
                                        <c:when test="${maj.statut == 'PLANIFIEE'}">active</c:when>
                                        <c:when test="${maj.statut == 'EN_COURS'}">warning</c:when>
                                        <c:when test="${maj.statut == 'TERMINEE'}">success</c:when>
                                        <c:otherwise>inactive</c:otherwise>
                                    </c:choose>">
                                    ${maj.statut}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />