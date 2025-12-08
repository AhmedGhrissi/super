<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles pour la gestion des utilisateurs */
.rapports-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.rapports-header-modern {
    background: linear-gradient(135deg, #06d6a0, #118ab2);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(6, 214, 160, 0.2);
}

.rapports-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.rapports-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.rapports-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.rapports-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

.period-badge {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    padding: 0.5rem 1.5rem;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 600;
}

/* Cartes de statistiques */
.stats-grid-rapports {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card-rapports {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    text-align: center;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    transition: transform 0.3s ease;
}

.stat-card-rapports:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}

.stat-icon-rapports {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.stat-value-rapports {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.stat-label-rapports {
    font-size: 1.1rem;
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
}

.stat-period-rapports {
    font-size: 0.9rem;
    color: #6c757d;
}

/* Graphique rôles */
.roles-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.roles-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.roles-header-rapports h2 {
    margin: 0;
    color: #06d6a0;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.roles-grid-rapports {
    padding: 1.5rem;
    display: flex;
    flex-wrap: wrap;
    gap: 2rem;
    justify-content: center;
}

.role-item-rapports {
    text-align: center;
    min-width: 120px;
}

.role-circle-rapports {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto;
    color: white;
    font-weight: bold;
    font-size: 1rem;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    margin-bottom: 0.75rem;
}

.role-name-rapports {
    font-weight: 600;
    font-size: 0.9rem;
    color: #343a40;
    margin-bottom: 0.25rem;
}

.role-count-rapports {
    font-size: 0.8rem;
    color: #6c757d;
}

/* Section filtres */
.filters-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.filters-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.filters-header-rapports h2 {
    margin: 0;
    color: #06d6a0;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.filters-grid-rapports {
    padding: 1.5rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
}

.filter-group-rapports {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.filter-label-rapports {
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
}

.filter-input-rapports {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 0.9rem;
    background: white;
    transition: all 0.3s ease;
}

.filter-input-rapports:focus {
    outline: none;
    border-color: #06d6a0;
    box-shadow: 0 0 0 3px rgba(6, 214, 160, 0.1);
}

.filter-select-rapports {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 0.9rem;
    background: white;
    cursor: pointer;
    transition: all 0.3s ease;
}

.filter-select-rapports:focus {
    outline: none;
    border-color: #06d6a0;
    box-shadow: 0 0 0 3px rgba(6, 214, 160, 0.1);
}

/* Tableau moderne */
.table-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.table-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.table-header-rapports h2 {
    margin: 0;
    color: #06d6a0;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.table-container-rapports {
    overflow-x: auto;
    padding: 1.5rem;
}

.data-table-rapports {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.9rem;
}

.data-table-rapports thead {
    background: #06d6a0;
    color: white;
}

.data-table-rapports th {
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    white-space: nowrap;
}

.data-table-rapports th:first-child {
    border-radius: 8px 0 0 0;
}

.data-table-rapports th:last-child {
    border-radius: 0 8px 0 0;
}

.data-table-rapports td {
    padding: 1rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.data-table-rapports tbody tr {
    transition: all 0.2s ease;
}

.data-table-rapports tbody tr:hover {
    background: #f8f9fa;
}

/* Badges */
.badge-role {
    background: rgba(108, 117, 125, 0.1);
    color: #495057;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-active {
    background: rgba(40, 167, 69, 0.1);
    color: #28a745;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-inactive {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

/* Boutons d'action dans le tableau */
.btn-table-action {
    padding: 0.4rem 0.8rem;
    border: none;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    font-size: 0.75rem;
    transition: all 0.3s ease;
}

.btn-edit {
    background: rgba(255, 193, 7, 0.1);
    color: #ffc107;
}

.btn-edit:hover {
    background: #ffc107;
    color: white;
    transform: translateY(-1px);
}

.btn-activate {
    background: rgba(40, 167, 69, 0.1);
    color: #28a745;
}

.btn-activate:hover {
    background: #28a745;
    color: white;
    transform: translateY(-1px);
}

.btn-deactivate {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
}

.btn-deactivate:hover {
    background: #dc3545;
    color: white;
    transform: translateY(-1px);
}

.btn-reset {
    background: rgba(108, 117, 125, 0.1);
    color: #6c757d;
}

.btn-reset:hover {
    background: #6c757d;
    color: white;
    transform: translateY(-1px);
}

/* Actions */
.actions-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
}

.actions-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.actions-header-rapports h2 {
    margin: 0;
    color: #06d6a0;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.actions-grid-rapports {
    padding: 1.5rem;
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
}

.action-button-rapports {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    border-radius: 12px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
}

.action-button-rapports.primary {
    background: linear-gradient(135deg, #06d6a0, #118ab2);
    color: white;
}

.action-button-rapports.secondary {
    background: linear-gradient(135deg, #4361ee, #3a0ca3);
    color: white;
}

.action-button-rapports:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.2);
    text-decoration: none;
}

/* Back button */
.back-button-rapports {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    background: #6c757d;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    margin-top: 2rem;
}

.back-button-rapports:hover {
    background: #5a6268;
    transform: translateY(-2px);
    text-decoration: none;
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .rapports-container {
        padding: 1rem;
    }

    .rapports-title-section {
        flex-direction: column;
    }

    .stats-grid-rapports {
        grid-template-columns: 1fr;
    }

    .roles-grid-rapports {
        gap: 1rem;
    }

    .role-item-rapports {
        min-width: 100px;
    }

    .filters-grid-rapports {
        grid-template-columns: 1fr;
    }

    .actions-grid-rapports {
        flex-direction: column;
    }

    .action-button-rapports {
        width: 100%;
        justify-content: center;
    }

    .table-container-rapports {
        overflow-x: auto;
    }

    .data-table-rapports {
        min-width: 800px;
    }
}
</style>

<div class="rapports-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="rapports-header-modern">
        <div class="rapports-title-section">
            <div>
                <div class="rapports-title">
                    <h1>👥 Gestion des Utilisateurs</h1>
                </div>
                <p class="rapports-subtitle">Administration complète des comptes et permissions</p>
            </div>
            <div class="period-badge">
                📊 ${users.size()} utilisateurs
            </div>
        </div>
    </div>

    <!-- ========== CARTES DE STATISTIQUES ========== -->
    <div class="stats-grid-rapports">
        <!-- Total utilisateurs -->
        <div class="stat-card-rapports animate-fade-in-up">
            <div class="stat-icon-rapports">👥</div>
            <div class="stat-value-rapports" style="color: #06d6a0;">${totalUsers}</div>
            <div class="stat-label-rapports">Utilisateurs Totaux</div>
            <div class="stat-period-rapports">Système</div>
        </div>

        <!-- Utilisateurs actifs -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.1s;">
            <div class="stat-icon-rapports">✅</div>
            <div class="stat-value-rapports" style="color: #28a745;">${activeUsers}</div>
            <div class="stat-label-rapports">Utilisateurs Actifs</div>
            <div class="stat-period-rapports">Actuellement</div>
        </div>

        <!-- Utilisateurs inactifs -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.2s;">
            <div class="stat-icon-rapports">❌</div>
            <div class="stat-value-rapports" style="color: #dc3545;">${totalUsers - activeUsers}</div>
            <div class="stat-label-rapports">Utilisateurs Inactifs</div>
            <div class="stat-period-rapports">À activer</div>
        </div>

        <!-- Rôles différents -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.3s; background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white;">
            <div class="stat-icon-rapports">🎯</div>
            <div class="stat-value-rapports">6</div>
            <div class="stat-label-rapports">Rôles Différents</div>
            <div class="stat-period-rapports" style="color: rgba(255,255,255,0.9);">Types</div>
        </div>
    </div>

    <!-- ========== RÉPARTITION DES RÔLES ========== -->
    <div class="roles-section-rapports">
        <div class="roles-header-rapports">
            <h2>📊 Répartition des Rôles</h2>
        </div>
        <div class="roles-grid-rapports">
            <!-- Comptage des rôles -->
            <c:set var="superAdminCount" value="0" />
            <c:set var="superviseurCount" value="0" />
            <c:set var="technicienCount" value="0" />
            <c:set var="operateurCount" value="0" />
            <c:set var="auditeurCount" value="0" />
            <c:set var="consultantCount" value="0" />

            <c:forEach var="user" items="${users}">
                <c:choose>
                    <c:when test="${user.role == 'SUPER_ADMIN'}"><c:set var="superAdminCount" value="${superAdminCount + 1}" /></c:when>
                    <c:when test="${user.role == 'SUPERVISEUR'}"><c:set var="superviseurCount" value="${superviseurCount + 1}" /></c:when>
                    <c:when test="${user.role == 'TECHNICIEN'}"><c:set var="technicienCount" value="${technicienCount + 1}" /></c:when>
                    <c:when test="${user.role == 'OPERATEUR'}"><c:set var="operateurCount" value="${operateurCount + 1}" /></c:when>
                    <c:when test="${user.role == 'AUDITEUR'}"><c:set var="auditeurCount" value="${auditeurCount + 1}" /></c:when>
                    <c:when test="${user.role == 'CONSULTANT'}"><c:set var="consultantCount" value="${consultantCount + 1}" /></c:when>
                </c:choose>
            </c:forEach>

            <!-- Affichage des rôles -->
            <c:if test="${superAdminCount > 0}">
                <div class="role-item-rapports">
                    <div class="role-circle-rapports" style="background: linear-gradient(135deg, #e83e8c, #d0006f);">
                        <fmt:formatNumber value="${(superAdminCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div class="role-name-rapports">SUPER_ADMIN</div>
                    <div class="role-count-rapports">${superAdminCount} utilisateur(s)</div>
                </div>
            </c:if>

            <c:if test="${superviseurCount > 0}">
                <div class="role-item-rapports">
                    <div class="role-circle-rapports" style="background: linear-gradient(135deg, #6f42c1, #4a1d96);">
                        <fmt:formatNumber value="${(superviseurCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div class="role-name-rapports">SUPERVISEUR</div>
                    <div class="role-count-rapports">${superviseurCount} utilisateur(s)</div>
                </div>
            </c:if>

            <c:if test="${technicienCount > 0}">
                <div class="role-item-rapports">
                    <div class="role-circle-rapports" style="background: linear-gradient(135deg, #fd7e14, #e85d04);">
                        <fmt:formatNumber value="${(technicienCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div class="role-name-rapports">TECHNICIEN</div>
                    <div class="role-count-rapports">${technicienCount} utilisateur(s)</div>
                </div>
            </c:if>

            <c:if test="${operateurCount > 0}">
                <div class="role-item-rapports">
                    <div class="role-circle-rapports" style="background: linear-gradient(135deg, #20c997, #139675);">
                        <fmt:formatNumber value="${(operateurCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div class="role-name-rapports">OPERATEUR</div>
                    <div class="role-count-rapports">${operateurCount} utilisateur(s)</div>
                </div>
            </c:if>

            <c:if test="${auditeurCount > 0}">
                <div class="role-item-rapports">
                    <div class="role-circle-rapports" style="background: linear-gradient(135deg, #4361ee, #3a0ca3);">
                        <fmt:formatNumber value="${(auditeurCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div class="role-name-rapports">AUDITEUR</div>
                    <div class="role-count-rapports">${auditeurCount} utilisateur(s)</div>
                </div>
            </c:if>

            <c:if test="${consultantCount > 0}">
                <div class="role-item-rapports">
                    <div class="role-circle-rapports" style="background: linear-gradient(135deg, #ff6b6b, #ff3838);">
                        <fmt:formatNumber value="${(consultantCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div class="role-name-rapports">CONSULTANT</div>
                    <div class="role-count-rapports">${consultantCount} utilisateur(s)</div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- ========== FILTRES ========== -->
    <div class="filters-section-rapports">
        <div class="filters-header-rapports">
            <h2>🔍 Recherche et Filtres</h2>
        </div>
        <div class="filters-grid-rapports">
            <div class="filter-group-rapports">
                <label class="filter-label-rapports">🔎 Recherche</label>
                <input type="text" id="searchInput" class="filter-input-rapports"
                       placeholder="Nom, email, rôle...">
            </div>

            <div class="filter-group-rapports">
                <label class="filter-label-rapports">📊 Statut</label>
                <select id="statusFilter" class="filter-select-rapports">
                    <option value="">Tous les statuts</option>
                    <option value="active">✅ Actifs</option>
                    <option value="inactive">❌ Inactifs</option>
                </select>
            </div>

            <div class="filter-group-rapports">
                <label class="filter-label-rapports">🎯 Rôle</label>
                <select id="roleFilter" class="filter-select-rapports">
                    <option value="">Tous les rôles</option>
                    <option value="SUPER_ADMIN">SUPER_ADMIN</option>
                    <option value="SUPERVISEUR">SUPERVISEUR</option>
                    <option value="TECHNICIEN">TECHNICIEN</option>
                    <option value="OPERATEUR">OPERATEUR</option>
                    <option value="AUDITEUR">AUDITEUR</option>
                    <option value="CONSULTANT">CONSULTANT</option>
                </select>
            </div>
        </div>
        <div style="padding: 0 1.5rem 1.5rem 1.5rem; display: flex; justify-content: space-between; align-items: center;">
            <div style="color: #6c757d; font-weight: 600;">
                📊 ${users.size()} utilisateurs trouvés
            </div>
            <div style="display: flex; gap: 0.75rem;">
                <button onclick="applyFilters()" class="action-button-rapports primary">
                    <span>🔍</span>
                    <span>Appliquer</span>
                </button>
                <button onclick="resetFilters()" class="action-button-rapports secondary">
                    <span>🔄</span>
                    <span>Réinitialiser</span>
                </button>
            </div>
        </div>
    </div>

    <!-- ========== TABLEAU ========== -->
    <div class="table-section-rapports">
        <div class="table-header-rapports">
            <h2>📋 Liste des Utilisateurs</h2>
        </div>
        <div class="table-container-rapports">
            <table class="data-table-rapports">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Utilisateur</th>
                        <th>Nom Complet</th>
                        <th>Email</th>
                        <th>Rôle</th>
                        <th>Statut</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty users and users.size() > 0}">
                            <c:forEach var="user" items="${users}">
                                <tr class="user-row"
                                    data-id="${user.id}"
                                    data-username="${user.username}"
                                    data-nom="${user.nomComplet}"
                                    data-email="${user.email}"
                                    data-role="${user.role}"
                                    data-status="${user.actif ? 'active' : 'inactive'}"
                                    data-search="${user.id} ${user.username} ${user.nomComplet} ${user.email} ${user.role}">
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                                            <div style="width: 8px; height: 8px; border-radius: 50%;
                                                 background: ${user.actif ? '#28a745' : '#dc3545'};"></div>
                                            <strong style="color: #06d6a0;">${user.id}</strong>
                                        </div>
                                    </td>

                                    <td>
                                        <div style="font-weight: 600; color: #343a40;">${user.username}</div>
                                    </td>

                                    <td>${user.nomComplet}</td>

                                    <td>
                                        <div style="color: #4361ee; font-weight: 500;">${user.email}</div>
                                    </td>

                                    <td>
                                        <span class="badge-role">${user.role}</span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${user.actif}">
                                                <span class="badge-active">✅ Actif</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-inactive">❌ Inactif</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td style="text-align: center;">
                                        <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                            <!-- Bouton Édition -->
                                            <button onclick="showEditModal(${user.id}, '${user.username}', '${user.nomComplet}', '${user.email}', '${user.role}', ${user.actif})"
                                                    class="btn-table-action btn-edit"
                                                    title="Modifier">
                                                ✏️
                                            </button>

                                            <!-- Boutons Activation/Désactivation -->
                                            <c:choose>
                                                <c:when test="${user.actif}">
                                                    <form action="/admin/users/${user.id}/deactivate" method="post"
                                                          style="display: inline; margin: 0;"
                                                          onsubmit="return confirm('Désactiver l\\'utilisateur ${user.username} ?')">
                                                        <button type="submit"
                                                                class="btn-table-action btn-deactivate"
                                                                title="Désactiver">
                                                            ⏸️
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="/admin/users/${user.id}/activate" method="post"
                                                          style="display: inline; margin: 0;"
                                                          onsubmit="return confirm('Activer l\\'utilisateur ${user.username} ?')">
                                                        <button type="submit"
                                                                class="btn-table-action btn-activate"
                                                                title="Activer">
                                                            ▶️
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Bouton Réinitialisation mot de passe -->
                                            <button onclick="showResetModal(${user.id}, '${user.username}')"
                                                    class="btn-table-action btn-reset"
                                                    title="Réinitialiser mot de passe">
                                                🔑
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 3rem;">
                                    <div style="font-size: 4rem; margin-bottom: 1rem; opacity: 0.3;">👥</div>
                                    <h4 style="color: #6c757d; margin-bottom: 1rem;">Aucun utilisateur trouvé</h4>
                                    <p style="color: #8d99ae; margin-bottom: 2rem;">
                                        Commencez par créer votre premier utilisateur
                                    </p>
                                    <button onclick="showCreateModal()" class="action-button-rapports primary">
                                        <span>➕</span>
                                        <span>Créer un utilisateur</span>
                                    </button>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ========== ACTIONS ========== -->
    <div class="actions-section-rapports">
        <div class="actions-header-rapports">
            <h2>🚀 Actions</h2>
        </div>
        <div class="actions-grid-rapports">
            <button onclick="showCreateModal()" class="action-button-rapports primary">
                <span>➕</span>
                <span>Nouvel Utilisateur</span>
            </button>

            <a href="/dashboard" class="action-button-rapports secondary">
                <span>🏠</span>
                <span>Retour au Dashboard</span>
            </a>
        </div>
    </div>

    <!-- ========== BOUTON RETOUR ========== -->
    <a href="/dashboard" class="back-button-rapports">
        ← Retour au Dashboard
    </a>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('Gestion utilisateurs initialisée');

    // Animation des cartes
    const cards = document.querySelectorAll('.stat-card-rapports');
    cards.forEach((card, index) => {
        card.style.animationDelay = (index * 0.1) + 's';
    });
});

// Fonctions de filtrage
function applyFilters() {
    var search = document.getElementById('searchInput').value.toLowerCase();
    var status = document.getElementById('statusFilter').value;
    var role = document.getElementById('roleFilter').value;

    var visibleCount = 0;

    document.querySelectorAll('.user-row').forEach(function(row) {
        var rowStatus = row.getAttribute('data-status');
        var rowRole = row.getAttribute('data-role');
        var rowSearch = row.getAttribute('data-search').toLowerCase();

        var statusMatch = !status || rowStatus == status;
        var roleMatch = !role || rowRole == role;
        var searchMatch = !search || rowSearch.indexOf(search) > -1;

        if (statusMatch && roleMatch && searchMatch) {
            row.style.display = '';
            visibleCount++;
        } else {
            row.style.display = 'none';
        }
    });

    alert('📊 ' + visibleCount + ' utilisateurs trouvés');
}

function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('statusFilter').value = '';
    document.getElementById('roleFilter').value = '';
    applyFilters();
}

// Fonctions de modal (simples pour l'exemple)
function showCreateModal() {
    alert('Fonctionnalité de création d\'utilisateur');
}

function showEditModal(userId, username, nomComplet, email, role, actif) {
    alert('Modification de l\'utilisateur: ' + username);
}

function showResetModal(userId, username) {
    if (confirm('Réinitialiser le mot de passe pour ' + username + ' ?')) {
        alert('Mot de passe réinitialisé pour ' + username);
    }
}
</script>

<jsp:include page="../includes/footer.jsp" />