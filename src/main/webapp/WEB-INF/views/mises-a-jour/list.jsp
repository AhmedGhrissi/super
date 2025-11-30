<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <!-- En-tête de page -->
    <div class="page-header">
        <h2>🔄 Gestion des Mises à Jour</h2>
        <div class="action-buttons">
            <a href="/mises-a-jour/create" class="btn btn-primary">
                <span>📅</span> Planifier une MAJ
            </a>
            <a href="/mises-a-jour/calendrier" class="btn btn-success">
                <span>📊</span> Vue Calendrier
            </a>
        </div>
    </div>

    <!-- Messages flash -->
    <c:if test="${not empty success}">
        <div class="alert alert-success" style="background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 2rem;">
            ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error" style="background: linear-gradient(135deg, #ef476f, #ff6b6b); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 2rem;">
            ${error}
        </div>
    </c:if>

    <!-- Statistiques des MAJ -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value">${totalMAJ}</div>
            <div class="stat-label">Total MAJ</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${majPlanifiees}</div>
            <div class="stat-label">Planifiées</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${majTerminees}</div>
            <div class="stat-label">Terminées</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${majCetteSemaine}</div>
            <div class="stat-label">Cette Semaine</div>
        </div>
    </div>

    <!-- Actions rapides -->
    <div class="quick-actions">
        <button class="action-btn" style="background: linear-gradient(135deg, #4361ee, #3a0ca3);" onclick="filtrerMAJ('PLANIFIEE')">
            <span class="action-icon">📋</span>
            <span class="action-text">Planifiées</span>
        </button>
        <button class="action-btn" style="background: linear-gradient(135deg, #06d6a0, #118ab2);" onclick="filtrerMAJ('EN_COURS')">
            <span class="action-icon">🔄</span>
            <span class="action-text">En Cours</span>
        </button>
        <button class="action-btn" style="background: linear-gradient(135deg, #ff9e00, #ff6b6b);" onclick="filtrerMAJ('TERMINEE')">
            <span class="action-icon">✅</span>
            <span class="action-text">Terminées</span>
        </button>
        <button class="action-btn" style="background: linear-gradient(135deg, #7209b7, #3a0ca3);" onclick="filtrerMAJ('CRITIQUE')">
            <span class="action-icon">🚨</span>
            <span class="action-text">Critiques</span>
        </button>
    </div>

	    <!-- Tableau des mises à jour -->
	    <div class="card">
	        <h3 style="color: #4361ee; margin-bottom: 1.5rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
	            Liste des Mises à Jour
	        </h3>

	        <div class="data-table-container">
	            <table class="data-table">
	                <thead>
	                    <tr>
	                        <th>Description</th>
	                        <th>Type</th>
	                        <th>Serveur</th>
	                        <th>Date Application</th>
	                        <th>Statut</th>
	                        <th>Actions</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach var="maj" items="${misesAJour}">
	                        <tr>
	                            <td>
	                                <strong>${maj.description}</strong>
	                                <c:if test="${not empty maj.version}">
	                                    <br><small style="color: #8d99ae;">Version: ${maj.version}</small>
	                                </c:if>
	                                <c:if test="${not empty maj.responsable}">
	                                    <br><small style="color: #8d99ae;">Responsable: ${maj.responsable}</small>
	                                </c:if>
	                            </td>
	                            <td>
	                                <span class="badge
	                                    <c:choose>
	                                        <c:when test="${maj.typeMiseAJour == 'CRITIQUE'}">badge-category-conformite</c:when>
	                                        <c:when test="${maj.typeMiseAJour == 'SECURITE'}">badge-category-surveillance</c:when>
	                                        <c:when test="${maj.typeMiseAJour == 'FONCTIONNEL'}">badge-category-processus_metier</c:when>
	                                        <c:otherwise>badge-category-integration</c:otherwise>
	                                    </c:choose>">
	                                    ${maj.typeMiseAJour}
	                                </span>
	                            </td>
	                            <td>
	                                <c:if test="${maj.serveur != null}">
	                                    <a href="/serveurs/view/${maj.serveur.id}" style="color: #4361ee; text-decoration: none;">
	                                        ${maj.serveur.nom}
	                                    </a>
	                                    <br>
	                                    <small style="color: #8d99ae;">${maj.serveur.environnement}</small>
	                                </c:if>
	                                <c:if test="${maj.serveur == null}">
	                                    <span style="color: #8d99ae;">Serveur non spécifié</span>
	                                </c:if>
	                            </td>
	                            <td>
	                                <!-- SOLUTION SIMPLIFIÉE - Affichez directement la date -->
	                                <c:choose>
	                                    <c:when test="${maj.dateApplication != null}">
	                                        ${maj.dateApplication}
	                                    </c:when>
	                                    <c:otherwise>
	                                        Non définie
	                                    </c:otherwise>
	                                </c:choose>
	                                <br>
	                                <small style="color: #8d99ae;">
	                                    Créé le
	                                    <c:choose>
	                                        <c:when test="${maj.dateCreation != null}">
	                                            ${maj.dateCreation}
	                                        </c:when>
	                                        <c:otherwise>
	                                            Date inconnue
	                                        </c:otherwise>
	                                    </c:choose>
	                                </small>
	                            </td>
	                            <td>
	                                <select onchange="changerStatutMAJ(${maj.id}, this.value)"
	                                        style="padding: 0.5rem; border-radius: 6px; border: 1px solid #ddd; background: white; cursor: pointer;">
	                                    <c:forEach var="statut" items="${statutsMAJ}">
	                                        <option value="${statut}" ${maj.statut == statut ? 'selected' : ''}>
	                                            ${statut}
	                                        </option>
	                                    </c:forEach>
	                                </select>
	                                <br>
	                                <small style="color: #8d99ae; font-size: 0.8rem;">
	                                    Modifié:
	                                    <c:choose>
	                                        <c:when test="${maj.dateModification != null}">
	                                            ${maj.dateModification}
	                                        </c:when>
	                                        <c:otherwise>
	                                            Jamais
	                                        </c:otherwise>
	                                    </c:choose>
	                                </small>
	                            </td>
	                            <td>
	                                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
	                                    <button class="btn btn-danger btn-sm"
	                                            onclick="supprimerMAJ(${maj.id}, '${maj.description}')"
	                                            style="padding: 0.4rem 0.8rem; font-size: 0.8rem; display: flex; align-items: center; gap: 0.25rem;">
	                                        <span>🗑️</span> Supprimer
	                                    </button>
	                                    <c:if test="${maj.serveur != null}">
	                                        <a href="/serveurs/view/${maj.serveur.id}" class="btn btn-info btn-sm"
	                                           style="padding: 0.4rem 0.8rem; font-size: 0.8rem; display: flex; align-items: center; gap: 0.25rem;">
	                                            <span>👁️</span> Serveur
	                                        </a>
	                                    </c:if>
	                                </div>
	                            </td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	        </div>

	        <c:if test="${empty misesAJour}">
	            <div class="text-center py-5">
	                <div style="font-size: 4rem; margin-bottom: 1rem;">📅</div>
	                <h3 style="color: #6c757d; margin-bottom: 1rem;">Aucune mise à jour planifiée</h3>
	                <p style="color: #8d99ae; margin-bottom: 2rem;">Commencez par planifier votre première mise à jour</p>
	                <a href="/mises-a-jour/create" class="btn btn-primary">📅 Planifier une MAJ</a>
	            </div>
	        </c:if>
	    </div>

	 <!-- Détails supplémentaires -->
<div class="details-grid">
	<!-- Mises à jour cette semaine -->
	<div class="detail-card">
	    <h3>📅 Cette Semaine</h3>
	    <c:if test="${not empty majCetteSemaineList}">
	        <c:forEach var="maj" items="${majCetteSemaineList}" end="4">
	            <div class="detail-item">
	                <label>${maj.description}</label>
	                <span>
	                    <c:choose>
	                        <c:when test="${maj.dateApplication != null}">
	                            ${maj.dateApplication}
	                        </c:when>
	                        <c:otherwise>
	                            Date indéfinie
	                        </c:otherwise>
	                    </c:choose>
	                    <c:if test="${maj.serveur != null}">
	                        - ${maj.serveur.nom}
	                    </c:if>
	                </span>
	            </div>
	        </c:forEach>
	    </c:if>
	    <c:if test="${empty majCetteSemaineList}">
	        <p style="color: #8d99ae; text-align: center; padding: 1rem;">Aucune MAJ cette semaine</p>
	    </c:if>
	</div>

    <!-- Statistiques détaillées -->
    <div class="detail-card">
        <h3>📊 Statistiques MAJ</h3>
        <c:if test="${not empty statsMAJ}">
            <div class="detail-item">
                <label>Planifiées</label>
                <span>${statsMAJ.PLANIFIEE != null ? statsMAJ.PLANIFIEE : 0}</span>
            </div>
            <div class="detail-item">
                <label>En cours</label>
                <span>${statsMAJ.EN_COURS != null ? statsMAJ.EN_COURS : 0}</span>
            </div>
            <div class="detail-item">
                <label>Terminées</label>
                <span>${statsMAJ.TERMINEE != null ? statsMAJ.TERMINEE : 0}</span>
            </div>
            <div class="detail-item">
                <label>Échecs</label>
                <span>${statsMAJ.ECHEC != null ? statsMAJ.ECHEC : 0}</span>
            </div>
        </c:if>
        <c:if test="${empty statsMAJ}">
            <p style="color: #8d99ae; text-align: center; padding: 1rem;">Aucune statistique disponible</p>
        </c:if>
    </div>

    <!-- Prochaine mise à jour -->
    <div class="detail-card">
        <h3>⏰ Prochaine MAJ</h3>
        <c:if test="${not empty prochaineMAJ}">
            <div style="text-align: center; padding: 1rem;">
                <div style="font-size: 2rem; margin-bottom: 0.5rem;">📅</div>
                <strong>${prochaineMAJ.description}</strong>
                <div style="color: #4361ee; font-weight: 600; margin: 0.5rem 0;">
                    <c:choose>
                        <c:when test="${prochaineMAJ.dateApplication != null}">
                            ${prochaineMAJ.dateApplication}
                        </c:when>
                        <c:otherwise>
                            Date non définie
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${prochaineMAJ.serveur != null and not empty prochaineMAJ.serveur.nom}">
                    <div style="color: #8d99ae;">
                        ${prochaineMAJ.serveur.nom}
                    </div>
                </c:if>
                <div style="margin-top: 1rem;">
                    <span class="badge
                        <c:choose>
                            <c:when test="${prochaineMAJ.typeMiseAJour == 'CRITIQUE'}">badge-category-conformite</c:when>
                            <c:when test="${prochaineMAJ.typeMiseAJour == 'SECURITE'}">badge-category-surveillance</c:when>
                            <c:otherwise>badge-category-integration</c:otherwise>
                        </c:choose>">
                        ${prochaineMAJ.typeMiseAJour}
                    </span>
                </div>
            </div>
        </c:if>
        <c:if test="${empty prochaineMAJ}">
            <div style="text-align: center; padding: 1rem;">
                <div style="font-size: 2rem; margin-bottom: 0.5rem;">✅</div>
                <p style="color: #8d99ae;">Aucune MAJ planifiée</p>
            </div>
        </c:if>
    </div>
</div>

<!-- Modal de confirmation -->
<div id="confirmationModal" class="modal-overlay" style="display: none;">
    <div class="modal">
        <div class="modal-header">
            <h3 id="modalTitle">Confirmation</h3>
            <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <p id="modalMessage">Êtes-vous sûr de vouloir effectuer cette action ?</p>
        </div>
        <div class="modal-footer">
            <button class="modal-btn modal-btn-cancel" onclick="closeModal()">Annuler</button>
            <button class="modal-btn modal-btn-confirm" id="modalConfirmBtn">Confirmer</button>
        </div>
    </div>
</div>

<style>
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card {
    background: white;
    padding: 1.5rem;
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    text-align: center;
    border: 1px solid #e9ecef;
}

.stat-value {
    font-size: 2.5rem;
    font-weight: 700;
    color: #4361ee;
    margin-bottom: 0.5rem;
}

.stat-label {
    color: #6c757d;
    font-weight: 600;
    font-size: 0.9rem;
}

.quick-actions {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
}

.action-btn {
    border: none;
    padding: 1rem;
    border-radius: 10px;
    color: white;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
}

.action-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 12px rgba(0,0,0,0.2);
}

