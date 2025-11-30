<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>👁️ Détails de la Caisse</h2>
        <div style="display: flex; gap: 1rem;">
            <a href="/caisses" class="btn btn-secondary">← Retour à la liste</a>
            <a href="/caisses/modifier/${caisse.id}" class="btn btn-warning">✏️ Modifier</a>
        </div>
    </div>

    <div class="card" style="max-width: 800px; margin: 0 auto;">
        <!-- En-tête avec statut -->
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 2px solid #e9ecef;">
            <div>
                <h1 style="color: #4361ee; margin: 0;">${caisse.nom}</h1>
                <p style="color: #6c757d; margin: 0.25rem 0 0 0;">Code: ${caisse.code}</p>
            </div>
            <span class="status-badge ${caisse.actif ? 'active' : 'inactive'}" style="font-size: 1rem; padding: 0.5rem 1rem;">
                ${caisse.actif ? '✅ Active' : '❌ Inactive'}
            </span>
        </div>

        <!-- Informations principales -->
        <div class="info-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
            <div class="info-card">
                <h3 style="color: #4361ee; margin-bottom: 1rem;">📋 Informations Générales</h3>
                <div class="info-item">
                    <strong>Code:</strong>
                    <span style="color: #4361ee; font-weight: 600;">${caisse.code}</span>
                </div>
                <div class="info-item">
                    <strong>Nom:</strong>
                    <span>${caisse.nom}</span>
                </div>
            </div>

            <div class="info-card">
                <h3 style="color: #7209b7; margin-bottom: 1rem;">🔗 Références</h3>
                <div class="info-item">
                    <strong>Partition:</strong>
                    <span style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                        ${caisse.codePartition}
                    </span>
                </div>
                <div class="info-item">
                    <strong>CR:</strong>
                    <span style="background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                        ${caisse.codeCr}
                    </span>
                </div>
            </div>
        </div>

        <!-- Actions -->
        <div style="display: flex; gap: 1rem; justify-content: center; padding-top: 2rem; border-top: 2px solid #e9ecef;">
            <button onclick="toggleCaisseStatus(${caisse.id})"
                    class="btn ${caisse.actif ? 'btn-danger' : 'btn-success'}"
                    style="padding: 0.75rem 1.5rem;">
                ${caisse.actif ? '⏸️ Désactiver' : '▶️ Activer'}
            </button>
            <a href="/caisses/modifier/${caisse.id}" class="btn btn-warning" style="padding: 0.75rem 1.5rem;">
                ✏️ Modifier
            </a>
            <a href="/caisses" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">
                ← Retour
            </a>
        </div>
    </div>
</div>

<script>
function toggleCaisseStatus(caisseId) {
    if (confirm('Voulez-vous changer le statut de cette caisse ?')) {
        window.location.href = '/caisses/toggle/' + caisseId;
    }
}
</script>

<style>
.info-card {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 10px;
    border-left: 4px solid #4361ee;
}

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
</style>

<%@ include file="../includes/footer.jsp" %>