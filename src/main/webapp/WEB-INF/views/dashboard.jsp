<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="includes/header.jsp" />

<style>
/* ========== STYLES ESSENTIELS ========== */
.dashboard-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

.dashboard-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    box-shadow: 0 8px 32px rgba(0, 103, 71, 0.2);
}

.dashboard-header-content {
    max-width: 1200px;
    margin: 0 auto;
}

.dashboard-title {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 0.5rem;
}

.dashboard-title h1 {
    margin: 0;
    font-size: 2.2rem;
    font-weight: 800;
}

.dashboard-badge {
    background: rgba(255, 255, 255, 0.2);
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    backdrop-filter: blur(10px);
}

.dashboard-subtitle {
    font-size: 1rem;
    color: rgba(255, 255, 255, 0.9);
    margin-bottom: 1.5rem;
}

.header-stats {
    display: flex;
    gap: 2rem;
    flex-wrap: wrap;
}

.stat-item {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.stat-icon {
    font-size: 1.8rem;
    background: rgba(255, 255, 255, 0.1);
    width: 50px;
    height: 50px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    backdrop-filter: blur(10px);
}

.stat-value {
    font-size: 1.3rem;
    font-weight: 700;
    margin-bottom: 0.1rem;
}

.stat-label {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.8);
}

.countdown-container {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    padding: 0.75rem 1.5rem;
    border-radius: 25px;
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    font-weight: 600;
    box-shadow: 0 4px 12px rgba(0, 103, 71, 0.2);
    margin-left: 1rem;
}

.countdown-timer {
    font-family: 'Courier New', monospace;
    font-size: 1.1rem;
    background: rgba(255, 255, 255, 0.2);
    padding: 0.25rem 0.75rem;
    border-radius: 12px;
    min-width: 70px;
    text-align: center;
}

.system-status-section {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.system-status-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #e9ecef;
}

.system-status-header h3 {
    margin: 0;
    color: #006747;
    font-size: 1.25rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.system-status-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
}