.action-icon {
    font-size: 1.5rem;
}

.action-text {
    font-size: 0.9rem;
}

.details-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
    margin-top: 2rem;
}

.detail-card {
    background: white;
    padding: 1.5rem;
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    border: 1px solid #e9ecef;
}

.detail-card h3 {
    color: #4361ee;
    margin-bottom: 1rem;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 0.5rem;
}

.detail-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 0;
    border-bottom: 1px solid #f8f9fa;
}

.detail-item:last-child {
    border-bottom: none;
}

.detail-item label {
    font-weight: 600;
    color: #2c3e50;
}

.detail-item span {
    color: #4361ee;
    font-weight: 600;
}

/* Styles pour les badges */
.badge {
    padding: 0.4rem 0.8rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    color: white;
}

.badge-category-conformite { background: linear-gradient(135deg, #ef476f, #ff6b6b); }
.badge-category-surveillance { background: linear-gradient(135deg, #ff9e00, #ff6b6b); }
.badge-category-processus_metier { background: linear-gradient(135deg, #06d6a0, #118ab2); }
.badge-category-integration { background: linear-gradient(135deg, #7209b7, #3a0ca3); }

/* Styles pour les boutons */
.btn {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-primary {
    background: linear-gradient(135deg, #4361ee, #3a0ca3);
    color: white;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.btn-success {
    background: linear-gradient(135deg, #06d6a0, #118ab2);
    color: white;
}

.btn-info {
    background: linear-gradient(135deg, #7209b7, #3a0ca3);
    color: white;
}

.btn-danger {
    background: linear-gradient(135deg, #ef476f, #ff6b6b);
    color: white;
}

.btn-sm {
    padding: 0.4rem 0.8rem;
    font-size: 0.8rem;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* Styles pour la modale */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 10000;
}

.modal {
    background: white;
    border-radius: 12px;
    padding: 0;
    min-width: 400px;
    max-width: 500px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

.modal-header {
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    color: #2c3e50;
    font-size: 1.3rem;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: #6c757d;
}

.modal-body {
    padding: 1.5rem;
}

.modal-footer {
    padding: 1rem 1.5rem;
    border-top: 1px solid #e9ecef;
    display: flex;
    gap: 0.5rem;
    justify-content: flex-end;
}

.modal-btn {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
}

.modal-btn-cancel {
    background: #6c757d;
    color: white;
}

.modal-btn-confirm {
    background: #4361ee;
    color: white;
}

.modal-btn-danger {
    background: #ef476f;
    color: white;
}
</style>

<script>
// Fonction pour changer le statut d'une MAJ
function changerStatutMAJ(id, nouveauStatut) {
    showConfirmation(
        'Changer le statut',
        'Voulez-vous vraiment changer le statut de cette mise à jour ?',
        function() {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/mises-a-jour/changer-statut/' + id;

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'nouveauStatut';
            input.value = nouveauStatut;
            form.appendChild(input);

            document.body.appendChild(form);
            form.submit();
        }
    );
}

// Fonction pour supprimer une MAJ
function supprimerMAJ(id, description) {
    showConfirmation(
        'Supprimer la mise à jour',
        'Êtes-vous sûr de vouloir supprimer la mise à jour "' + description + '" ?',
        function() {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/mises-a-jour/delete/' + id;
            document.body.appendChild(form);
            form.submit();
        },
        true
    );
}

// Fonction de filtrage (placeholder)
function filtrerMAJ(filtre) {
    showNotification('Filtrage des MAJ: ' + filtre, 'info');
}

// Gestion des modales
let currentAction = null;

function showConfirmation(title, message, confirmCallback, danger = false) {
    document.getElementById('modalTitle').textContent = title;
    document.getElementById('modalMessage').textContent = message;

    const confirmBtn = document.getElementById('modalConfirmBtn');
    if (danger) {
        confirmBtn.className = 'modal-btn modal-btn-danger';
    } else {
        confirmBtn.className = 'modal-btn modal-btn-confirm';
    }

    currentAction = confirmCallback;
    document.getElementById('confirmationModal').style.display = 'flex';
}

function closeModal() {
    document.getElementById('confirmationModal').style.display = 'none';
    currentAction = null;
}

document.getElementById('modalConfirmBtn').addEventListener('click', function() {
    if (currentAction) {
        currentAction();
    }
    closeModal();
});

// Fermer la modale en cliquant à l'extérieur
document.getElementById('confirmationModal').addEventListener('click', function(e) {
    if (e.target === this) {
        closeModal();
    }
});

// Raccourci clavier Échap
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        closeModal();
    }
});

// Fonction de notification
function showNotification(message, type = 'info') {
    console.log(type + ': ' + message);
    // Implémentez votre système de notification ici
}
</script>

<jsp:include page="../includes/footer.jsp" />