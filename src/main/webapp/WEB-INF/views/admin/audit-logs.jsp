<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
   <div class="page-header">
      <h2>📋 Journal d'Audit</h2>
      <div class="header-actions">
         <span class="update-badge">🟢 Audit actif</span>
      </div>
   </div>

   <!-- Bannière stats -->
   <div style="background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 1rem;">
      <div style="display: flex; justify-content: space-between; align-items: center;">
         <div>
            <strong>📊 Surveillance des Actions</strong>
            <div style="font-size: 0.9rem; opacity: 0.9;">
               Historique complet des activités utilisateurs
            </div>
         </div>
         <div style="font-size: 0.8rem; background: rgba(255,255,255,0.2); padding: 0.25rem 0.75rem; border-radius: 15px;">
            🔄 Données en temps réel
         </div>
      </div>
   </div>

   <!-- Cartes stats principales -->
   <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📈</div>
         <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;" id="totalActions">-</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Actions (24h)</div>
         <div style="font-size: 0.9rem; color: #6c757d; padding: 0.3rem 0.8rem; background: #e7f1ff; color: #004085; border-radius: 15px; display: inline-block;">
            Total
         </div>
      </div>

      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">✅</div>
         <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;" id="successActions">-</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Succès</div>
         <div style="font-size: 0.9rem; color: #6c757d; padding: 0.3rem 0.8rem; background: #d4edda; color: #155724; border-radius: 15px; display: inline-block;">
            Réussites
         </div>
      </div>

      <div style="background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">❌</div>
         <div style="font-size: 3rem; font-weight: bold; margin-bottom: 0.5rem;" id="failedActions">-</div>
         <div style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem;">Échecs</div>
         <div style="font-size: 0.9rem; opacity: 0.9;">
            Échecs détectés
         </div>
      </div>

      <div style="background: linear-gradient(135deg, #ef476f, #ff6b6b); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📊</div>
         <div style="font-size: 3rem; font-weight: bold; margin-bottom: 0.5rem;" id="successRate">-</div>
         <div style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem;">Taux Succès</div>
         <div style="font-size: 0.9rem; opacity: 0.9;">
            Performance
         </div>
      </div>
   </div>

   <!-- SECTION GRAPHIQUES -->
   <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 2rem; margin-bottom: 2rem;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
         <h3 style="margin: 0; color: #4361ee;">📈 Tableau de Bord Statistique</h3>
         <button onclick="loadAllCharts()" style="padding: 0.5rem 1rem; background: #4361ee; color: white; border: none; border-radius: 5px; cursor: pointer;">
            🔄 Actualiser les graphiques
         </button>
      </div>

      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 2rem;">
         <!-- Graphique 1: Répartition des actions -->
         <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px;">
            <h4 style="margin: 0 0 1rem 0; color: #495057;">📋 Répartition des Actions</h4>
            <canvas id="actionDistributionChart" height="250"></canvas>
         </div>

         <!-- Graphique 2: Top utilisateurs -->
         <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px;">
            <h4 style="margin: 0 0 1rem 0; color: #495057;">👥 Top 5 Utilisateurs</h4>
            <canvas id="userActivityChart" height="250"></canvas>
         </div>

         <!-- Graphique 3: Évolution temporelle -->
         <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; grid-column: span 2;">
            <h4 style="margin: 0 0 1rem 0; color: #495057;">📅 Évolution sur 7 Jours</h4>
            <canvas id="timelineChart" height="200"></canvas>
         </div>
      </div>
   </div>

   <!-- FILTRES -->
   <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 2rem; margin-bottom: 2rem;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 2px solid #e9ecef;">
         <h3 style="margin: 0; color: #4361ee; font-size: 1.5rem;">🔍 Filtres et Recherche</h3>
         <button onclick="resetFilters()"
                 style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; border: 2px solid #6c757d; border-radius: 25px; background: white; color: #6c757d; cursor: pointer; font-weight: 600; text-decoration: none;">
            <span>🔄</span>
            <span>Reset</span>
         </button>
      </div>

      <div style="display: flex; flex-wrap: wrap; gap: 1rem; align-items: end;">
         <div style="flex: 1; min-width: 180px;">
            <label style="font-weight: 600; color: #495057; font-size: 0.9rem; display: block; margin-bottom: 0.5rem;">Recherche</label>
            <input type="text" id="searchInput" placeholder="Texte, utilisateur..."
                   style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; background: white; width: 100%; box-sizing: border-box;">
         </div>

         <div style="flex: 1; min-width: 160px;">
            <label style="font-weight: 600; color: #495057; font-size: 0.9rem; display: block; margin-bottom: 0.5rem;">Action</label>
            <select id="actionFilter"
                    style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; background: white; width: 100%; box-sizing: border-box; cursor: pointer;">
               <option value="">Toutes les actions</option>
               <option value="CREATE">CREATE</option>
               <option value="READ">READ</option>
               <option value="UPDATE">UPDATE</option>
               <option value="DELETE">DELETE</option>
               <option value="EXECUTE">EXECUTE</option>
            </select>
         </div>

         <div style="flex: 1; min-width: 160px;">
            <label style="font-weight: 600; color: #495057; font-size: 0.9rem; display: block; margin-bottom: 0.5rem;">Ressource</label>
            <select id="resourceFilter"
                    style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; background: white; width: 100%; box-sizing: border-box; cursor: pointer;">
               <option value="">Toutes les ressources</option>
               <option value="SERVEUR">SERVEUR</option>
               <option value="TEST">TEST</option>
               <option value="CAISSE">CAISSE</option>
               <option value="SYSTEM">SYSTEM</option>
            </select>
         </div>

         <div style="flex: 1; min-width: 160px;">
            <label style="font-weight: 600; color: #495057; font-size: 0.9rem; display: block; margin-bottom: 0.5rem;">Statut</label>
            <select id="statusFilter"
                    style="padding: 0.75rem 1rem; border: 2px solid #e9ecef; border-radius: 10px; background: white; width: 100%; box-sizing: border-box; cursor: pointer;">
               <option value="">Tous</option>
               <option value="SUCCESS">✅ Succès</option>
               <option value="FAILED">❌ Échec</option>
            </select>
         </div>

         <div style="flex: 0 0 auto; min-width: 120px;">
            <label style="font-weight: 600; color: #495057; font-size: 0.9rem; display: block; margin-bottom: 0.5rem; opacity: 0;">Actions</label>
            <button onclick="applyFilters()"
                    style="padding: 0.75rem 1.5rem; border: none; border-radius: 10px; background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; cursor: pointer; font-weight: 600; display: flex; align-items: center; justify-content: center; gap: 0.5rem; width: 100%; white-space: nowrap;">
               🔍 Filtrer
            </button>
         </div>
      </div>
   </div>

   <!-- TABLEAU -->
   <div class="card">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
         <h3 style="color: #4361ee; margin: 0;">📋 Historique des Actions</h3>
         <select id="pageSize" onchange="loadAuditLogs(0)"
                 style="padding: 0.5rem; border: 1px solid #e9ecef; border-radius: 5px; background: white; min-width: 120px;">
            <option value="10">10 lignes</option>
            <option value="20" selected>20 lignes</option>
            <option value="50">50 lignes</option>
            <option value="100">100 lignes</option>
         </select>
      </div>

      <div class="data-table-container">
         <table class="data-table">
            <thead style="position: sticky; top: 0; z-index: 10;">
               <tr>
                  <th style="min-width: 150px;">Date/Heure</th>
                  <th style="min-width: 120px;">Utilisateur</th>
                  <th style="min-width: 100px;">Action</th>
                  <th style="min-width: 120px;">Ressource</th>
                  <th style="min-width: 200px;">Description</th>
                  <th style="min-width: 100px;">Statut</th>
                  <th style="min-width: 80px;">Temps</th>
                  <th style="min-width: 120px;">IP</th>
                  <th style="min-width: 100px; text-align: center;">Actions</th>
               </tr>
            </thead>
            <tbody id="auditLogsTable">
            </tbody>
         </table>
      </div>

      <div style="margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #e9ecef;">
         <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center mb-0" id="pagination" style="display: flex; gap: 0.5rem; list-style: none; padding: 0; margin: 0; flex-wrap: wrap; justify-content: center;">
            </ul>
         </nav>
      </div>
   </div>
