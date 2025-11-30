<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>🚨 Erreur</h2>
        <a href="/" class="btn btn-primary">🏠 Retour à l'accueil</a>
    </div>

    <div class="card" style="max-width: 600px; margin: 2rem auto; text-align: center; padding: 3rem;">
        <div style="font-size: 6rem; margin-bottom: 2rem;">😵</div>

        <h1 style="color: #e74c3c; margin-bottom: 1rem;">
            Une erreur est survenue
        </h1>

        <p style="color: #6c757d; font-size: 1.1rem; margin-bottom: 2rem; line-height: 1.6;">
            <c:choose>
                <c:when test="${not empty errorMessage}">
                    ${errorMessage}
                </c:when>
                <c:otherwise>
                    Désolé, une erreur inattendue s'est produite.
                    Notre équipe technique a été notifiée et travaille à résoudre le problème.
                </c:otherwise>
            </c:choose>
        </p>

        <!-- Détails techniques (seulement en mode développement) -->
        <c:if test="${not empty error}">
            <details style="margin: 2rem 0; text-align: left;">
                <summary style="cursor: pointer; color: #4361ee; font-weight: 600;">
                    🔍 Détails techniques (pour le débogage)
                </summary>
                <div style="background: #f8f9fa; padding: 1rem; border-radius: 8px; margin-top: 0.5rem; font-family: monospace; font-size: 0.9rem;">
                    <strong>Type:</strong> ${error.getClass().name}<br>
                    <strong>Message:</strong> ${error.message}<br>
                    <c:if test="${not empty error.stackTrace}">
                        <strong>Stack Trace:</strong><br>
                        <div style="max-height: 200px; overflow-y: auto; background: white; padding: 0.5rem; border-radius: 4px; margin-top: 0.5rem;">
                            <c:forEach var="element" items="${error.stackTrace}" begin="0" end="9">
                                &nbsp;&nbsp;at ${element}<br>
                            </c:forEach>
                            <c:if test="${error.stackTrace.length > 10}">
                                &nbsp;&nbsp;... ${error.stackTrace.length - 10} more lines
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </details>
        </c:if>

        <!-- Actions -->
        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; margin-top: 2rem;">
            <a href="/" class="btn btn-primary" style="padding: 0.75rem 1.5rem;">
                🏠 Page d'accueil
            </a>
            <button onclick="history.back()" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">
                ↩️ Retour
            </button>
            <a href="javascript:location.reload()" class="btn btn-info" style="padding: 0.75rem 1.5rem;">
                🔄 Réessayer
            </a>
        </div>

        <!-- Informations de contact -->
        <div style="margin-top: 3rem; padding-top: 2rem; border-top: 1px solid #e9ecef;">
            <p style="color: #8d99ae; font-size: 0.9rem;">
                Si le problème persiste, veuillez contacter
                <a href="mailto:support@example.com" style="color: #4361ee;">notre équipe de support</a>.
            </p>
        </div>
    </div>
</div>

<style>
.card {
    background: white;
    border-radius: var(--radius);
    box-shadow: var(--shadow);
}

details summary {
    transition: color 0.3s ease;
}

details summary:hover {
    color: #7209b7 !important;
}

.btn {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
</style>

<%@ include file="includes/footer.jsp" %>