// realtime-manager.js
/**
 * Gestionnaire temps réel pour le dashboard
 * Version corrigée - Ne remplace PAS showNotification
 */
const RealtimeManager = {
    eventSource: null,
    pollingInterval: null,
    isConnected: false,

    init: function() {
        console.log('🔄 RealtimeManager initialisé');

        // Vérifier si SSE est supporté
        if (typeof EventSource !== 'undefined') {
            this.connectSSE();
        } else {
            console.log('SSE non supporté, utilisation du polling');
            this.startPolling();
        }

        this.bindEvents();
        return this;
    },

    connectSSE: function() {
        try {
            this.eventSource = new EventSource('/api/metrics/stream');

            this.eventSource.onopen = () => {
                this.isConnected = true;
                console.log('✅ Connexion SSE établie');
                if (window.showNotification) {
                    window.showNotification('Connexion temps réel', 'Données en temps réel activées', 'success', 3000);
                }
            };

            this.eventSource.onmessage = (event) => {
                this.processEvent(event);
            };

            this.eventSource.addEventListener('metrics-update', (event) => {
                const data = JSON.parse(event.data);
                this.updateMetrics(data);
            });

            this.eventSource.addEventListener('alerts-update', (event) => {
                const data = JSON.parse(event.data);
                this.updateAlerts(data);
            });

            this.eventSource.addEventListener('tests-update', (event) => {
                const data = JSON.parse(event.data);
                this.updateTests(data);
            });

            this.eventSource.onerror = (error) => {
                console.error('❌ Erreur SSE:', error);
                this.isConnected = false;
                this.eventSource.close();

                setTimeout(() => {
                    if (!this.isConnected) {
                        console.log('🔄 Tentative de reconnexion SSE...');
                        this.connectSSE();
                    }
                }, 5000);
            };

        } catch (error) {
            console.error('Erreur initialisation SSE:', error);
            this.startPolling();
        }
    },

    startPolling: function() {
        console.log('🔄 Démarrage polling (30s)');

        this.pollUpdates();

        this.pollingInterval = setInterval(() => {
            this.pollUpdates();
        }, 30000);
    },

    pollUpdates: async function() {
        try {
            // Simuler des données pour l'exemple
            const mockData = {
                disponibilite: 95 + Math.floor(Math.random() * 5),
                tauxReussite: 92 + Math.floor(Math.random() * 8),
                tempsReponse: 150 + Math.floor(Math.random() * 50),
                serveursActifs: 8,
                testsEnCours: 3
            };

            this.updateMetrics(mockData);
        } catch (error) {
            console.warn('Erreur polling:', error);
        }
    },

    processEvent: function(event) {
        try {
            const data = JSON.parse(event.data);
            this.updateMetrics(data);
        } catch (error) {
            console.error('Erreur traitement événement:', error);
        }
    },

    updateMetrics: function(data) {
        if (!data) return;

        this.updateValue('disponibilite', data.disponibilite, '%');
        this.updateValue('tauxReussite', data.tauxReussite, '%');
        this.updateValue('tempsReponse', data.tempsReponse, 'ms');
        this.updateValue('serveursActifs', data.serveursActifs);
        this.updateValue('testsEnCours', data.testsEnCours);

        this.animateUpdate();
        this.updateTimestamp();
    },

    updateAlerts: function(data) {
        if (!data) return;

        if (data.critical && data.critical > 0) {
            this.showAlertBadge(data.critical);
        }
    },

    updateTests: function(data) {
        if (!data) return;
        console.log('Mise à jour tests:', data);
    },

    updateValue: function(type, value, suffix = '') {
        const elements = document.querySelectorAll(`[data-metric="${type}"]`);

        elements.forEach(el => {
            const currentValue = el.textContent.replace(suffix, '').trim();
            const newValue = value + suffix;

            if (currentValue !== newValue) {
                el.textContent = newValue;

                if (el.classList.contains('stat-value') || el.classList.contains('stat-value-metrics')) {
                    el.classList.add('animate-pulse');
                    setTimeout(() => el.classList.remove('animate-pulse'), 1000);
                }
            }
        });
    },

    showAlertBadge: function(count) {
        let badge = document.getElementById('liveAlertBadge');

        if (!badge) {
            badge = document.createElement('div');
            badge.id = 'liveAlertBadge';
            badge.style.cssText = `
                position: fixed;
                top: 80px;
                right: 200px;
                background: linear-gradient(135deg, #d50032, #ff5252);
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-weight: bold;
                z-index: 1000;
                box-shadow: 0 4px 12px rgba(213, 0, 50, 0.3);
                animation: bounce 1s infinite;
            `;
            document.body.appendChild(badge);
        }

        badge.innerHTML = `🚨 ${count} alerte(s) critique(s)`;
        badge.style.display = 'block';

        setTimeout(() => {
            if (badge && badge.style.display !== 'none') {
                badge.style.display = 'none';
            }
        }, 10000);
    },

    animateUpdate: function() {
        const badges = document.querySelectorAll('.realtime-badge, [data-realtime="true"]');
        badges.forEach(badge => {
            badge.classList.add('animate-pulse');
            setTimeout(() => badge.classList.remove('animate-pulse'), 1000);
        });
    },

    updateTimestamp: function() {
        const now = new Date();
        const timeString = now.getHours().toString().padStart(2, '0') + ':' +
                          now.getMinutes().toString().padStart(2, '0');

        const timeElements = document.querySelectorAll('#currentTime, [data-time="current"]');
        timeElements.forEach(el => {
            el.textContent = timeString;
        });
    },

    bindEvents: function() {
        const refreshBtn = document.getElementById('manualRefreshBtn');
        if (refreshBtn) {
            refreshBtn.addEventListener('click', () => {
                this.forceRefresh();
            });
        }

        const toggleBtn = document.getElementById('toggleAutoRefresh');
        if (toggleBtn) {
            toggleBtn.addEventListener('click', (e) => {
                this.toggleAutoRefresh(e.target);
            });
        }
    },

    forceRefresh: function() {
        if (window.showNotification) {
            window.showNotification('Rafraîchissement', 'Mise à jour manuelle en cours...', 'info');
        }

        this.pollUpdates();

        if (window.ChartsManager) {
            window.ChartsManager.refresh();
        }
    },

    toggleAutoRefresh: function(button) {
        if (this.pollingInterval) {
            clearInterval(this.pollingInterval);
            this.pollingInterval = null;
            button.textContent = '▶️ Activer Auto-Refresh';
            button.classList.remove('active');

            if (window.showNotification) {
                window.showNotification('Auto-refresh', 'Auto-rafraîchissement désactivé', 'warning');
            }
        } else {
            this.startPolling();
            button.textContent = '⏸️ Désactiver Auto-Refresh';
            button.classList.add('active');

            if (window.showNotification) {
                window.showNotification('Auto-refresh', 'Auto-rafraîchissement activé (30s)', 'success');
            }
        }
    },

    disconnect: function() {
        if (this.eventSource) {
            this.eventSource.close();
            this.eventSource = null;
        }

        if (this.pollingInterval) {
            clearInterval(this.pollingInterval);
            this.pollingInterval = null;
        }

        this.isConnected = false;
        console.log('🔌 RealtimeManager déconnecté');
    }
};

// Fonction de notification SPÉCIFIQUE pour RealtimeManager
RealtimeManager.showRealtimeNotification = function(message, type = 'info') {
    if (window.showNotification && typeof window.showNotification === 'function') {
        window.showNotification('Temps réel', message, type, 3000);
        return;
    }

    console.log(`[REALTIME ${type}] ${message}`);
};

// Initialiser automatiquement
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(() => {
        window.RealtimeManager = RealtimeManager.init();
    }, 1000);
});

// Ajouter les styles
const realtimeStyles = document.createElement('style');
realtimeStyles.textContent = `
    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-5px); }
    }

    .animate-pulse {
        animation: pulse 1s;
    }

    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }
`;
document.head.appendChild(realtimeStyles);