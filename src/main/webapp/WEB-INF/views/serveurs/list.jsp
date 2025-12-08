<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* ========== STYLES CORRIGÉS ========== */
.servers-stats-container {
    max-width: 1600px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.servers-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.servers-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.servers-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.servers-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

/* Boutons d'action */
.servers-actions-modern {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.btn-servers-modern {
    padding: 0.75rem 1.5rem;
    border-radius: 12px;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
}

.btn-servers-primary {
    background: white;
    color: #006747;
}

.btn-servers-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(255, 255, 255, 0.3);
}

.btn-servers-success {
    background: linear-gradient(135deg, #06d6a0, #118ab2);
    color: white;
}

.btn-servers-success:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(6, 214, 160, 0.3);
}

/* Cartes de statistiques */
.stats-grid-servers {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card-servers {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    border: 1px solid #e9ecef;
}

.stat-card-servers:hover {
    transform: translateY(-4px);
    transition: transform 0.3s ease;
}

.stat-value-servers {
    font-size: 2.5rem;
    font-weight: 700;
    color: #006747;
    margin-bottom: 0.5rem;
}

.stat-label-servers {
    font-size: 0.9rem;
    color: #6c757d;
    font-weight: 500;
}

/* ========== FILTRES CORRIGÉS ========== */
.filters-modern-servers {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.filters-grid-servers {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.2rem;
    align-items: end;
}

.filter-group-servers {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.filter-label-servers {
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
    margin-bottom: 0.25rem;
}

.filter-select-servers {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    background: white;
    font-size: 0.9rem;
    width: 100%;
    cursor: pointer;
    font-family: inherit;
}

.filter-select-servers:focus {
    outline: none;
    border-color: #006747;
    box-shadow: 0 0 0 3px rgba(0, 103, 71, 0.1);
}

.filter-actions-servers {
    display: flex;
    gap: 0.75rem;
    align-items: center;
    flex-wrap: wrap;
    margin-top: 0.5rem;
}

.btn-filter-servers {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    transition: all 0.3s ease;
    font-family: inherit;
    font-size: 0.9rem;
    min-width: 140px;
    justify-content: center;
}

.btn-filter-servers:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
}

.btn-reset-servers {
    padding: 0.75rem 1.5rem;
    border: 2px solid #6c757d;
    border-radius: 8px;
    background: white;
    color: #6c757d;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
    transition: all 0.3s ease;
    font-family: inherit;
    font-size: 0.9rem;
    min-width: 140px;
    justify-content: center;
}

.btn-reset-servers:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
    text-decoration: none;
    color: #6c757d;
}

.results-count-servers {
    font-size: 0.9rem;
    color: #495057;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 0;
}

/* ========== TABLEAU ========== */
.table-modern-servers {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    margin-bottom: 2rem;
}

.table-container-servers {
    overflow-x: auto;
}

.data-table-servers {
    width: 100%;
    border-collapse: collapse;
    min-width: 1000px;
}

.data-table-servers th {
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    color: #495057;
    border-bottom: 2px solid #e9ecef;
    background: #f8f9fa;
}

.data-table-servers td {
    padding: 1rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.data-table-servers tbody tr:hover {
    background-color: #f8f9fa;
}

/* Badges */
.badge {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    color: white;
}

.badge-category-integration { background: #4cc9f0; }
.badge-category-processus_metier { background: #06d6a0; }
.badge-category-web { background: #7209b7; }
.badge-category-ged { background: #ef476f; }
.badge-category-surveillance { background: #ffd166; color: #333; }
.badge-category-conformite { background: #118ab2; }

/* Status badges */
.status-badge {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
}

.status-badge.active {
    background: rgba(40, 167, 69, 0.1);
    color: #28a745;
    border: 1px solid rgba(40, 167, 69, 0.2);
}

.status-badge.inactive {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.2);
}

/* Actions */
.actions-container {
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
    justify-content: center;
}

.btn-action {
    padding: 0.4rem 0.8rem;
    border-radius: 6px;
    font-size: 0.8rem;
    font-weight: 500;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    transition: all 0.2s ease;
    border: 1px solid transparent;
}

.btn-action:hover {
    transform: translateY(-1px);
    text-decoration: none;
}

.btn-details {
    background: #e3f2fd;
    color: #1976d2;
    border-color: #bbdefb;
}

.btn-details:hover {
    background: #bbdefb;
}

.btn-edit {
    background: #fff3e0;
    color: #ef6c00;
    border-color: #ffe0b2;
}

.btn-edit:hover {
    background: #ffe0b2;
}

.btn-delete {
    background: #ffebee;
    color: #d32f2f;
    border-color: #ffcdd2;
}

.btn-delete:hover {
    background: #ffcdd2;
}

.btn-stats {
    background: #e8f5e9;
    color: #2e7d32;
    border-color: #c8e6c9;
}

.btn-stats:hover {
    background: #c8e6c9;
}

/* Empty state */
.empty-state-servers {
    text-align: center;
    padding: 3rem 2rem;
}

.empty-state-icon-servers {
    font-size: 3rem;
    margin-bottom: 1.5rem;
    opacity: 0.5;
    color: #6c757d;
}

.empty-state-servers h3 {
    color: #495057;
    margin-bottom: 1rem;
    font-size: 1.5rem;
}

.empty-state-servers p {
    color: #8d99ae;
    margin-bottom: 2rem;
    font-size: 1rem;
}

/* Responsive */
@media (max-width: 768px) {
    .servers-stats-container {
        padding: 1rem;
    }

    .servers-title-section {
        flex-direction: column;
    }

    .servers-actions-modern {
        width: 100%;
        justify-content: center;
    }

    .filters-grid-servers {
        grid-template-columns: 1fr;
    }

    .filter-actions-servers {
        flex-direction: column;
        width: 100%;
    }

    .btn-filter-servers, .btn-reset-servers {
        width: 100%;
    }

    .results-count-servers {
        justify-content: center;
        text-align: center;
    }
}
/* ========== FILTRES AMÉLIORÉS ========== */
.filters-modern-servers {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.filters-grid-servers {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 5 colonnes */
    gap: 1.2rem;
    align-items: start;
}

.filter-group-servers {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.filter-label-servers {
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
    margin-bottom: 0.25rem;
}

.filter-select-servers {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    background: white;
    font-size: 0.9rem;
    width: 100%;
    cursor: pointer;
    font-family: inherit;
    transition: all 0.3s ease;
}

.filter-select-servers:focus {
    outline: none;
    border-color: #006747;
    box-shadow: 0 0 0 3px rgba(0, 103, 71, 0.1);
}

/* Bouton Filtrer spécifique */
.btn-filter-servers {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    transition: all 0.3s ease;
    font-family: inherit;
    font-size: 0.9rem;
    justify-content: center;
    height: 42px; /* Même hauteur que les selects */
    margin-top: 1.5rem; /* Alignement avec les labels */
}

.btn-filter-servers:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
}

/* Zone des actions en bas */
.filter-actions-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 1.5rem;
    padding-top: 1.5rem;
    border-top: 1px solid #e9ecef;
}

/* Bouton Réinitialiser */
.btn-reset-servers {
    padding: 0.75rem 1.5rem;
    border: 2px solid #6c757d;
    border-radius: 8px;
    background: white;
    color: #6c757d;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
    transition: all 0.3s ease;
    font-family: inherit;
    font-size: 0.9rem;
}

.btn-reset-servers:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
    text-decoration: none;
    color: #6c757d;
}

/* Compteur */
.results-count-servers {
    font-size: 0.9rem;
    color: #495057;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 0;
}

/* Responsive */
@media (max-width: 1200px) {
    .filters-grid-servers {
        grid-template-columns: repeat(3, 1fr);
    }
}

@media (max-width: 768px) {
    .filters-grid-servers {
        grid-template-columns: repeat(2, 1fr);
    }

    .filter-actions-bottom {
        flex-direction: column;
        gap: 1rem;
        align-items: stretch;
    }

    .btn-reset-servers {
        width: 100%;
        justify-content: center;
    }

    .results-count-servers {
        justify-content: center;
    }
}

@media (max-width: 480px) {
    .filters-grid-servers {
        grid-template-columns: 1fr;
    }
}
</style>

<div class="servers-stats-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="servers-header-modern">
        <div class="servers-title-section">
            <div>
                <div class="servers-title">
                    <h1>🖥️ Gestion des Serveurs</h1>
                </div>
                <p class="servers-subtitle">Supervision et administration des serveurs</p>
            </div>

            <div class="servers-actions-modern">
                <a href="/serveurs/create" class="btn-servers-modern btn-servers-primary">
                    <span>➕</span> Nouveau Serveur
                </a>
                <a href="/serveurs-stats" class="btn-servers-modern btn-servers-success">
                    <span>📈</span> Statistiques
                </a>
            </div>
        </div>
    </div>

    <!-- ========== MESSAGES FLASH ========== -->
    <c:if test="${not empty success}">
        <div style="background: #d4edda; color: #155724; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
            <span>✅</span>
            <span>${success}</span>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
            <span>❌</span>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- ========== STATISTIQUES GLOBALES ========== -->
    <div class="stats-grid-servers">
        <div class="stat-card-servers">
            <div class="stat-value-servers">${totalServeurs}</div>
            <div class="stat-label-servers">Total Serveurs</div>
        </div>

        <div class="stat-card-servers">
            <div class="stat-value-servers">${serveursActifs}</div>
            <div class="stat-label-servers">Serveurs Actifs</div>
        </div>

        <div class="stat-card-servers">
            <div class="stat-value-servers">
                <fmt:formatNumber value="${tauxDisponibilite}" pattern="0.0"/>%
            </div>
            <div class="stat-label-servers">Disponibilité</div>
        </div>

        <div class="stat-card-servers">
            <div class="stat-value-servers">${serveursProduction}</div>
            <div class="stat-label-servers">Production</div>
        </div>
    </div>



	<!-- ========== FILTRES FONCTIONNELS ========== -->
	<form method="get" action="/serveurs" class="filters-modern-servers">
	    <!-- Ligne des filtres + bouton Filtrer -->
	    <div class="filters-grid-servers">
	        <!-- Code Caisse -->
	        <div class="filter-group-servers">
	            <label class="filter-label-servers">Code Caisse</label>
	            <select id="codeCaisse" name="codeCaisse" class="filter-select-servers">
	                <option value="">Toutes les caisses</option>
	                <c:forEach items="${codesCaisse}" var="caisse">
	                    <option value="${caisse}" ${param.codeCaisse == caisse ? 'selected' : ''}>${caisse}</option>
	                </c:forEach>
	            </select>
	        </div>

	        <!-- Type de Serveur -->
	        <div class="filter-group-servers">
	            <label class="filter-label-servers">Type de Serveur</label>
	            <select id="typePatron" name="typePatron" class="filter-select-servers">
	                <option value="">Tous les types</option>
	                <c:forEach items="${statsParType.keySet()}" var="type">
	                    <option value="${type}" ${param.typePatron == type ? 'selected' : ''}>${type}</option>
	                </c:forEach>
	            </select>
	        </div>

	        <!-- Environnement -->
	        <div class="filter-group-servers">
	            <label class="filter-label-servers">Environnement</label>
	            <select id="environnement" name="environnement" class="filter-select-servers">
	                <option value="">Tous</option>
	                <option value="PRODUCTION" ${param.environnement == 'PRODUCTION' ? 'selected' : ''}>Production</option>
	                <option value="PREPRODUCTION" ${param.environnement == 'PREPRODUCTION' ? 'selected' : ''}>Pré-production</option>
	                <option value="DEVELOPPEMENT" ${param.environnement == 'DEVELOPPEMENT' ? 'selected' : ''}>Développement</option>
	            </select>
	        </div>

	        <!-- Statut -->
	        <div class="filter-group-servers">
	            <label class="filter-label-servers">Statut</label>
	            <select id="statut" name="statut" class="filter-select-servers">
	                <option value="">Tous</option>
	                <option value="ACTIF" ${param.statut == 'ACTIF' ? 'selected' : ''}>Actif</option>
	                <option value="INACTIF" ${param.statut == 'INACTIF' ? 'selected' : ''}>Inactif</option>
	                <option value="MAINTENANCE" ${param.statut == 'MAINTENANCE' ? 'selected' : ''}>Maintenance</option>
	            </select>
	        </div>

	        <!-- Bouton Filtrer (5ème colonne) -->
	        <div class="filter-group-servers">
	            <label class="filter-label-servers" style="visibility: hidden;">Actions</label>
	            <button type="submit" class="btn-filter-servers">
	                <span>🔍</span> Filtrer
	            </button>
	        </div>
	    </div>

	    <!-- Ligne inférieure : Réinitialiser + Compteur -->
	    <div class="filter-actions-bottom">
	        <!-- Bouton Réinitialiser -->
	        <a href="/serveurs" class="btn-reset-servers">
	            <span>🔄</span> Réinitialiser tous les filtres
	        </a>

	        <!-- Compteur -->
	        <div class="results-count-servers">
	            <span>📊</span> ${serveurs.size()} serveur(s)
	        </div>
	    </div>
	</form>

    <!-- ========== TABLEAU DES SERVEURS ========== -->
    <div class="table-modern-servers">
        <div class="table-container-servers">
            <table class="data-table-servers">
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
                            <!-- Nom -->
                            <td>
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <strong style="color: #006747;">${serveur.nom}</strong>
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

                            <!-- Type -->
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

                            <!-- Environnement -->
                            <td>
                                <span class="badge" style="background: #7209b7; color: white;">
                                    ${serveur.environnement}
                                </span>
                            </td>

                            <!-- Statut -->
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

                            <!-- Adresse IP -->
                            <td>
                                <code style="background: #f8f9fa; padding: 0.25rem 0.5rem; border-radius: 5px; font-size: 0.8rem;">
                                    ${serveur.adresseIP}
                                </code>
                            </td>

                            <!-- Actions -->
                            <td>
                                <div class="actions-container">
                                    <!-- Détails -->
                                    <a href="/serveurs/view/${serveur.id}"
                                       class="btn-action btn-details">
                                        <span>👁️</span> Détails
                                    </a>
                                    <!-- Modification -->
                                    <a href="/serveurs/edit/${serveur.id}"
                                       class="btn-action btn-edit">
                                        <span>✏️</span> Modifier
                                    </a>
                                    <!-- Statistiques -->
                                    <a href="/serveurs-stats/${serveur.nom}"
                                       class="btn-action btn-stats">
                                        <span>📈</span> Stats
                                    </a>
                                    <!-- Suppression -->
                                    <form action="/serveurs/delete/${serveur.id}" method="post"
                                          style="display: inline; margin: 0;">
                                        <button type="submit"
                                                onclick="return confirm('Êtes-vous sûr de vouloir supprimer le serveur ${serveur.nom} ?')"
                                                class="btn-action btn-delete">
                                            <span>🗑️</span> Supprimer
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Empty state -->
            <c:if test="${empty serveurs}">
                <div class="empty-state-servers">
                    <div class="empty-state-icon-servers">🖥️</div>
                    <h3>Aucun serveur trouvé</h3>
                    <p>Aucun serveur ne correspond à vos critères de recherche</p>
                    <div style="display: flex; gap: 1rem; justify-content: center;">
                        <a href="/serveurs/create" class="btn-filter-servers">
                            <span>➕</span> Créer un serveur
                        </a>
                        <a href="/serveurs" class="btn-reset-servers">
                            <span>🔄</span> Afficher tous
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
// ========== CORRECTION DES FILTRES ==========
document.addEventListener('DOMContentLoaded', function() {
    console.log('✅ Page serveurs chargée');

    // Vérifier si des filtres sont présents dans l'URL
    const urlParams = new URLSearchParams(window.location.search);
    const hasFilters = urlParams.toString() !== '';

    if (hasFilters) {
        console.log('Filtres actifs:', Object.fromEntries(urlParams.entries()));
    }

    // Ajouter un événement pour montrer les filtres appliqués
    const filterForm = document.querySelector('form.filters-modern-servers');
    if (filterForm) {
        filterForm.addEventListener('submit', function(e) {
            console.log('Soumission du formulaire de filtrage');

            // Récupérer les valeurs des filtres
            const filters = {
                codeCaisse: document.getElementById('codeCaisse').value,
                typePatron: document.getElementById('typePatron').value,
                environnement: document.getElementById('environnement').value,
                statut: document.getElementById('statut').value
            };

            console.log('Filtres appliqués:', filters);
        });
    }

    // Filtrer côté client (optionnel - pour feedback immédiat)
    function filterClientSide() {
        const codeCaisse = document.getElementById('codeCaisse')?.value || '';
        const typePatron = document.getElementById('typePatron')?.value || '';
        const environnement = document.getElementById('environnement')?.value || '';
        const statut = document.getElementById('statut')?.value || '';

        // Si tous les filtres sont vides, ne rien faire
        if (!codeCaisse && !typePatron && !environnement && !statut) {
            return;
        }

        // Mettre en évidence les filtres actifs
        const selects = document.querySelectorAll('.filter-select-servers');
        selects.forEach(select => {
            if (select.value) {
                select.style.borderColor = '#006747';
                select.style.backgroundColor = '#f8fff9';
            } else {
                select.style.borderColor = '#e9ecef';
                select.style.backgroundColor = 'white';
            }
        });
    }

    // Appliquer le filtrage client-side au chargement
    filterClientSide();

    // Écouter les changements
    document.querySelectorAll('.filter-select-servers').forEach(select => {
        select.addEventListener('change', filterClientSide);
    });
});

// ========== FONCTION POUR TESTER UN SERVEUR ==========
function testerServeur(serveurId, serveurNom) {
    if (confirm(`Lancer un test sur "${serveurNom}" ?`)) {
        // Afficher un indicateur
        const button = event.target;
        const originalHTML = button.innerHTML;
        button.innerHTML = '<span>🔄</span> Test...';
        button.disabled = true;

        // Simuler le test
        setTimeout(() => {
            alert(`✅ Test de "${serveurNom}" réussi !`);
            button.innerHTML = originalHTML;
            button.disabled = false;
        }, 1500);
    }
}

// ========== DEBUG : Afficher les paramètres URL ==========
function debugFilters() {
    const params = new URLSearchParams(window.location.search);
    console.log('=== DEBUG FILTRES ===');
    console.log('URL:', window.location.href);
    console.log('Paramètres:', Object.fromEntries(params.entries()));

    // Afficher une alerte avec les filtres
    let message = 'Filtres actuels:\n';
    params.forEach((value, key) => {
        message += `- ${key}: ${value}\n`;
    });
    alert(message);
}
</script>

<!-- Bouton debug (optionnel - à enlever en production) -->
<div style="text-align: center; margin-top: 1rem;">
    <button onclick="debugFilters()"
            style="padding: 0.5rem 1rem; background: #6c757d; color: white; border: none; border-radius: 6px; font-size: 0.8rem;">
        🐛 Debug Filtres
    </button>
</div>

<jsp:include page="../includes/footer.jsp" />