.system-status-item {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.system-status-label {
    font-size: 0.9rem;
    color: #6c757d;
    font-weight: 500;
}

.system-status-value {
    font-size: 1.1rem;
    font-weight: 600;
    color: #343a40;
}

.system-status-value.success { color: #28a745; }
.system-status-value.warning { color: #ffc107; }
.system-status-value.error { color: #dc3545; }

/* ========== ALERTES EN LISTE ========== */
.alerts-section-modern {
    background: white;
    border-radius: 16px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.alerts-header-modern {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 2px solid #e9ecef;
}

.alerts-title {
    font-size: 1.3rem;
    font-weight: 700;
    color: #006747;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.badge-tests {
    background: linear-gradient(135deg, #ff6b00, #e65c00);
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    margin-left: 0.5rem;
}

.alerts-count {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-weight: 600;
    color: #495057;
}

.alert-count-critical { color: #d50032; }
.alert-count-warning { color: #ffc107; }

.alerts-refresh-btn {
    cursor: pointer;
    margin-left: 0.5rem;
    padding: 0.25rem 0.5rem;
    border-radius: 6px;
    background: #f8f9fa;
    border: 1px solid #dee2e6;
    font-size: 0.9rem;
    transition: all 0.2s ease;
}

.alerts-refresh-btn:hover {
    background: #e9ecef;
    transform: rotate(90deg);
}

.alerts-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 1rem;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

.alerts-table th {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    color: #495057;
    border-bottom: 2px solid #dee2e6;
    font-size: 0.9rem;
}

.alerts-table td {
    padding: 1rem;
    border-bottom: 1px solid #e9ecef;
    vertical-align: middle;
}

.alerts-table tr:hover {
    background-color: #f8f9fa;
}

.alert-priority {
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-size: 0.8rem;
}

.alert-priority.CRITICAL { color: #d50032; }
.alert-priority.WARNING { color: #ff8c00; }
.alert-priority.INFO { color: #1976d2; }

.empty-alerts-list {
    text-align: center;
    padding: 3rem;
    background: #f8f9fa;
    border-radius: 12px;
    margin-top: 1rem;
}

/* ========== ACTIONS RAPIDES ========== */
.quick-actions-section {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.quick-actions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
}

.quick-action-card {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s ease;
    border: 1px solid #e9ecef;
}

.quick-action-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.1);
}

.quick-action-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.quick-action-title {
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
    font-size: 1.1rem;
}

.quick-action-description {
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 1.5rem;
}

.btn-quick-action {
    width: 100%;
    padding: 0.75rem 1rem;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    justify-content: center;
    transition: all 0.3s ease;
    font-size: 0.95rem;
}

.btn-test-all {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
}

.btn-test-all:hover {
    background: linear-gradient(135deg, #00563c, #247a4d);
    transform: translateY(-2px);
}

.btn-test-category {
    background: linear-gradient(135deg, #7209b7, #3a0ca3);
    color: white;
}

.btn-test-category:hover {
    background: linear-gradient(135deg, #5e0a9c, #2f0b84);
    transform: translateY(-2px);
}

/* ========== CHATBOT ========== */
.chatbot-wrapper {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
}

.chatbot-toggle-btn {
    width: 60px;
    height: 60px;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    border: none;
    border-radius: 50%;
    font-size: 1.5rem;
    cursor: pointer;
    box-shadow: 0 4px 16px rgba(0, 103, 71, 0.3);
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.chatbot-toggle-btn:hover {
    transform: scale(1.1);
    box-shadow: 0 6px 24px rgba(0, 103, 71, 0.4);
}

.chatbot-container {
    position: absolute;
    bottom: 70px;
    right: 0;
    width: 380px;
    height: 520px;
    background: white;
    border-radius: 20px;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
    display: none;
    flex-direction: column;
    overflow: hidden;
    border: 1px solid #e9ecef;
}

.chatbot-container.active {
    display: flex;
    animation: slideUp 0.3s ease-out;
}

@keyframes slideUp {
    from { transform: translateY(20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

.chatbot-header {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    padding: 1.25rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-radius: 20px 20px 0 0;
}

.chatbot-title {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-weight: 600;
    font-size: 1.1rem;
}

.chatbot-status {
    background: rgba(255, 255, 255, 0.2);
    padding: 0.25rem 0.75rem;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 500;
}

.chatbot-close-btn {
    background: none;
    border: none;
    color: white;
    font-size: 1.8rem;
    cursor: pointer;
    line-height: 1;
    padding: 0;
    opacity: 0.8;
    transition: opacity 0.2s;
}

.chatbot-close-btn:hover { opacity: 1; }

.chatbot-body {
    flex: 1;
    padding: 1.25rem;
    overflow-y: auto;
    background: #f8f9fa;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.chatbot-message {
    max-width: 85%;
    animation: fadeIn 0.3s ease-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.chatbot-message.bot { align-self: flex-start; }
.chatbot-message.user { align-self: flex-end; }

.message-bubble {
    padding: 0.875rem 1.125rem;
    border-radius: 18px;
    font-size: 0.95rem;
    line-height: 1.4;
    position: relative;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.chatbot-message.bot .message-bubble {
    background: white;
    border: 1px solid #e9ecef;
    color: #343a40;
    border-radius: 18px 18px 18px 4px;
}

.chatbot-message.user .message-bubble {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    border-radius: 18px 18px 4px 18px;
}

.chatbot-quick-actions {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.75rem;
    margin-top: 0.5rem;
}

.quick-action-btn {
    background: rgba(0, 103, 71, 0.1);
    border: 1px solid rgba(0, 103, 71, 0.2);
    border-radius: 12px;
    padding: 0.625rem;
    font-size: 0.85rem;
    color: #006747;
    cursor: pointer;
    transition: all 0.2s ease;
    text-align: center;
    font-weight: 500;
}

.quick-action-btn:hover {
    background: rgba(0, 103, 71, 0.15);
    transform: translateY(-2px);
}

/* ========== RESPONSIVE ========== */
@media (max-width: 768px) {
    .dashboard-container { padding: 1rem; }
    .dashboard-header-modern { padding: 1.5rem; }
    .header-stats { gap: 1rem; }
    .stat-item { flex-direction: column; text-align: center; gap: 0.5rem; }
    .alerts-table { display: block; overflow-x: auto; }
    .alerts-table th, .alerts-table td { min-width: 120px; }
    .quick-actions-grid { grid-template-columns: 1fr; }
}
</style>

<script>
	// ========== VARIABLES GLOBALES ==========
	let refreshInterval;
	let countdownInterval;
	let timeLeft = 5 * 60;
	const REFRESH_INTERVAL_MS = 5 * 60 * 1000;
	let currentStats = {};

	// ========== UTILITAIRES ==========
	function escapeHtml(text) {
	    if (!text) return '';
	    const div = document.createElement('div');
	    div.textContent = text;
	    return div.innerHTML;
	}

	function getCurrentTime() {
	    return new Date().toLocaleTimeString('fr-FR', {hour: '2-digit', minute: '2-digit'});
	}

	// ========== INITIALISATION ==========
	document.addEventListener('DOMContentLoaded', function() {
	    console.log('📊 Dashboard initialisé');

	    // 1. Mettre à jour l\'horloge
	    updateClock();
	    setInterval(updateClock, 60000);

	    // 2. Initialiser chatbot avec message de bienvenue
	    initChatbotWithWelcome();

	    // 3. Charger les données via API
	    loadDashboardData();

	    // 4. Démarrer le compte à rebours
	    startCountdown();

	    // 5. Rafraîchissement auto
	    startAutoRefresh();

	    // 6. Boutons rafraîchissement
	    setupRefreshButtons();
	});

	// ========== CHARGEMENT DONNÉES ==========
	function loadDashboardData() {
	    console.log('📡 Chargement données dashboard...');

	    // Essayer l\'API principale
	    fetch('/dashboard/api/data')
	        .then(response => {
	            if (!response.ok) {
	                console.log('⚠️ API principale non disponible, tentative fallback');
	                return loadFallbackData();
	            }
	            return response.json();
	        })
	        .then(data => {
	            if (data.error) {
	                console.error('❌ Erreur dans les données:', data.error);
	                loadFallbackData();
	                return;
	            }

	            console.log('✅ Données dashboard chargées');
	            currentStats = data;

	            // Mettre à jour toutes les sections
	            updateAllSections(data);

	        })
	        .catch(error => {
	            console.error('❌ Erreur chargement dashboard:', error);
	            loadFallbackData();
	        });
	}

	function updateAllSections(data) {
	    // Alertes
	    if (data.alertesCritiques && Array.isArray(data.alertesCritiques)) {
	        displayAlertsList(data.alertesCritiques);
	        updateAlertCounters(data.alertesCritiques);
	    } else {
	        displayAlertsList([]);
	    }

	    // Statistiques
	    const statsData = {
	        serveursActifs: data.serveursActifs || 0,
	        totalServeurs: data.totalServeurs || 0,
	        disponibilite: data.tauxDisponibilite || data.disponibilite || '0.0',
	        derniereMaj: data.derniereMaj || getCurrentTime(),
	        serveursCritiquesCount: data.serveursCritiquesCount || 0
	    };
	    updateDashboardStats(statsData);

	    // Graphiques
	    if (data.chartData) {
	        updateChartsWithData(data.chartData);
	    } else {
	        initializeChartsWithDefaultData();
	    }
	}

	function loadFallbackData() {
	    console.log('🔄 Chargement fallback...');

	    // 1. Alertes via API séparée
	    fetch('/api/alertes/actives')
	        .then(response => response.ok ? response.json() : [])
	        .then(alertes => {
	            console.log('📊 Alertes (fallback):', alertes.length);
	            displayAlertsList(alertes);
	            updateAlertCounters(alertes);
	        })
	        .catch(() => displayAlertsList([]));

	    // 2. Stats via mini-stats
	    fetch('/dashboard/mini-stats')
	        .then(response => response.ok ? response.json() : {})
	        .then(stats => {
	            console.log('📈 Stats (fallback):', stats);
	            updateDashboardStats(stats);
	        })
	        .catch(() => {
	            updateDashboardStats({
	                serveursActifs: 150,
	                totalServeurs: 161,
	                disponibilite: '75.3',
	                derniereMaj: getCurrentTime()
	            });
	        });
	}

	// ========== AFFICHER ALERTES EN LISTE ==========
	function displayAlertsList(alertes) {
	    const container = document.getElementById('alerts-list-container');
	    if (!container) return;

	    console.log('📋 Affichage de', alertes.length, 'alertes');

	    if (alertes && alertes.length > 0) {
	        let html = '<div style="overflow-x: auto;"><table class="alerts-table"><thead><tr>';
	        html += '<th>Nom</th><th>Priorité</th><th>Type</th><th>Serveur</th><th>Description</th><th>Heure</th><th>Actions</th></tr></thead><tbody>';

	        alertes.forEach((alerte, index) => {
	            const criticite = alerte.criticite || 'CRITICAL';
	            const nom = alerte.nom || alerte.titre || 'Alerte ' + (index + 1);
	            const type = alerte.type || alerte.typeAlerte || 'serveur';
	            const serveur = alerte.serveurCible || 'N/A';
	            const description = alerte.description || '';
	            const timestamp = alerte.timestampDisplay || getCurrentTime();
	            const id = alerte.id || 0;

	            html += '<tr>';
	            html += '<td><strong>' + escapeHtml(nom) + '</strong></td>';
	            html += '<td><span class="alert-priority ' + criticite + '">' + criticite + '</span></td>';
	            html += '<td>' + escapeHtml(type) + '</td>';
	            html += '<td>' + escapeHtml(serveur) + '</td>';
	            html += '<td>' + escapeHtml(description) + '</td>';
	            html += '<td>' + escapeHtml(timestamp) + '</td>';
	            html += '<td>';
	            html += '<button style="padding: 0.4rem 0.8rem; background: #006747; color: white; border: none; border-radius: 6px; cursor: pointer;" onclick="viewAlert(' + id + ')">Voir</button>';
	            html += '</td></tr>';
	        });

	        html += '</tbody></table></div>';
	        html += '<div style="margin-top: 1.5rem; text-align: center;">';
	        html += '<a href="/alertes" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #6c757d; color: white; border-radius: 8px; text-decoration: none; font-weight: 600;">';
	        html += '<span>📋</span> Voir toutes les alertes</a></div>';

	        container.innerHTML = html;
	    } else {
	        container.innerHTML = '<div class="empty-alerts-list">' +
	            '<div style="font-size: 4rem; margin-bottom: 1rem;">✅</div>' +
	            '<h4 style="color: #006747; margin-bottom: 0.5rem;">Aucune alerte critique</h4>' +
	            '<p style="color: #6c757d; margin-bottom: 1.5rem;">Tous les systèmes fonctionnent normalement</p>' +
	            '<div style="display: flex; gap: 1rem; justify-content: center; margin-top: 1rem;">' +
	            '<a href="/tests" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #6c757d; color: white; border-radius: 8px; text-decoration: none; font-weight: 600;">' +
	            '<span>🧪</span> Voir les tests</a>' +
	            '<a href="/alertes" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; background: #006747; color: white; border-radius: 8px; text-decoration: none; font-weight: 600;">' +
	            '<span>🔔</span> Historique des alertes</a>' +
	            '</div></div>';
	    }
	}

	function updateAlertCounters(alertes) {
	    let criticalCount = 0;
	    let warningCount = 0;

	    if (alertes && alertes.length > 0) {
	        alertes.forEach(alerte => {
	            const criticite = alerte.criticite || '';
	            if (criticite.toUpperCase() == 'CRITICAL') {
	                criticalCount++;
	            } else if (criticite.toUpperCase() === 'WARNING') {
	                warningCount++;
	            }
	        });
	    }

	    // Mettre à jour l\'interface
	    document.querySelector('.alert-count-critical').textContent = criticalCount + ' critiques';
	    document.querySelector('.alert-count-warning').textContent = '/ ' + warningCount + ' warnings';
	    document.getElementById('alertes-critiques-count').textContent = criticalCount;

	    const badgeTests = document.querySelector('.badge-tests');
	    if (criticalCount > 0) {
	        badgeTests.textContent = criticalCount + ' CRITIQUES';
	        badgeTests.style.display = 'inline-block';
	    } else {
	        badgeTests.style.display = 'none';
	    }

	    // Mettre à jour le statut système
	    const alertesElement = document.querySelector('.system-status-item:nth-child(4) .system-status-value');
	    if (alertesElement) {
	        alertesElement.textContent = criticalCount;
	        alertesElement.className = criticalCount > 0 ? 'system-status-value error' : 'system-status-value';
	    }
	}

	function updateDashboardStats(stats) {
	    // Mettre à jour les valeurs
	    document.querySelectorAll('[data-stat="serveursActifs"]').forEach(el => {
	        el.textContent = stats.serveursActifs + '/' + stats.totalServeurs;
	    });

	    document.querySelectorAll('[data-stat="disponibilite"]').forEach(el => {
	        el.textContent = stats.disponibilite + '%';
	    });

	    document.querySelectorAll('.last-update-time').forEach(el => {
	        el.textContent = stats.derniereMaj;
	    });

	    // Mettre à jour le statut global
	    updateGlobalStatus(stats);
	}

	function updateGlobalStatus(stats) {
	    const disponibilite = parseFloat(stats.disponibilite) || 0;
	    const alertesCritiques = parseInt(stats.serveursCritiquesCount) || 0;

	    let statutGlobal = 'EXCELLENT';
	    let statutClass = 'success';

	    if (alertesCritiques > 3) {
	        statutGlobal = 'CRITIQUE';
	        statutClass = 'error';
	    } else if (alertesCritiques > 0) {
	        statutGlobal = 'DÉGRADÉ';
	        statutClass = 'warning';
	    } else if (disponibilite >= 99.5) {
	        statutGlobal = 'EXCELLENT';
	        statutClass = 'success';
	    } else if (disponibilite >= 98.0) {
	        statutGlobal = 'BON';
	        statutClass = 'success';
	    } else if (disponibilite >= 95.0) {
	        statutGlobal = 'STABLE';
	        statutClass = 'success';
	    } else {
	        statutGlobal = 'DÉGRADÉ';
	        statutClass = 'warning';
	    }

	    // Mettre à jour le badge
	    const badge = document.querySelector('.dashboard-badge');
	    if (badge) {
	        badge.textContent = statutGlobal;
	        badge.style.background = statutClass === 'error' ? 'rgba(213, 0, 50, 0.2)' :
	                                 statutClass === 'warning' ? 'rgba(255, 193, 7, 0.2)' :
	                                 'rgba(40, 167, 69, 0.2)';
	    }

	    // Mettre à jour le statut dans la section système
	    const statutElement = document.querySelector('.system-status-item:nth-child(1) .system-status-value');
	    if (statutElement) {
	        statutElement.textContent = statutGlobal;
	        statutElement.className = 'system-status-value ' + statutClass;
	    }

	    // Mettre à jour la disponibilité
	    const dispoElement = document.querySelector('.system-status-item:nth-child(3) .system-status-value');
	    if (dispoElement) {
	        dispoElement.textContent = disponibilite + '%';
	    }
	}

	// ========== COMPTE À REBOURS ==========
	function startCountdown() {
	    clearInterval(countdownInterval);
	    timeLeft = 5 * 60;

	    function updateCountdownDisplay() {
	        const minutes = Math.floor(timeLeft / 60);
	        const seconds = timeLeft % 60;
	        const timeStr = minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');

	        document.querySelectorAll('.countdown-timer, #refresh-countdown, #refresh-countdown-header').forEach(el => {
	            if (el) el.textContent = timeStr;
	        });

	        if (timeLeft <= 0) {
	            refreshDashboard();
	            timeLeft = 5 * 60;
	        } else {
	            timeLeft--;
	        }
	    }

	    updateCountdownDisplay();
	    countdownInterval = setInterval(updateCountdownDisplay, 1000);
	}

	function startAutoRefresh() {
	    clearInterval(refreshInterval);
	    refreshInterval = setInterval(refreshDashboard, REFRESH_INTERVAL_MS);
	}

	function refreshDashboard() {
	    console.log('🔄 Rafraîchissement dashboard');

	    const refreshBtn = document.querySelector('.alerts-refresh-btn');
	    if (refreshBtn) {
	        refreshBtn.style.transform = 'rotate(360deg)';
	        refreshBtn.style.transition = 'transform 0.5s ease';
	        setTimeout(() => refreshBtn.style.transform = '', 500);
	    }

	    if (typeof showNotification === 'function') {
	        showNotification('🔄 Rafraîchissement en cours...', 'info');
	    }

	    startCountdown();
	    loadDashboardData();

	    setTimeout(() => {
	        if (typeof showNotification === 'function') {
	            showNotification('✅ Dashboard mis à jour', 'success');
	        }
	    }, 1000);
	}

	function setupRefreshButtons() {
	    document.querySelectorAll('.alerts-refresh-btn, .refresh-dashboard-btn').forEach(btn => {
	        btn.addEventListener('click', function(e) {
	            e.preventDefault();
	            refreshDashboard();
	        });
	    });
	}

	function updateClock() {
	    const now = new Date();
	    const timeStr = now.toLocaleTimeString('fr-FR', {hour: '2-digit', minute: '2-digit', second: '2-digit'});
	    const dateStr = now.toLocaleDateString('fr-FR', {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'});

	    const clockElement = document.getElementById('current-time');
	    if (clockElement) {
	        clockElement.innerHTML = '<strong>' + timeStr + '</strong> - ' + dateStr;
	    }
	}

	// ========== TESTS ==========
	function lancerTousTests() {
	    if (!confirm('Voulez-vous lancer tous les tests ?')) return;

	    console.log('🚀 Lancement de tous les tests');
	    showNotification('🔄 Lancement en cours...', 'info');

	    fetch('/tests/lancer-tous', {method: 'POST', headers: {'Content-Type': 'application/json'}})
	        .then(response => {
	            if (response.ok) {
	                showNotification('✅ Tests lancés avec succès !', 'success');
	                setTimeout(() => location.reload(), 3000);
	            } else {
	                showNotification('❌ Erreur lors du lancement', 'error');
	            }
	        })
	        .catch(() => showNotification('❌ Erreur réseau', 'error'));
	}

	function dashboardLancerTestsCategorie() {
	    const categorieSelect = document.getElementById('categorieSelectDashboard');
	    const categorie = categorieSelect ? categorieSelect.value : '';

	    if (!categorie) {
	        alert('⚠️ Veuillez sélectionner une catégorie');
	        return;
	    }

	    if (!confirm('Voulez-vous lancer les tests de la catégorie "' + categorie + '" ?')) return;

	    console.log('🚀 Lancement tests pour catégorie:', categorie);
	    showNotification('🔄 Lancement tests ' + categorie + '...', 'info');

	    fetch('/tests/lancer-categorie/' + encodeURIComponent(categorie), {method: 'POST', headers: {'Content-Type': 'application/json'}})
	        .then(response => {
	            if (response.ok) {
	                showNotification('✅ Tests lancés avec succès !', 'success');
	                setTimeout(() => location.reload(), 3000);
	            } else {
	                showNotification('❌ Erreur lors du lancement', 'error');
	            }
	        })
	        .catch(() => showNotification('❌ Erreur réseau', 'error'));
	}

	// ========== ALERTES ==========
	function viewAlert(alertId) {
	    if (alertId > 0) {
	        window.location.href = '/alertes/view/' + alertId;
	    }
	}

	// ========== GRAPHIQUES ==========
	function updateChartsWithData(chartData) {
	    updateAvailabilityChart(chartData.disponibilite7jours || [95, 96, 94, 97, 95, 96, 95]);
	    updateAlertsChart(chartData);
	}

	function updateAvailabilityChart(data) {
	    const ctx = document.getElementById('availabilityChart');
	    if (!ctx) return;

	    // Nettoyer si existe déjà
	    if (window.availabilityChart instanceof Chart) {
	        window.availabilityChart.destroy();
	    }

	    window.availabilityChart = new Chart(ctx.getContext('2d'), {
	        type: 'line',
	        data: {
	            labels: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
	            datasets: [{
	                label: 'Disponibilité (%)',
	                data: data,
	                borderColor: '#006747',
	                backgroundColor: 'rgba(0, 103, 71, 0.1)',
	                borderWidth: 2,
	                fill: true,
	                tension: 0.4
	            }]
	        },
	        options: {
	            responsive: true,
	            maintainAspectRatio: false,
	            plugins: {legend: {display: false}}
	        }
	    });
	}

	function updateAlertsChart(chartData) {
	    const ctx = document.getElementById('alertsChart');
	    if (!ctx) return;

	    // Nettoyer si existe déjà
	    if (window.alertsChart instanceof Chart) {
	        window.alertsChart.destroy();
	    }

	    const critical = chartData.alertesCritiques || 0;
	    const warning = chartData.alertesWarning || 0;
	    const info = chartData.alertesInfo || 0;

	    window.alertsChart = new Chart(ctx.getContext('2d'), {
	        type: 'doughnut',
	        data: {
	            labels: ['Critiques', 'Warnings', 'Info'],
	            datasets: [{
	                data: [critical, warning, info],
	                backgroundColor: ['#d50032', '#ffc107', '#2196F3']
	            }]
	        },
	        options: {
	            responsive: true,
	            maintainAspectRatio: false,
	            plugins: {legend: {position: 'bottom'}}
	        }
	    });

	    // Mettre à jour le badge
	    const total = critical + warning + info;
	    const badgeElement = document.getElementById('badge-total-alertes');
	    if (badgeElement) {
	        badgeElement.textContent = total + ' total';
	    }
	}

	function initializeChartsWithDefaultData() {
	    updateAvailabilityChart([95, 96, 94, 97, 95, 96, 95]);
	    updateAlertsChart({alertesCritiques: 0, alertesWarning: 0, alertesInfo: 0});
	}

	// ========== CHATBOT COMPLET ==========
	function initChatbotWithWelcome() {
	    const chatbotBody = document.getElementById('chatbot-body');
	    if (!chatbotBody) return;

	    // Message de bienvenue
	    const welcomeMsg = document.createElement('div');
	    welcomeMsg.className = 'chatbot-message bot';
	    welcomeMsg.innerHTML = '<div class="message-bubble">Bonjour ! Je suis votre assistant de monitoring IA. Comment puis-je vous aider ? 😊</div>' +
	                          '<div class="message-time">' + getCurrentTime() + '</div>';
	    chatbotBody.appendChild(welcomeMsg);

	    // Boutons d\'actions rapides
	    const quickActions = document.createElement('div');
	    quickActions.className = 'chatbot-quick-actions';
	    quickActions.innerHTML = '<button class="quick-action-btn" onclick="askChatbot(\'statut des serveurs\')">🖥️ Serveurs</button>' +
	                            '<button class="quick-action-btn" onclick="askChatbot(\'alertes actives\')">🔔 Alertes</button>' +
	                            '<button class="quick-action-btn" onclick="askChatbot(\'disponibilité\')">📊 Disponibilité</button>' +
	                            '<button class="quick-action-btn" onclick="askChatbot(\'tests en cours\')">🧪 Tests</button>';
	    chatbotBody.appendChild(quickActions);

	    // Initialiser les interactions
	    initChatbot();
	}

	function initChatbot() {
	    const toggle = document.getElementById('chatbot-toggle');
	    const container = document.getElementById('chatbot-container');
	    const closeBtn = document.getElementById('chatbot-close');
	    const input = document.getElementById('chatbot-input');

	    if (!toggle || !container) return;

	    toggle.addEventListener('click', function() {
	        container.classList.toggle('active');
	        if (container.classList.contains('active') && input) {
	            setTimeout(function() { input.focus(); }, 100);
	        }
	    });

	    if (closeBtn) {
	        closeBtn.addEventListener('click', function() {
	            container.classList.remove('active');
	        });
	    }
	}

	function sendChatbotMessage() {
	    const input = document.getElementById('chatbot-input');
	    if (!input || !input.value.trim()) return;

	    askChatbot(input.value.trim());
	    input.value = '';
	}

	function askChatbot(question) {
	    const container = document.getElementById('chatbot-container');
	    const body = document.getElementById('chatbot-body');

	    if (container) container.classList.add('active');
	    if (!body) return;

	    // Message utilisateur
	    const userMsg = document.createElement('div');
	    userMsg.className = 'chatbot-message user';
	    userMsg.innerHTML = '<div class="message-bubble">' + escapeHtml(question) + '</div>' +
	                       '<div class="message-time">' + getCurrentTime() + '</div>';
	    body.appendChild(userMsg);

	    // Réponse du bot (avec délai)
	    setTimeout(function() {
	        const botMsg = document.createElement('div');
	        botMsg.className = 'chatbot-message bot';
	        botMsg.innerHTML = '<div class="message-bubble">' + getChatbotResponse(question) + '</div>' +
	                          '<div class="message-time">' + getCurrentTime() + '</div>';
	        body.appendChild(botMsg);
	        body.scrollTop = body.scrollHeight;
	    }, 500);
	}

	function getChatbotResponse(question) {
	    const q = question.toLowerCase();

	    if (q.includes('serveur')) return "🖥️ " + (currentStats.serveursActifs || 0) + " serveurs actifs sur " + (currentStats.totalServeurs || 0);
	    if (q.includes('alerte')) return "🔔 Alertes chargées depuis la surveillance en temps réel";
	    if (q.includes('disponibilité')) return "📊 Disponibilité : " + (currentStats.tauxDisponibilite || currentStats.disponibilite || '0.0') + "%";
	    if (q.includes('test')) return "🧪 Tests automatisés - utilisez les 'Actions rapides' pour en lancer";
	    if (q.includes('bonjour') || q.includes('salut')) return "👋 Bonjour ! Comment puis-je vous aider avec le monitoring ?";
	    if (q.includes('aide')) return "💡 Je peux vous informer sur : serveurs, alertes, disponibilité, tests";

	    return "🤖 Posez-moi une question sur les serveurs, alertes, disponibilité ou tests !";
	}

	// AJOUTEZ CES FONCTIONS
	function loadServeursActifs() {
	    fetch('/dashboard/api/serveurs-actifs')
	        .then(response => response.ok ? response.json() : [])
	        .then(serveurs => {
	            console.log('✅ Serveurs chargés:', serveurs.length);
	            displayServeursList(serveurs);
	        })
	        .catch(error => {
	            console.error('❌ Erreur serveurs:', error);
	            displayServeursList([]);
	        });
	}

	function displayServeursList(serveurs) {
	    const container = document.getElementById('serveurs-list-container');
	    if (!container) return;

	    if (serveurs && serveurs.length > 0) {
	        let html = '<div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1rem;">';

	        serveurs.slice(0, 6).forEach(serveur => {
	            const statutClass = serveur.statut === 'ACTIF' ? 'success' :
	                              serveur.statut === 'INACTIF' ? 'warning' : 'error';

	            html += `
	            <div style="background: #f8f9fa; border-radius: 12px; padding: 1rem; border: 1px solid #e9ecef; transition: all 0.3s ease;">
	                <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 0.5rem;">
	                    <div>
	                        <h5 style="margin: 0 0 0.25rem 0; color: #343a40; font-size: 1rem;">${escapeHtml(serveur.nom)}</h5>
	                        <p style="margin: 0; color: #6c757d; font-size: 0.85rem;">${escapeHtml(serveur.adresseIP)}</p>
	                    </div>
	                    <span style="background: ${statutClass == 'success' ? '#28a745' : statutClass == 'warning' ? '#ffc107' : '#dc3545'};
	                           color: white; padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.75rem; font-weight: 600;">
	                        ${serveur.statut}
	                    </span>
	                </div>
	                <div style="display: flex; gap: 1rem; margin-top: 0.5rem; font-size: 0.85rem;">
	                    <span style="color: #6c757d;">${serveur.typeServeur || 'N/A'}</span>
	                    <span style="color: #6c757d;">•</span>
	                    <span style="color: #6c757d;">${serveur.environnement || 'N/A'}</span>
	                </div>
	                <a href="/serveurs/view/${serveur.id}"
	                   style="display: block; margin-top: 0.75rem; text-align: center; padding: 0.5rem; background: rgba(0, 103, 71, 0.1);
	                          color: #006747; border-radius: 8px; text-decoration: none; font-weight: 600; font-size: 0.85rem;">
	                    Voir détails
	                </a>
	            </div>`;
	        });

	        html += '</div>';

	        if (serveurs.length > 6) {
	            html += `<div style="text-align: center; margin-top: 1rem;">
	                <p style="color: #6c757d; font-size: 0.9rem;">+ ${serveurs.length - 6} autres serveurs</p>
	            </div>`;
	        }

	        container.innerHTML = html;
	    } else {
	        container.innerHTML = `
	        <div style="text-align: center; padding: 2rem;">
	            <div style="font-size: 3rem; margin-bottom: 1rem;">🖥️</div>
	            <h4 style="color: #006747; margin-bottom: 0.5rem;">Aucun serveur actif</h4>
	            <p style="color: #6c757d; margin-bottom: 1.5rem;">Ajoutez des serveurs pour commencer le monitoring</p>
	            <a href="/serveurs/create" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem;
	               background: #006747; color: white; border-radius: 8px; text-decoration: none; font-weight: 600;">
	                <span>➕</span> Ajouter un serveur
	            </a>
	        </div>`;
	    }
	}

	// AJOUTEZ CETTE FONCTION
	function loadAlertesStats() {
	    fetch('/dashboard/api/stats-alertes')
	        .then(response => response.ok ? response.json() : {})
	        .then(stats => {
	            console.log('📊 Stats alertes:', stats);
	            updateAlertsChart(stats);
	        })
	        .catch(error => {
	            console.log('⚠️ Pas de stats alertes, utilisation données par défaut');
	            updateAlertsChart({critical: 0, warning: 0, info: 0});
	        });
	}

	// MODIFIEZ LA FONCTION updateAlertsChart
	function updateAlertsChart(stats) {
	    const ctx = document.getElementById('alertsChart');
	    if (!ctx) return;

	    // Nettoyer si existe déjà
	    if (window.alertsChart instanceof Chart) {
	        window.alertsChart.destroy();
	    }

	    const critical = stats.critical || 0;
	    const warning = stats.warning || 0;
	    const info = stats.info || 0;
	    const total = critical + warning + info;

	    // Mettre à jour le badge
	    const badgeElement = document.getElementById('badge-total-alertes');
	    if (badgeElement) {
	        badgeElement.textContent = total + ' total';
	    }

	    // Si pas d'alertes, afficher un message
	    if (total == 0) {
	        ctx.parentElement.innerHTML = `
	            <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 250px;">
	                <div style="font-size: 4rem; margin-bottom: 1rem;">✅</div>
	                <h4 style="color: #006747; margin-bottom: 0.5rem;">Aucune alerte active</h4>
	                <p style="color: #6c757d;">Toutes les alertes sont résolues</p>
	            </div>
	        `;
	        return;
	    }

	    window.alertsChart = new Chart(ctx.getContext('2d'), {
	        type: 'doughnut',
	        data: {
	            labels: ['Critiques (' + critical + ')', 'Warnings (' + warning + ')', 'Info (' + info + ')'],
	            datasets: [{
	                data: [critical, warning, info],
	                backgroundColor: ['#d50032', '#ffc107', '#2196F3'],
	                borderWidth: 2,
	                borderColor: '#fff'
	            }]
	        },
	        options: {
	            responsive: true,
	            maintainAspectRatio: false,
	            plugins: {
	                legend: {
	                    position: 'bottom',
	                    labels: {
	                        padding: 20,
	                        font: { size: 12 },
	                        usePointStyle: true
	                    }
	                },
	                tooltip: {
	                    callbacks: {
	                        label: function(context) {
	                            const value = context.raw;
	                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
	                            const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
	                            return context.label + ': ' + value + ' (' + percentage + '%)';
	                        }
	                    }
	                }
	            }
	        }
	    });
	}

	// MODIFIEZ loadDashboardData pour inclure les stats
	function loadDashboardData() {
	    console.log('📡 Chargement données dashboard...');

	    // 1. Charger les stats des alertes
	    loadAlertesStats();

	    // 2. Charger les alertes actives
	    fetch('/api/alertes/actives')
	        .then(response => response.ok ? response.json() : [])
	        .then(alertes => {
	            console.log('✅ Alertes chargées:', alertes.length);
	            displayAlertsList(alertes);
	            updateAlertCounters(alertes);
	        })
	        .catch(() => displayAlertsList([]));

	    // 3. Charger les statistiques
	    fetch('/dashboard/mini-stats')
	        .then(response => response.ok ? response.json() : {})
	        .then(stats => {
	            console.log('✅ Stats chargées:', stats);
	            updateDashboardStats(stats);
	        })
	        .catch(() => updateDashboardStats({
	            serveursActifs: 150,
	            totalServeurs: 161,
	            disponibilite: '75.3'
	        }));
	}
</script>

<!-- ========== HTML PRINCIPAL ========== -->
<div class="dashboard-container" data-page="dashboard">

<!-- Header -->
<header class="dashboard-header-modern">
    <div class="dashboard-header-content">
        <div class="dashboard-title">
            <h1>Tableau de Bord</h1>
            <span class="dashboard-badge">ACTIF</span>
        </div>
        <p class="dashboard-subtitle">Supervision infrastructure - Temps réel</p>
        <div class="header-stats">
            <div class="stat-item">
                <div class="stat-icon">🖥️</div>
                <div>
                    <div class="stat-value" data-stat="serveursActifs">0/0</div>
                    <div class="stat-label">Serveurs actifs</div>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon">📊</div>
                <div>
                    <div class="stat-value" data-stat="disponibilite">0%</div>
                    <div class="stat-label">Disponibilité</div>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon">🔔</div>
                <div>
                    <div class="stat-value" id="alertes-critiques-count">0</div>
                    <div class="stat-label">Alertes critiques</div>
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-icon">🔄</div>
                <div>
                    <div class="stat-value last-update-time">--:--</div>
                    <div class="stat-label">Dernière mise à jour</div>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- État système -->
<section class="system-status-section">
    <div class="system-status-header">
        <h3><span>📈</span> État du Système</h3>
        <div style="display: flex; align-items: center; gap: 1rem;">
            <div style="font-size: 0.9rem; color: #6c757d;">
                <span id="current-time">--:--:--</span>
            </div>
            <div style="font-size: 0.9rem; color: #006747; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                <span>🔄</span> Rafraîchissement dans
                <span id="refresh-countdown-header" class="countdown-timer">05:00</span>
            </div>
        </div>
    </div>
    <div class="system-status-grid">
        <div class="system-status-item">
            <span class="system-status-label">Statut global</span>
            <span class="system-status-value success">EXCELLENT</span>
        </div>
        <div class="system-status-item">
            <span class="system-status-label">Prochaine MAJ</span>
            <span class="system-status-value warning">Demain 02:00</span>
        </div>
        <div class="system-status-item">
            <span class="system-status-label">Disponibilité</span>
            <span class="system-status-value">0%</span>
        </div>
        <div class="system-status-item">
            <span class="system-status-label">Alertes critiques</span>
            <span class="system-status-value error">0</span>
        </div>
    </div>
</section>

<!-- Alertes en liste -->
<section class="alerts-section-modern">
    <div class="alerts-header-modern">
        <div class="alerts-title">
            <span>🔔</span> Alertes Actives
            <span class="badge-tests" style="display: none;">0 CRITIQUES</span>
        </div>
        <div class="alerts-count">
            <span class="alert-count-critical">0 critiques</span>
            <span class="alert-count-warning">/ 0 warnings</span>
            <span class="alerts-refresh-btn" title="Rafraîchir">↻</span>
        </div>
    </div>
    <div id="alerts-list-container">
        <p style="text-align: center; padding: 2rem; color: #6c757d;">
            Chargement des alertes...
        </p>
    </div>
</section>

<!-- Actions rapides -->
<section class="quick-actions-section">
    <h3 style="margin-bottom: 1.5rem; color: #006747; display: flex; align-items: center; gap: 0.5rem;">
        <span>⚡</span> Actions Rapides
    </h3>
    <div class="quick-actions-grid">
        <div class="quick-action-card">
            <div class="quick-action-icon">🎯</div>
            <div class="quick-action-title">Lancer Tous les Tests</div>
            <div class="quick-action-description">Exécute tous les tests actifs</div>
            <button type="button" onclick="lancerTousTests()" class="btn-quick-action btn-test-all">
                <span>🚀</span> Exécuter
            </button>
        </div>
        <div class="quick-action-card">
            <div class="quick-action-icon">📁</div>
            <div class="quick-action-title">Tests par Catégorie</div>
            <div class="quick-action-description">Exécute des tests ciblés</div>
            <div style="margin-bottom: 1rem;">
                <select id="categorieSelectDashboard" style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 8px;">
                    <option value="">Choisir une catégorie</option>
                    <option value="conformite">Conformité</option>
                    <option value="processus_metier">Processus Métier</option>
                    <option value="surveillance">Surveillance</option>
                    <option value="ged">GED</option>
                    <option value="integration">Intégration</option>
                    <option value="web">Web</option>
                </select>
            </div>
            <button type="button" onclick="dashboardLancerTestsCategorie()" class="btn-quick-action btn-test-category">
                <span>📊</span> Lancer
            </button>
        </div>
        <div class="quick-action-card">
            <div class="quick-action-icon">📅</div>
            <div class="quick-action-title">Planifier MAJ</div>
            <div class="quick-action-description">Programmer une mise à jour</div>
            <a href="/mises-a-jour/create" class="btn-quick-action" style="background: linear-gradient(135deg, #ff6b00, #e65c00); color: white; text-decoration: none; text-align: center;">
                <span>➕</span> Nouvelle MAJ
            </a>
        </div>
    </div>
</section>

<!-- Graphiques -->
<section class="charts-section" style="margin-top: 2rem;">
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 1.5rem;">
        <div style="background: white; border-radius: 16px; padding: 1.5rem; box-shadow: 0 4px 16px rgba(0,0,0,0.08);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                <h4 style="margin: 0; color: #006747; font-size: 1.1rem; display: flex; align-items: center; gap: 0.5rem;">
                    <span>📈</span> Disponibilité (7 jours)
                </h4>
                <span style="background: rgba(0, 103, 71, 0.1); color: #006747; padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: 600;">
                    En temps réel
                </span>
            </div>
            <div style="position: relative; height: 250px;">
                <canvas id="availabilityChart" height="250"></canvas>
            </div>
        </div>
        <div style="background: white; border-radius: 16px; padding: 1.5rem; box-shadow: 0 4px 16px rgba(0,0,0,0.08);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                <h4 style="margin: 0; color: #006747; font-size: 1.1rem; display: flex; align-items: center; gap: 0.5rem;">
                    <span>📊</span> Répartition des alertes
                </h4>
                <span style="background: rgba(0, 103, 71, 0.1); color: #006747; padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.8rem; font-weight: 600;" id="badge-total-alertes">
                    0 total
                </span>
            </div>
            <div style="position: relative; height: 250px;">
                <canvas id="alertsChart" height="250"></canvas>
            </div>
        </div>
    </div>
</section>
<!-- Serveurs Actifs -->
<section class="serveurs-section" style="margin-top: 2rem;">
    <div style="background: white; border-radius: 16px; padding: 1.5rem; box-shadow: 0 4px 16px rgba(0,0,0,0.08);">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
            <h4 style="margin: 0; color: #006747; font-size: 1.1rem; display: flex; align-items: center; gap: 0.5rem;">
                <span>🖥️</span> Serveurs Actifs
            </h4>
            <a href="/serveurs" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.5rem 1rem; background: #006747; color: white; border-radius: 8px; text-decoration: none; font-size: 0.9rem; font-weight: 600;">
                <span>📋</span> Voir tous
            </a>
        </div>
        <div id="serveurs-list-container" style="min-height: 200px;">
            <p style="text-align: center; padding: 2rem; color: #6c757d;">
                Chargement des serveurs...
            </p>
        </div>
    </div>
</section>

<!-- Footer -->
<footer style="margin-top: 2rem; padding: 1.5rem; text-align: center; color: #6c757d; font-size: 0.85rem; border-top: 1px solid #e9ecef;">
    <p>
        🖥️ Dashboard de supervision |
        Dernière mise à jour: <span id="footer-time">--:--</span>
        |
        <span class="countdown-container">
            <span>🔄</span> Rafraîchissement dans
            <span id="refresh-countdown" class="countdown-timer">05:00</span>
        </span>
    </p>
    <p style="margin-top: 0.5rem; font-size: 0.8rem;">
        <span class="refresh-dashboard-btn" style="cursor: pointer; color: #006747; font-weight: 600; margin-right: 1rem;">
            🔄 Rafraîchir maintenant
        </span>
        | Système de monitoring v1.0
    </p>
</footer>

</div>

<!-- Chatbot -->
<div class="chatbot-wrapper">
    <div id="chatbot-container" class="chatbot-container">
        <div class="chatbot-header">
            <div class="chatbot-title">
                <span>🤖</span> Assistant IA
                <span class="chatbot-status">En ligne</span>
            </div>
            <button id="chatbot-close" class="chatbot-close-btn">×</button>
        </div>
        <div class="chatbot-body" id="chatbot-body">
            <!-- Le message de bienvenue sera ajouté par JavaScript -->
        </div>
        <div class="chatbot-input-area" style="padding: 1rem; border-top: 1px solid #e9ecef; background: white; display: flex; gap: 0.5rem;">
            <input type="text" id="chatbot-input" class="chatbot-input"
                   style="flex: 1; padding: 0.75rem; border: 1px solid #dee2e6; border-radius: 12px; font-size: 0.9rem;"
                   placeholder="Posez votre question..." onkeypress="if(event.key == 'Enter') sendChatbotMessage()">
            <button id="chatbot-send" class="chatbot-send-btn" onclick="sendChatbotMessage()"
                    style="background: #006747; color: white; border: none; border-radius: 12px; width: 50px; cursor: pointer; display: flex; align-items: center; justify-content: center;">
                <span>📤</span>
            </button>
        </div>
    </div>
    <button id="chatbot-toggle" class="chatbot-toggle-btn">
        <span>🤖</span>
    </button>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<jsp:include page="includes/footer.jsp" />