</div>

<!-- POPUP DÉTAILS AMÉLIORÉE -->
<div id="auditDetailPopup" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.7); z-index: 10000; justify-content: center; align-items: center; backdrop-filter: blur(5px);">
   <div style="background: white; padding: 2rem; border-radius: 15px; max-width: 600px; width: 90%; max-height: 85vh; overflow-y: auto; box-shadow: 0 20px 60px rgba(0,0,0,0.3); position: relative;">
      <!-- Bouton fermer -->
      <button onclick="fermerDetailAudit()" style="position: absolute; top: 1rem; right: 1rem; background: none; border: none; font-size: 1.5rem; cursor: pointer; color: #6c757d; padding: 0.5rem; border-radius: 50%; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
         ✕
      </button>

      <h3 style="margin: 0 0 1.5rem 0; color: #4361ee; padding-right: 3rem;">🔍 Détails Complets de l'Audit</h3>

      <div id="auditDetailContent" style="margin-bottom: 1.5rem;">
         <!-- Le contenu sera chargé dynamiquement -->
      </div>

      <div style="display: flex; gap: 1rem; justify-content: flex-end; border-top: 1px solid #e9ecef; padding-top: 1.5rem;">
         <button onclick="fermerDetailAudit()"
                 style="padding: 0.75rem 1.5rem; background: #6c757d; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 600; transition: all 0.3s;">
            Fermer
         </button>
         <button onclick="exporterDetails()"
                 style="padding: 0.75rem 1.5rem; background: #4361ee; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 0.5rem; transition: all 0.3s;">
            📄 Exporter
         </button>
      </div>
   </div>
