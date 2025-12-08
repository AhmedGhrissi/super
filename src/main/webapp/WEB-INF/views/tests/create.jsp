<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/css/global-styles.css">
<div class="dashboard">
    <div class="page-header">
        <h2>➕ Créer un Test</h2>
        <a href="/tests" class="btn btn-secondary">← Retour à la liste</a>
    </div>

    <div class="card" style="max-width: 700px; margin: 0 auto;">
        <form action="/tests" method="post" id="testForm">
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
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: TEST_CONFORMITE_001">
                    </div>

                    <div class="form-group">
                        <label for="nom" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Nom *
                        </label>
                        <input type="text" id="nom" name="nom" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: Test de conformité API">
                    </div>

                    <div class="form-group">
                        <label for="description" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Description
                        </label>
                        <textarea id="description" name="description" rows="3"
                                  style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; resize: vertical;"
                                  placeholder="Description du test"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="categorie" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Catégorie *
                        </label>
                        <select id="categorie" name="categorie" required
                                style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                            <option value="">Sélectionner une catégorie</option>
                            <option value="conformite">Conformité</option>
                            <option value="processus_metier">Processus Métier</option>
                            <option value="surveillance">Surveillance</option>
                            <option value="ged">GED</option>
                            <option value="integration">Intégration</option>
                            <option value="web">Applications Web</option>
                        </select>
                    </div>
                </div>

                <!-- Configuration technique -->
                <div class="form-section">
                    <h3 style="color: #7209b7; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #7209b7;">🔧 Configuration technique</h3>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="type" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Type *
                            </label>
                            <select id="type" name="type" required
                                    style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                                <option value="">Sélectionner un type</option>
                                <option value="HTTP">HTTP</option>
                                <option value="HTTPS">HTTPS</option>
                                <option value="TCP">TCP</option>
                                <option value="PING">PING</option>
                                <option value="DATABASE">Base de données</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="methode" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Méthode *
                            </label>
                            <select id="methode" name="methode" required
                                    style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                                <option value="">Sélectionner une méthode</option>
                                <option value="GET">GET</option>
                                <option value="POST">POST</option>
                                <option value="PUT">PUT</option>
                                <option value="DELETE">DELETE</option>
                                <option value="PING">PING</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="endpoint" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Endpoint *
                        </label>
                        <input type="text" id="endpoint" name="endpoint" required
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: https://api.example.com/health">
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="port" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Port
                            </label>
                            <input type="number" id="port" name="port"
                                   style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                                   placeholder="Ex: 8080">
                        </div>

                        <div class="form-group">
                            <label for="timeout" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                                Timeout (ms)
                            </label>
                            <input type="number" id="timeout" name="timeout" value="5000"
                                   style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                                   placeholder="Ex: 5000">
                        </div>
                    </div>
                </div>

                <!-- Paramètres de validation -->
                <div class="form-section">
                    <h3 style="color: #06d6a0; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #06d6a0;">📊 Paramètres de validation</h3>

                    <div class="form-group">
                        <label for="attendu" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Résultat attendu
                        </label>
                        <input type="text" id="attendu" name="attendu"
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: Status 200 OK">
                    </div>

                    <div class="form-group">
                        <label for="seuil" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #495057;">
                            Seuil de réussite (%)
                        </label>
                        <input type="number" id="seuil" name="seuil" value="100" min="0" max="100"
                               style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                               placeholder="Ex: 100">
                    </div>
                </div>

                <!-- Statut -->
                <div class="form-section">
                    <h3 style="color: #f39c12; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #f39c12;">📈 Statut</h3>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                            <input type="checkbox" id="actif" name="actif" checked
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
                <a href="/tests" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">
                    ❌ Annuler
                </a>
                <button type="submit" class="btn btn-primary" style="padding: 0.75rem 1.5rem;">
                    💾 Créer le test
                </button>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('testForm').addEventListener('submit', function(e) {
    const code = document.getElementById('code').value.trim();
    const nom = document.getElementById('nom').value.trim();
    const categorie = document.getElementById('categorie').value;
    const type = document.getElementById('type').value;
    const methode = document.getElementById('methode').value;
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

.form-section:first-child { border-left-color: #4361ee; }
.form-section:nth-child(2) { border-left-color: #7209b7; }
.form-section:nth-child(3) { border-left-color: #06d6a0; }
.form-section:last-child { border-left-color: #f39c12; }

input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: #4361ee !important;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}
</style>

<%@ include file="../includes/footer.jsp" %>