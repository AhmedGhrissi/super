<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>👥 Gestion des Utilisateurs</h2>
        <a href="#" class="btn btn-primary" onclick="showCreateModal()">➕ Nouvel Utilisateur</a>
    </div>

    <!-- Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success">
            <strong>✅ Succès:</strong>
            <c:choose>
                <c:when test="${param.success == 'created'}">Utilisateur créé</c:when>
                <c:when test="${param.success == 'deactivated'}">Utilisateur désactivé</c:when>
                <c:when test="${param.success == 'activated'}">Utilisateur activé</c:when>
                <c:otherwise>Opération réussie</c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- Cartes stats -->
    <div class="stats-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 2rem 0;">
		<div class="stat-card" style="background: linear-gradient(135deg, #4361ee, #3a0ca3); padding: 1.5rem; border-radius: 10px; text-align: center;">
		   <div class="stat-value" style="font-size: 2rem; font-weight: bold; color: #FFD700;">${totalUsers}</div>
		    <div class="stat-label" style="opacity: 0.9; color: #f8f9fa;">Total</div>
		</div>
        <div class="stat-card" style="background: linear-gradient(135deg, #06d6a0, #04a777); color: white; padding: 1.5rem; border-radius: 10px; text-align: center;">
            <div class="stat-value" style="font-size: 2rem; font-weight: bold;">${activeUsers}</div>
            <div class="stat-label" style="opacity: 0.9;">Actifs</div>
        </div>
        <div class="stat-card" style="background: linear-gradient(135deg, #7209b7, #560bad); color: white; padding: 1.5rem; border-radius: 10px; text-align: center;">
            <div class="stat-value" style="font-size: 2rem; font-weight: bold;">${totalUsers - activeUsers}</div>
            <div class="stat-label" style="opacity: 0.9;">Inactifs</div>
        </div>
    </div>

    <!-- GRAPHIQUE DES RÔLES -->
    <div class="card" style="background: white; border-radius: 10px; padding: 2rem; margin: 2rem 0; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <h3 style="color: #4361ee; margin-bottom: 1.5rem;">📊 Répartition des Rôles</h3>
        <div style="display: flex; flex-wrap: wrap; gap: 2rem; justify-content: center; padding: 1rem;">
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
                <div style="text-align: center;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #e83e8c, #d0006f); display: flex; align-items: center; justify-content: center; margin: 0 auto; color: white; font-weight: bold; font-size: 1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <fmt:formatNumber value="${(superAdminCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div style="margin-top: 0.5rem;">
                        <div style="font-weight: 600; font-size: 0.9rem;">SUPER_ADMIN</div>
                        <div style="color: #6c757d; font-size: 0.8rem;">${superAdminCount} utilisateur(s)</div>
                    </div>
                </div>
            </c:if>

            <c:if test="${superviseurCount > 0}">
                <div style="text-align: center;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #6f42c1, #4a1d96); display: flex; align-items: center; justify-content: center; margin: 0 auto; color: white; font-weight: bold; font-size: 1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <fmt:formatNumber value="${(superviseurCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div style="margin-top: 0.5rem;">
                        <div style="font-weight: 600; font-size: 0.9rem;">SUPERVISEUR</div>
                        <div style="color: #6c757d; font-size: 0.8rem;">${superviseurCount} utilisateur(s)</div>
                    </div>
                </div>
            </c:if>

            <c:if test="${technicienCount > 0}">
                <div style="text-align: center;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #fd7e14, #e85d04); display: flex; align-items: center; justify-content: center; margin: 0 auto; color: white; font-weight: bold; font-size: 1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <fmt:formatNumber value="${(technicienCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div style="margin-top: 0.5rem;">
                        <div style="font-weight: 600; font-size: 0.9rem;">TECHNICIEN</div>
                        <div style="color: #6c757d; font-size: 0.8rem;">${technicienCount} utilisateur(s)</div>
                    </div>
                </div>
            </c:if>

            <c:if test="${operateurCount > 0}">
                <div style="text-align: center;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #20c997, #139675); display: flex; align-items: center; justify-content: center; margin: 0 auto; color: white; font-weight: bold; font-size: 1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <fmt:formatNumber value="${(operateurCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div style="margin-top: 0.5rem;">
                        <div style="font-weight: 600; font-size: 0.9rem;">OPERATEUR</div>
                        <div style="color: #6c757d; font-size: 0.8rem;">${operateurCount} utilisateur(s)</div>
                    </div>
                </div>
            </c:if>

            <c:if test="${auditeurCount > 0}">
                <div style="text-align: center;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #4361ee, #3a0ca3); display: flex; align-items: center; justify-content: center; margin: 0 auto; color: white; font-weight: bold; font-size: 1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <fmt:formatNumber value="${(auditeurCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div style="margin-top: 0.5rem;">
                        <div style="font-weight: 600; font-size: 0.9rem;">AUDITEUR</div>
                        <div style="color: #6c757d; font-size: 0.8rem;">${auditeurCount} utilisateur(s)</div>
                    </div>
                </div>
            </c:if>

            <c:if test="${consultantCount > 0}">
                <div style="text-align: center;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #ff6b6b, #ff3838); display: flex; align-items: center; justify-content: center; margin: 0 auto; color: white; font-weight: bold; font-size: 1rem; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                        <fmt:formatNumber value="${(consultantCount / users.size()) * 100}" pattern="0"/>%
                    </div>
                    <div style="margin-top: 0.5rem;">
                        <div style="font-weight: 600; font-size: 0.9rem;">CONSULTANT</div>
                        <div style="color: #6c757d; font-size: 0.8rem;">${consultantCount} utilisateur(s)</div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Filtres et recherche -->
    <div class="filters" style="margin-bottom: 2rem; display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
        <div style="position: relative; flex: 1; min-width: 300px;">
            <input type="text" id="searchInput" placeholder="🔍 Rechercher un utilisateur..."
                   style="width: 100%; padding: 0.75rem 1rem 0.75rem 3rem; border: 2px solid #e9ecef; border-radius: 25px; font-size: 1rem; transition: all 0.3s ease;">
        </div>

        <select id="statusFilter" style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer;">
            <option value="">Tous les statuts</option>
            <option value="active">✅ Actifs</option>
            <option value="inactive">❌ Inactifs</option>
        </select>

        <select id="roleFilter" style="padding: 0.75rem 1.5rem; border: 2px solid #e9ecef; border-radius: 25px; background: white; cursor: pointer;">
            <option value="">Tous les rôles</option>
            <option value="SUPER_ADMIN">SUPER_ADMIN</option>
            <option value="SUPERVISEUR">SUPERVISEUR</option>
            <option value="TECHNICIEN">TECHNICIEN</option>
            <option value="OPERATEUR">OPERATEUR</option>
            <option value="AUDITEUR">AUDITEUR</option>
            <option value="CONSULTANT">CONSULTANT</option>
        </select>

        <!-- BOUTON RESET FILTRES -->
        <button onclick="resetFilters()" class="btn btn-secondary" style="padding: 0.75rem 1.5rem; border-radius: 25px;">
            🔄 Reset
        </button>

        <div style="color: #6c757d; font-weight: 600;">
            📊 <span id="userCount">${users.size()}</span> utilisateurs trouvés
        </div>
    </div>

    <!-- Tableau moderne -->
    <div class="table-container">
        <table class="data-table">
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
                <c:forEach var="user" items="${users}">
                    <tr class="user-row"
                        data-status="${user.actif ? 'active' : 'inactive'}"
                        data-role="${user.role}"
                        data-search="${user.id} ${user.username} ${user.nomComplet} ${user.email} ${user.role}">
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.5rem;">
                                <div style="width: 8px; height: 8px; border-radius: 50%; background: ${user.actif ? '#06d6a0' : '#ef476f'};"></div>
                                <strong style="color: #4361ee;">${user.id}</strong>
                            </div>
                        </td>
                        <td>
                            <div style="font-weight: 600; color: #4361ee;">${user.username}</div>
                        </td>
                        <td>${user.nomComplet}</td>
                        <td>${user.email}</td>
                        <td>
                            <span style="background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                                ${user.role}
                            </span>
                        </td>
                        <td>
                            <span class="status-badge ${user.actif ? 'active' : 'inactive'}">
                                ${user.actif ? '✅ Actif' : '❌ Inactif'}
                            </span>
                        </td>
                        <td style="text-align: center;">
                            <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                <!-- Bouton Édition -->
                                <button onclick="showEditModal(${user.id}, '${user.username}', '${user.nomComplet}', '${user.email}', '${user.role}', ${user.actif})"
                                        class="btn btn-warning"
                                        style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                    ✏️ Modifier
                                </button>

                                <!-- BOUTONS DÉSACTIVER/ACTIVER AVEC FORMULAIRES -->
                                <c:choose>
                                    <c:when test="${user.actif}">
                                        <!-- Formulaire Désactiver -->
                                        <form action="/admin/users/${user.id}/deactivate" method="post" style="display: inline; margin: 0;">
                                            <button type="submit"
                                                    onclick="return confirm('⏸️ Voulez-vous désactiver l\\'utilisateur ${user.username} ?')"
                                                    class="btn btn-danger"
                                                    style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                                ⏸️ Désactiver
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Formulaire Activer -->
                                        <form action="/admin/users/${user.id}/activate" method="post" style="display: inline; margin: 0;">
                                            <button type="submit"
                                                    onclick="return confirm('▶️ Voulez-vous activer l\\'utilisateur ${user.username} ?')"
                                                    class="btn btn-success"
                                                    style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                                ▶️ Activer
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Bouton Réinitialiser mot de passe -->
                                <button onclick="showResetModal(${user.id}, '${user.username}')"
                                        class="btn btn-secondary"
                                        style="padding: 0.5rem 1rem; font-size: 0.8rem;">
                                    🔑 Réinit
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Message si aucun utilisateur -->
    <c:if test="${empty users}">
        <div class="card" style="text-align: center; padding: 3rem;">
            <div style="font-size: 4rem; margin-bottom: 1rem;">👥</div>
            <h3 style="color: #6c757d; margin-bottom: 1rem;">Aucun utilisateur trouvé</h3>
            <p style="color: #8d99ae; margin-bottom: 2rem;">Commencez par créer votre premier utilisateur</p>
            <a href="#" class="btn btn-primary" onclick="showCreateModal()">➕ Créer un utilisateur</a>
        </div>
    </c:if>
</div>

<!-- MODALS -->
<div id="createUserModal" class="modal-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; align-items: center; justify-content: center;">
   <div class="modal" style="background: white; padding: 2rem; border-radius: 10px; width: 90%; max-width: 500px; max-height: 90vh; overflow-y: auto;">
       <div class="modal-header" style="display: flex; justify-content: between; align-items: center; margin-bottom: 1.5rem;">
           <h3 style="color: #4361ee; margin: 0;">➕ Nouvel Utilisateur</h3>
           <button type="button" class="modal-close" onclick="hideCreateModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer;">✕</button>
       </div>
       <form action="/admin/users/create" method="post">
           <input type="hidden" name="username" autocomplete="username" style="display:none">
           <div style="display: grid; gap: 1rem;">
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Nom d'utilisateur *</label>
                   <input type="text" name="username" autocomplete="username" required style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
               </div>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Mot de passe *</label>
                   <input type="password" name="password" autocomplete="new-password" required style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
               </div>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Nom Complet *</label>
                   <input type="text" name="nomComplet" required style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
               </div>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Email</label>
                   <input type="email" name="email" style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
               </div>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Rôle *</label>
                   <select name="role" required style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
                      <option value="OPERATEUR">OPERATEUR</option>
                      <option value="TECHNICIEN">TECHNICIEN</option>
                      <option value="SUPERVISEUR">SUPERVISEUR</option>
                      <option value="AUDITEUR">AUDITEUR</option>
                      <option value="CONSULTANT">CONSULTANT</option>
                      <option value="SUPER_ADMIN">SUPER_ADMIN</option>
                   </select>
               </div>
           </div>
           <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
               <button type="button" onclick="hideCreateModal()"
                       class="btn btn-secondary" style="flex: 1;">
                   Annuler
               </button>
               <button type="submit" class="btn btn-primary" style="flex: 1;">
                   Créer
               </button>
           </div>
       </form>
   </div>
</div>

<div id="editUserModal" class="modal-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; align-items: center; justify-content: center;">
   <div class="modal" style="background: white; padding: 2rem; border-radius: 10px; width: 90%; max-width: 500px; max-height: 90vh; overflow-y: auto;">
       <div class="modal-header" style="display: flex; justify-content: between; align-items: center; margin-bottom: 1.5rem;">
           <h3 style="color: #4361ee; margin: 0;">✏️ Modifier Utilisateur</h3>
           <button type="button" class="modal-close" onclick="hideEditModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer;">✕</button>
       </div>
       <form action="/admin/users/update" method="post">
           <input type="hidden" id="editUserId" name="id">
           <div style="display: grid; gap: 1rem;">
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Nom d'utilisateur</label>
                   <input type="text" id="editUsername" readonly style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem; background: #f8f9fa;">
               </div>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Nom Complet *</label>
                   <input type="text" id="editNomComplet" name="nomComplet" required style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
               </div>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Email</label>
                   <input type="email" id="editEmail" name="email" style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
               </div>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Rôle *</label>
                   <select id="editRole" name="role" required style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;">
                      <option value="OPERATEUR">OPERATEUR</option>
                      <option value="TECHNICIEN">TECHNICIEN</option>
                      <option value="SUPERVISEUR">SUPERVISEUR</option>
                      <option value="AUDITEUR">AUDITEUR</option>
                      <option value="CONSULTANT">CONSULTANT</option>
                      <option value="SUPER_ADMIN">SUPER_ADMIN</option>
                   </select>
               </div>
               <div>
                   <label style="display: flex; align-items: center; gap: 0.5rem; font-weight: 600;">
                       <input type="checkbox" id="editActif" name="actif" value="true" style="width: auto;">
                       Utilisateur actif
                   </label>
               </div>
           </div>
           <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
               <button type="button" onclick="hideEditModal()"
                       class="btn btn-secondary" style="flex: 1;">
                   Annuler
               </button>
               <button type="submit" class="btn btn-primary" style="flex: 1;">
                   💾 Enregistrer
               </button>
           </div>
       </form>
   </div>
</div>

<div id="resetPasswordModal" class="modal-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; align-items: center; justify-content: center;">
   <div class="modal" style="background: white; padding: 2rem; border-radius: 10px; width: 90%; max-width: 500px;">
       <div class="modal-header" style="display: flex; justify-content: between; align-items: center; margin-bottom: 1.5rem;">
           <h3 style="color: #4361ee; margin: 0;">🔑 Réinitialiser Mot de Passe</h3>
           <button type="button" class="modal-close" onclick="hideResetModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer;">✕</button>
       </div>
       <form action="/admin/users/reset-password" method="post">
           <input type="hidden" id="resetUserId" name="id">
           <input type="text" name="username" autocomplete="username" style="display: none;">
           <div style="margin-bottom: 1.5rem;">
               <p>Réinitialiser le mot de passe pour : <strong id="resetUsername">-</strong></p>
               <div>
                   <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Nouveau mot de passe *</label>
                   <input type="password" name="newPassword" autocomplete="new-password" required
                          style="width: 100%; padding: 0.75rem; border: 2px solid #e9ecef; border-radius: 5px; font-size: 1rem;"
                          placeholder="Minimum 6 caractères">
               </div>
           </div>
           <div style="display: flex; gap: 1rem;">
               <button type="button" onclick="hideResetModal()"
                       class="btn btn-secondary" style="flex: 1;">
                   Annuler
               </button>
               <button type="submit" class="btn btn-primary" style="flex: 1; background: #7209b7;">
                   🔑 Réinitialiser
               </button>
           </div>
       </form>
   </div>
</div>

<!-- SCRIPT CORRIGÉ ET COMPLET -->
<script>
// FONCTIONS DE MODAL SIMPLES
function showCreateModal() {
    document.getElementById('createUserModal').style.display = 'flex';
}
function hideCreateModal() {
    document.getElementById('createUserModal').style.display = 'none';
}

// FONCTION ÉDITION CORRIGÉE (sans caisseCode)
function showEditModal(userId, username, nomComplet, email, role, actif) {
    document.getElementById('editUserId').value = userId;
    document.getElementById('editUsername').value = username;
    document.getElementById('editNomComplet').value = nomComplet;
    document.getElementById('editEmail').value = email || '';
    document.getElementById('editRole').value = role;
    document.getElementById('editActif').checked = actif;
    document.getElementById('editUserModal').style.display = 'flex';
}
function hideEditModal() {
    document.getElementById('editUserModal').style.display = 'none';
}

function showResetModal(userId, username) {
    document.getElementById('resetUserId').value = userId;
    document.getElementById('resetUsername').textContent = username;
    document.getElementById('resetPasswordModal').style.display = 'flex';
}
function hideResetModal() {
    document.getElementById('resetPasswordModal').style.display = 'none';
}

// FONCTION RESET FILTRES
function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('statusFilter').value = '';
    document.getElementById('roleFilter').value = '';
    filterUsers();
}

// FILTRES
function filterUsers() {
    var search = document.getElementById('searchInput').value.toLowerCase();
    var status = document.getElementById('statusFilter').value;
    var role = document.getElementById('roleFilter').value;

    var visibleCount = 0;

    document.querySelectorAll('.user-row').forEach(function(row) {
        var rowStatus = row.getAttribute('data-status');
        var rowRole = row.getAttribute('data-role');
        var rowSearch = row.getAttribute('data-search').toLowerCase();

        var statusMatch = !status || rowStatus === status || status === 'all'; // MODIF ICI
        var roleMatch = !role || rowRole === role;
        var searchMatch = !search || rowSearch.includes(search);

        if (statusMatch && roleMatch && searchMatch) {
            row.style.display = '';
            visibleCount++;
        } else {
            row.style.display = 'none';
        }
    });

    document.getElementById('userCount').textContent = visibleCount;
}

// INITIALISATION
document.addEventListener('DOMContentLoaded', function() {
    // Événements de filtrage
    document.getElementById('searchInput').addEventListener('input', filterUsers);
    document.getElementById('statusFilter').addEventListener('change', filterUsers);
    document.getElementById('roleFilter').addEventListener('change', filterUsers);

    // Filtrer au chargement
    filterUsers();

    // Fermeture modals en cliquant dehors
    document.querySelectorAll('.modal-overlay').forEach(function(modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                this.style.display = 'none';
            }
        });
    });

    console.log('✅ Page utilisateurs initialisée avec succès');
});
</script>

<style>
/* VOTRE STYLE EXISTANT */
.filters input:focus, .filters select:focus {
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
.btn-primary { background: #4361ee; color: white; }
.btn-warning { background: #ffc107; color: #212529; }
.btn-success { background: #28a745; color: white; }
.btn-danger { background: #dc3545; color: white; }
.btn-secondary { background: #6c757d; color: white; }
</style>

<%@ include file="../includes/footer.jsp" %>