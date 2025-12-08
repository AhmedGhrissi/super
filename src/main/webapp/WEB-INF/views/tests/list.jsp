<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles pour la liste des tests */
.tests-container {
    max-width: 1600px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.tests-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.tests-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.tests-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.tests-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.tests-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

.tests-stats-badge {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    padding: 0.5rem 1.5rem;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 600;
}

/* Filtres */
.filters-tests-modern {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.filters-grid-tests {
    display: flex;
    gap: 1rem;
    align-items: center;
    flex-wrap: wrap;
}

.search-container-tests {
    position: relative;
    flex: 1;
    min-width: 300px;
}

.search-input-tests {
    width: 100%;
    padding: 0.75rem 1rem 0.75rem 3rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 0.95rem;
    transition: all 0.3s ease;
}

.search-input-tests:focus {
    outline: none;
    border-color: #006747;
    box-shadow: 0 0 0 3px rgba(0, 103, 71, 0.1);
}

.search-icon-tests {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: #6c757d;
}

.filter-select-tests {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    background: white;
    cursor: pointer;
    font-size: 0.95rem;
    min-width: 150px;
}

.filter-select-tests:focus {
    outline: none;
    border-color: #006747;
}

.results-count-tests {
    color: #495057;
    font-weight: 600;
    padding: 0.75rem 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

/* Table moderne */
.table-tests-modern {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.table-header-tests {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    padding: 1.5rem;
}

.table-header-tests h2 {
    margin: 0;
    font-size: 1.25rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.table-container-tests {
    overflow-x: auto;
}

.data-table-tests {
    width: 100%;
    border-collapse: collapse;
    min-width: 1000px;
}

.data-table-tests th {
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    color: #495057;
    border-bottom: 2px solid #e9ecef;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    background: #f8f9fa;
}

.data-table-tests td {
    padding: 1rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.data-table-tests tbody tr:hover {
    background-color: #f8f9fa;
}

/* Indicateur de statut */
.status-indicator-tests {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    display: inline-block;
    margin-right: 0.5rem;
}

.status-active-tests {
    background: #06d6a0;
}

.status-inactive-tests {
    background: #ef476f;
}

/* Badges de type */
.type-badge-tests {
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    color: white;
}

.type-HTTP { background: linear-gradient(135deg, #3498db, #2980b9); }
.type-HTTPS { background: linear-gradient(135deg, #2ecc71, #27ae60); }
.type-TCP { background: linear-gradient(135deg, #e74c3c, #c0392b); }
.type-PING { background: linear-gradient(135deg, #f39c12, #d35400); }
.type-DATABASE { background: linear-gradient(135deg, #9b59b6, #8e44ad); }

/* Badge méthode */
.method-badge-tests {
    background: linear-gradient(135deg, #4cc9f0, #4361ee);
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
}

/* Badge port */
.port-badge-tests {
    background: linear-gradient(135deg, #7209b7, #3a0ca3);
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
}

/* Badge statut */
.status-badge-tests {
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
}

.status-active {
    background: #d4edda;
    color: #155724;
}

.status-inactive {
    background: #f8d7da;
    color: #721c24;
}

/* Boutons d'action */
.actions-grid-tests {
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.btn-action-tests {
    padding: 0.4rem 0.8rem;
    border-radius: 6px;
    font-size: 0.8rem;
    font-weight: 500;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    transition: all 0.2s ease;
    border: none;
    cursor: pointer;
}

.btn-view-tests {
    background: #e3f2fd;
    color: #1976d2;
    border: 1px solid #bbdefb;
}

.btn-view-tests:hover {
    background: #bbdefb;
    transform: translateY(-1px);
}

.btn-edit-tests {
    background: #fff3e0;
    color: #ef6c00;
    border: 1px solid #ffe0b2;
}

.btn-edit-tests:hover {
    background: #ffe0b2;
    transform: translateY(-1px);
}

.btn-toggle-tests {
    background: #e8f5e9;
    color: #2e7d32;
    border: 1px solid #c8e6c9;
}

.btn-toggle-tests:hover {
    background: #c8e6c9;
    transform: translateY(-1px);
}

.btn-toggle-tests.inactive {
    background: #ffebee;
    color: #d32f2f;
    border: 1px solid #ffcdd2;
}

.btn-toggle-tests.inactive:hover {
    background: #ffcdd2;
    transform: translateY(-1px);
}

/* Empty state */
.empty-state-tests {
    text-align: center;
    padding: 4rem 2rem;
}

.empty-state-icon-tests {
    font-size: 4rem;
    margin-bottom: 1.5rem;
    opacity: 0.5;
}

.empty-state-tests h3 {
    color: #6c757d;
    margin-bottom: 1rem;
    font-size: 1.5rem;
}

.empty-state-tests p {
    color: #8d99ae;
    margin-bottom: 2rem;
    font-size: 1rem;
}

/* Bouton création */
.btn-create-tests {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-create-tests:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
    text-decoration: none;
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .tests-container {
        padding: 1rem;
    }

    .tests-title-section {
        flex-direction: column;
    }

    .filters-grid-tests {
        flex-direction: column;
        align-items: stretch;
    }

    .search-container-tests {
        min-width: 100%;
    }

    .filter-select-tests {
        width: 100%;
    }

    .actions-grid-tests {
        justify-content: center;
    }
}
</style>

<div class="tests-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="tests-header-modern">
        <div class="tests-title-section">
            <div>
                <div class="tests-title">
                    <h1>🧪 Tests Standards</h1>
                </div>
                <p class="tests-subtitle">Gestion et configuration des tests automatisés</p>
            </div>
            <div class="tests-stats-badge">
                <c:set var="activeTests" value="${tests.stream().filter(t -> t.actif).count()}" />
                📊 ${tests.size()} tests • ${activeTests} actifs • ${tests.size() - activeTests} inactifs
            </div>
        </div>
    </div>

    <!-- ========== FILTRES ========== -->
    <div class="filters-tests-modern">
        <div class="filters-grid-tests">
            <div class="search-container-tests">
                <span class="search-icon-tests">🔍</span>
                <input type="text" id="searchInput" placeholder="Rechercher un test..."
                       class="search-input-tests">
            </div>

            <select id="typeFilter" class="filter-select-tests">
                <option value="">Tous les types</option>
                <option value="HTTP">HTTP</option>
                <option value="HTTPS">HTTPS</option>
                <option value="TCP">TCP</option>
                <option value="PING">PING</option>
                <option value="DATABASE">Base de données</option>
            </select>

            <select id="statusFilter" class="filter-select-tests">
                <option value="">Tous les statuts</option>
                <option value="actif">✅ Actifs</option>
                <option value="inactif">❌ Inactifs</option>
            </select>

            <div class="results-count-tests">
                📊 <span id="resultsCount">${tests.size()}</span> tests trouvés
            </div>
        </div>
    </div>

    <!-- ========== TABLEAU DES TESTS ========== -->
    <div class="table-tests-modern">
        <div class="table-header-tests">
            <h2>📋 Liste des Tests</h2>
        </div>

        <div class="table-container-tests">
            <table class="data-table-tests">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Nom</th>
                        <th>Type</th>
                        <th>Méthode</th>
                        <th>Endpoint</th>
                        <th>Port</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="testsTableBody">
                    <c:if test="${empty tests}">
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 3rem;">
                                <div class="empty-state-tests">
                                    <div class="empty-state-icon-tests">🧪</div>
                                    <h3>Aucun test trouvé</h3>
                                    <p>Commencez par créer votre premier test</p>
                                    <a href="/tests/creer" class="btn-create-tests">
                                        ➕ Créer un test
                                    </a>
                                </div>
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
                                    <span class="status-indicator-tests ${test.actif ? 'status-active-tests' : 'status-inactive-tests'}"></span>
                                    <strong style="color: #006747;">${test.codeTest}</strong>
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
                                <span class="type-badge-tests type-${test.typeTest}">
                                    ${test.typeTest}
                                </span>
                            </td>
                            <td>
                                <span class="method-badge-tests">
                                    ${test.methodeHttp}
                                </span>
                            </td>
                            <td style="max-width: 200px;">
                                <div style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                    ${test.endpoint}
                                </div>
                            </td>
                            <td>
                                <c:if test="${not empty test.port}">
                                    <span class="port-badge-tests">
                                        ${test.port}
                                    </span>
                                </c:if>
                            </td>
                            <td>
                                <span class="status-badge-tests ${test.actif ? 'status-active' : 'status-inactive'}">
                                    ${test.actif ? '✅ Actif' : '❌ Inactif'}
                                </span>
                            </td>
                            <td>
                                <div class="actions-grid-tests">
                                    <a href="/tests/details/${test.id}" class="btn-action-tests btn-view-tests">
                                        <span>👁️</span> Voir
                                    </a>
                                    <a href="/tests/modifier/${test.id}" class="btn-action-tests btn-edit-tests">
                                        <span>✏️</span> Modifier
                                    </a>
                                    <button onclick="toggleTestStatus(${test.id}, '${test.nomTest}', ${test.actif})"
                                            class="btn-action-tests btn-toggle-tests ${test.actif ? '' : 'inactive'}">
                                        <span>${test.actif ? '⏸️' : '▶️'}</span>
                                        ${test.actif ? 'Désactiver' : 'Activer'}
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
// Filtrage en temps réel
document.getElementById('searchInput').addEventListener('input', filterTests);
document.getElementById('typeFilter').addEventListener('change', filterTests);
document.getElementById('statusFilter').addEventListener('change', filterTests);

function filterTests() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    const type = document.getElementById('typeFilter').value;
    const status = document.getElementById('statusFilter').value;

    const rows = document.querySelectorAll('.test-row');
    let visibleCount = 0;

    rows.forEach(row => {
        const rowType = row.getAttribute('data-type');
        const rowStatus = row.getAttribute('data-status');
        const rowSearch = row.getAttribute('data-search').toLowerCase();

        const typeMatch = !type || rowType === type;
        const statusMatch = !status || rowStatus === status;
        const searchMatch = !search || rowSearch.includes(search);

        const shouldShow = typeMatch && statusMatch && searchMatch;
        row.style.display = shouldShow ? '' : 'none';

        if (shouldShow) visibleCount++;
    });

    // Mettre à jour le compteur
    document.getElementById('resultsCount').textContent = visibleCount;

    // Afficher l'état vide si aucun résultat
    const emptyState = document.querySelector('.empty-state-tests');
    if (emptyState && visibleCount === 0) {
        emptyState.style.display = 'block';
    }
}

// Toggle du statut du test
function toggleTestStatus(testId, testNom, isActive) {
    const action = isActive ? 'désactiver' : 'activer';

    if (confirm(`Voulez-vous ${action} le test "${testNom}" ?`)) {
        // Redirection vers le contrôleur
        window.location.href = '/tests/toggle/' + testId;
    }
}

// Initialisation
document.addEventListener('DOMContentLoaded', function() {
    filterTests(); // Appliquer les filtres initiaux

    // Animation des lignes
    const rows = document.querySelectorAll('.test-row');
    rows.forEach((row, index) => {
        row.style.animationDelay = `${index * 0.05}s`;
        row.classList.add('animate-fade-in-up');
    });
});

// Fonction de notification
// Fonction de notification compatible EL
window.showNotification = function(message, type) {
    // Valeur par défaut
    if (!type) type = 'info';

    // Déterminer l'icône (pas de ===, utiliser ==)
    var icon = 'ℹ️';
    if (type == 'success') icon = '✅';
    if (type == 'error') icon = '❌';
    if (type == 'warning') icon = '⚠️';

    // Créer la notification
    var notification = document.createElement('div');
    notification.className = 'notification ' + type;
    notification.innerHTML = '<span style="font-size: 1.2rem;">' + icon + '</span><span>' + message + '</span>';

    document.body.appendChild(notification);

    // Auto-suppression
    setTimeout(function() {
        if (notification.parentNode) {
            notification.parentNode.removeChild(notification);
        }
    }, 3000);
};

// Fonction de confirmation
window.showConfirmation = function(title, message, callback, danger) {
    if (confirm(title + ': ' + message)) {
        callback();
    }
};
</script>
<jsp:include page="../includes/footer.jsp" />