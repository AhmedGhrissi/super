class RealTimeMonitor {
    constructor() {
        this.statsInterval = null;
        this.autoRefresh = true;
        this.init();
    }

    init() {
        this.loadDashboardStats();
        this.startAutoRefresh();
        this.bindEvents();
    }

    loadDashboardStats() {
        fetch('/api/dashboard/stats')
            .then(response => response.json())
            .then(data => this.updateDashboard(data))
            .catch(error => console.error('Erreur:', error));
    }

    updateDashboard(stats) {
        // Mettre à jour les éléments du dashboard
        document.getElementById('totalCaisses').textContent = stats.totalCaisses;
        document.getElementById('activeCaisses').textContent = stats.activeCaisses;
        document.getElementById('tauxReussite').textContent = stats.tauxReussite.toFixed(2) + '%';
        document.getElementById('tempsReponseMoyen').textContent = stats.tempsReponseMoyen + 'ms';

        // Mettre à jour le timestamp
        document.getElementById('lastUpdate').textContent = new Date().toLocaleTimeString();
    }

    startAutoRefresh() {
        this.statsInterval = setInterval(() => {
            if (this.autoRefresh) {
                this.loadDashboardStats();
            }
        }, 300000); // Toutes les 5 minutes
    }

    bindEvents() {
        // Bouton d'arrêt/démarrage auto-refresh
        document.getElementById('toggleRefresh').addEventListener('click', (e) => {
            this.autoRefresh = !this.autoRefresh;
            e.target.textContent = this.autoRefresh ? '🔄 Désactiver Auto-Refresh' : '🔄 Activer Auto-Refresh';
        });

        // Bouton de lancement de tous les tests
        document.getElementById('runAllTests').addEventListener('click', () => {
            this.runAllTests();
        });
    }

	runAllTests() {
	    fetch('/api/tests/lancer-tous', { method: 'POST' })
	        .then(response => response.text())
	        .then(message => {
	            showNotification('🚀 ' + message, 'success');
	            this.loadDashboardStats();
	        })
	        .catch(error => {
	            console.error('Erreur:', error);
	            showNotification('❌ Erreur lors du lancement des tests', 'error');
	        });
	}
}

// Initialisation quand la page est chargée
document.addEventListener('DOMContentLoaded', () => {
    new RealTimeMonitor();
});