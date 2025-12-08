<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles simplifiés et corrigés */
.caisses-container {
    max-width: 1600px;
    margin: 0 auto;
    padding: 1.5rem;
}

.caisses-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.caisses-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.caisses-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.caisses-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

.btn-new-caisse {
    background: white;
    color: #006747;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 12px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    text-decoration: none;
    transition: all 0.3s ease;
}

.btn-new-caisse:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
    text-decoration: none;
    color: #006747;
}

.filters-modern-caisses {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.filters-grid-caisses {
    display: flex;
    gap: 1rem;
    align-items: center;
    flex-wrap: wrap;
}

.search-container-caisses {
    position: relative;
    flex: 1;
    min-width: 300px;
}

.search-input-caisses {
    width: 100%;
    padding: 0.75rem 1rem 0.75rem 3rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 0.95rem;
}

.search-icon-caisses {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: #6c757d;
}

.results-count-caisses {
    color: #495057;
    font-weight: 600;
    padding: 0.75rem 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.table-caisses-modern {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    margin-bottom: 2rem;
}

.table-header-caisses {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    padding: 1.5rem;
}

.table-header-caisses h2 {
    margin: 0;
    font-size: 1.25rem;
}

.data-table-caisses {
    width: 100%;
    border-collapse: collapse;
    min-width: 1000px;
}

.data-table-caisses th {
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    border-bottom: 2px solid #e9ecef;
    background: #f8f9fa;
}

.data-table-caisses td {
    padding: 1rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.data-table-caisses tbody tr:hover {
    background-color: #f8f9fa;
}

.status-indicator-caisses {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    display: inline-block;
    margin-right: 0.5rem;
}

.status-active-caisses {
    background: #06d6a0;
}

.status-inactive-caisses {
    background: #ef476f;
}

.code-badge-caisses {
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    color: white;
}

.badge-partition {
    background: linear-gradient(135deg, #4cc9f0, #4361ee);
}

.badge-cr {
    background: linear-gradient(135deg, #7209b7, #3a0ca3);
}

.status-badge-caisses {
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 600;
}

.status-badge-active {
    background: rgba(6, 214, 160, 0.1);
    color: #06d6a0;
    border: 1px solid rgba(6, 214, 160, 0.2);
}

.status-badge-inactive {
    background: rgba(239, 71, 111, 0.1);
    color: #ef476f;
    border: 1px solid rgba(239, 71, 111, 0.2);
}

.actions-grid-caisses {
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
    justify-content: center;
}

.btn-action-caisses {
    padding: 0.4rem 0.8rem;
    border-radius: 6px;
    font-size: 0.8rem;
    font-weight: 500;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    border: none;
    cursor: pointer;
}

.btn-view-caisses {
    background: #e3f2fd;
    color: #1976d2;
    border: 1px solid #bbdefb;
}

.btn-edit-caisses {
    background: #fff3e0;
    color: #ef6c00;
    border: 1px solid #ffe0b2;
}

.btn-toggle-caisses {
    background: #e8f5e9;
    color: #2e7d32;
    border: 1px solid #c8e6c9;
}

.btn-toggle-caisses.inactive {
    background: #ffebee;
    color: #d32f2f;
    border: 1px solid #ffcdd2;
}

.empty-state-caisses {
    text-align: center;
    padding: 4rem 2rem;
    display: none;
}

.empty-state-caisses h3 {
    color: #495057;
    margin-bottom: 1rem;
}

.empty-state-caisses p {
    color: #6c757d;
    margin-bottom: 2rem;
}

.btn-create-empty {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 600;
}
</style>

<div class="caisses-container">
    <!-- HEADER -->
    <div class="caisses-header-modern">
        <div class="caisses-title-section">
            <div>
                <div class="caisses-title">
                    <h1>🏦 Liste des Caisses</h1>
                </div>
                <p class="caisses-subtitle">Gestion et administration des caisses bancaires</p>
            </div>
            <a href="/caisses/creer" class="btn-new-caisse">
                <span>➕</span>
                <span>Nouvelle Caisse</span>
            </a>
        </div>
    </div>

    <!-- FILTRES -->
    <div class="filters-modern-caisses">
        <div class="filters-grid-caisses">
            <div class="search-container-caisses">
                <span class="search-icon-caisses">🔍</span>
                <input type="text" id="searchInput" placeholder="Rechercher par code ou nom..."
                       class="search-input-caisses">
            </div>

            <select id="statusFilter" class="filter-select-caisses">
                <option value="">Tous les statuts</option>
                <option value="active">✅ Actives</option>
                <option value="inactive">❌ Inactives</option>
            </select>

            <div class="results-count-caisses">
                📊 <span id="resultsCount">${caisses.size()}</span> caisses trouvées
            </div>
        </div>
    </div>

    <!-- TABLEAU -->
    <div class="table-caisses-modern">
        <div class="table-header-caisses">
            <h2>📋 Liste des Caisses</h2>
        </div>

        <div class="table-container-caisses">
            <!-- VERSION SIMPLIFIÉE - Sans erreur de propriété -->
            <c:choose>
                <c:when test="${empty caisses}">
                    <!-- Aucune caisse en base -->
                    <div class="empty-state-caisses" style="display: block; padding: 3rem;">
                        <div style="font-size: 4rem; margin-bottom: 1.5rem; opacity: 0.5;">🏦</div>
                        <h3>Aucune caisse trouvée</h3>
                        <p>Commencez par créer votre première caisse</p>
                        <a href="/caisses/creer" class="btn-create-empty">
                            ➕ Créer une caisse
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- Caisses existantes -->
                    <table class="data-table-caisses">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Nom</th>
                                <th>Partition</th>
                                <th>CR</th>
                                <th>Statut</th>
                                <th style="text-align: center;">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="caissesTableBody">
                            <c:forEach var="caisse" items="${caisses}" varStatus="loop">
                                <tr class="caisse-row"
                                    data-status="${caisse.actif ? 'active' : 'inactive'}"
                                    data-search="${caisse.code} ${caisse.nom} ${caisse.codePartition} ${caisse.codeCr}">
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                                            <span class="status-indicator-caisses ${caisse.actif ? 'status-active-caisses' : 'status-inactive-caisses'}"></span>
                                            <strong style="color: #006747;">${caisse.code}</strong>
                                        </div>
                                    </td>
                                    <td>
                                        <div style="font-weight: 600;">${caisse.nom}</div>
                                    </td>
                                    <td>
                                        <span class="code-badge-caisses badge-partition">
                                            ${caisse.codePartition}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="code-badge-caisses badge-cr">
                                            ${caisse.codeCr}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="status-badge-caisses ${caisse.actif ? 'status-badge-active' : 'status-badge-inactive'}">
                                            ${caisse.actif ? '✅ Active' : '❌ Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="actions-grid-caisses">
                                            <a href="/caisses/details/${caisse.id}" class="btn-action-caisses btn-view-caisses">
                                                <span>👁️</span> Voir
                                            </a>
                                            <a href="/caisses/modifier/${caisse.id}" class="btn-action-caisses btn-edit-caisses">
                                                <span>✏️</span> Modifier
                                            </a>
                                            <button onclick="toggleCaisseStatus(${caisse.id}, '${caisse.nom}', ${caisse.actif})"
                                                    class="btn-action-caisses btn-toggle-caisses ${caisse.actif ? '' : 'inactive'}">
                                                <span>${caisse.actif ? '⏸️' : '▶️'}</span>
                                                ${caisse.actif ? 'Désactiver' : 'Activer'}
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Empty state pour filtrage -->
    <div id="filterEmptyState" class="empty-state-caisses" style="display: none; margin-top: 2rem;">
        <div style="font-size: 4rem; margin-bottom: 1.5rem; opacity: 0.5;">🔍</div>
        <h3>Aucune caisse correspondante</h3>
        <p>Aucune caisse ne correspond à vos critères de recherche</p>
        <button onclick="resetFilters()" class="btn-create-empty">
            🔄 Réinitialiser les filtres
        </button>
    </div>
</div>

<script>
// VERSION SIMPLIFIÉE et CORRECTE du filtrage

// Fonction de filtrage
function filterCaisses() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    const status = document.getElementById('statusFilter').value;

    const rows = document.querySelectorAll('.caisse-row');
    let visibleCount = 0;

    rows.forEach((row) => {
        const rowStatus = row.getAttribute('data-status');
        const rowSearch = row.getAttribute('data-search').toLowerCase();

        // Conditions de filtrage
        const statusMatch = !status || rowStatus === status;
        const searchMatch = !search || rowSearch.includes(search);

        // Afficher seulement si les DEUX conditions sont vraies
        if (statusMatch && searchMatch) {
            row.style.display = '';
            visibleCount++;
        } else {
            row.style.display = 'none';
        }
    });

    // Mettre à jour le compteur
    document.getElementById('resultsCount').textContent = visibleCount;

    // Gérer l'empty state
    const filterEmptyState = document.getElementById('filterEmptyState');
    const totalRows = rows.length;

    if (totalRows > 0 && visibleCount === 0) {
        // Des caisses existent mais aucun filtre ne correspond
        filterEmptyState.style.display = 'block';
    } else {
        filterEmptyState.style.display = 'none';
    }
}

// Réinitialiser les filtres
function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('statusFilter').value = '';

    // Afficher TOUTES les lignes
    const rows = document.querySelectorAll('.caisse-row');
    rows.forEach(row => {
        row.style.display = '';
    });

    // Mettre à jour le compteur
    document.getElementById('resultsCount').textContent = rows.length;

    // Cacher l'empty state
    document.getElementById('filterEmptyState').style.display = 'none';
}

// Toggle du statut
function toggleCaisseStatus(caisseId, caisseNom, isActive) {
    const action = isActive ? 'désactiver' : 'activer';
    if (confirm(`Voulez-vous ${action} la caisse "${caisseNom}" ?`)) {
        window.location.href = '/caisses/toggle/' + caisseId;
    }
}

// INITIALISATION - NE PAS FILTRER AU CHARGEMENT
document.addEventListener('DOMContentLoaded', function() {
    console.log('✅ Page chargée - Filtrage désactivé au chargement');

    // Initialiser le compteur
    const rows = document.querySelectorAll('.caisse-row');
    document.getElementById('resultsCount').textContent = rows.length;
    console.log(`📊 ${rows.length} caisses trouvées`);

    // Configurer les événements
    document.getElementById('searchInput').addEventListener('input', filterCaisses);
    document.getElementById('statusFilter').addEventListener('change', filterCaisses);

    // S'assurer que tout est visible
    rows.forEach(row => row.style.display = '');
});
</script>

<jsp:include page="../includes/footer.jsp" />