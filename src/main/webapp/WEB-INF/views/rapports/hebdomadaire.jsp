<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/css/global-styles.css">
<div class="dashboard">
    <div class="page-header">
        <h2>📊 Rapport Hebdomadaire Détaillé</h2>
        <a href="/rapports" class="btn btn-primary">← Retour aux Rapports</a>
    </div>

    <!-- Messages d'erreur -->
    <c:if test="${not empty error}">
        <div style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 8px; margin-bottom: 1rem; border: 1px solid #f5c6cb;">
            ❌ ${error}
        </div>
    </c:if>

    <!-- Période -->
    <div style="background: white; padding: 1.5rem; border-radius: 10px; margin-bottom: 2rem; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
        <h3 style="color: #4361ee; margin-bottom: 0.5rem;">📅 Période du rapport</h3>
        <p style="font-size: 1.1rem; color: #495057; margin: 0;">${rapports.periode}</p>
    </div>

    <!-- Statistiques principales -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
        <div style="background: white; padding: 1.5rem; border-radius: 10px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); border-left: 4px solid #4361ee;">
            <div style="font-size: 2rem; color: #4361ee; font-weight: bold;">${rapports.totalTests}</div>
            <div style="font-size: 0.9rem; color: #495057;">Tests Exécutés</div>
        </div>
        <div style="background: white; padding: 1.5rem; border-radius: 10px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); border-left: 4px solid #28a745;">
            <div style="font-size: 2rem; color: #28a745; font-weight: bold;">${rapports.testsReussis}</div>
            <div style="font-size: 0.9rem; color: #495057;">Tests Réussis</div>
        </div>
        <div style="background: white; padding: 1.5rem; border-radius: 10px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); border-left: 4px solid #ffc107;">
            <div style="font-size: 2rem; color: #ffc107; font-weight: bold;">${rapports.tauxReussite}%</div>
            <div style="font-size: 0.9rem; color: #495057;">Taux de Réussite</div>
        </div>
        <div style="background: white; padding: 1.5rem; border-radius: 10px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); border-left: 4px solid #17a2b8;">
            <div style="font-size: 2rem; color: #17a2b8; font-weight: bold;">${rapports.tempsReponseMoyen}ms</div>
            <div style="font-size: 0.9rem; color: #495057;">Temps Réponse Moyen</div>
        </div>
    </div>

    <!-- Détails supplémentaires -->
    <div style="background: white; border-radius: 10px; padding: 1.5rem; margin-bottom: 2rem; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
        <h3 style="color: #4361ee; margin-bottom: 1rem;">🏦 Informations Complémentaires</h3>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
            <div>
                <strong>Caisses Testées:</strong> ${rapports.caissesTestees}
            </div>
            <div>
                <strong>Tests Actifs:</strong> ${rapports.testsActifs}
            </div>
        </div>
    </div>

    <!-- Actions -->
    <div style="text-align: center; margin-top: 2rem;">
        <button onclick="window.print()"
                style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; border: none; border-radius: 25px; font-weight: 600; cursor: pointer; margin: 0 0.5rem;"
                onmouseover="this.style.transform='translateY(-2px)';"
                onmouseout="this.style.transform='translateY(0)';">
            <span>🖨️</span>
            <span>Imprimer ce Rapport</span>
        </button>

        <a href="/rapports"
           style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: linear-gradient(135deg, #6c757d, #495057); color: white; text-decoration: none; border-radius: 25px; font-weight: 600; margin: 0 0.5rem;"
           onmouseover="this.style.transform='translateY(-2px)';"
           onmouseout="this.style.transform='translateY(0)';">
            <span>📋</span>
            <span>Rapport Standard</span>
        </a>

        <a href="/dashboard"
           style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; text-decoration: none; border-radius: 25px; font-weight: 600; margin: 0 0.5rem;"
           onmouseover="this.style.transform='translateY(-2px)';"
           onmouseout="this.style.transform='translateY(0)';">
            <span>🏠</span>
            <span>Retour au Dashboard</span>
        </a>
    </div>
</div>

<style>
.dashboard {
   max-width: 1200px;
   margin: 0 auto;
   padding: 20px;
}

.page-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   margin-bottom: 2rem;
}

.btn {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    background: #4361ee;
    color: white;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn:hover {
    background: #3a0ca3;
    transform: translateY(-2px);
    color: white;
    text-decoration: none;
}

.btn-primary {
    background: #4361ee;
}

/* Styles pour l'impression */
@media print {
    .btn, .page-header a {
        display: none !important;
    }
}

/* Responsive */
@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        gap: 1rem;
        text-align: center;
    }

    div[style*="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr))"] {
        grid-template-columns: 1fr 1fr;
    }

    div[style*="grid-template-columns: 1fr 1fr"] {
        grid-template-columns: 1fr;
    }

    div[style*="text-align: center"] {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
}
</style>

<%@ include file="../includes/footer.jsp" %>