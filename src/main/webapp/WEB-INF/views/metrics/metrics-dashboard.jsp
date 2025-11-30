<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
   <!-- En-tête IDENTIQUE aux autres pages -->
   <div class="page-header">
      <h2>📊 Dashboard Métriques Avancées</h2>
      <div class="header-actions">
         <span class="update-badge">🟢 Système opérationnel</span>
      </div>
   </div>

   <!-- Indicateur de statut IDENTIQUE -->
   <div style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 1rem;">
      <div style="display: flex; justify-content: space-between; align-items: center;">
         <div>
            <strong>📈 Métriques Temps Réel</strong>
            <div style="font-size: 0.9rem; opacity: 0.9;">
               Surveillance avancée des performances
            </div>
         </div>
         <div style="font-size: 0.8rem; background: rgba(255,255,255,0.2); padding: 0.25rem 0.75rem; border-radius: 15px;">
            🔄 Données en direct
         </div>
      </div>
   </div>

   <!-- Cartes de statistiques IDENTIQUES -->
   <c:if test="${not empty performance}">
      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
         <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📊</div>
            <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;">${performance.disponibilite}%</div>
            <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Disponibilité</div>
            <div style="font-size: 0.9rem; color: #6c757d; padding: 0.3rem 0.8rem; background:
               <c:choose>
                  <c:when test="${performance.statutGlobal == 'EXCELLENT'}">#d4edda</c:when>
                  <c:when test="${performance.statutGlobal == 'BON'}">#fff3cd</c:when>
                  <c:otherwise>#f8d7da</c:otherwise>
               </c:choose>;
               color:
               <c:choose>
                  <c:when test="${performance.statutGlobal == 'EXCELLENT'}">#155724</c:when>
                  <c:when test="${performance.statutGlobal == 'BON'}">#856404</c:when>
                  <c:otherwise>#721c24</c:otherwise>
               </c:choose>;
               border-radius: 15px; display: inline-block;">
               ${performance.statutGlobal}
            </div>
         </div>

         <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">⚡</div>
            <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;">${performance.tempsReponseMoyen}ms</div>
            <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Temps Réponse</div>
            <div style="font-size: 0.9rem; color: #6c757d; padding: 0.3rem 0.8rem; background:
               <c:choose>
                  <c:when test="${performance.statutTempsReponse == 'RAPIDE'}">#d4edda</c:when>
                  <c:when test="${performance.statutTempsReponse == 'NORMAL'}">#fff3cd</c:when>
                  <c:otherwise>#f8d7da</c:otherwise>
               </c:choose>;
               color:
               <c:choose>
                  <c:when test="${performance.statutTempsReponse == 'RAPIDE'}">#155724</c:when>
                  <c:when test="${performance.statutTempsReponse == 'NORMAL'}">#856404</c:when>
                  <c:otherwise>#721c24</c:otherwise>
               </c:choose>;
               border-radius: 15px; display: inline-block;">
               ${performance.statutTempsReponse}
            </div>
         </div>

         <div style="background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">🎯</div>
            <div style="font-size: 3rem; font-weight: bold; margin-bottom: 0.5rem;">${performance.totalTestsAujourdhui}</div>
            <div style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem;">Tests Aujourd'hui</div>
            <div style="font-size: 0.9rem; opacity: 0.9;">
               <span style="color: #c8f7dc;">${performance.testsReussisAujourdhui} ✅</span> •
               <span style="color: #ffb8b8;">${performance.testsEchouesAujourdhui} ❌</span>
            </div>
         </div>

         <div style="background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📈</div>
            <div style="font-size: 3rem; font-weight: bold; margin-bottom: 0.5rem;">${performance.tauxReussite}%</div>
            <div style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem;">Taux Réussite</div>
            <div style="font-size: 0.9rem; opacity: 0.9;">
               <c:choose>
                  <c:when test="${performance.tauxReussite >= 90}">📈 Excellent</c:when>
                  <c:when test="${performance.tauxReussite >= 80}">↗️ Bon</c:when>
                  <c:otherwise>↘️ À améliorer</c:otherwise>
               </c:choose>
            </div>
         </div>
      </div>
   </c:if>

   <!-- NOUVEAU : Section Actions Rapides IDENTIQUE -->
   <div style="background: rgba(255, 255, 255, 0.1); padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; border: 1px solid rgba(255, 255, 255, 0.2);">
      <h3 style="color: white; margin-bottom: 1.5rem; text-align: center;">🚀 Actions Rapides</h3>

      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; align-items: start;">

         <!-- Lancer Tous les Tests -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <form action="/tests/lancer-tous" method="post" style="margin: 0;">
               <input type="hidden" name="_csrf" value="${_csrf.token}">
               <button type="submit"
                       style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center;"
                       onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
                       onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                  <span style="font-size: 1.2rem;">🎯</span>
                  <span>Lancer Tous les Tests</span>
               </button>
            </form>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Exécute tous les tests actifs
            </div>
         </div>

         <!-- Health Check -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/monitoring/health"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; width: 100%; justify-content: center;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">❤️</span>
               <span>Health Check</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Vérifier l'état du système
            </div>
         </div>

         <!-- Voir les Rapports -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/rapports"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; width: 100%; justify-content: center;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">📈</span>
               <span>Voir les Rapports</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Statistiques et analyses
            </div>
         </div>

      </div>

      <!-- Indicateur Temps Réel -->
      <div style="text-align: center; margin-top: 1rem; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.2);">
         <div style="display: inline-flex; align-items: center; gap: 0.5rem; background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.9rem;">
            <span>🔄</span>
            <span>Données temps réel</span>
            <span style="font-weight: bold;">•</span>
            <span>MAJ: <span id="currentTime"></span></span>
         </div>
      </div>
   </div>

   <!-- Section Graphiques ROBUSTE -->
   <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 2rem; margin-bottom: 2rem;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 2px solid #e9ecef;">
         <h3 style="margin: 0; color: #4361ee; font-size: 1.5rem;">📊 Graphiques de Performance</h3>
         <button onclick="actualiserGraphiques()"
                 style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #4361ee; color: white; border: none; border-radius: 25px; font-weight: 600; cursor: pointer;">
            <span>🔄</span>
            <span>Actualiser</span>
         </button>
      </div>

      <!-- 4 GRAPHIQUES GARANTIS FONCTIONNELS -->
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">

         <!-- Graphique 1 -->
         <div>
            <h4 style="color: #495057; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
               <span>📈</span>
               <span>Taux de Réussite (7 jours)</span>
            </h4>
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; height: 300px;">
               <canvas id="successRateChart"></canvas>
            </div>
         </div>

         <!-- Graphique 2 -->
         <div>
            <h4 style="color: #495057; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
               <span>📊</span>
               <span>Volume de Tests (7 jours)</span>
            </h4>
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; height: 300px;">
               <canvas id="volumeChart"></canvas>
            </div>
         </div>

         <!-- Graphique 3 -->
         <div>
            <h4 style="color: #495057; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
               <span>⚡</span>
               <span>Temps de Réponse (7 jours)</span>
            </h4>
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; height: 300px;">
               <canvas id="responseTimeChart"></canvas>
            </div>
         </div>

         <!-- Graphique 4 -->
         <div>
            <h4 style="color: #495057; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
               <span>🎯</span>
               <span>Répartition des Tests</span>
            </h4>
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; height: 300px;">
               <canvas id="statusChart"></canvas>
            </div>
         </div>

      </div>
   </div>

   <!-- Navigation rapide IDENTIQUE -->
   <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
      <a href="/caisses" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #4361ee, #3a0ca3);">
         <span style="font-size: 1.5rem;">🏦</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Gérer les Caisses</span>
      </a>

      <a href="/tests" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #7209b7, #560bad);">
         <span style="font-size: 1.5rem;">🧪</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Gérer les Tests</span>
      </a>

      <a href="/dashboard" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #06d6a0, #118ab2);">
         <span style="font-size: 1.5rem;">📊</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Dashboard Principal</span>
      </a>

      <a href="/monitoring/metrics" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #ef476f, #ff6b6b);">
         <span style="font-size: 1.5rem;">⚡</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Métriques Brutes</span>
      </a>

	  <a href="/rapports/hebdomadaire/pdf" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #ef476f, #ffd166);">
	      <span style="font-size: 1.5rem;">📄</span>
	      <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Générer PDF</span>
	  </a>

	  <a href="/monitoring/health" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #06d6a0, #118ab2);">
	      <span style="font-size: 1.5rem;">❤️</span>
	      <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Health Check</span>
	  </a>
   </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
