<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <!-- En-tête -->
    <div class="page-header">
        <h2>➕ Créer un Serveur</h2>
        <div class="header-actions">
            <a href="/serveurs" class="btn btn-secondary">
                ← Retour à la liste
            </a>
        </div>
    </div>

    <!-- Carte du formulaire -->
    <div class="card">
        <div style="background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; padding: 1.5rem; border-radius: 10px 10px 0 0;">
            <h3 style="margin: 0; display: flex; align-items: center; gap: 0.5rem;">
                🚀 Nouveau Serveur
            </h3>
            <p style="margin: 0.5rem 0 0 0; opacity: 0.9;">
                Ajoutez un nouveau serveur à votre infrastructure de monitoring
            </p>
        </div>

        <form:form action="/serveurs/create" method="post" modelAttribute="serveur" style="padding: 2rem;">

            <!-- Section Informations de base -->
            <div style="margin-bottom: 2rem;">
                <h4 style="color: #4361ee; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                    📋 Informations de base
                </h4>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                    <!-- Nom du serveur -->
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label style="font-weight: 600; color: #495057;">Nom du Serveur *</label>
                        <form:input path="nom"
                            style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                            placeholder="Ex: SRV-PROD-001" required="true"/>
                    </div>

                    <!-- Type de serveur -->
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label style="font-weight: 600; color: #495057;">Type de Serveur *</label>
                        <form:select path="typeServeur"
                            style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                            <c:forEach var="type" items="${typesServeur}">
                                <form:option value="${type}">${type}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
            </div>

            <!-- Section Configuration réseau -->
            <div style="margin-bottom: 2rem;">
                <h4 style="color: #4361ee; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                    🌐 Configuration Réseau
                </h4>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                    <!-- URL/Endpoint -->
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label style="font-weight: 600; color: #495057;">URL/Endpoint *</label>
                        <form:input path="url"
                            style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                            placeholder="Ex: https://api.example.com" required="true"/>
                    </div>

                    <!-- Port -->
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label style="font-weight: 600; color: #495057;">Port</label>
                        <form:input path="port" type="number"
                            style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem;"
                            placeholder="Ex: 8080"/>
                    </div>
                </div>
            </div>

            <!-- Section Environnement -->
            <div style="margin-bottom: 2rem;">
                <h4 style="color: #4361ee; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                    🏷️ Environnement
                </h4>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                    <!-- Environnement -->
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label style="font-weight: 600; color: #495057;">Environnement *</label>
                        <form:select path="environnement"
                            style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                            <c:forEach var="env" items="${environnements}">
                                <form:option value="${env}">${env}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>

                    <!-- Caisse -->
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label style="font-weight: 600; color: #495057;">Caisse</label>
                        <form:select path="caisseCode"
                            style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; background: white;">
                            <form:option value="">Sélectionnez une caisse</form:option>
                            <c:forEach var="caisse" items="${caisses}">
                                <form:option value="${caisse.code}">${caisse.code} - ${caisse.nom}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
            </div>

            <!-- Section Description -->
            <div style="margin-bottom: 2rem;">
                <h4 style="color: #4361ee; margin-bottom: 1rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                    📝 Description
                </h4>

                <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                    <label style="font-weight: 600; color: #495057;">Description</label>
                    <form:textarea path="description" rows="4"
                        style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; font-size: 1rem; resize: vertical;"
                        placeholder="Description du serveur, rôle, fonctionnalités..."/>
                </div>
            </div>

            <!-- Boutons d'action -->
            <div style="display: flex; gap: 1rem; justify-content: flex-end; border-top: 2px solid #e9ecef; padding-top: 2rem;">
                <a href="/serveurs"
                   style="padding: 0.75rem 2rem; border: 2px solid #6c757d; border-radius: 25px; background: white; color: #6c757d; text-decoration: none; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                    ❌ Annuler
                </a>
                <button type="submit"
                        style="padding: 0.75rem 2rem; border: none; border-radius: 25px; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                    ✅ Créer le serveur
                </button>
            </div>
        </form:form>
    </div>
</div>

<style>
.dashboard {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.card {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    overflow: hidden;
}

.btn {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 25px;
    font-weight: 600;
    text-decoration: none;
    cursor: pointer;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        gap: 1rem;
        text-align: center;
    }

    div[style*="grid-template-columns: 1fr 1fr"] {
        grid-template-columns: 1fr;
    }
}
</style>

<jsp:include page="../includes/footer.jsp" />