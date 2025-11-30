<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>✏️ Modifier la Caisse</h2>
        <div style="display: flex; gap: 1rem;">
            <a href="/caisses" class="btn btn-secondary">← Retour à la liste</a>
            <a href="/caisses/details/${caisse.id}" class="btn btn-info">👁️ Voir</a>
        </div>
    </div>

    <div class="card" style="max-width: 600px; margin: 0 auto;">
        <form action="/caisses/modifier/${caisse.id}" method="post" id="caisseForm">
            <div class="form-grid" style="display: grid; gap: 1.5rem;">

                <!-- Informations de base -->
                <div class="form-section">
                    <h3 style="color: #4361ee; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #4361ee;">📋 Informations de base</h3>

                    <div class="form-group">
                        <label for="code" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Code *
                        </label>
                        <input type="text" id="code" name="code" value="${caisse.code}" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: #f8f9fa;"
                               readonly>
                        <div style="color: #6c757d; font-size: 0.8rem; margin-top: 0.25rem;">
                            Le code ne peut pas être modifié
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="nom" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Nom *
                        </label>
                        <input type="text" id="nom" name="nom" value="${caisse.nom}" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: Caisse Principale">
                    </div>
                </div>

                <!-- Références -->
                <div class="form-section">
                    <h3 style="color: #7209b7; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #7209b7;">🔗 Références</h3>

                    <div class="form-group">
                        <label for="codePartition" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Code Partition *
                        </label>
                        <input type="text" id="codePartition" name="codePartition" value="${caisse.codePartition}" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: PART_001">
                    </div>

                    <div class="form-group">
                        <label for="codeCr" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Code CR *
                        </label>
                        <input type="text" id="codeCr" name="codeCr" value="${caisse.codeCr}" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: CR_001">
                    </div>
                </div>

                <!-- Statut -->
                <div class="form-section">
                    <h3 style="color: #06d6a0; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #06d6a0;">📊 Statut</h3>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                            <input type="checkbox" id="actif" name="actif" ${caisse.actif ? 'checked' : ''}
                                   style="width: 18px; height: 18px;">
                            <span style="font-weight: 600; color: #495057;">Caisse active</span>
                        </label>
                        <div style="color: #6c757d; font-size: 0.8rem; margin-top: 0.25rem;">
                            Si désactivé, la caisse ne sera pas utilisable
                        </div>
                    </div>
                </div>
            </div>

            <!-- Actions du formulaire -->
            <div style="display: flex; gap: 1rem; justify-content: flex-end; margin-top: 2rem; padding-top: 1.5rem; border-top: 2px solid #e9ecef;">
                <a href="/caisses/details/${caisse.id}" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">
                    ❌ Annuler
                </a>
                <button type="submit" class="btn btn-primary" style="padding: 0.75rem 1.5rem;">
                    💾 Enregistrer les modifications
                </button>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('caisseForm').addEventListener('submit', function(e) {
    const nom = document.getElementById('nom').value.trim();
    const partition = document.getElementById('codePartition').value.trim();
    const cr = document.getElementById('codeCr').value.trim();

    if (!nom || !partition || !cr) {
        e.preventDefault();
        alert('Veuillez remplir tous les champs obligatoires (*)');
        return;
    }
});

document.getElementById('caisseForm').addEventListener('submit', function(e) {
    e.preventDefault(); // Empêche l'envoi immédiat

    showConfirmation(
        'Enregistrer les modifications',
        'Voulez-vous enregistrer les modifications apportées à cette caisse ?',
        function() {
            // Soumet le formulaire après confirmation
            document.getElementById('caisseForm').submit();
        }
    );
});
</script>

<style>
.form-group {
    margin-bottom: 1rem;
}

.form-section {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 10px;
    border-left: 4px solid;
}

.form-section:first-child { border-left-color: #4361ee; }
.form-section:nth-child(2) { border-left-color: #7209b7; }
.form-section:last-child { border-left-color: #06d6a0; }

input:focus {
    outline: none;
    border-color: #4361ee !important;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}

input[readonly] {
    background-color: #f8f9fa !important;
    cursor: not-allowed;
}
</style>

<%@ include file="../includes/footer.jsp" %>