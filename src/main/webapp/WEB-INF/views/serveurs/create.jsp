<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* ========== STYLES SPÉCIFIQUES CRÉATION SERVEUR ========== */
.create-server-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.create-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.create-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.create-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.create-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.create-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

/* Carte du formulaire */
.create-card-modern {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
    margin-bottom: 2rem;
}

.create-card-header {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    padding: 2rem;
}

.create-card-header h2 {
    margin: 0;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.create-card-header p {
    margin: 0.75rem 0 0 0;
    opacity: 0.9;
    font-size: 0.95rem;
}

/* Formulaires */
.create-form {
    padding: 2rem;
}

.form-section {
    margin-bottom: 2.5rem;
}

.form-section-title {
    color: #006747;
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1.5rem;
    padding-bottom: 0.75rem;
    border-bottom: 2px solid #e9ecef;
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.form-label {
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
    margin-bottom: 0.25rem;
}

.form-label.required::after {
    content: " *";
    color: #dc3545;
}

.form-input, .form-select, .form-textarea {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 0.95rem;
    font-family: inherit;
    transition: all 0.3s ease;
    width: 100%;
}

.form-input:focus, .form-select:focus, .form-textarea:focus {
    outline: none;
    border-color: #006747;
    box-shadow: 0 0 0 3px rgba(0, 103, 71, 0.1);
}

.form-textarea {
    resize: vertical;
    min-height: 100px;
}

/* Boutons */
.form-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 2rem;
    border-top: 2px solid #e9ecef;
    margin-top: 2rem;
}

.btn-back {
    padding: 0.75rem 1.5rem;
    border: 2px solid #6c757d;
    border-radius: 8px;
    background: white;
    color: #6c757d;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    transition: all 0.3s ease;
}

.btn-back:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
    color: #6c757d;
    text-decoration: none;
}

.btn-submit {
    padding: 0.75rem 2rem;
    border: none;
    border-radius: 8px;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    transition: all 0.3s ease;
}

.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
}

/* Messages d'erreur */
.form-error {
    color: #dc3545;
    font-size: 0.85rem;
    margin-top: 0.25rem;
    display: flex;
    align-items: center;
    gap: 0.25rem;
}

/* Indicateur de champ obligatoire */
.required-indicator {
    color: #dc3545;
    margin-left: 0.25rem;
}

/* Responsive */
@media (max-width: 768px) {
    .create-server-container {
        padding: 1rem;
    }

    .create-title-section {
        flex-direction: column;
        align-items: stretch;
    }

    .form-grid {
        grid-template-columns: 1fr;
    }

    .form-actions {
        flex-direction: column;
        gap: 1rem;
        align-items: stretch;
    }

    .btn-back, .btn-submit {
        width: 100%;
        justify-content: center;
    }
}

@media (max-width: 480px) {
    .create-header-modern {
        padding: 1.5rem;
    }

    .create-form {
        padding: 1.5rem;
    }
}
</style>

