<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <!-- En-tête -->
    <div class="page-header">
        <h2>🗄️ Détails du Serveur</h2>
        <div class="header-actions">
            <a href="/serveurs" class="btn btn-secondary">
                ← Retour à la liste
            </a>
        </div>
    </div>

    <!-- Cartes d'informations -->
    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem; margin-bottom: 2rem;">

        <!-- Informations principales -->
        <div class="card">
            <div style="background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; padding: 1.5rem; border-radius: 10px 10px 0 0;">
                <h3 style="margin: 0; display: flex; align-items: center; gap: 0.5rem;">
                    🖥️ ${serveur.nom}
                </h3>
                <p style="margin: 0.5rem 0 0 0; opacity: 0.9;">
                    ${serveur.typeServeur} - ${serveur.environnement}
                </p>
            </div>

            <div style="padding: 2rem;">
                <!-- Informations de base -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                    <div>
                        <h4 style="color: #4361ee; margin-bottom: 1rem;">📋 Informations</h4>
                        <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                            <div>
                                <strong>Type:</strong>
                                <span class="badge badge-category-processus_metier">${serveur.typeServeur}</span>
                            </div>
                            <div>
                                <strong>Environnement:</strong>
                                <span class="badge" style="background: #7209b7; color: white;">${serveur.environnement}</span>
                            </div>
                            <div>
                                <strong>Caisse:</strong>
                                <span>${serveur.caisseCode}</span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <h4 style="color: #4361ee; margin-bottom: 1rem;">🌐 Réseau</h4>
                        <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                            <div>
                                <strong>URL:</strong>
                                <code style="background: #f8f9fa; padding: 0.25rem 0.5rem; border-radius: 5px;">${serveur.adresseIP}</code>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Description -->
                <c:if test="${not empty serveur.description}">
                    <div style="margin-bottom: 2rem;">
                        <h4 style="color: #4361ee; margin-bottom: 1rem;">📝 Description</h4>
                        <p style="background: #f8f9fa; padding: 1rem; border-radius: 10px; border-left: 4px solid #4361ee;">
                            ${serveur.description}
                        </p>
                    </div>
                </c:if>

                <!-- Actions -->
                <div style="display: flex; gap: 1rem; border-top: 2px solid #e9ecef; padding-top: 2rem;">
                    <a href="/serveurs/edit/${serveur.id}"
                       class="btn btn-primary" style="background: #4361ee;">
                        ✏️ Modifier
                    </a>
                    <form action="/serveurs/delete/${serveur.id}" method="post" style="display: inline;">
                        <button type="submit"
                                onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce serveur ?')"
                                class="btn btn-danger" style="background: #ef476f;">
                            🗑️ Supprimer
                        </button>
                    </form>
                    <a href="/serveurs-stats/${serveur.nom}"
                       class="btn" style="background: #06d6a0; color: white;">
                        📈 Statistiques
                    </a>
                </div>
            </div>
        </div>

        <!-- Analyse et métadonnées -->
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
            <!-- Analyse du nom -->
            <div class="card">
                <h4 style="color: #4361ee; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                    🔍 Analyse du nom
                </h4>
                <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                    <div>
                        <strong>Code Caisse:</strong>
                        <span class="badge" style="background: #4cc9f0; color: white;">${codeCaisse}</span>
                    </div>
                    <div>
                        <strong>Numéro Serveur:</strong>
                        <span class="badge" style="background: #f72585; color: white;">${numeroServeur}</span>
                    </div>
                    <div>
                        <strong>Type Patron:</strong>
                        <span class="badge" style="background: #7209b7; color: white;">${typePatron}</span>
                    </div>
                    <div>
                        <strong>Statut:</strong>
                        <c:choose>
                            <c:when test="${estPrimaire}">
                                <span class="status-badge active">Primaire</span>
                            </c:when>
                            <c:when test="${estSecondaire}">
                                <span class="status-badge" style="background: #ff9e00; color: white;">Secondaire</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge inactive">Standard</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Dernières mises à jour -->
            <c:if test="${not empty misesAJour}">
                <div class="card">
                    <h4 style="color: #4361ee; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                        🔄 Dernières MAJ
                    </h4>
                    <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                        <c:forEach var="maj" items="${misesAJour}" end="2">
                            <div style="background: #f8f9fa; padding: 0.75rem; border-radius: 8px;">
                                <div style="font-weight: 600;">${maj.typeMiseAJour}</div>
                                <div style="font-size: 0.8rem; color: #6c757d;">
                                    <fmt:formatDate value="${maj.datePlanification}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<style>
.dashboard {
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.card {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    padding: 1.5rem;
}

.btn {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 25px;
    font-weight: 600;
    text-decoration: none;
    cursor: pointer;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.btn-primary {
    background: #4361ee;
    color: white;
}

.btn-danger {
    background: #ef476f;
    color: white;
}

.badge {
    padding: 0.25rem 0.75rem;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 600;
    display: inline-block;
}

.badge-category-processus_metier {
    background: linear-gradient(135deg, #7209b7, #4361ee);
    color: white;
}

.status-badge {
    padding: 0.25rem 0.75rem;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
}

.status-badge.active {
    background: linear-gradient(135deg, #06d6a0, #118ab2);
    color: white;
}

.status-badge.inactive {
    background: linear-gradient(135deg, #6c757d, #8d99ae);
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        gap: 1rem;
        text-align: center;
    }

    div[style*="grid-template-columns: 2fr 1fr"] {
        grid-template-columns: 1fr;
    }
}
</style>

<jsp:include page="../includes/footer.jsp" />