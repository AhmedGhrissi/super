<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />

<style>
.alertes-container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 1.5rem;
}

.alertes-header {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.alertes-stats {
    display: flex;
    gap: 1rem;
    margin-top: 1rem;
    flex-wrap: wrap;
}

.stat-badge {
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 600;
    font-size: 0.9rem;
}

.stat-badge.total { background: #006747; color: white; }
.stat-badge.critical { background: #d50032; color: white; }
.stat-badge.warning { background: #ffc107; color: #333; }
.stat-badge.info { background: #2196F3; color: white; }

.alertes-grid {
    display: grid;
    gap: 1rem;
}

.alerte-card {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    border-left: 5px solid;
}

.alerte-card.critical { border-left-color: #d50032; }
.alerte-card.warning { border-left-color: #ffc107; }
.alerte-card.info { border-left-color: #2196F3; }

.alerte-header {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 1rem;
}

.alerte-icon {
    font-size: 2rem;
}

.alerte-title {
    flex: 1;
}

.alerte-actions {
    display: flex;
    gap: 0.5rem;
}

.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.empty-state-icon {
    font-size: 4rem;
    margin-bottom: 1rem;
}
</style>

<div class="alertes-container">
    <div class="alertes-header">
        <h1 style="color: #006747; margin-bottom: 0.5rem;">
            <span>🚨</span> Alertes du Système
        </h1>
        <p>Supervision en temps réel des incidents</p>

        <div class="alertes-stats">
            <div class="stat-badge total">Total: ${totalAlertes}</div>
            <div class="stat-badge critical">Critiques: ${alertesCritiquesCount}</div>
            <c:if test="${not empty statsAlertes}">
                <div class="stat-badge warning">Avertissements: ${statsAlertes.warning}</div>
                <div class="stat-badge info">Informations: ${statsAlertes.info}</div>
            </c:if>
        </div>

        <div style="margin-top: 1.5rem; display: flex; gap: 1rem;">
            <button onclick="rafraichirAlertes()" class="btn-action">
                <span>🔄</span> Rafraîchir
            </button>
            <a href="/dashboard" class="btn-action secondary">
                <span>📊</span> Retour Dashboard
            </a>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty alertes && !alertes.isEmpty()}">
            <div class="alertes-grid">
                <c:forEach var="alerte" items="${alertes}">
                    <div class="alerte-card ${alerte.criticite}">
                        <div class="alerte-header">
                            <div class="alerte-icon">${alerte.icone}</div>
                            <div class="alerte-title">
                                <h3 style="margin: 0 0 0.5rem 0;">${alerte.nom}</h3>
                                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                                    <span class="alert-tag ${alerte.criticite}">
                                        ${alerte.statutCourt}
                                    </span>
                                    <c:if test="${not empty alerte.type}">
                                        <span class="alert-tag type">${alerte.type}</span>
                                    </c:if>
                                    <span class="alert-tag timestamp">${alerte.timestampDisplay}</span>
                                </div>
                            </div>
                        </div>

                        <div style="margin: 1rem 0; padding: 1rem; background: #f8f9fa; border-radius: 8px;">
                            ${alerte.description}
                        </div>

                        <c:if test="${not empty alerte.serveurCible or not empty alerte.caisseCode}">
                            <div style="display: flex; gap: 1rem; color: #666; font-size: 0.9rem;">
                                <c:if test="${not empty alerte.serveurCible}">
                                    <div><strong>Serveur:</strong> ${alerte.serveurCible}</div>
                                </c:if>
                                <c:if test="${not empty alerte.caisseCode}">
                                    <div><strong>Caisse:</strong> ${alerte.caisseCode}</div>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-state-icon">✅</div>
                <h3>Aucune alerte active</h3>
                <p>Tous les systèmes fonctionnent normalement</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function rafraichirAlertes() {
    const btn = event.target;
    const originalText = btn.innerHTML;
    btn.innerHTML = '<span>⏳</span> Rafraîchissement...';
    btn.disabled = true;

    fetch('/alertes/api/refresh')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                showNotification('Alertes rafraîchies avec succès', 'success');
                setTimeout(() => location.reload(), 1000);
            } else {
                showNotification('Erreur lors du rafraîchissement', 'error');
                btn.innerHTML = originalText;
                btn.disabled = false;
            }
        })
        .catch(error => {
            console.error('Erreur:', error);
            showNotification('Erreur réseau', 'error');
            btn.innerHTML = originalText;
            btn.disabled = false;
        });
}
</script>

<jsp:include page="../includes/footer.jsp" />