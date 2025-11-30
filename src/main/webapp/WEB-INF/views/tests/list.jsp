
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>🧪 Tests Standards</h2>
        <a href="/tests/creer" class="btn btn-primary">➕ Nouveau Test</a>
    </div>

    <!-- Indicateur de statut -->
    <div style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 1rem;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <strong>📊 ${tests.size()} tests</strong>
                <div style="font-size: 0.9rem; opacity: 0.9;">
                    <c:set var="activeTests" value="${tests.stream().filter(t -> t.actif).count()}" />
                    ${activeTests} actifs • ${tests.size() - activeTests} inactifs
                </div>
            </div>
            <div style="font-size: 0.8rem; background: rgba(255,255,255,0.2); padding: 0.25rem 0.75rem; border-radius: 15px;">
                🟢 Système opérationnel
            </div>
        </div>
    </div>

    <!-- Filtres et recherche -->
    <div class="filters" style="margin-bottom: 2rem; display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
        <div style="position: relative; flex: 1; min-width: 300px;">
            <input type="text" id="searchInput" placeholder="🔍 Rechercher un test..."
                   style="width: 100%; padding: 0.75rem 1rem 0.75rem 3rem; border: 2px solid #e9ecef; border-radius: 25px; font-size: 1rem; transition: all 0.3s ease;">
        </div>

        <select id="typeFilter" style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer;">
            <option value="">Tous les types</option>
            <option value="HTTP">HTTP</option>
            <option value="HTTPS">HTTPS</option>
            <option value="TCP">TCP</option>
            <option value="PING">PING</option>
            <option value="DATABASE">Base de données</option>
        </select>

        <select id="statusFilter" style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer;">
            <option value="">Tous les statuts</option>
            <option value="actif">✅ Actifs</option>
            <option value="inactif">❌ Inactifs</option>
        </select>

        <div style="color: #6c757d; font-weight: 600;">
            📊 ${tests.size()} tests trouvés
        </div>
    </div>

    <!-- Tableau moderne -->
    <div class="table-container">
        <table class="data-table">
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Nom</th>
                    <th>Type</th>
                    <th>Méthode</th>
                    <th>Endpoint</th>
                    <th>Port</th>
                    <th>Statut</th>
                    <th style="text-align: center;">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty tests}">
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 3rem;">
                            <div style="font-size: 4rem; margin-bottom: 1rem;">🧪</div>
                            <h3 style="color: #6c757d; margin-bottom: 1rem;">Aucun test trouvé</h3>
                            <p style="color: #8d99ae; margin-bottom: 2rem;">Commencez par créer votre premier test</p>
                            <a href="/tests/creer" class="btn btn-primary">➕ Créer un test</a>
                        </td>
                    </tr>
                </c:if>

                <c:forEach var="test" items="${tests}">
                    <tr class="test-row"
                        data-type="${test.typeTest}"
                        data-status="${test.actif ? 'actif' : 'inactif'}"
                        data-search="${test.codeTest} ${test.nomTest} ${test.description} ${test.typeTest}">
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.5rem;">
                                <div style="width: 8px; height: 8px; border-radius: 50%; background: ${test.actif ? '#06d6a0' : '#ef476f'};"></div>
                                <strong style="color: #4361ee;">${test.codeTest}</strong>
                            </div>
                        </td>
                        <td>
                            <div style="font-weight: 600;">${test.nomTest}</div>
                            <c:if test="${not empty test.description}">
                                <div style="font-size: 0.8rem; color: #6c757d; margin-top: 0.25rem;">
                                    ${test.description}
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <span class="type-badge type-${test.typeTest}">
                                ${test.typeTest}
                            </span>
                        </td>
                        <td>
                            <span style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                                ${test.methodeHttp}
                            </span>
                        </td>
                        <td class="endpoint-cell">
                            <div style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                ${test.endpoint}
                            </div>
                        </td>
                        <td>
                            <c:if test="${not empty test.port}">
                                <span style="background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                                    ${test.port}
                                </span>
                            </c:if>
                        </td>
                        <td>
                            <span class="status-badge ${test.actif ? 'active' : 'inactive'}">
                                ${test.actif ? '✅ Actif' : '❌ Inactif'}
                            </span>
                        </td>
                        <td style="text-align: center;">
                            <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                <a href="/tests/details/${test.id}" class="btn btn-info" style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                    👁️ Voir
                                </a>
                                <a href="/tests/modifier/${test.id}" class="btn btn-warning" style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                    ✏️ Modifier
                                </a>
								<button onclick="toggleTestStatus(${test.id}, '${test.nomTest}', ${test.actif})"
								        class="btn ${test.actif ? 'btn-danger' : 'btn-success'}"
								        style="padding: 0.5rem 1rem; font-size: 0.8rem;">
								    ${test.actif ? '⏸️ Désactiver' : '▶️ Activer'}
								</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
	function toggleTestStatus(testId, testNom, isActive) {
	    const action = isActive ? 'désactiver' : 'activer';

	    showConfirmation(
	        'Changer le statut',
	        'Voulez-vous ' + action + ' le test "' + testNom + '" ?',
	        function() { window.location.href = '/tests/toggle/' + testId; },
	        true
	    );
	}

// Filtrage en temps réel
document.getElementById('searchInput').addEventListener('input', filterTests);
document.getElementById('typeFilter').addEventListener('change', filterTests);
document.getElementById('statusFilter').addEventListener('change', filterTests);

function filterTests() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    const type = document.getElementById('typeFilter').value;
    const status = document.getElementById('statusFilter').value;

    document.querySelectorAll('.test-row').forEach(row => {
        const rowType = row.getAttribute('data-type');
        const rowStatus = row.getAttribute('data-status');
        const rowSearch = row.getAttribute('data-search').toLowerCase();

        const typeMatch = !type || rowType === type;
        const statusMatch = !status || rowStatus === status;
        const searchMatch = !search || rowSearch.includes(search);

        row.style.display = (typeMatch && statusMatch && searchMatch) ? '' : 'none';
    });

    // Mettre à jour le compteur
    const visibleRows = document.querySelectorAll('.test-row[style=""]').length;
    const totalRows = document.querySelectorAll('.test-row').length;
    document.querySelector('.filters div:last-child').textContent = `📊 ${visibleRows} tests trouvés`;
}

// Initialisation
document.addEventListener('DOMContentLoaded', function() {
    filterTests();
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

.type-badge {
    padding: 0.25rem 0.75rem;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 600;
    color: white;
}

.type-HTTP { background: linear-gradient(135deg, #3498db, #2980b9); }
.type-HTTPS { background: linear-gradient(135deg, #2ecc71, #27ae60); }
.type-TCP { background: linear-gradient(135deg, #e74c3c, #c0392b); }
.type-PING { background: linear-gradient(135deg, #f39c12, #d35400); }
.type-DATABASE { background: linear-gradient(135deg, #9b59b6, #8e44ad); }

.endpoint-cell {
    max-width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
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
.btn-primary { background: #4361ee; color: white; }
</style>

<%@ include file="../includes/footer.jsp" %>