<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles spécifiques pour le formulaire de création */
.caisse-form-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.caisse-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.caisse-title-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
}

.caisse-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.caisse-title h1 {
    margin: 0;
    font-size: 1.75rem;
    font-weight: 700;
}

/* Formulaire moderne */
.form-modern-caisse {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.form-grid-modern {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1.5rem;
}

.form-section-modern {
    padding: 1.5rem;
    border-radius: 10px;
    background: #f8f9fa;
    border-left: 4px solid;
}

.form-section-modern:nth-child(1) {
    border-left-color: #006747;
}

.form-section-modern:nth-child(2) {
    border-left-color: #7209b7;
}

.form-section-modern:nth-child(3) {
    border-left-color: #06d6a0;
}

.form-group-modern {
    margin-bottom: 1.5rem;
}

.form-label-modern {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 600;
    color: #495057;
    font-size: 0.95rem;
}

.form-control-modern {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    background: white;
}

.form-control-modern:focus {
    outline: none;
    border-color: #006747;
    box-shadow: 0 0 0 3px rgba(0, 103, 71, 0.1);
}

.form-text-modern {
    color: #6c757d;
    font-size: 0.8rem;
    margin-top: 0.25rem;
    display: block;
}

/* Checkbox moderne */
.checkbox-modern {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    cursor: pointer;
}

.checkbox-input-modern {
    width: 20px;
    height: 20px;
    cursor: pointer;
}

.checkbox-label-modern {
    font-weight: 600;
    color: #495057;
    cursor: pointer;
}

/* Actions du formulaire */
.form-actions-modern {
    display: flex;
    gap: 1rem;
    justify-content: flex-end;
    margin-top: 2rem;
    padding-top: 1.5rem;
    border-top: 2px solid #e9ecef;
}

.btn-modern {
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
    font-size: 0.95rem;
}

.btn-cancel-modern {
    background: #6c757d;
    color: white;
}

.btn-cancel-modern:hover {
    background: #5a6268;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.btn-submit-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
}

.btn-submit-modern:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
}

/* Responsive */
@media (max-width: 768px) {
    .caisse-form-container {
        padding: 1rem;
    }

    .caisse-title-section {
        flex-direction: column;
        align-items: flex-start;
    }

    .form-actions-modern {
        flex-direction: column;
    }

    .btn-modern {
        width: 100%;
        justify-content: center;
    }
}
</style>

<div class="caisse-form-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="caisse-header-modern">
        <div class="caisse-title-section">
            <div class="caisse-title">
                <h1>➕ Créer une Caisse</h1>
            </div>
            <a href="/caisses" class="btn-modern btn-cancel-modern">
                <span>←</span> Retour à la liste
            </a>
        </div>
        <p style="margin: 1rem 0 0 0; opacity: 0.9; font-size: 0.95rem;">
            Ajouter une nouvelle caisse au système de monitoring
        </p>
    </div>

    <!-- ========== FORMULAIRE MODERNE ========== -->
    <form action="/caisses" method="post" class="form-modern-caisse" id="caisseForm">
        <div class="form-grid-modern">

            <!-- Section 1 : Informations de base -->
            <div class="form-section-modern">
                <h3 style="color: #006747; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
                    <span>📋</span>
                    Informations de base
                </h3>

                <div class="form-group-modern">
                    <label for="code" class="form-label-modern">
                        Code *
                        <span class="form-text-modern">(identifiant unique)</span>
                    </label>
                    <input type="text" id="code" name="code" required
                           class="form-control-modern"
                           placeholder="Ex: CAISSE_001">
                    <span class="form-text-modern">
                        Utilisez un code unique pour identifier cette caisse
                    </span>
                </div>

                <div class="form-group-modern">
                    <label for="nom" class="form-label-modern">
                        Nom *
                    </label>
                    <input type="text" id="nom" name="nom" required
                           class="form-control-modern"
                           placeholder="Ex: Caisse Principale">
                </div>

                <div class="form-group-modern">
                    <label for="description" class="form-label-modern">
                        Description
                    </label>
                    <textarea id="description" name="description" rows="3"
                              class="form-control-modern"
                              placeholder="Description optionnelle de la caisse"></textarea>
                </div>
            </div>

            <!-- Section 2 : Références -->
            <div class="form-section-modern">
                <h3 style="color: #7209b7; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
                    <span>🔗</span>
                    Références
                </h3>

                <div class="form-group-modern">
                    <label for="codePartition" class="form-label-modern">
                        Code Partition *
                    </label>
                    <input type="text" id="codePartition" name="codePartition" required
                           class="form-control-modern"
                           placeholder="Ex: PART_001">
                </div>

                <div class="form-group-modern">
                    <label for="codeCr" class="form-label-modern">
                        Code CR *
                    </label>
                    <input type="text" id="codeCr" name="codeCr" required
                           class="form-control-modern"
                           placeholder="Ex: CR_001">
                </div>
            </div>

            <!-- Section 3 : Statut -->
            <div class="form-section-modern">
                <h3 style="color: #06d6a0; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
                    <span>📊</span>
                    Statut
                </h3>

                <div class="form-group-modern">
                    <label class="checkbox-modern">
                        <input type="checkbox" id="actif" name="actif" checked
                               class="checkbox-input-modern">
                        <span class="checkbox-label-modern">Caisse active</span>
                    </label>
                    <span class="form-text-modern">
                        Si désactivé, la caisse ne sera pas utilisable dans les tests
                    </span>
                </div>
            </div>
        </div>

        <!-- ========== ACTIONS DU FORMULAIRE ========== -->
        <div class="form-actions-modern">
            <a href="/caisses" class="btn-modern btn-cancel-modern">
                ❌ Annuler
            </a>
            <button type="submit" class="btn-modern btn-submit-modern">
                💾 Créer la caisse
            </button>
        </div>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('caisseForm');
    const inputs = form.querySelectorAll('.form-control-modern');

    // Validation du formulaire
    form.addEventListener('submit', function(e) {
        const code = document.getElementById('code').value.trim();
        const nom = document.getElementById('nom').value.trim();
        const partition = document.getElementById('codePartition').value.trim();
        const cr = document.getElementById('codeCr').value.trim();

        if (!code || !nom || !partition || !cr) {
            e.preventDefault();
            showNotification('❌ Veuillez remplir tous les champs obligatoires (*)', 'error');
            return;
        }

        if (code.length < 2) {
            e.preventDefault();
            showNotification('❌ Le code doit contenir au moins 2 caractères', 'error');
            return;
        }
    });

    // Animation des inputs
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.style.borderColor = '#006747';
            this.style.boxShadow = '0 0 0 3px rgba(0, 103, 71, 0.1)';
        });

        input.addEventListener('blur', function() {
            this.style.borderColor = '#e9ecef';
            this.style.boxShadow = 'none';
        });
    });
});

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
</script>

<jsp:include page="../includes/footer.jsp" />