/**
 * Gestionnaire de graphiques pour Chart.js
 * Compatible avec ton thème existant
 */
const ChartsManager = {
    charts: [],

    init: function() {
        console.log('📊 ChartsManager initialisé');

        // Initialiser les graphiques sur la page metrics
        if (document.getElementById('successRateChart')) {
            this.loadMetricsCharts();
        }

        // Initialiser les mini-graphiques sur le dashboard
        if (document.getElementById('dashboardMiniCharts')) {
            this.loadDashboardMiniCharts();
        }

        return this;
    },

    loadMetricsCharts: async function() {
        showLoading('Chargement des données graphiques...');

        try {
            // Essayer de charger les données réelles
            const data = await this.fetchRealData();
            this.createMetricsCharts(data);
            showNotification('📈 Graphiques chargés avec succès', 'success');
        } catch (error) {
            console.warn('Utilisation de données démo:', error);
            this.createDemoCharts();
            showNotification('ℹ️ Données démo affichées', 'info');
        } finally {
            hideLoading();
        }
    },

    fetchRealData: async function() {
        const response = await fetch('/monitoring/api/historique?days=7');
        if (!response.ok) throw new Error('Erreur réseau');
        return await response.json();
    },

    createMetricsCharts: function(data) {
        // Nettoyer les anciens graphiques
        this.destroyAllCharts();

        // Données par défaut si manquantes
        const labels = data.labels || ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
        const tauxReussite = data.tauxReussite || [85, 92, 78, 95, 88, 91, 86];
        const testsReussis = data.testsReussis || [120, 150, 95, 180, 135, 165, 140];
        const testsEchoues = data.testsEchoues || [15, 8, 22, 5, 12, 9, 16];
        const tempsReponse = data.tempsReponse || [450, 380, 520, 350, 420, 390, 440];

        // 1. Graphique Taux de Réussite
        const successRateCtx = document.getElementById('successRateChart');
        if (successRateCtx) {
            this.charts.push(new Chart(successRateCtx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Taux de Réussite (%)',
                        data: tauxReussite,
                        borderColor: '#006747',
                        backgroundColor: 'rgba(0, 103, 71, 0.1)',
                        tension: 0.4,
                        fill: true,
                        borderWidth: 3
                    }]
                },
                options: this.getLineChartOptions('Pourcentage', true)
            }));
        }

        // 2. Graphique Volume de Tests
        const volumeCtx = document.getElementById('volumeChart');
        if (volumeCtx) {
            this.charts.push(new Chart(volumeCtx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Tests Réussis',
                            data: testsReussis,
                            backgroundColor: 'rgba(40, 167, 69, 0.8)'
                        },
                        {
                            label: 'Tests Échoués',
                            data: testsEchoues,
                            backgroundColor: 'rgba(213, 0, 50, 0.8)'
                        }
                    ]
                },
                options: this.getBarChartOptions('Nombre')
            }));
        }

        // 3. Graphique Temps de Réponse
        const responseCtx = document.getElementById('responseTimeChart');
        if (responseCtx) {
            this.charts.push(new Chart(responseCtx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Temps de Réponse (ms)',
                        data: tempsReponse,
                        borderColor: '#ff6b00',
                        backgroundColor: 'rgba(255, 107, 0, 0.1)',
                        tension: 0.4,
                        fill: true,
                        borderWidth: 3
                    }]
                },
                options: this.getLineChartOptions('Millisecondes')
            }));
        }

        // 4. Graphique Répartition
        const statusCtx = document.getElementById('statusChart');
        if (statusCtx) {
            const totalSuccess = testsReussis.reduce((a, b) => a + b, 0);
            const totalFailed = testsEchoues.reduce((a, b) => a + b, 0);

            this.charts.push(new Chart(statusCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Tests Réussis', 'Tests Échoués'],
                    datasets: [{
                        data: [totalSuccess, totalFailed],
                        backgroundColor: ['rgba(40, 167, 69, 0.8)', 'rgba(213, 0, 50, 0.8)'],
                        borderWidth: 2
                    }]
                },
                options: this.getDoughnutChartOptions()
            }));
        }
    },

    createDemoCharts: function() {
        // Données de démonstration
        const demoData = {
            labels: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
            tauxReussite: [85, 92, 78, 95, 88, 91, 86],
            testsReussis: [120, 150, 95, 180, 135, 165, 140],
            testsEchoues: [15, 8, 22, 5, 12, 9, 16],
            tempsReponse: [450, 380, 520, 350, 420, 390, 440]
        };

        this.createMetricsCharts(demoData);
    },

    loadDashboardMiniCharts: function() {
        const container = document.getElementById('dashboardMiniCharts');
        if (!container) return;

        // Nettoyer le conteneur
        container.innerHTML = '';

        // Créer un graphique de disponibilité
        const chart1 = this.createMiniChart('Disponibilité (%)', '#006747', Array.from({length: 12}, (_, i) => i + 'h'));
        container.appendChild(chart1);

        // Créer un graphique de taux de réussite
        const chart2 = this.createMiniChart('Taux Réussite (%)', '#28a745', Array.from({length: 12}, (_, i) => i + 'h'));
        container.appendChild(chart2);
    },

    createMiniChart: function(title, color, labels) {
        const chartCard = document.createElement('div');
        chartCard.className = 'mini-chart-card';

        const chartHeader = document.createElement('div');
        chartHeader.className = 'mini-chart-header';
        chartHeader.innerHTML = `<h4>${title}</h4>`;

        const chartContainer = document.createElement('div');
        chartContainer.className = 'mini-chart-container';

        const canvas = document.createElement('canvas');

        chartContainer.appendChild(canvas);
        chartCard.appendChild(chartHeader);
        chartCard.appendChild(chartContainer);

        // Générer des données aléatoires réalistes
        const data = labels.map(() => {
            const base = title.includes('Disponibilité') ? 90 : 85;
            return base + Math.random() * 10;
        });

        const chart = new Chart(canvas, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: title,
                    data: data,
                    borderColor: color,
                    backgroundColor: color + '20',
                    tension: 0.3,
                    fill: true,
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: { enabled: true }
                },
                scales: {
                    x: { display: true, grid: { display: false } },
                    y: {
                        min: title.includes('Disponibilité') ? 80 : 70,
                        max: 100,
                        ticks: { callback: v => v + '%' }
                    }
                }
            }
        });

        this.charts.push(chart);
        return chartCard;
    },

    getLineChartOptions: function(unit, isPercentage = false) {
        return {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: !isPercentage,
                    max: isPercentage ? 100 : undefined,
                    ticks: {
                        callback: isPercentage ? v => v + '%' : v => v
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { color: '#495057' }
                },
                tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.8)',
                    titleColor: 'white',
                    bodyColor: 'white',
                    titleFont: { size: 14 },
                    bodyFont: { size: 13 },
                    padding: 12,
                    cornerRadius: 8
                }
            }
        };
    },

    getBarChartOptions: function(unit) {
        return {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { callback: v => v }
                }
            },
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { color: '#495057' }
                }
            }
        };
    },

    getDoughnutChartOptions: function() {
        return {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { color: '#495057' }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const label = context.label || '';
                            const value = context.raw || 0;
                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                            const percentage = Math.round((value / total) * 100);
                            return `${label}: ${value} (${percentage}%)`;
                        }
                    }
                }
            }
        };
    },

    destroyAllCharts: function() {
        this.charts.forEach(chart => {
            if (chart && typeof chart.destroy === 'function') {
                chart.destroy();
            }
        });
        this.charts = [];
    },

    refresh: function() {
        showNotification('🔄 Actualisation des graphiques...', 'info');
        this.loadMetricsCharts();
    }
};

// Fonctions utilitaires globales
window.showLoading = function(message = 'Chargement...') {
    let overlay = document.getElementById('loadingOverlay');
    if (!overlay) {
        overlay = document.createElement('div');
        overlay.id = 'loadingOverlay';
        overlay.innerHTML = `
            <div class="loading-spinner"></div>
            <div class="loading-text">${message}</div>
        `;
        document.body.appendChild(overlay);
    }

    const text = overlay.querySelector('.loading-text');
    if (text) text.textContent = message;

    overlay.style.display = 'flex';
};

window.hideLoading = function() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) {
        overlay.style.display = 'none';
    }
};

// Initialiser automatiquement si Chart.js est disponible
if (typeof Chart !== 'undefined') {
    document.addEventListener('DOMContentLoaded', function() {
        window.ChartsManager = ChartsManager.init();
    });
}