</div>
<script>
//<![CDATA[

// VARIABLES GLOBALES
let currentPage = 0;
let actionDistributionChart, userActivityChart, timelineChart;

// FONCTIONS DE BASE
function applyFilters() {
    loadAuditLogs(0);
}

function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('actionFilter').value = '';
    document.getElementById('resourceFilter').value = '';
    document.getElementById('statusFilter').value = '';
    loadAuditLogs(0);
}

// CHARGEMENT DES DONNÉES
function loadAuditLogs(page) {
    console.log('🚨 loadAuditLogs appelée, page:', page);

    const pageSize = 20;
    const search = document.getElementById('searchInput').value || '';
    const action = document.getElementById('actionFilter').value || '';
    const resource = document.getElementById('resourceFilter').value || '';
    const status = document.getElementById('statusFilter').value || '';

    // Construction URL
    let url = '/api/audit/page?page=' + page + '&size=' + pageSize;
    if (search) url += '&search=' + encodeURIComponent(search);
    if (action) url += '&action=' + encodeURIComponent(action);
    if (resource) url += '&resource=' + encodeURIComponent(resource);
    if (status) url += '&status=' + encodeURIComponent(status);

    console.log('🔍 URL appelée:', url);

    // REQUÊTE SIMPLE
    fetch(url)
        .then(function(response) {
            console.log('📡 Response status:', response.status);
            if (!response.ok) {
                throw new Error('Erreur HTTP ' + response.status);
            }
            return response.json();
        })
        .then(function(data) {
            console.log('✅ DATA reçue:', data);

            // VÉRIFICATION CRITIQUE
            if (!data) {
                console.error('❌ data est null/undefined');
                return;
            }

            if (!data.content) {
                console.warn('⚠️ data.content est undefined');
                data.content = [];
            }

            console.log('📊 data.content:', data.content);
            console.log('🔢 data.content length:', data.content.length);

            // AFFICHAGE
            renderAuditLogs(data.content);
            updateStats(data.content);
            currentPage = data.number || 0;

        })
        .catch(function(error) {
            console.error('💥 ERREUR FATALE:', error);
            document.getElementById('auditLogsTable').innerHTML =
                '<tr><td colspan="9" style="text-align: center; padding: 3rem; color: red;">ERREUR: ' + error.message + '</td></tr>';
        });
}

