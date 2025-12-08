<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles pour la gestion des MAJ */
.maj-container {
    max-width: 1600px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.maj-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.maj-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.maj-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.maj-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.maj-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

/* Boutons d'action */
.maj-actions-modern {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.btn-maj-modern {
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

.btn-maj-primary {
    background: white;
    color: #006747;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.btn-maj-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
}

.btn-maj-secondary {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    border: 1px solid rgba(255, 255, 255, 0.3);
}

.btn-maj-secondary:hover {
    background: rgba(255, 255, 255, 0.3);
    transform: translateY(-2px);
}

/* Cartes de statistiques */
.stats-grid-maj {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card-maj {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    transition: transform 0.3s ease;
    text-align: center;
}

.stat-card-maj:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}

.stat-value-maj {
    font-size: 2.5rem;
    font-weight: 700;
    color: #006747;
    margin-bottom: 0.5rem;
}

.stat-label-maj {
    font-size: 0.9rem;
    color: #6c757d;
    font-weight: 500;
}

/* Actions rapides */
.quick-actions-maj {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
}

.action-btn-maj {
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

.action-btn-maj:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 12px rgba(0,0,0,0.2);
}

.action-icon-maj {
    font-size: 1.5rem;
}

.action-text-maj {
    font-size: 0.9rem;
}

/* Table moderne */
.table-modern-maj {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    margin-bottom: 2rem;
}

.table-header-maj {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    padding: 1.5rem;
}

.table-header-maj h2 {
    margin: 0;
    font-size: 1.25rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.data-table-maj {
    width: 100%;
    border-collapse: collapse;
    min-width: 1000px;
}

.data-table-maj th {
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

.data-table-maj td {
    padding: 1rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.data-table-maj tbody tr:hover {
    background-color: #f8f9fa;
}

/* Badges */
.badge-maj {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    color: white;
}

.badge-planifiee { background: linear-gradient(135deg, #4361ee, #3a0ca3); }
.badge-en-cours { background: linear-gradient(135deg, #06d6a0, #118ab2); }
.badge-terminee { background: linear-gradient(135deg, #ff9e00, #ff6b6b); }
.badge-critique { background: linear-gradient(135deg, #ef476f, #ff6b6b); }

/* Détails supplémentaires */
.details-grid-maj {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
    margin-top: 2rem;
}

.detail-card-maj {
    background: white;
    padding: 1.5rem;
    border-radius: 12px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    border: 1px solid #e9ecef;
}

.detail-card-maj h3 {
    color: #006747;
    margin-bottom: 1rem;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 0.5rem;
}

.detail-item-maj {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 0;
    border-bottom: 1px solid #f8f9fa;
}

.detail-item-maj:last-child {
    border-bottom: none;
}

.detail-label-maj {
    font-weight: 600;
    color: #495057;
}

.detail-value-maj {
    color: #006747;
    font-weight: 600;
}

/* Empty state */
.empty-state-maj {
    text-align: center;
    padding: 4rem 2rem;
}

.empty-state-icon-maj {
    font-size: 4rem;
    margin-bottom: 1.5rem;
    opacity: 0.5;
}

.empty-state-maj h3 {
    color: #6c757d;
    margin-bottom: 1rem;
    font-size: 1.5rem;
}

.empty-state-maj p {
    color: #8d99ae;
    margin-bottom: 2rem;
    font-size: 1rem;
}

/* Responsive */
@media (max-width: 768px) {
    .maj-container {
        padding: 1rem;
    }

    .maj-title-section {
        flex-direction: column;
    }

    .maj-actions-modern {
        width: 100%;
    }

    .stats-grid-maj {
        grid-template-columns: repeat(2, 1fr);
    }

    .quick-actions-maj {
        grid-template-columns: repeat(2, 1fr);
    }

    .details-grid-maj {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 480px) {
    .stats-grid-maj {
        grid-template-columns: 1fr;
    }

    .quick-actions-maj {
        grid-template-columns: 1fr;
    }
}
</style>

<div class="maj-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="maj-header-modern">
        <div class="maj-title-section">
            <div>
                <div class="maj-title">
                    <h1>🔄 Gestion des Mises à Jour</h1>
                </div>
                <p class="maj-subtitle">Planification et suivi des mises à jour système</p>
            </div>

            <div class="maj-actions-modern">
                <a href="/mises-a-jour/create" class="btn-maj-modern btn-maj-primary">
                    <span>📅</span> Planifier une MAJ
                </a>
                <a href="/mises-a-jour/calendrier" class="btn-maj-modern btn-maj-secondary">
                    <span>📊</span> Vue Calendrier
                </a>
            </div>
        </div>
    </div>

    <!-- ========== MESSAGES FLASH ========== -->
    <c:if test="${not empty success}">
        <div class="notification success" style="margin-bottom: 2rem;">
            <span>✅</span>
            <span>${success}</span>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="notification error" style="margin-bottom: 2rem;">
            <span>❌</span>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- ========== STATISTIQUES GLOBALES ========== -->
    <div class="stats-grid-maj">
        <div class="stat-card-maj animate-fade-in-up">
            <div class="stat-value-maj">${totalMAJ}</div>
            <div class="stat-label-maj">Total MAJ</div>
        </div>

        <div class="stat-card-maj animate-fade-in-up" style="animation-delay: 0.1s;">
            <div class="stat-value-maj">${majPlanifiees}</div>
            <div class="stat-label-maj">Planifiées</div>
        </div>

        <div class="stat-card-maj animate-fade-in-up" style="animation-delay: 0.2s;">
            <div class="stat-value-maj">${majTerminees}</div>
            <div class="stat-label-maj">Terminées</div>
        </div>

        <div class="stat-card-maj animate-fade-in-up" style="animation-delay: 0.3s;">
            <div class="stat-value-maj">${majCetteSemaine}</div>
            <div class="stat-label-maj">Cette Semaine</div>
        </div>
    </div>

    <!-- ========== ACTIONS RAPIDES ========== -->
    <div class="quick-actions-maj">
        <button class="action-btn-maj" style="background: linear-gradient(135deg, #4361ee, #3a0ca3);" onclick="filtrerMAJ('PLANIFIEE')">
            <span class="action-icon-maj">📋</span>
            <span class="action-text-maj">Planifiées</span>
        </button>
        <button class="action-btn-maj" style="background: linear-gradient(135deg, #06d6a0, #118ab2);" onclick="filtrerMAJ('EN_COURS')">
            <span class="action-icon-maj">🔄</span>
            <span class="action-text-maj">En Cours</span>
        </button>
        <button class="action-btn-maj" style="background: linear-gradient(135deg, #ff9e00, #ff6b6b);" onclick="filtrerMAJ('TERMINEE')">
            <span class="action-icon-maj">✅</span>
            <span class="action-text-maj">Terminées</span>
        </button>
        <button class="action-btn-maj" style="background: linear-gradient(135deg, #7209b7, #3a0ca3);" onclick="filtrerMAJ('CRITIQUE')">
            <span class="action-icon-maj">🚨</span>
            <span class="action-text-maj">Critiques</span>
        </button>
    </div>

    <!-- ========== TABLEAU DES MAJ ========== -->
    <div class="table-modern-maj">
        <div class="table-header-maj">
            <h2>📋 Liste des Mises à Jour</h2>
        </div>

        <div style="overflow-x: auto;">
            <table class="data-table-maj">
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
                                <span class="badge-maj
                                    <c:choose>
                                        <c:when test="${maj.typeMiseAJour == 'CRITIQUE'}">badge-critique</c:when>
                                        <c:when test="${maj.typeMiseAJour == 'SECURITE'}">badge-en-cours</c:when>
                                        <c:when test="${maj.typeMiseAJour == 'FONCTIONNEL'}">badge-planifiee</c:when>
                                        <c:otherwise>badge-terminee</c:otherwise>
                                    </c:choose>">
                                    ${maj.typeMiseAJour}
                                </span>
                            </td>
                            <td>
                                <c:if test="${maj.serveur != null}">
                                    <a href="/serveurs/view/${maj.serveur.id}" style="color: #006747; text-decoration: none; font-weight: 600;">
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
                                    Créé le:
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
                                        style="padding: 0.5rem; border-radius: 6px; border: 1px solid #ddd; background: white; cursor: pointer; font-size: 0.9rem; width: 100%;">
                                    <c:forEach var="statut" items="${statutsMAJ}">
                                        <option value="${statut}" ${maj.statut == statut ? 'selected' : ''}>
                                            ${statut}
                                        </option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td>
                                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                                    <button onclick="supprimerMAJ(${maj.id}, '${maj.description}')"
                                            style="padding: 0.4rem 0.8rem; background: #ef476f; color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; display: flex; align-items: center; gap: 0.25rem;">
                                        <span>🗑️</span> Supprimer
                                    </button>
                                    <c:if test="${maj.serveur != null}">
                                        <a href="/serveurs/view/${maj.serveur.id}"
                                           style="padding: 0.4rem 0.8rem; background: #06d6a0; color: white; text-decoration: none; border-radius: 6px; font-size: 0.8rem; display: flex; align-items: center; gap: 0.25rem;">
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
            <div class="empty-state-maj">
                <div class="empty-state-icon-maj">📅</div>
                <h3>Aucune mise à jour planifiée</h3>
                <p>Commencez par planifier votre première mise à jour</p>
                <a href="/mises-a-jour/create" class="btn-maj-modern btn-maj-primary" style="margin-top: 1rem;">
                    📅 Planifier une MAJ
                </a>
            </div>
        </c:if>
    </div>

    <!-- ========== DÉTAILS SUPPLÉMENTAIRES ========== -->
    <div class="details-grid-maj">
        <!-- Mises à jour cette semaine -->
        <div class="detail-card-maj">
            <h3>📅 Cette Semaine</h3>
            <c:if test="${not empty majCetteSemaineList}">
                <c:forEach var="maj" items="${majCetteSemaineList}" end="4">
                    <div class="detail-item-maj">
                        <span class="detail-label-maj">${maj.description}</span>
                        <span class="detail-value-maj">
                            <c:choose>
                                <c:when test="${maj.dateApplication != null}">
                                    ${maj.dateApplication}
                                </c:when>
                                <c:otherwise>
                                    Date indéfinie
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty majCetteSemaineList}">
                <p style="color: #8d99ae; text-align: center; padding: 1rem;">Aucune MAJ cette semaine</p>
            </c:if>
        </div>

        <!-- Statistiques détaillées -->
        <div class="detail-card-maj">
            <h3>📊 Statistiques MAJ</h3>
            <c:if test="${not empty statsMAJ}">
                <div class="detail-item-maj">
                    <span class="detail-label-maj">Planifiées</span>
                    <span class="detail-value-maj">${statsMAJ.PLANIFIEE != null ? statsMAJ.PLANIFIEE : 0}</span>
                </div>
                <div class="detail-item-maj">
                    <span class="detail-label-maj">En cours</span>
                    <span class="detail-value-maj">${statsMAJ.EN_COURS != null ? statsMAJ.EN_COURS : 0}</span>
                </div>
                <div class="detail-item-maj">
                    <span class="detail-label-maj">Terminées</span>
                    <span class="detail-value-maj">${statsMAJ.TERMINEE != null ? statsMAJ.TERMINEE : 0}</span>
                </div>
                <div class="detail-item-maj">
                    <span class="detail-label-maj">Échecs</span>
                    <span class="detail-value-maj">${statsMAJ.ECHEC != null ? statsMAJ.ECHEC : 0}</span>
                </div>
            </c:if>
            <c:if test="${empty statsMAJ}">
                <p style="color: #8d99ae; text-align: center; padding: 1rem;">Aucune statistique disponible</p>
            </c:if>
        </div>

        <!-- Prochaine mise à jour -->
        <div class="detail-card-maj">
            <h3>⏰ Prochaine MAJ</h3>
            <c:if test="${not empty prochaineMAJ}">
                <div style="text-align: center; padding: 1rem;">
                    <div style="font-size: 2rem; margin-bottom: 0.5rem;">📅</div>
                    <strong>${prochaineMAJ.description}</strong>
                    <div style="color: #006747; font-weight: 600; margin: 0.5rem 0;">
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
                        <span class="badge-maj
                            <c:choose>
                                <c:when test="${prochaineMAJ.typeMiseAJour == 'CRITIQUE'}">badge-critique</c:when>
                                <c:when test="${prochaineMAJ.typeMiseAJour == 'SECURITE'}">badge-en-cours</c:when>
                                <c:otherwise>badge-planifiee</c:otherwise>
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
</div>

<script>
// Fonctions pour la gestion des MAJ
function changerStatutMAJ(id, nouveauStatut) {
    if (confirm('Voulez-vous vraiment changer le statut de cette mise à jour ?')) {
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
}

function supprimerMAJ(id, description) {
    if (confirm('Êtes-vous sûr de vouloir supprimer la mise à jour "' + description + '" ?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/mises-a-jour/delete/' + id;
        document.body.appendChild(form);
        form.submit();
    }
}

function filtrerMAJ(filtre) {
    showNotification('Filtrage des MAJ: ' + filtre, 'info');
}

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

// Animation des cartes au chargement
document.addEventListener('DOMContentLoaded', function() {
    const statCards = document.querySelectorAll('.stat-card-maj');
    statCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
});
</script>

<jsp:include page="../includes/footer.jsp" />