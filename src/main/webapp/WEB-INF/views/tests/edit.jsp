<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>✏️ Modifier le Test</h2>
        <div style="display: flex; gap: 1rem;">
            <a href="/tests" class="btn btn-secondary">← Retour à la liste</a>
            <a href="/tests/details/${test.id}" class="btn btn-info">👁️ Voir</a>
        </div>
    </div>

    <div class="card" style="max-width: 700px; margin: 0 auto;">
        <form action="/tests/modifier/${test.id}" method="post" id="testForm">
            <div class="form-grid" style="display: grid; gap: 1.5rem;">

                <!-- Informations de base -->
                <div class="form-section">
                    <h3 style="color: #4361ee; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #4361ee;">📋 Informations de base</h3>

                    <div class="form-group">
                        <label for="codeTest" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Code *
                        </label>
                        <input type="text" id="codeTest" name="codeTest" value="${test.codeTest}" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: #f8f9fa;"
                               readonly>
                        <div style="color: #6c757d; font-size: 0.8rem; margin-top: 0.25rem;">
                            Le code ne peut pas être modifié
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="nomTest" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Nom *
                        </label>
                        <input type="text" id="nomTest" name="nomTest" value="${test.nomTest}" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: Test de conformité API">
                    </div>

                    <div class="form-group">
                        <label for="description" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Description
                        </label>
                        <textarea id="description" name="description" rows="3"
                                  style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; resize: vertical;"
                                  placeholder="Description du test">${test.description}</textarea>
                    </div>
                </div>

                <!-- Configuration technique -->
                <div class="form-section">
                    <h3 style="color: #7209b7; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #7209b7;">🔧 Configuration technique</h3>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="typeTest" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Type *
                            </label>
                            <select id="typeTest" name="typeTest" required
                                    style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                                <option value="">Sélectionner un type</option>
                                <option value="HTTP" ${test.typeTest == 'HTTP' ? 'selected' : ''}>HTTP</option>
                                <option value="HTTPS" ${test.typeTest == 'HTTPS' ? 'selected' : ''}>HTTPS</option>
                                <option value="TCP" ${test.typeTest == 'TCP' ? 'selected' : ''}>TCP</option>
                                <option value="PING" ${test.typeTest == 'PING' ? 'selected' : ''}>PING</option>
                                <option value="DATABASE" ${test.typeTest == 'DATABASE' ? 'selected' : ''}>Base de données</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="methodeHttp" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Méthode *
                            </label>
                            <select id="methodeHttp" name="methodeHttp" required
                                    style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                                <option value="">Sélectionner une méthode</option>
                                <option value="GET" ${test.methodeHttp == 'GET' ? 'selected' : ''}>GET</option>
                                <option value="POST" ${test.methodeHttp == 'POST' ? 'selected' : ''}>POST</option>
                                <option value="PUT" ${test.methodeHttp == 'PUT' ? 'selected' : ''}>PUT</option>
                                <option value="DELETE" ${test.methodeHttp == 'DELETE' ? 'selected' : ''}>DELETE</option>
                                <option value="PING" ${test.methodeHttp == 'PING' ? 'selected' : ''}>PING</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="endpoint" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Endpoint *
                        </label>
                        <input type="text" id="endpoint" name="endpoint" value="${test.endpoint}" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: https://api.example.com/health">
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="port" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Port
                            </label>
                            <input type="number" id="port" name="port" value="${test.port}"
                                   style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                                   placeholder="Ex: 8080">
                        </div>

                        <div class="form-group">
                            <label for="timeoutMs" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Timeout (ms)
                            </label>
                            <input type="number" id="timeoutMs" name="timeoutMs" value="${test.timeoutMs}"
                                   style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                                   placeholder="Ex: 5000">
                        </div>
                    </div>
                </div>

                <!-- Paramètres de validation -->
                <div class="form-section">
                    <h3 style="color: #06d6a0; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #06d6a0;">📊 Paramètres de validation</h3>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="validationType" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Type de validation
                            </label>
                            <select id="validationType" name="validationType"
                                    style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                                <option value="STATUS_CODE" ${test.validationType == 'STATUS_CODE' ? 'selected' : ''}>Status Code</option>
                                <option value="RESPONSE_BODY" ${test.validationType == 'RESPONSE_BODY' ? 'selected' : ''}>Response Body</option>
                                <option value="HEADER" ${test.validationType == 'HEADER' ? 'selected' : ''}>Header</option>
                                <option value="CONNECTION" ${test.validationType == 'CONNECTION' ? 'selected' : ''}>Connection</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="statusAttendu" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Status attendu
                            </label>
                            <input type="number" id="statusAttendu" name="statusAttendu" value="${test.statusAttendu}"
                                   style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                                   placeholder="Ex: 200">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="valeurAttendue" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Valeur attendue
                        </label>
                        <input type="text" id="valeurAttendue" name="valeurAttendue" value="${test.valeurAttendue}"
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: OK ou valeur spécifique">
                    </div>
                </div>

                <!-- Statut -->
                <div class="form-section">
                    <h3 style="color: #f39c12; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #f39c12;">📈 Statut</h3>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                            <input type="checkbox" id="actif" name="actif" ${test.actif ? 'checked' : ''}
                                   style="width: 18px; height: 18px;">
                            <span style="font-weight: 600; color: #495057;">Test actif</span>
                        </label>
                        <div style="color: #6c757d; font-size: 0.8rem; margin-top: 0.25rem;">
                            Si désactivé, le test ne sera pas exécuté
                        </div>
                    </div>
                </div>
            </div>

            <!-- Actions du formulaire -->
            <div style="display: flex; gap: 1rem; justify-content: flex-end; margin-top: 2rem; padding-top: 1.5rem; border-top: 2px solid #e9ecef;">
                <a href="/tests/details/${test.id}" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">
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
document.getElementById('testForm').addEventListener('submit', function(e) {
    const nom = document.getElementById('nomTest').value.trim();
    const type = document.getElementById('typeTest').value;
    const methode = document.getElementById('methodeHttp').value;
    const endpoint = document.getElementById('endpoint').value.trim();

	if (!nom || !type || !methode || !endpoint) {
	    e.preventDefault();
	    showNotification('⚠️ Veuillez remplir tous les champs obligatoires (*)', 'warning');
	    return;
	}

    // Validation du endpoint pour HTTP/HTTPS
	// Validation du endpoint pour HTTP/HTTPS
	if (type === 'HTTP' || type === 'HTTPS') {
	    if (!endpoint.startsWith('http://') && !endpoint.startsWith('https://')) {
	        e.preventDefault();
	        showNotification('⚠️ L\'endpoint doit commencer par http:// ou https:// pour les types HTTP/HTTPS', 'warning');
	        return;
	    }
	}
});