<div class="create-server-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="create-header-modern">
        <div class="create-title-section">
            <div>
                <div class="create-title">
                    <h1>➕ Créer un Serveur</h1>
                </div>
                <p class="create-subtitle">Ajoutez un nouveau serveur à votre infrastructure de monitoring</p>
            </div>

            <a href="/serveurs" class="btn-back">
                <span>←</span> Retour à la liste
            </a>
        </div>
    </div>

    <!-- ========== FORMULAIRE ========== -->
    <div class="create-card-modern">
        <div class="create-card-header">
            <h2>🚀 Configuration du Nouveau Serveur</h2>
            <p>Remplissez les informations nécessaires pour ajouter un serveur au système de monitoring</p>
        </div>

        <form:form action="/serveurs/create" method="post" modelAttribute="serveur" class="create-form">

            <!-- Section 1 : Informations de base -->
            <div class="form-section">
                <h3 class="form-section-title">
                    <span>📋</span> Informations de base
                </h3>

                <div class="form-grid">
                    <!-- Nom du serveur -->
                    <div class="form-group">
                        <label class="form-label required">Nom du Serveur</label>
                        <form:input path="nom" class="form-input"
                            placeholder="Ex: SRV-PROD-001" required="true"/>
                        <form:errors path="nom" cssClass="form-error" element="div"/>
                    </div>

                    <!-- Type de serveur -->
                    <div class="form-group">
                        <label class="form-label required">Type de Serveur</label>
                        <form:select path="typeServeur" class="form-select">
                            <c:forEach var="type" items="${typesServeur}">
                                <form:option value="${type}">${type}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="typeServeur" cssClass="form-error" element="div"/>
                    </div>
                </div>
            </div>

            <!-- Section 2 : Configuration réseau -->
            <div class="form-section">
                <h3 class="form-section-title">
                    <span>🌐</span> Configuration Réseau
                </h3>

                <div class="form-grid">
                    <!-- URL/Endpoint -->
                    <div class="form-group">
                        <label class="form-label required">Adresse IP / URL</label>
                        <form:input path="adresseIP" class="form-input"
                            placeholder="Ex: 192.168.1.100 ou https://api.example.com" required="true"/>
                        <form:errors path="adresseIP" cssClass="form-error" element="div"/>
                    </div>


                </div>
            </div>

            <!-- Section 3 : Environnement -->
            <div class="form-section">
                <h3 class="form-section-title">
                    <span>🏷️</span> Environnement
                </h3>

                <div class="form-grid">
                    <!-- Environnement -->
                    <div class="form-group">
                        <label class="form-label required">Environnement</label>
                        <form:select path="environnement" class="form-select">
                            <c:forEach var="env" items="${environnements}">
                                <form:option value="${env}">${env}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="environnement" cssClass="form-error" element="div"/>
                    </div>

                    <!-- Caisse -->
                    <div class="form-group">
                        <label class="form-label">Caisse associée</label>
                        <form:select path="caisseCode" class="form-select">
                            <form:option value="">Sélectionnez une caisse</form:option>
                            <c:forEach var="caisse" items="${caisses}">
                                <form:option value="${caisse.code}">${caisse.code} - ${caisse.nom}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="caisseCode" cssClass="form-error" element="div"/>
                    </div>
                </div>
            </div>

            <!-- Section 4 : Statut (si vous voulez l'ajouter) -->
            <div class="form-section">
                <h3 class="form-section-title">
                    <span>⚙️</span> Statut du Serveur
                </h3>

                <div class="form-grid">
                    <!-- Statut -->
                    <div class="form-group">
                        <label class="form-label required">Statut initial</label>
                        <form:select path="statut" class="form-select">
                            <c:forEach var="stat" items="${statuts}">
                                <form:option value="${stat}">${stat}</form:option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="statut" cssClass="form-error" element="div"/>
                    </div>

                    <!-- Champ vide pour l'alignement -->
                    <div class="form-group"></div>
                </div>
            </div>

            <!-- Section 5 : Description -->
            <div class="form-section">
                <h3 class="form-section-title">
                    <span>📝</span> Description
                </h3>

                <div class="form-group">
                    <label class="form-label">Description</label>
                    <form:textarea path="description" class="form-textarea"
                        placeholder="Description du serveur, rôle, fonctionnalités, notes importantes..."/>
                    <form:errors path="description" cssClass="form-error" element="div"/>
                    <small style="color: #6c757d; font-size: 0.85rem; margin-top: 0.25rem;">
                        Optionnel - Maximum 500 caractères
                    </small>
                </div>
            </div>

            <!-- ========== ACTIONS DU FORMULAIRE ========== -->
            <div class="form-actions">
                <a href="/serveurs" class="btn-back">
                    <span>❌</span> Annuler
                </a>
                <button type="submit" class="btn-submit">
                    <span>✅</span> Créer le serveur
                </button>
            </div>
        </form:form>
    </div>

    <!-- ========== INFORMATIONS COMPLÉMENTAIRES ========== -->
    <div class="info-card-modern" style="background: #f8f9fa; border-radius: 12px; padding: 1.5rem; margin-top: 2rem;">
        <h4 style="color: #006747; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
            💡 Informations utiles
        </h4>
        <ul style="color: #6c757d; padding-left: 1.5rem; margin: 0;">
            <li>Le nom du serveur doit être unique et descriptif</li>
            <li>Utilisez des adresses IP ou des URL complètes pour le monitoring</li>
            <li>Associez le serveur à une caisse pour un suivi par entité</li>
            <li>Le statut "ACTIF" déclenchera immédiatement les tests de monitoring</li>
        </ul>
    </div>
</div>

<script>
// ========== VALIDATION ET AMÉLIORATIONS ==========
document.addEventListener('DOMContentLoaded', function() {
    console.log('✅ Formulaire de création de serveur chargé');

    // Validation en temps réel
    const form = document.querySelector('form.create-form');
    const inputs = form.querySelectorAll('.form-input, .form-select, .form-textarea');

    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });

        input.addEventListener('input', function() {
            clearFieldError(this);
        });
    });

    // Validation avant soumission
    form.addEventListener('submit', function(e) {
        let isValid = true;

        inputs.forEach(input => {
            if (input.hasAttribute('required') && !input.value.trim()) {
                showFieldError(input, 'Ce champ est obligatoire');
                isValid = false;
            }
        });

        if (!isValid) {
            e.preventDefault();
            showNotification('Veuillez remplir tous les champs obligatoires', 'error');
        } else {
            showNotification('Création du serveur en cours...', 'info');
        }
    });

    // Fonctions utilitaires
    function validateField(field) {
        if (field.hasAttribute('required') && !field.value.trim()) {
            showFieldError(field, 'Ce champ est obligatoire');
            return false;
        }
        return true;
    }

    function showFieldError(field, message) {
        clearFieldError(field);

        const errorDiv = document.createElement('div');
        errorDiv.className = 'form-error';
        errorDiv.innerHTML = '<span>⚠️</span> ' + message;

        field.parentNode.appendChild(errorDiv);
        field.style.borderColor = '#dc3545';
    }

    function clearFieldError(field) {
        const errorDiv = field.parentNode.querySelector('.form-error');
        if (errorDiv) {
            errorDiv.remove();
        }
        field.style.borderColor = '#e9ecef';
    }

    function showNotification(message, type) {
	    // Déterminer la couleur en fonction du type
	    var backgroundColor;
	    var icon;

	    if (type === 'error') {
	        backgroundColor = '#dc3545';
	        icon = '❌';
	    } else if (type === 'success') {
	        backgroundColor = '#28a745';
	        icon = '✅';
	    } else {
	        backgroundColor = '#006747';
	        icon = 'ℹ️';
	    }

	    // Créer une notification temporaire
	    var notification = document.createElement('div');
	    notification.style.position = 'fixed';
	    notification.style.top = '20px';
	    notification.style.right = '20px';
	    notification.style.padding = '1rem 1.5rem';
	    notification.style.borderRadius = '8px';
	    notification.style.background = backgroundColor;
	    notification.style.color = 'white';
	    notification.style.zIndex = '1000';
	    notification.style.display = 'flex';
	    notification.style.alignItems = 'center';
	    notification.style.gap = '0.5rem';
	    notification.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';

	    notification.innerHTML = '<span>' + icon + '</span><span>' + message + '</span>';

	    document.body.appendChild(notification);

	    setTimeout(function() {
	        if (notification.parentNode) {
	            notification.parentNode.removeChild(notification);
	        }
	    }, 3000);
	}
</script>

<jsp:include page="../includes/footer.jsp" />