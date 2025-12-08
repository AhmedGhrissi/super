/**
 * Gestionnaire d'API pour toutes les requêtes
 * Gère le CSRF token automatiquement
 */
const ApiManager = {

    getCsrfToken: function() {
        // Rechercher le token CSRF de différentes manières
        const meta = document.querySelector('meta[name="_csrf"]');
        const input = document.querySelector('input[name="_csrf"]');
        const header = document.querySelector('input[name="${_csrf.parameterName}"]');

        if (meta) return meta.content;
        if (input) return input.value;
        if (header) return header.value;

        console.warn('Token CSRF non trouvé');
        return '';
    },

    getHeaders: function(contentType = 'application/json') {
        const headers = {
            'X-CSRF-TOKEN': this.getCsrfToken()
        };

        if (contentType) {
            headers['Content-Type'] = contentType;
        }

        return headers;
    },

    fetchJson: async function(url, options = {}) {
        const defaultOptions = {
            headers: this.getHeaders(),
            credentials: 'same-origin'
        };

        const mergedOptions = { ...defaultOptions, ...options };

        try {
            const response = await fetch(url, mergedOptions);

            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }

            return await response.json();
        } catch (error) {
            console.error(`Erreur fetch ${url}:`, error);
            throw error;
        }
    },

    // ========== ENDPOINTS SPÉCIFIQUES ==========

    // Métriques
    getMetricsHistorique: async function(days = 7) {
        return this.fetchJson(`/api/metrics/historique?days=${days}`);
    },

    getLiveMetrics: async function() {
        return this.fetchJson('/api/metrics/live');
    },

    // Tests
    launchAllTests: async function() {
        return this.fetchJson('/tests/lancer-tous', { method: 'POST' });
    },

    launchTestsByCategory: async function(category) {
        return this.fetchJson(`/tests/lancer-categorie/${category}`, { method: 'POST' });
    },

    // Serveurs
    getServerStats: async function() {
        return this.fetchJson('/api/serveurs/stats');
    },

    getActiveServers: async function() {
        return this.fetchJson('/api/serveurs/actifs');
    },

    // Alertes
    getAlertsStats: async function() {
        return this.fetchJson('/api/alertes/stats');
    },

    getCriticalAlerts: async function() {
        return this.fetchJson('/api/alertes/critiques');
    },

    // Rapports
    getWeeklyReports: async function() {
        return this.fetchJson('/api/rapports/hebdomadaires');
    },

    // Santé
    getHealthStatus: async function() {
        return this.fetchJson('/monitoring/health');
    },

    // ========== UTILITAIRES ==========

    postForm: async function(url, formData) {
        return this.fetchJson(url, {
            method: 'POST',
            headers: this.getHeaders('application/x-www-form-urlencoded'),
            body: new URLSearchParams(formData)
        });
    },

    uploadFile: async function(url, file, fieldName = 'file') {
        const formData = new FormData();
        formData.append(fieldName, file);

        return this.fetchJson(url, {
            method: 'POST',
            headers: { 'X-CSRF-TOKEN': this.getCsrfToken() },
            body: formData
        });
    },

    // SSE (Server-Sent Events)
    createEventSource: function(url, onMessage, onError = null) {
        const eventSource = new EventSource(url);

        eventSource.onmessage = function(event) {
            try {
                const data = JSON.parse(event.data);
                onMessage(data);
            } catch (e) {
                console.error('Erreur parsing SSE:', e);
            }
        };

        if (onError) {
            eventSource.onerror = onError;
        }

        return eventSource;
    }
};

// Exposer globalement
window.ApiManager = ApiManager;