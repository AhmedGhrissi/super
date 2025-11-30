<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
    <div class="page-header">
        <h2>📈 Rapports de Supervision</h2>
        <a href="/dashboard" class="btn btn-primary">← Retour au Dashboard</a>
    </div>

    <!-- Indicateur de statut -->
    <div style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 1rem;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <strong>📊 Rapports Hebdomadaires</strong>
                <div style="font-size: 0.9rem; opacity: 0.9;">
                    Période du ${rapports.periode}
                </div>
            </div>
            <div style="font-size: 0.8rem; background: rgba(255,255,255,0.2); padding: 0.25rem 0.75rem; border-radius: 15px;">
                📅 Données statistiques
            </div>
        </div>
    </div>

    <!-- Cartes de statistiques -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
        <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📊</div>
            <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;">${rapports.totalTests}</div>
            <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Tests Exécutés</div>
            <div style="font-size: 0.9rem; color: #6c757d;">Cette semaine</div>
        </div>

        <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">✅</div>
            <div style="font-size: 3rem; font-weight: bold; color: #28a745; margin-bottom: 0.5rem;">${rapports.testsReussis}</div>
            <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Tests Réussis</div>
            <div style="font-size: 0.9rem; color: #6c757d;">Cette semaine</div>
        </div>

        <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📈</div>
            <div style="font-size: 3rem; font-weight: bold; color: #ffc107; margin-bottom: 0.5rem;">${rapports.tauxReussite}%</div>
            <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Taux de Réussite</div>
            <div style="font-size: 0.9rem; color: #6c757d;">Moyenne hebdo</div>
        </div>

        <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">⚡</div>
            <div style="font-size: 3rem; font-weight: bold; color: #17a2b8; margin-bottom: 0.5rem;">${rapports.tempsReponseMoyen}ms</div>
            <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Temps Réponse</div>
            <div style="font-size: 0.9rem; color: #6c757d;">Moyen</div>
        </div>
    </div>

    <!-- Informations supplémentaires -->
    <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 2rem;">
        <div style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
            <h3 style="margin: 0; color: #4361ee; font-size: 1.3rem;">🏦 Informations Système</h3>
        </div>
        <div style="padding: 1.5rem;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div>
                    <h4 style="color: #495057; margin-bottom: 0.5rem;">Caisses Testées</h4>
                    <div style="font-size: 1.5rem; color: #4361ee; font-weight: bold;">${rapports.caissesTestees}</div>
                </div>
                <div>
                    <h4 style="color: #495057; margin-bottom: 0.5rem;">Tests Actifs</h4>
                    <div style="font-size: 1.5rem; color: #4361ee; font-weight: bold;">${rapports.testsActifs}</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions -->
    <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden;">
        <div style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
            <h3 style="margin: 0; color: #4361ee; font-size: 1.3rem;">🚀 Actions</h3>
        </div>
        <div style="padding: 1.5rem;">
            <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                <button onclick="window.print()"
                        style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;"
                        onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
                        onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                    <span>🖨️</span>
                    <span>Imprimer le Rapport</span>
                </button>

                <a href="/dashboard"
                   style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease;"
                   onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
                   onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                    <span>🏠</span>
                    <span>Retour au Dashboard</span>
                </a>
            </div>
        </div>
    </div>
</div>

<style>
.dashboard {
   max-width: 1400px;
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
    border: none;
    cursor: pointer;
}

.btn:hover {
    background: #3a0ca3;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    color: white;
    text-decoration: none;
}

.btn-primary {
    background: #4361ee;
}

/* Responsive */
@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        gap: 1rem;
        text-align: center;
    }

    div[style*="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr))"] {
        grid-template-columns: 1fr;
    }

    div[style*="grid-template-columns: 1fr 1fr"] {
        grid-template-columns: 1fr;
    }
}
</style>

<%@ include file="../includes/footer.jsp" %>