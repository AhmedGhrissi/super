<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../includes/header.jsp" />

<style>
.alerte-detail-container {
    max-width: 900px;
    margin: 2rem auto;
    padding: 0 1.5rem;
}

.alerte-card {
    background: white;
    border-radius: 16px;
    padding: 2rem;
    box-shadow: 0 8px 32px rgba(0,0,0,0.1);
    border-left: 6px solid #d50032;
}

.alerte-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    padding-bottom: 1.5rem;
    border-bottom: 2px solid #e9ecef;
}

.alerte-titre {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.alerte-titre h1 {
    margin: 0;
    color: #343a40;
    font-size: 1.8rem;
}

.badge-criticite {
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 700;
    font-size: 0.9rem;
    text-transform: uppercase;
}

.badge-criticite.CRITICAL { background: #d50032; color: white; }
.badge-criticite.WARNING { background: #ffc107; color: #343a40; }
.badge-criticite.INFO { background: #2196F3; color: white; }

.alerte-actions {
    display: flex;
    gap: 0.75rem;
}

.btn-action {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 10px;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    transition: all 0.3s ease;
}

.btn-resoudre {
    background: linear-gradient(135deg, #28a745, #20c997);
    color: white;
}

.btn-resoudre:hover {
    background: linear-gradient(135deg, #218838, #1ba87e);
}

.btn-supprimer {
    background: linear-gradient(135deg, #dc3545, #d50032);
    color: white;
}

.btn-supprimer:hover {
    background: linear-gradient(135deg, #c82333, #b30029);
}

.alerte-details {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.detail-item {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.detail-label {
    font-size: 0.9rem;
    color: #6c757d;
    font-weight: 500;
}

.detail-value {
    font-size: 1.1rem;
    font-weight: 600;
    color: #343a40;
}

.alerte-description {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
}

.alerte-description h3 {
    color: #006747;
    margin-top: 0;
    margin-bottom: 1rem;
    font-size: 1.2rem;
}

.alerte-description p {
    color: #495057;
    line-height: 1.6;
    margin: 0;
}

.historique-section {
    margin-top: 2rem;
}

.historique-section h3 {
    color: #006747;
    margin-bottom: 1rem;
    font-size: 1.2rem;
}

.historique-list {
    background: white;
    border-radius: 12px;
    border: 1px solid #e9ecef;
    overflow: hidden;
}

.historique-item {
    padding: 1rem 1.5rem;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.historique-item:last-child {
    border-bottom: none;
}

.historique-action {
    font-weight: 600;
    color: #343a40;
}

.historique-date {
    color: #6c757d;
    font-size: 0.9rem;
}

.back-link {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    background: #6c757d;
    color: white;
    text-decoration: none;
    border-radius: 10px;
    font-weight: 600;
    margin-top: 2rem;
    transition: all 0.3s ease;
}

.back-link:hover {
    background: #5a6268;
    transform: translateY(-2px);
}
</style>

<div class="alerte-detail-container">
    <div class="alerte-card">
        <div class="alerte-header">
            <div class="alerte-titre">
                <h1>${alerte.titre}</h1>
                <span class="badge-criticite ${alerte.criticite}">${alerte.criticite}</span>
            </div>
            <div class="alerte-actions">
                <button class="btn-action btn-resoudre" onclick="resoudreAlerte(${alerte.id})">
                    <span>✅</span> Marquer comme résolu
                </button>
                <button class="btn-action btn-supprimer" onclick="supprimerAlerte(${alerte.id})">
                    <span>🗑️</span> Supprimer
                </button>
            </div>
        </div>

        <div class="alerte-details">
            <div class="detail-item">
                <span class="detail-label">Serveur</span>
                <span class="detail-value">${alerte.serveurCible != null ? alerte.serveurCible : 'Non spécifié'}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Type</span>
                <span class="detail-value">${alerte.typeAlerte != null ? alerte.typeAlerte : 'Général'}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Date de création</span>
                <span class="detail-value">
                    <fmt:formatDate value="${alerte.dateCreation}" pattern="dd/MM/yyyy HH:mm:ss" />
                </span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Statut</span>
                <span class="detail-value">
                    ${alerte.resolue ?
                        '<span style="color: #28a745; font-weight: 700;">RÉSOLUE</span>' :
                        '<span style="color: #d50032; font-weight: 700;">ACTIVE</span>'}
                </span>
            </div>
        </div>

        <div class="alerte-description">
            <h3>Description</h3>
            <p>${alerte.description != null ? alerte.description : 'Aucune description fournie.'}</p>
        </div>

        <div class="historique-section">
            <h3>Historique des actions</h3>
            <div class="historique-list">
                <div class="historique-item">
                    <span class="historique-action">Alerte créée</span>
                    <span class="historique-date">
                        <fmt:formatDate value="${alerte.dateCreation}" pattern="dd/MM/yyyy HH:mm:ss" />
                    </span>
                </div>
                <c:if test="${alerte.resolue && alerte.dateResolution != null}">
                <div class="historique-item">
                    <span class="historique-action">Alerte résolue</span>
                    <span class="historique-date">
                        <fmt:formatDate value="${alerte.dateResolution}" pattern="dd/MM/yyyy HH:mm:ss" />
                    </span>
                </div>
                </c:if>
            </div>
        </div>

        <a href="/alertes" class="back-link">
            <span>←</span> Retour à la liste des alertes
        </a>
    </div>
</div>

<script>
function resoudreAlerte(alerteId) {
    if (!confirm('Voulez-vous marquer cette alerte comme résolue ?')) return;

    fetch('/alertes/resoudre/' + alerteId, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'}
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('✅ Alerte marquée comme résolue', 'success');
            setTimeout(() => location.reload(), 1500);
        } else {
            showNotification('❌ ' + data.message, 'error');
        }
    })
    .catch(error => {
        showNotification('❌ Erreur réseau', 'error');
    });
}

function supprimerAlerte(alerteId) {
    if (!confirm('Voulez-vous vraiment supprimer cette alerte ?')) return;

    fetch('/alertes/supprimer/' + alerteId, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'}
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('✅ Alerte supprimée', 'success');
            setTimeout(() => window.location.href = '/alertes', 1500);
        } else {
            showNotification('❌ ' + data.message, 'error');
        }
    })
    .catch(error => {
        showNotification('❌ Erreur réseau', 'error');
    });
}
</script>

<jsp:include page="../includes/footer.jsp" />