// RENDU SIMPLE
function renderAuditLogs(logs) {
    console.log('🎨 renderAuditLogs appelée avec:', logs);

    const tbody = document.getElementById('auditLogsTable');
    if (!tbody) {
        console.error('❌ tbody introuvable');
        return;
    }

    tbody.innerHTML = '';

    if (!logs || logs.length === 0) {
        tbody.innerHTML = '<tr><td colspan="9" style="text-align: center; padding: 3rem;">Aucune donnée</td></tr>';
        return;
    }

    logs.forEach(function(log) {
        const date = new Date(log.timestamp).toLocaleString('fr-FR');
        const row = document.createElement('tr');

        row.innerHTML =
            '<td style="padding: 0.75rem;"><small><strong>' + date + '</strong></small></td>' +
            '<td style="padding: 0.75rem;"><div style="font-weight: 600;">' + (log.username || 'N/A') + '</div></td>' +
            '<td style="padding: 0.75rem;"><span style="background: #4361ee; color: white; padding: 0.25rem 0.5rem; border-radius: 12px; font-size: 0.75rem; font-weight: 600;">' + (log.action || 'N/A') + '</span></td>' +
            '<td style="padding: 0.75rem;"><span style="background: #7209b7; color: white; padding: 0.25rem 0.5rem; border-radius: 12px; font-size: 0.75rem; font-weight: 600;">' + (log.resource || 'N/A') + '</span></td>' +
            '<td style="padding: 0.75rem;"><div style="font-weight: 500;">' + (log.description || 'N/A') + '</div></td>' +
            '<td style="padding: 0.75rem; white-space: nowrap;">' +
                (log.success ?
                    '<span style="background: #06d6a0; color: white; padding: 0.25rem 0.5rem; border-radius: 12px; font-size: 0.75rem; font-weight: 600; white-space: nowrap;">✅ SUCCÈS</span>' :
                    '<span style="background: #ef476f; color: white; padding: 0.25rem 0.5rem; border-radius: 12px; font-size: 0.75rem; font-weight: 600; white-space: nowrap;">❌ ÉCHEC</span>') +
            '</td>' +
            '<td style="padding: 0.75rem; text-align: center;"><div style="font-weight: 600;">' + (log.executionTime ? log.executionTime + ' ms' : 'N/A') + '</div></td>' +
            '<td style="padding: 0.75rem;"><code style="background: #f8f9fa; padding: 0.2rem 0.4rem; border-radius: 4px; font-size: 0.75rem;">' + (log.ipAddress || 'N/A') + '</code></td>' +
            '<td style="padding: 0.75rem; text-align: center;">' +
                '<button onclick="voirDetailsAudit(' + log.id + ')" style="padding: 0.3rem 0.6rem; background: #4361ee; color: white; border: none; border-radius: 5px; font-size: 0.7rem; cursor: pointer; white-space: nowrap;">👁️ Détails</button>' +
            '</td>';

        tbody.appendChild(row);
    });
}

function updateStats(logs) {
    const total = logs.length;
    const success = logs.filter(function(log) { return log.success; }).length;
    const failed = logs.filter(function(log) { return !log.success; }).length;
    const rate = total > 0 ? ((success / total) * 100).toFixed(1) : 0;

    document.getElementById('totalActions').textContent = total;
    document.getElementById('successActions').textContent = success;
    document.getElementById('failedActions').textContent = failed;
    document.getElementById('successRate').textContent = rate + '%';
}

// ==================== FONCTIONS GRAPHIQUES ====================

function loadAllCharts() {
    console.log('📊 Chargement des graphiques...');
    loadActionDistribution();
    loadUserActivity();
    loadTimelineData();
}

function loadActionDistribution() {
    fetch('/api/audit/stats/actions')
        .then(function(response) { return response.json(); })
        .then(function(data) {
            console.log('📈 Données actions:', data);
            createActionDistributionChart(data);
        })
        .catch(function(error) {
            console.error('❌ Erreur stats actions:', error);
            showChartError('actionDistributionChart', 'Données indisponibles');
        });
}

function loadUserActivity() {
    fetch('/api/audit/stats/users')
        .then(function(response) { return response.json(); })
        .then(function(data) {
            console.log('👥 Données utilisateurs:', data);
            createUserActivityChart(data);
        })
        .catch(function(error) {
            console.error('❌ Erreur stats utilisateurs:', error);
            showChartError('userActivityChart', 'Données indisponibles');
        });
}

function loadTimelineData() {
    fetch('/api/audit/stats/timeline')
        .then(function(response) { return response.json(); })
        .then(function(data) {
            console.log('📅 Données timeline:', data);
            createTimelineChart(data);
        })
        .catch(function(error) {
            console.error('❌ Erreur timeline:', error);
            showChartError('timelineChart', 'Données indisponibles');
        });
}

function createActionDistributionChart(data) {
    const ctx = document.getElementById('actionDistributionChart').getContext('2d');
    if (actionDistributionChart) actionDistributionChart.destroy();

    if (!data || !data.labels || data.labels.length === 0) {
        showChartError('actionDistributionChart', 'Aucune donnée disponible');
        return;
    }

    actionDistributionChart = new Chart(ctx, {
        type: 'doughnut',
        data: data,
        options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
    });
}

