<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>➕ Créer une Caisse</h2>
        <a href="/caisses" class="btn btn-secondary">← Retour à la liste</a>
    </div>

    <div class="card" style="max-width: 600px; margin: 0 auto;">
        <form action="/caisses" method="post" id="caisseForm">
            <div class="form-grid" style="display: grid; gap: 1.5rem;">

                <!-- Informations de base -->
                <div class="form-section">
                    <h3 style="color: #4361ee; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #4361ee;">📋 Informations de base</h3>

                    <div class="form-group">
                        <label for="code" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Code *
                            <span style="color: #6c757d; font-weight: normal;">(unique)</span>
                        </label>
                        <input type="text" id="code" name="code" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; transition: all 0.3s ease;"
                               placeholder="Ex: CAISSE_001">
                        <div style="color: #6c757d; font-size: 0.8rem; margin-top: 0.25rem;">
                            Le code doit être unique et identifier la caisse
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="nom" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Nom *
                        </label>
                        <input type="text" id="nom" name="nom" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: Caisse Principale">
                    </div>

                    <div class="form-group">
                        <label for="description" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Description
                        </label>
                        <textarea id="description" name="description" rows="3"
                                  style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; resize: vertical;"
                                  placeholder="Description optionnelle de la caisse"></textarea>
                    </div>
                </div>

                <!-- Références -->
                <div class="form-section">
                    <h3 style="color: #7209b7; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #7209b7;">🔗 Références</h3>

                    <div class="form-group">
                        <label for="codePartition" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Code Partition *
                        </label>
                        <input type="text" id="codePartition" name="codePartition" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: PART_001">
                    </div>

                    <div class="form-group">
                        <label for="codeCr" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Code CR *
                        </label>
                        <input type="text" id="codeCr" name="codeCr" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: CR_001">
                    </div>
                </div>

                <!-- Statut -->
                <div class="form-section">
                    <h3 style="color: #06d6a0; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #06d6a0;">📊 Statut</h3>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                            <input type="checkbox" id="actif" name="actif" checked
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
                <a href="/caisses" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">
                    ❌ Annuler
                </a>
                <button type="submit" class="btn btn-primary" style="padding: 0.75rem 1.5rem;">
                    💾 Créer la caisse
                </button>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('caisseForm').addEventListener('submit', function(e) {
    const code = document.getElementById('code').value.trim();
    const nom = document.getElementById('nom').value.trim();
    const partition = document.getElementById('codePartition').value.trim();
    const cr = document.getElementById('codeCr').value.trim();

    if (!code || !nom || !partition || !cr) {
        e.preventDefault();
        alert('Veuillez remplir tous les champs obligatoires (*)');
        return;
    }

    // Validation basique du format
    if (code.length < 2) {
        e.preventDefault();
        alert('Le code doit contenir au moins 2 caractères');
        return;
    }
});

// Styles pour les focus
const inputs = document.querySelectorAll('input, textarea');
inputs.forEach(input => {
    input.addEventListener('focus', function() {
        this.style.borderColor = '#4361ee';
        this.style.boxShadow = '0 0 0 3px rgba(67, 97, 238, 0.1)';
    });

    input.addEventListener('blur', function() {
        this.style.borderColor = '#e9ecef';
        this.style.boxShadow = 'none';
    });
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

.form-section:first-child {
    border-left-color: #4361ee;
}

.form-section:nth-child(2) {
    border-left-color: #7209b7;
}

.form-section:last-child {
    border-left-color: #06d6a0;
}

input:focus, textarea:focus {
    outline: none;
    border-color: #4361ee !important;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}
</style>

<%@ include file="../includes/footer.jsp" %>