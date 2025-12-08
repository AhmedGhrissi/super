<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/global-styles.css">
<div class="container">
    <div class="page-header">
        <h2>✏️ Modifier le Serveur</h2>
        <a href="/serveurs" class="btn btn-secondary">
            <span>←</span> Retour à la liste
        </a>
    </div>

    <div class="card">
        <div class="card-body">
            <!-- FORMULAIRE CORRIGÉ - ACTION CORRECTE -->
            <form:form method="post" action="/serveurs/edit/${serveur.id}" modelAttribute="serveur">
                <div class="form-grid">

                    <!-- Nom du serveur -->
                    <div class="form-group">
                        <label for="nom">Nom du serveur *</label>
                        <form:input path="nom" type="text" class="form-control"
                                   required="true" placeholder="Ex: Serveur Production 01"/>
                        <form:errors path="nom" class="error-message"/>
                    </div>

                    <!-- Type de serveur -->
                    <div class="form-group">
                        <label for="typeServeur">Type de serveur *</label>
                        <form:select path="typeServeur" class="form-control" required="true">
                            <form:option value="">Sélectionnez un type</form:option>
                            <form:options items="${typesServeur}" />
                        </form:select>
                        <form:errors path="typeServeur" class="error-message"/>
                    </div>

                    <!-- Environnement -->
                    <div class="form-group">
                        <label for="environnement">Environnement *</label>
                        <form:select path="environnement" class="form-control" required="true">
                            <form:option value="">Sélectionnez un environnement</form:option>
                            <form:options items="${environnements}" />
                        </form:select>
                        <form:errors path="environnement" class="error-message"/>
                    </div>

                    <!-- Statut -->
                    <div class="form-group">
                        <label for="statut">Statut *</label>
                        <form:select path="statut" class="form-control" required="true">
                            <form:option value="">Sélectionnez un statut</form:option>
                            <form:options items="${statuts}" />
                        </form:select>
                        <form:errors path="statut" class="error-message"/>
                    </div>

                    <!-- Adresse IP -->
                    <div class="form-group">
                        <label for="adresseIP">Adresse IP *</label>
                        <form:input path="adresseIP" type="text" class="form-control"
                                   required="true" placeholder="Ex: 192.168.1.100"/>
                        <form:errors path="adresseIP" class="error-message"/>
                    </div>

                    <!-- Code Caisse -->
                    <div class="form-group">
                        <label for="caisseCode">Code Caisse</label>
                        <form:input path="caisseCode" type="text" class="form-control"
                                   placeholder="Ex: CAISSE_001"/>
                        <form:errors path="caisseCode" class="error-message"/>
                    </div>

                    <!-- Description -->
                    <div class="form-group full-width">
                        <label for="description">Description</label>
                        <form:textarea path="description" class="form-control"
                                      rows="3" placeholder="Description du serveur..."/>
                        <form:errors path="description" class="error-message"/>
                    </div>

                </div>

                <!-- BOUTONS D'ACTION -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <span>💾</span> Mettre à jour
                    </button>
                    <a href="/serveurs" class="btn btn-secondary">
                        <span>❌</span> Annuler
                    </a>
                    <a href="/serveurs/view/${serveur.id}" class="btn btn-info">
                        <span>👁️</span> Voir les détails
                    </a>
                </div>

            </form:form>

        </div>
    </div>
</div>

<style>
.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.form-group {
    display: flex;
    flex-direction: column;
}

.form-group.full-width {
    grid-column: 1 / -1;
}

.form-group label {
    font-weight: 600;
    margin-bottom: 0.5rem;
    color: #2c3e50;
}

.form-control {
    padding: 0.75rem;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 1rem;
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: #4361ee;
    box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
    outline: none;
}

.form-actions {
    display: flex;
    gap: 1rem;
    justify-content: flex-start;
    align-items: center;
    padding-top: 1.5rem;
    border-top: 1px solid #e9ecef;
}

.error-message {
    color: #ef476f;
    font-size: 0.85rem;
    margin-top: 0.25rem;
    font-weight: 500;
}

.btn {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-primary {
    background: linear-gradient(135deg, #4361ee, #3a0ca3);
    color: white;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.btn-info {
    background: #06d6a0;
    color: white;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}
</style>

<jsp:include page="../includes/footer.jsp" />