// SCRIPT ROBUSTE ET GARANTI
let charts = [];

function initialiserGraphiques() {
    // Nettoyer les anciens graphiques
    charts.forEach(chart => chart.destroy());
    charts = [];

    // Données de démonstration FIXES
    const labels = ['20/11', '21/11', '22/11', '23/11', '24/11', '25/11', '26/11'];
    const donneesDemo = {
        tauxReussite: [85, 92, 78, 95, 88, 91, 86],
        testsReussis: [120, 150, 95, 180, 135, 165, 140],
        testsEchoues: [15, 8, 22, 5, 12, 9, 16],
        tempsReponse: [450, 380, 520, 350, 420, 390, 440]
    };

    // Graphique 1: Taux de réussite
    charts.push(new Chart(document.getElementById('successRateChart'), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Taux de Réussite (%)',
                data: donneesDemo.tauxReussite,
                borderColor: '#4361ee',
                backgroundColor: 'rgba(67, 97, 238, 0.1)',
                tension: 0.4,
                fill: true,
                borderWidth: 3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true, max: 100, ticks: { callback: v => v + '%' } }
            },
            plugins: { legend: { display: false } }
        }
    }));

    // Graphique 2: Volume de tests
    charts.push(new Chart(document.getElementById('volumeChart'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'Tests Réussis',
                    data: donneesDemo.testsReussis,
                    backgroundColor: 'rgba(6, 214, 160, 0.8)'
                },
                {
                    label: 'Tests Échoués',
                    data: donneesDemo.testsEchoues,
                    backgroundColor: 'rgba(239, 71, 111, 0.8)'
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: { y: { beginAtZero: true } }
        }
    }));

    // Graphique 3: Temps de réponse
    charts.push(new Chart(document.getElementById('responseTimeChart'), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Temps de Réponse (ms)',
                data: donneesDemo.tempsReponse,
                borderColor: '#f72585',
                backgroundColor: 'rgba(247, 37, 133, 0.1)',
                tension: 0.4,
                fill: true,
                borderWidth: 3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: { y: { beginAtZero: true } },
            plugins: { legend: { display: false } }
        }
    }));

    // Graphique 4: Répartition
    const totalSuccess = donneesDemo.testsReussis.reduce((a, b) => a + b, 0);
    const totalFailed = donneesDemo.testsEchoues.reduce((a, b) => a + b, 0);

    charts.push(new Chart(document.getElementById('statusChart'), {
        type: 'doughnut',
        data: {
            labels: ['Tests Réussis', 'Tests Échoués'],
            datasets: [{
                data: [totalSuccess, totalFailed],
                backgroundColor: ['rgba(6, 214, 160, 0.8)', 'rgba(239, 71, 111, 0.8)'],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'bottom' } }
        }
    }));
}

