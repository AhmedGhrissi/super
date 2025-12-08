// Initialisation et gestion des graphiques
const ChartManager = {
    charts: [],

    init: function() {
        this.loadRealData();
        this.setupAutoRefresh();
    },

    loadRealData: async function() {
        showLoading(true);

        try {
            const response = await fetch('/api/metrics/historique');
            if (!response.ok) throw new Error('Erreur réseau');

            const data = await response.json();
            this.updateCharts(data);

        } catch (error) {
            console.error('Erreur chargement données:', error);
            this.loadDemoData();
        } finally {
            showLoading(false);
        }
    },

    updateCharts: function(data) {
        // Nettoyer anciens graphiques
        this.charts.forEach(chart => chart.destroy());
        this.charts = [];

        // Créer les graphiques avec données réelles
        this.createSuccessRateChart(data);
        this.createVolumeChart(data);
        this.createResponseTimeChart(data);
        this.createStatusChart(data);
    },

    createSuccessRateChart: function(data) {
        const ctx = document.getElementById('successRateChart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.labels || ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
                datasets: [{
                    label: 'Taux de Réussite (%)',
                    data: data.tauxReussite || [85, 92, 78, 95, 88, 91, 86],
                    borderColor: '#006747',
                    backgroundColor: 'rgba(0, 103, 71, 0.1)',
                    tension: 0.4,
                    fill: true,
                    borderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        ticks: {
                            callback: v => v + '%'
                        }
                    }
                },
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleFont: { size: 14 },
                        bodyFont: { size: 13 },
                        padding: 12,
                        cornerRadius: 8,
                        callbacks: {
                            label: context => `Taux: ${context.parsed.y}%`
                        }
                    }
                }
            }
        });

        this.charts.push(chart);
    },

    // ... autres méthodes createVolumeChart, createResponseTimeChart, createStatusChart

    setupAutoRefresh: function() {
        // Auto-refresh toutes les 5 minutes
        setInterval(() => {
            this.loadRealData();
            showNotification('🔄 Données actualisées', 'info');
        }, 300000);
    }
};

// Exposer au global
window.ChartManager = ChartManager;