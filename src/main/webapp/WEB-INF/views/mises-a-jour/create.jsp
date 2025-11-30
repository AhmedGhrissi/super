<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="page-header">
        <h2>📅 Planifier une Mise à Jour</h2>
        <a href="/mises-a-jour" class="btn btn-secondary">
            <span>←</span> Retour à la liste
        </a>
    </div>

    <div class="card">
        <div class="card-body">
            <form method="post" action="/mises-a-jour/create" class="form-container">

                <!-- Description -->
                <div class="form-group full-width">
                    <label for="description" class="form-label">Description *</label>
                    <textarea id="description" name="description" required
                              class="form-control" rows="3" placeholder="Décrivez la mise à jour à planifier..."></textarea>
                </div>

                <!-- Grille des champs -->
                <div class="form-grid">

                    <!-- Type de mise à jour -->
                    <div class="form-group">
                        <label for="type" class="form-label">Type de mise à jour *</label>
                        <select id="type" name="type" required class="form-control">
                            <option value="">Sélectionnez un type</option>
                            <c:forEach var="type" items="${typesMAJ}">
                                <option value="${type}">${type}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Serveur concerné -->
                    <div class="form-group">
                        <label for="serveurId" class="form-label">Serveur concerné *</label>
                        <select id="serveurId" name="serveurId" required class="form-control">
                            <option value="">Sélectionnez un serveur</option>
                            <c:forEach var="serveur" items="${serveurs}">
                                <option value="${serveur.id}">
                                    ${serveur.nom} (${serveur.environnement})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Date d'application -->
                    <div class="form-group">
                        <label for="dateApplication" class="form-label">Date d'application *</label>
                        <input type="date" id="dateApplication" name="dateApplication"
                               required class="form-control">
                    </div>

                    <!-- Heure prévue -->
                    <div class="form-group">
                        <label for="heurePrevue" class="form-label">Heure prévue</label>
                        <input type="time" id="heurePrevue" name="heurePrevue"
                               class="form-control">
                    </div>

                    <!-- Version -->
                    <div class="form-group">
                        <label for="version" class="form-label">Version *</label>
                        <input type="text" id="version" name="version" required
                               class="form-control" placeholder="Ex: v2.1.0">
                    </div>

                    <!-- Responsable -->
                    <div class="form-group">
                        <label for="responsable" class="form-label">Responsable</label>
                        <input type="text" id="responsable" name="responsable"
                               class="form-control" placeholder="Nom du responsable">
                    </div>

                </div>

                <!-- Actions du formulaire -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <span>📅</span> Planifier la mise à jour
                    </button>
                    <a href="/mises-a-jour" class="btn btn-secondary">
                        <span>❌</span> Annuler
                    </a>
                </div>

            </form>
        </div>
    </div>
</div>

<style>
.form-container {
    max-width: 100%;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
    margin: 2rem 0;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.form-group.full-width {
    grid-column: 1 / -1;
}

.form-label {
    font-weight: 600;
    color: #2c3e50;
    font-size: 0.95rem;
    margin-bottom: 0.25rem;
}

.form-control {
    padding: 0.75rem 1rem;
    border: 2px solid #e9ecef;
    border-radius: 10px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: white;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.form-control:focus {
    border-color: #4361ee;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
    outline: none;
}

.form-control::placeholder {
    color: #8d99ae;
}

/* Styles spécifiques pour les selects */
.form-control select {
    appearance: none;
    background-image: url("data:image/svg+xml;charset=US-ASCII,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'><path fill='%236c757d' d='M2 0L0 2h4zm0 5L0 3h4z'/></svg>");
    background-repeat: no-repeat;
    background-position: right 0.75rem center;
    background-size: 16px 12px;
    padding-right: 2.5rem;
}

/* Styles pour les textareas */
textarea.form-control {
    resize: vertical;
    min-height: 100px;
}

/* Styles pour les inputs date et time */
input[type="date"].form-control,
input[type="time"].form-control {
    position: relative;
}

input[type="date"].form-control::-webkit-calendar-picker-indicator,
input[type="time"].form-control::-webkit-calendar-picker-indicator {
    background: transparent;
    bottom: 0;
    color: transparent;
    cursor: pointer;
    height: auto;
    left: 0;
    position: absolute;
    right: 0;
    top: 0;
    width: auto;
}

.form-actions {
    display: flex;
    gap: 1rem;
    justify-content: flex-start;
    align-items: center;
    padding-top: 2rem;
    border-top: 1px solid #e9ecef;
    margin-top: 1rem;
}

/* Responsive */
@media (max-width: 768px) {
    .form-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
    }

    .form-actions {
        flex-direction: column;
        align-items: stretch;
    }

    .form-actions .btn {
        width: 100%;
        justify-content: center;
    }
}

/* Animation pour les champs requis */
.form-control:required {
    border-left: 3px solid #4361ee;
}

.form-control:required:invalid {
    border-left-color: #ef476f;
}

.form-control:required:valid {
    border-left-color: #06d6a0;
}
</style>

<script>
// Script pour améliorer l'expérience utilisateur
document.addEventListener('DOMContentLoaded', function() {
    // Date minimale = aujourd'hui
    const dateInput = document.getElementById('dateApplication');
    const today = new Date().toISOString().split('T')[0];
    dateInput.min = today;

    // Valeur par défaut = aujourd'hui
    dateInput.value = today;

    // Focus sur le premier champ
    document.getElementById('description').focus();

    // Validation en temps réel
    const requiredFields = document.querySelectorAll('[required]');
    requiredFields.forEach(field => {
        field.addEventListener('blur', function() {
            if (this.value.trim() === '') {
                this.style.borderColor = '#ef476f';
            } else {
                this.style.borderColor = '#06d6a0';
            }
        });
    });

    // Auto-remplissage de l'heure actuelle
    const timeInput = document.getElementById('heurePrevue');
    const now = new Date();
    const currentTime = now.getHours().toString().padStart(2, '0') + ':' +
                       now.getMinutes().toString().padStart(2, '0');
    timeInput.value = currentTime;
});
</script>

<jsp:include page="../includes/footer.jsp" />