function createUserActivityChart(data) {
    const ctx = document.getElementById('userActivityChart').getContext('2d');
    if (userActivityChart) userActivityChart.destroy();

    if (!data || !data.labels || data.labels.length === 0) {
        showChartError('userActivityChart', 'Aucune donnée disponible');
        return;
    }

    userActivityChart = new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true }, x: { grid: { display: false } } }
        }
    });
}

function createTimelineChart(data) {
    const ctx = document.getElementById('timelineChart').getContext('2d');
    if (timelineChart) timelineChart.destroy();

    if (!data || !data.labels || data.labels.length === 0) {
        showChartError('timelineChart', 'Aucune donnée disponible');
        return;
    }

    timelineChart = new Chart(ctx, {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            plugins: { legend: { position: 'top' } },
            scales: { y: { beginAtZero: true }, x: { grid: { display: false } } }
        }
    });
}

function showChartError(canvasId, message) {
    const canvas = document.getElementById(canvasId);
    const ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = '#f8f9fa';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = '#6c757d';
    ctx.textAlign = 'center';
    ctx.font = '14px Arial';
    ctx.fillText(message, canvas.width / 2, canvas.height / 2);
}

// ==================== FONCTIONS POPUP AMÉLIORÉES ====================

function voirDetailsAudit(auditId) {
    console.log('🔍 Chargement détails audit:', auditId);

    // Afficher loader
    const content = document.getElementById('auditDetailContent');
    content.innerHTML = '<div style="text-align: center; padding: 2rem;">' +
        '<div style="font-size: 3rem; margin-bottom: 1rem;">⏳</div>' +
        '<h4 style="color: #4361ee;">Chargement...</h4>' +
        '</div>';

    // Afficher popup
    document.getElementById('auditDetailPopup').style.display = 'flex';

    // Charger données
    fetch('/api/audit/' + auditId)
        .then(function(response) {
            if (!response.ok) throw new Error('Erreur HTTP ' + response.status);
            return response.json();
        })
        .then(function(auditData) {
            afficherDetailsAudit(auditData);
        })
        .catch(function(error) {
            content.innerHTML = '<div style="text-align: center; color: #dc3545;">' +
                '<h4>❌ Erreur</h4><p>' + error.message + '</p>' +
                '</div>';
        });
}

