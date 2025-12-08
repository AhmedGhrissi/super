// dashboard-simple.js
// ========== TIMER SIMPLE ET GARANTI ==========

(function() {
    'use strict';

    console.log('🚀 Dashboard Simple - Chargement');

    // Variables
    let timerSeconds = 300; // 5 minutes
    let timerInterval = null;
    let autoRefreshEnabled = true;

    // ========== 1. CRÉATION DU TIMER VISIBLE ==========
    function createTimer() {
        console.log('⏱️ Création du timer...');

        // Supprimer l'ancien si existe
        const oldTimer = document.getElementById('simpleTimer');
        if (oldTimer) oldTimer.remove();

        // Créer un NOUVEAU div
        const timerDiv = document.createElement('div');
        timerDiv.id = 'simpleTimer';

        // Style ABSOLUMENT visible
        timerDiv.style.cssText = `
            position: fixed !important;
            top: 15px !important;
            right: 15px !important;
            background: #28a745 !important;
            color: white !important;
            padding: 15px 25px !important;
            border-radius: 10px !important;
            font-size: 24px !important;
            font-weight: bold !important;
            font-family: Arial, Helvetica, sans-serif !important;
            z-index: 1000000 !important;
            box-shadow: 0 6px 20px rgba(0,0,0,0.3) !important;
            text-align: center !important;
            min-width: 140px !important;
            border: 3px solid white !important;
            display: block !important;
            visibility: visible !important;
            opacity: 1 !important;
        `;

        // Ajouter au body
        document.body.appendChild(timerDiv);
        console.log('✅ Timer créé');

        return timerDiv;
    }

    // ========== 2. METTRE À JOUR L'AFFICHAGE ==========
    function updateTimerDisplay(element) {
        const minutes = Math.floor(timerSeconds / 60);
        const seconds = timerSeconds % 60;
        element.textContent = `⏱️ ${minutes}:${seconds.toString().padStart(2, '0')}`;

        // Changer couleur à 1 minute
        if (timerSeconds <= 60) {
            element.style.background = '#dc3545';
        }

        // Log toutes les 30 secondes
        if (timerSeconds % 30 === 0) {
            console.log(`🕐 Timer: ${minutes}:${seconds.toString().padStart(2, '0')}`);
        }
    }

    // ========== 3. DÉMARRER LE TIMER ==========
    function startTimer() {
        console.log('▶️ Démarrage du timer...');

        // Arrêter l'ancien intervalle
        if (timerInterval) {
            clearInterval(timerInterval);
        }

        // Réinitialiser
        timerSeconds = 300;

        // Créer l'élément
        const timerElement = createTimer();
        updateTimerDisplay(timerElement);

        // Démarrer l'intervalle
        timerInterval = setInterval(() => {
            timerSeconds--;

            if (timerSeconds >= 0) {
                updateTimerDisplay(timerElement);

                // Rafraîchir à 0
                if (timerSeconds === 0) {
                    clearInterval(timerInterval);
                    timerElement.textContent = '🔄 Actualisation...';
                    timerElement.style.background = '#007bff';

                    setTimeout(() => {
                        console.log('🔄 Rafraîchissement de la page');
                        location.reload();
                    }, 2000);
                }
            } else {
                clearInterval(timerInterval);
            }
        }, 1000);

        console.log('✅ Timer démarré avec succès');
    }

    // ========== 4. AUTO-REFRESH ==========
    function setupAutoRefresh() {
        console.log('🔄 Configuration auto-refresh...');

        // Créer un bouton de contrôle
        const controlsDiv = document.createElement('div');
        controlsDiv.id = 'simpleControls';
        controlsDiv.style.cssText = `
            position: fixed;
            top: 15px;
            left: 15px;
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 999999;
            min-width: 200px;
        `;

        controlsDiv.innerHTML = `
            <div style="font-weight: bold; margin-bottom: 10px; color: #333;">Contrôles</div>
            <button id="pauseBtn" style="width: 100%; padding: 10px; margin-bottom: 8px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">
                ⏸️ Pause Auto-Refresh
            </button>
            <button id="debugBtn" style="width: 100%; padding: 10px; background: #17a2b8; color: white; border: none; border-radius: 5px; cursor: pointer;">
                🐛 Debug
            </button>
            <div style="margin-top: 10px; font-size: 12px; color: #666;">
                Rafraîchissement automatique chaque 5 minutes
            </div>
        `;

        document.body.appendChild(controlsDiv);

        // Gestionnaire pour pause/reprise
        document.getElementById('pauseBtn').addEventListener('click', function() {
            autoRefreshEnabled = !autoRefreshEnabled;

            if (autoRefreshEnabled) {
                this.textContent = '⏸️ Pause Auto-Refresh';
                this.style.background = '#28a745';
                showSimpleNotification('Auto-refresh', 'Activé', 'success');
                startTimer(); // Redémarrer le timer
            } else {
                this.textContent = '▶️ Activer Auto-Refresh';
                this.style.background = '#6c757d';
                showSimpleNotification('Auto-refresh', 'Désactivé', 'warning');

                if (timerInterval) {
                    clearInterval(timerInterval);
                    timerInterval = null;
                }
            }
        });

        // Gestionnaire pour debug
        document.getElementById('debugBtn').addEventListener('click', function() {
            const timer = document.getElementById('simpleTimer');
            alert(`📊 DEBUG DASHBOARD
• Timer visible: ${timer ? 'OUI' : 'NON'}
• Secondes restantes: ${timerSeconds}
• Auto-refresh: ${autoRefreshEnabled ? 'ACTIF' : 'PAUSE'}
• Timer actif: ${timerInterval ? 'OUI' : 'NON'}
${timer ? '• Affichage: ' + timer.textContent : ''}`);
        });
    }

    // ========== 5. NOTIFICATIONS SIMPLES ==========
    function showSimpleNotification(title, message, type = 'info') {
        console.log(`[${type}] ${title}: ${message}`);

        // Créer notification simple
        const notif = document.createElement('div');
        notif.style.cssText = `
            position: fixed;
            top: 100px;
            right: 15px;
            background: ${type === 'success' ? '#28a745' :
                         type === 'error' ? '#dc3545' :
                         type === 'warning' ? '#ffc107' : '#17a2b8'};
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            z-index: 999999;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            animation: slideIn 0.3s ease;
            max-width: 300px;
        `;

        let icon = 'ℹ️';
        if (type === 'success') icon = '✅';
        else if (type === 'error') icon = '❌';
        else if (type === 'warning') icon = '⚠️';

        notif.innerHTML = `
            <div style="display: flex; align-items: center; gap: 10px;">
                <div style="font-size: 20px;">${icon}</div>
                <div>
                    <div style="font-weight: bold;">${title}</div>
                    <div style="font-size: 14px; opacity: 0.9;">${message}</div>
                </div>
            </div>
        `;

        document.body.appendChild(notif);

        // Auto-suppression après 4 secondes
        setTimeout(() => {
            notif.style.opacity = '0';
            notif.style.transform = 'translateX(20px)';
            setTimeout(() => notif.remove(), 300);
        }, 4000);
    }

    // ========== 6. INITIALISATION ==========
    function initDashboard() {
        console.log('🎯 Initialisation Dashboard Simple');

        // Ajouter style CSS
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(30px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }
        `;
        document.head.appendChild(style);

        // Démarrer le timer
        startTimer();

        // Configurer les contrôles
        setupAutoRefresh();

        // Notification de bienvenue
        setTimeout(() => {
            showSimpleNotification('Dashboard Simple', 'Timer actif - Rafraîchissement automatique', 'success');
        }, 1000);

        console.log('✅ Dashboard Simple prêt !');
    }

    // ========== 7. EXPOSITION GLOBALE ==========
    window.startSimpleTimer = startTimer;
    window.debugDashboard = function() {
        const timer = document.getElementById('simpleTimer');
        alert(`DEBUG:\nTimer: ${timerSeconds}s\nAuto-refresh: ${autoRefreshEnabled ? 'ON' : 'OFF'}`);
    };

    // ========== 8. DÉMARRAGE ==========
    // Attendre que le DOM soit chargé
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initDashboard);
    } else {
        initDashboard();
    }

})();