// Styles pour les focus
const inputs = document.querySelectorAll('input, select, textarea');
inputs.forEach(input => {
    if (!input.readOnly) {
        input.addEventListener('focus', function() {
            this.style.borderColor = '#4361ee';
            this.style.boxShadow = '0 0 0 3px rgba(67, 97, 238, 0.1)';
        });

        input.addEventListener('blur', function() {
            this.style.borderColor = '#e9ecef';
            this.style.boxShadow = 'none';
        });
    }
});

document.getElementById('testForm').addEventListener('submit', function(e) {
    // NE PAS mettre e.preventDefault() ici - laisse la validation HTML faire son travail
    // La confirmation se fera après la validation

    const nom = document.getElementById('nomTest').value.trim();
    const type = document.getElementById('typeTest').value;
    const methode = document.getElementById('methodeHttp').value;
    const endpoint = document.getElementById('endpoint').value.trim();

    if (!nom || !type || !methode || !endpoint) {
        // La validation HTML va gérer l'erreur
        return;
    }

    // Si tous les champs sont valides, montrer la confirmation
    e.preventDefault();

    showConfirmation(
        'Enregistrer les modifications',
        'Voulez-vous enregistrer les modifications apportées à ce test ?',
        function() {
            document.getElementById('testForm').submit();
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
.form-section:nth-child(3) { border-left-color: #06d6a0; }
.form-section:last-child { border-left-color: #f39c12; }

input:focus, select:focus, textarea:focus {
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