function afficherDetailsAudit(audit) {
    const content = document.getElementById('auditDetailContent');
    const date = new Date(audit.timestamp).toLocaleString('fr-FR');

    let html = '<div style="display: grid; gap: 1rem;">';

    // En-tête
    html += '<div style="display: flex; justify-content: space-between; align-items: start;">';
    html += '<div><h4 style="margin: 0; color: #4361ee;">' + (audit.action || 'N/A') + '</h4>';
    html += '<p style="margin: 0; color: #6c757d; font-size: 0.9rem;">ID: ' + audit.id + ' • ' + date + '</p></div>';
    html += '<span style="background: ' + (audit.success ? '#06d6a0' : '#ef476f') + '; color: white; padding: 0.4rem 0.8rem; border-radius: 20px; font-size: 0.8rem; font-weight: 600;">';
    html += (audit.success ? '✅ SUCCÈS' : '❌ ÉCHEC') + '</span>';
    html += '</div>';

    // Informations
    html += '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">';
    html += '<div style="background: #f8f9fa; padding: 1rem; border-radius: 8px;">';
    html += '<strong style="display: block; color: #495057; margin-bottom: 0.5rem; font-size: 0.8rem;">👤 UTILISATEUR</strong>';
    html += '<div style="font-weight: 600; color: #4361ee;">' + (audit.username || 'N/A') + '</div>';
    html += '<div style="font-size: 0.8rem; color: #6c757d;">' + (audit.userRole || 'N/A') + '</div>';
    html += '</div>';

    html += '<div style="background: #f8f9fa; padding: 1rem; border-radius: 8px;">';
    html += '<strong style="display: block; color: #495057; margin-bottom: 0.5rem; font-size: 0.8rem;">🎯 RESSOURCE</strong>';
    html += '<div style="font-weight: 600; color: #7209b7;">' + (audit.resource || 'N/A') + '</div>';
    html += '<div style="font-size: 0.8rem; color: #6c757d;">ID: ' + (audit.resourceId || 'N/A') + '</div>';
    html += '</div>';
    html += '</div>';

    // Description
    html += '<div>';
    html += '<strong style="display: block; color: #495057; margin-bottom: 0.5rem; font-size: 0.8rem;">📝 DESCRIPTION</strong>';
    html += '<div style="background: #f8f9fa; padding: 1rem; border-radius: 8px; border-left: 4px solid #4361ee;">';
    html += (audit.description || 'Aucune description disponible');
    html += '</div>';
    html += '</div>';

    // Informations techniques
    html += '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">';
    html += '<div>';
    html += '<strong style="display: block; color: #495057; margin-bottom: 0.5rem; font-size: 0.8rem;">⏱️ PERFORMANCE</strong>';
    html += '<div style="font-weight: 600; color: #06d6a0;">' + (audit.executionTime ? audit.executionTime + ' ms' : 'N/A') + '</div>';
    html += '</div>';

    html += '<div>';
    html += '<strong style="display: block; color: #495057; margin-bottom: 0.5rem; font-size: 0.8rem;">🌐 CONNEXION</strong>';
    html += '<code style="background: #e9ecef; padding: 0.3rem 0.6rem; border-radius: 4px; font-size: 0.8rem;">' + (audit.ipAddress || 'N/A') + '</code>';
    html += '</div>';
    html += '</div>';

    // User Agent
    if (audit.userAgent) {
        html += '<div>';
        html += '<strong style="display: block; color: #495057; margin-bottom: 0.5rem; font-size: 0.8rem;">🖥️ USER AGENT</strong>';
        html += '<div style="background: #f8f9fa; padding: 0.75rem; border-radius: 8px; font-size: 0.8rem; color: #495057; font-family: monospace;">';
        html += audit.userAgent;
        html += '</div>';
        html += '</div>';
    }

    // Erreur
    if (!audit.success && audit.errorMessage) {
        html += '<div>';
        html += '<strong style="display: block; color: #495057; margin-bottom: 0.5rem; font-size: 0.8rem;">🚨 ERREUR</strong>';
        html += '<div style="background: #ffe6e6; padding: 1rem; border-radius: 8px; border-left: 4px solid #ef476f; color: #dc3545; font-size: 0.9rem;">';
        html += audit.errorMessage;
        html += '</div>';
        html += '</div>';
    }

    html += '</div>';
    content.innerHTML = html;
}

function fermerDetailAudit() {
    document.getElementById('auditDetailPopup').style.display = 'none';
}

function exporterDetails() {
    const content = document.getElementById('auditDetailContent').innerText;
    const blob = new Blob([content], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'audit-details-' + new Date().toISOString().split('T')[0] + '.txt';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);

    // Feedback utilisateur
    const bouton = document.querySelector('button[onclick="exporterDetails()"]');
    const oldText = bouton.innerHTML;
    bouton.innerHTML = '✅ Exporté !';
    setTimeout(function() {
        bouton.innerHTML = oldText;
    }, 2000);
}

// CHARGEMENT INITIAL
document.addEventListener('DOMContentLoaded', function() {
    console.log('🚀 DOM chargé - Démarrage');
    setTimeout(function() {
        loadAuditLogs(0);
        loadAllCharts();
    }, 100);
});

//]]>
</script>
<style>
.dashboard { max-width: 1400px; margin: 0 auto; padding: 20px; }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
.update-badge { background: rgba(255, 255, 255, 0.2); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.9rem; font-weight: 600; }
.card { background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 2rem; margin-bottom: 2rem; }
.data-table-container { overflow-x: auto; border-radius: 10px; border: 1px solid #e9ecef; }
.data-table { width: 100%; border-collapse: collapse; font-size: 0.85rem; }
.data-table th { background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; padding: 0.75rem; text-align: left; font-weight: 600; border: none; }
.data-table td { padding: 0.75rem; border-bottom: 1px solid #e9ecef; vertical-align: middle; }
.data-table tr:hover { background-color: #f8f9fa; }
.pagination { display: flex; gap: 0.5rem; list-style: none; padding: 0; margin: 0; flex-wrap: wrap; justify-content: center; }

/* SUPPRESSION SCROLLBAR VERTICALE */
.data-table-container::-webkit-scrollbar { display: none; }
.data-table-container { -ms-overflow-style: none; scrollbar-width: none; }
</style>

<jsp:include page="../includes/footer.jsp" />