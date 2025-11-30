<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>🏦 Liste des Caisses</h2>
        <a href="/caisses/creer" class="btn btn-primary">➕ Nouvelle Caisse</a>
    </div>

    <!-- Filtres et recherche -->
    <div class="filters" style="margin-bottom: 2rem; display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
        <div style="position: relative; flex: 1; min-width: 300px;">
            <input type="text" id="searchInput" placeholder="🔍 Rechercher une caisse..."
                   style="width: 100%; padding: 0.75rem 1rem 0.75rem 3rem; border: 2px solid #e9ecef; border-radius: 25px; font-size: 1rem; transition: all 0.3s ease;">
        </div>

        <select id="statusFilter" style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer;">
            <option value="">Tous les statuts</option>
            <option value="active">✅ Actives</option>
            <option value="inactive">❌ Inactives</option>
        </select>

        <div style="color: #6c757d; font-weight: 600;">
            📊 ${caisses.size()} caisses trouvées
        </div>
    </div>

    <!-- Tableau moderne -->
    <div class="table-container">
        <table class="data-table">
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
            <tbody>
                <c:forEach var="caisse" items="${caisses}">
                    <tr class="caisse-row"
                        data-status="${caisse.actif ? 'active' : 'inactive'}"
                        data-search="${caisse.code} ${caisse.nom} ${caisse.codePartition} ${caisse.codeCr}">
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.5rem;">
                                <div style="width: 8px; height: 8px; border-radius: 50%; background: ${caisse.actif ? '#06d6a0' : '#ef476f'};"></div>
                                <strong style="color: #4361ee;">${caisse.code}</strong>
                            </div>
                        </td>
                        <td>
                            <div style="font-weight: 600;">${caisse.nom}</div>
                        </td>
                        <td>
                            <span style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                                ${caisse.codePartition}
                            </span>
                        </td>
                        <td>
                            <span style="background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                                ${caisse.codeCr}
                            </span>
                        </td>
                        <td>
                            <span class="status-badge ${caisse.actif ? 'active' : 'inactive'}">
                                ${caisse.actif ? '✅ Active' : '❌ Inactive'}
                            </span>
                        </td>
                        <td style="text-align: center;">
                            <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                <a href="/caisses/details/${caisse.id}" class="btn btn-info" style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                    👁️ Voir
                                </a>
                                <a href="/caisses/modifier/${caisse.id}" class="btn btn-warning" style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                    ✏️ Modifier
                                </a>
								<button onclick="toggleCaisseStatus(${caisse.id}, '${caisse.nom}', ${caisse.actif})"
								        class="btn ${caisse.actif ? 'btn-danger' : 'btn-success'}"
								        style="padding: 0.5rem 1rem; font-size: 0.8rem;">
								    ${caisse.actif ? '⏸️ Désactiver' : '▶️ Activer'}
								</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Message si aucune caisse -->
    <c:if test="${empty caisses}">
        <div class="card" style="text-align: center; padding: 3rem;">
            <div style="font-size: 4rem; margin-bottom: 1rem;">🏦</div>
            <h3 style="color: #6c757d; margin-bottom: 1rem;">Aucune caisse trouvée</h3>
            <p style="color: #8d99ae; margin-bottom: 2rem;">Commencez par créer votre première caisse</p>
            <a href="/caisses/creer" class="btn btn-primary">➕ Créer une caisse</a>
        </div>
    </c:if>
</div>

<script>
	function toggleCaisseStatus(caisseId, caisseNom, isActive) {
	    const action = isActive ? 'désactiver' : 'activer';

	    showConfirmation(
	        'Changer le statut',
	        'Voulez-vous ' + action + ' la caisse "' + caisseNom + '" ?',
	        function() { window.location.href = '/caisses/toggle/' + caisseId; },
	        true
	    );
	}

// Filtrage en temps réel
document.getElementById('searchInput').addEventListener('input', filterCaisses);
document.getElementById('statusFilter').addEventListener('change', filterCaisses);

function filterCaisses() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    const status = document.getElementById('statusFilter').value;

    document.querySelectorAll('.caisse-row').forEach(row => {
        const rowStatus = row.getAttribute('data-status');
        const rowSearch = row.getAttribute('data-search').toLowerCase();

        const statusMatch = !status || rowStatus === status;
        const searchMatch = !search || rowSearch.includes(search);

        row.style.display = (statusMatch && searchMatch) ? '' : 'none';
    });

    // Mettre à jour le compteur
    const visibleRows = document.querySelectorAll('.caisse-row[style=""]').length;
    const totalRows = document.querySelectorAll('.caisse-row').length;
    document.querySelector('.filters div:last-child').textContent = `📊 ${visibleRows} caisses trouvées`;
}

// Initialisation
document.addEventListener('DOMContentLoaded', function() {
    filterCaisses();
});
</script>

<style>
.filters input:focus {
    outline: none;
    border-color: #4361ee !important;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}

.filters select:focus {
    outline: none;
    border-color: #4361ee !important;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}

.table-container {
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table th {
    background: linear-gradient(135deg, #4361ee, #3a0ca3);
    color: white;
    padding: 1.25rem;
    text-align: left;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-size: 0.9rem;
}

.data-table td {
    padding: 1.25rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.data-table tr:hover {
    background: rgba(67, 97, 238, 0.05);
    transform: scale(1.01);
    transition: all 0.2s ease;
}

.data-table tr:last-child td {
    border-bottom: none;
}

.status-badge.active {
    background: #d4edda;
    color: #155724;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 600;
}

.status-badge.inactive {
    background: #f8d7da;
    color: #721c24;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 600;
}

.btn {
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    text-decoration: none;
    border-radius: 20px;
    font-weight: 600;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.btn-info { background: #17a2b8; color: white; }
.btn-warning { background: #ffc107; color: #212529; }
.btn-success { background: #28a745; color: white; }
.btn-danger { background: #dc3545; color: white; }
.btn-secondary { background: #6c757d; color: white; }
</style>

<%@ include file="../includes/footer.jsp" %>