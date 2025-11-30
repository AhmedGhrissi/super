<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>👁️ Détails du Test</h2>
        <div style="display: flex; gap: 1rem;">
            <a href="/tests" class="btn btn-secondary">← Retour à la liste</a>
            <a href="/tests/modifier/${test.id}" class="btn btn-warning">✏️ Modifier</a>
        </div>
    </div>

    <div class="card" style="max-width: 900px; margin: 0 auto;">
        <!-- En-tête avec statut -->
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 2px solid #e9ecef;">
            <div>
                <h1 style="color: #4361ee; margin: 0;">${test.nomTest}</h1>
                <p style="color: #6c757d; margin: 0.25rem 0 0 0;">Code: ${test.codeTest}</p>
            </div>
            <span class="status-badge ${test.actif ? 'active' : 'inactive'}" style="font-size: 1rem; padding: 0.5rem 1rem;">
                ${test.actif ? '✅ Actif' : '❌ Inactif'}
            </span>
        </div>

        <!-- Informations principales -->
        <div class="info-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">

            <!-- Colonne gauche -->
            <div>
                <div class="info-card">
                    <h3 style="color: #4361ee; margin-bottom: 1rem;">📋 Informations Générales</h3>
                    <div class="info-item">
                        <strong>Code:</strong>
                        <span style="color: #4361ee; font-weight: 600;">${test.codeTest}</span>
                    </div>
                    <div class="info-item">
                        <strong>Nom:</strong>
                        <span>${test.nomTest}</span>
                    </div>
                    <div class="info-item">
                        <strong>Description:</strong>
                        <span>${empty test.description ? 'Non renseignée' : test.description}</span>
                    </div>
                    <div class="info-item">
                        <strong>Type:</strong>
                        <span class="badge badge-category-${test.typeTest}">
                            ${test.typeTest}
                        </span>
                    </div>
                </div>

                <div class="info-card">
                    <h3 style="color: #7209b7; margin-bottom: 1rem;">🔧 Configuration</h3>
                    <div class="info-item">
                        <strong>Méthode:</strong>
                        <span>${test.methodeHttp}</span>
                    </div>
                    <div class="info-item">
                        <strong>Validation:</strong>
                        <span>${test.validationType}</span>
                    </div>
                </div>
            </div>

            <!-- Colonne droite -->
            <div>
                <div class="info-card">
                    <h3 style="color: #06d6a0; margin-bottom: 1rem;">🌐 Connexion</h3>
                    <div class="info-item">
                        <strong>Endpoint:</strong>
                        <span class="endpoint-cell">${test.endpoint}</span>
                    </div>
                    <div class="info-item">
                        <strong>Port:</strong>
                        <span>${test.port}</span>
                    </div>
                    <div class="info-item">
                        <strong>Timeout:</strong>
                        <span>${test.timeoutMs} ms</span>
                    </div>
                </div>

                <div class="info-card">
                    <h3 style="color: #f39c12; margin-bottom: 1rem;">📊 Validation</h3>
                    <div class="info-item">
                        <strong>Valeur attendue:</strong>
                        <span>${empty test.valeurAttendue ? 'Non défini' : test.valeurAttendue}</span>
                    </div>
                    <div class="info-item">
                        <strong>Status attendu:</strong>
                        <span>${test.statusAttendu}</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Actions -->
        <div style="display: flex; gap: 1rem; justify-content: center; padding-top: 2rem; border-top: 2px solid #e9ecef;">
            <button onclick="toggleTestStatus(${test.id})"
                    class="btn ${test.actif ? 'btn-danger' : 'btn-success'}"
                    style="padding: 0.75rem 1.5rem;">
                ${test.actif ? 'Désactiver' : 'Activer'}
            </button>
            <a href="/tests/modifier/${test.id}" class="btn btn-warning" style="padding: 0.75rem 1.5rem;">
                Modifier
            </a>
            <a href="/tests" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">
                ← Retour
            </a>
        </div>
    </div>
</div>

<script>
function toggleTestStatus(testId) {
    if (confirm('Voulez-vous changer le statut de ce test ?')) {
        window.location.href = '/tests/toggle/' + testId;
    }
}
</script>

<style>
.info-card {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 10px;
    border-left: 4px solid;
    margin-bottom: 1rem;
}

.info-card:nth-child(1) { border-left-color: #4361ee; }
.info-card:nth-child(2) { border-left-color: #7209b7; }
.info-card:nth-child(3) { border-left-color: #06d6a0; }
.info-card:nth-child(4) { border-left-color: #f39c12; }

.info-item {
    display: flex;
    justify-content: space-between;
    margin-bottom: 0.75rem;
    padding-bottom: 0.75rem;
    border-bottom: 1px solid #e9ecef;
}

.info-item strong {
    color: #495057;
    min-width: 120px;
}

.info-item span {
    color: #6c757d;
    text-align: right;
}

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

.badge-category-HTTP { background: #3498db; color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; }
.badge-category-HTTPS { background: #2ecc71; color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; }
.badge-category-TCP { background: #e74c3c; color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; }
.badge-category-PING { background: #f39c12; color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; }
</style>

<%@ include file="../includes/footer.jsp" %>