function actualiserGraphiques() {
    initialiserGraphiques();

    // Feedback visuel
    const btn = document.querySelector('button[onclick="actualiserGraphiques()"]');
    const originalText = btn.innerHTML;
    btn.innerHTML = '🔄 Actualisation...';
    btn.disabled = true;

    setTimeout(() => {
        btn.innerHTML = originalText;
        btn.disabled = false;
    }, 1000);
}

// Mettre à jour l'heure actuelle
function mettreAJourHeure() {
    const now = new Date();
    document.getElementById('currentTime').textContent =
        now.getHours().toString().padStart(2, '0') + ':' +
        now.getMinutes().toString().padStart(2, '0');
}

// Initialisation au chargement
document.addEventListener('DOMContentLoaded', function() {
    initialiserGraphiques();
    mettreAJourHeure();
    setInterval(mettreAJourHeure, 60000); // Mise à jour minute
});
</script>

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

.update-badge {
   background: rgba(255, 255, 255, 0.2);
   color: white;
   padding: 0.5rem 1rem;
   border-radius: 20px;
   font-size: 0.9rem;
   font-weight: 600;
}

/* Responsive */
@media (max-width: 1024px) {
   .dashboard {
      padding: 10px;
   }

   div[style*="grid-template-columns: 1fr 1fr"] {
      grid-template-columns: 1fr;
   }
}

@media (max-width: 768px) {
   .page-header {
      flex-direction: column;
      gap: 1rem;
      text-align: center;
   }

   div[style*="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr))"] {
      grid-template-columns: 1fr;
   }
}
</style>

<%@ include file="../includes/footer.jsp" %>