<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="page-header">
        <h2>🖥️ Gestion des Serveurs</h2>
        <div class="action-buttons">
            <!-- BOUTON CRÉATION -->
            <a href="/serveurs/create" class="btn btn-primary">
                <span>➕</span> Nouveau Serveur
            </a>
            <!-- BOUTON STATS -->
            <a href="/serveurs-stats" class="btn btn-success">
                <span>📈</span> Voir les Statistiques
            </a>
        </div>
    </div>

    <!-- Statistiques globales -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value">${totalServeurs}</div>
            <div class="stat-label">Total Serveurs</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${serveursActifs}</div>
            <div class="stat-label">Serveurs Actifs</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">
                <fmt:formatNumber value="${tauxDisponibilite}" pattern="0.0"/>%
            </div>
            <div class="stat-label">Disponibilité</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${serveursProduction}</div>
            <div class="stat-label">Production</div>
        </div>
    </div>

    <!-- Filtres -->
    <form method="get" action="/serveurs" style="margin-bottom: 2rem;">
        <div class="filters" style="margin-bottom: 2rem; display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
            <!-- Code Caisse -->
            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                <label style="font-weight: 600; color: #495057; font-size: 0.9rem;">Code Caisse</label>
                <select id="codeCaisse" name="codeCaisse"
                        style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer; min-width: 180px;">
                    <option value="">Toutes les caisses</option>
                    <c:forEach items="${codesCaisse}" var="caisse">
                        <option value="${caisse}" ${filtreCaisse == caisse ? 'selected' : ''}>${caisse}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Type de Serveur -->
            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                <label style="font-weight: 600; color: #495057; font-size: 0.9rem;">Type de Serveur</label>
                <select id="typePatron" name="typePatron"
                        style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer; min-width: 180px;">
                    <option value="">Tous les types</option>
                    <c:forEach items="${statsParType.keySet()}" var="type">
                        <option value="${type}" ${filtreType == type ? 'selected' : ''}>${type}</option>
                    </c:forEach>
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
                    <a href="/serveurs"
                       style="padding: 0.75rem 1.5rem; border: 2px solid #6c757d; border-radius: 25px; background: white; color: #6c757d; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 0.5rem; text-decoration: none;">
                        🔄 Reset
                    </a>
                </div>
            </div>

            <!-- Compteur -->
            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                <label style="font-weight: 600; color: #495057; font-size: 0.9rem; opacity: 0;">Résultats</label>
                <div style=" color: #495057; font-weight: 600; padding: 0.75rem 0;">
                    📊 ${serveurs.size()} serveurs trouvés
                </div>
            </div>
        </div>
    </form>

    <!-- Tableau des serveurs -->
    <div class="card">
        <h3 style="color: #4361ee; margin-bottom: 1.5rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
            Liste des Serveurs
        </h3>

        <div class="data-table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Type</th>
                        <th>Environnement</th>
                        <th>Statut</th>
                        <th>Adresse IP</th>

                        <th style="text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="serveur" items="${serveurs}">
                        <tr>
                            <td>
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <strong>${serveur.nom}</strong>
                                    <c:if test="${serveur.statut == 'ACTIF'}">
                                        <span class="status-badge active">Actif</span>
                                    </c:if>
                                </div>
                                <c:if test="${not empty serveur.description}">
                                    <div style="font-size: 0.8rem; color: #6c757d; margin-top: 0.25rem;">
                                        ${serveur.description}
                                    </div>
                                </c:if>
                            </td>
                            <td>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${serveur.typeServeur.name() == 'INTEGRATION'}">badge-category-integration</c:when>
                                        <c:when test="${serveur.typeServeur.name() == 'APPLICATION'}">badge-category-processus_metier</c:when>
                                        <c:when test="${serveur.typeServeur.name() == 'WEB'}">badge-category-web</c:when>
                                        <c:when test="${serveur.typeServeur.name() == 'BASE_DONNEES'}">badge-category-ged</c:when>
                                        <c:when test="${serveur.typeServeur.name() == 'SUPERVISION'}">badge-category-surveillance</c:when>
                                        <c:otherwise>badge-category-conformite</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${serveur.typeServeur.name() == 'BASE_DONNEES'}">Base de Données</c:when>
                                        <c:when test="${serveur.typeServeur.name() == 'SUPERVISION'}">Supervision</c:when>
                                        <c:otherwise>${serveur.typeServeur}</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <span class="badge" style="background: #7209b7; color: white;">
                                    ${serveur.environnement}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${serveur.statut == 'ACTIF'}">
                                        <span class="status-badge active">✅ Actif</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge inactive">❌ ${serveur.statut}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <code style="background: #f8f9fa; padding: 0.25rem 0.5rem; border-radius: 5px; font-size: 0.8rem;">
                                    ${serveur.adresseIP}
                                </code>
                            </td>

                            <td style="text-align: center;">
                                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap; justify-content: center;">
                                    <!-- BOUTON VUE DÉTAILS -->
                                    <a href="/serveurs/view/${serveur.id}" class="btn btn-primary btn-sm"
                                       style="padding: 0.25rem 0.5rem; font-size: 0.7rem; display: flex; align-items: center; gap: 0.25rem;">
                                        <span>👁️</span> Détails
                                    </a>
                                    <!-- BOUTON MODIFICATION -->
                                    <a href="/serveurs/edit/${serveur.id}" class="btn btn-warning btn-sm"
                                       style="padding: 0.25rem 0.5rem; font-size: 0.7rem; display: flex; align-items: center; gap: 0.25rem;">
                                        <span>✏️</span> Modifier
                                    </a>
                                    <!-- BOUTON SUPPRESSION -->
                                    <form action="/serveurs/delete/${serveur.id}" method="post" style="display: inline;">
                                        <button type="submit"
                                                onclick="return confirm('Êtes-vous sûr de vouloir supprimer le serveur ${serveur.nom} ?')"
                                                class="btn btn-danger btn-sm"
                                                style="padding: 0.25rem 0.5rem; font-size: 0.7rem; display: flex; align-items: center; gap: 0.25rem;">
                                            <span>🗑️</span> Supprimer
                                        </button>
                                    </form>
                                    <!-- BOUTON STATS -->
                                    <a href="/serveurs-stats/${serveur.nom}" class="btn btn-info btn-sm"
                                       style="padding: 0.25rem 0.5rem; font-size: 0.7rem; display: flex; align-items: center; gap: 0.25rem;">
                                        <span>📈</span> Stats
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty serveurs}">
            <div class="text-center py-5">
                <div style="font-size: 4rem; margin-bottom: 1rem;">🖥️</div>
                <h3 style="color: #6c757d; margin-bottom: 1rem;">Aucun serveur trouvé</h3>
                <p style="color: #8d99ae; margin-bottom: 2rem;">Commencez par créer votre premier serveur</p>
                <a href="/serveurs/create" class="btn btn-primary">➕ Créer un serveur</a>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />