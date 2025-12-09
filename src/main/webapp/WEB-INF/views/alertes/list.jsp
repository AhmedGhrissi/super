<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alertes - Supervision GEID</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* VOS STYLES ICI - PAS DE CHANGEMENT */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f8f9fa; color: #333; margin: 0; padding: 0; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .alertes-header { background: white; border-radius: 16px; padding: 25px; margin-bottom: 25px; box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08); }
        .alertes-header h1 { color: #006747; font-size: 28px; margin-bottom: 10px; display: flex; align-items: center; gap: 15px; }
        .alertes-stats { display: flex; gap: 15px; margin: 20px 0; flex-wrap: wrap; }
        .stat-badge { padding: 12px 25px; border-radius: 50px; font-weight: 700; font-size: 15px; display: flex; align-items: center; gap: 10px; color: white; }
        .stat-badge.total { background: #006747; }
        .stat-badge.critical { background: #d50032; }
        .stat-badge.warning { background: #ffc107; color: #333; }
        .stat-badge.info { background: #2196F3; }
        .btn-action { display: inline-flex; align-items: center; gap: 10px; background: #006747; color: white; border: none; padding: 12px 24px; border-radius: 8px; font-weight: 700; cursor: pointer; text-decoration: none; font-size: 14px; transition: all 0.3s ease; }
        .btn-action:hover { background: #005738; transform: translateY(-2px); }
        .btn-action.secondary { background: #6c757d; }
        .filters-section { background: #f8f9fa; border-radius: 12px; padding: 20px; margin-bottom: 20px; }
        .filters-grid { display: flex; gap: 10px; flex-wrap: wrap; }
        .filter-btn { padding: 10px 20px; background: white; border: 2px solid #dee2e6; border-radius: 8px; cursor: pointer; font-weight: 600; color: #666; transition: all 0.3s ease; }
        .filter-btn:hover { background: #e9ecef; }
        .filter-btn.active { background: #006747; color: white; border-color: #006747; }
        .alertes-grid { display: grid; gap: 20px; }
        .alerte-card { background: white; border-radius: 12px; padding: 20px; box-shadow: 0 4px 16px rgba(0,0,0,0.08); border-left: 5px solid #d50032; }
        .alerte-card.warning { border-left-color: #ffc107; }
        .alerte-card.info { border-left-color: #2196F3; }
        .alerte-header { display: flex; align-items: center; gap: 15px; margin-bottom: 15px; }
        .alerte-icon { font-size: 24px; width: 50px; height: 50px; background: #f8f9fa; border-radius: 12px; display: flex; align-items: center; justify-content: center; }
        .alerte-icon.critical { color: #d50032; }
        .alerte-icon.warning { color: #ffc107; }
        .alerte-icon.info { color: #2196F3; }
        .alerte-title { flex: 1; }
        .alerte-title h3 { color: #006747; margin: 0 0 8px 0; font-size: 18px; }
        .alert-tags { display: flex; gap: 8px; flex-wrap: wrap; }
        .alert-tag { padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .alert-tag.critical { background: #d50032; color: white; }
        .alert-tag.warning { background: #ffc107; color: #333; }
        .alert-tag.info { background: #2196F3; color: white; }
        .alert-tag.type { background: #e9ecef; color: #666; }
        .alert-tag.timestamp { background: #f8f9fa; color: #6c757d; border: 1px solid #dee2e6; }
        .alerte-description { background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 15px 0; color: #495057; line-height: 1.5; }
        .alerte-meta { display: flex; gap: 20px; color: #666; font-size: 14px; }
        .alerte-meta div { display: flex; align-items: center; gap: 8px; }
        .loading-spinner { display: flex; justify-content: center; align-items: center; padding: 60px 20px; }
        .spinner { width: 50px; height: 50px; border: 5px solid #f3f3f3; border-top: 5px solid #006747; border-radius: 50%; animation: spin 1s linear infinite; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        .empty-state { text-align: center; padding: 60px 20px; background: white; border-radius: 12px; box-shadow: 0 4px 16px rgba(0,0,0,0.08); }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="../includes/header.jsp"/>

    <!-- Main Content -->
    <main class="container">
        <div class="alertes-header">
            <h1><i class="fas fa-bell"></i> Alertes du Système</h1>
            <p style="color: #666; margin-bottom: 25px;">Supervision en temps réel des incidents</p>

            <!-- Stats -->
            <div class="alertes-stats">
                <div class="stat-badge total" id="statTotal">
                    <i class="fas fa-chart-bar"></i> Total: <span id="totalCount">0</span>
                </div>
                <div class="stat-badge critical" id="statCritical">
                    <i class="fas fa-exclamation-circle"></i> Critiques: <span id="criticalCount">0</span>
                </div>
                <div class="stat-badge warning" id="statWarning">
                    <i class="fas fa-exclamation-triangle"></i> Avertissements: <span id="warningCount">0</span>
                </div>
                <div class="stat-badge info" id="statInfo">
                    <i class="fas fa-info-circle"></i> Informations: <span id="infoCount">0</span>
                </div>
            </div>

            <!-- Actions -->
            <div style="display: flex; gap: 15px; margin-top: 20px;">
                <button onclick="rafraichirAlertes()" class="btn-action">
                    <i class="fas fa-sync-alt"></i> Rafraîchir
                </button>
                <a href="/dashboard" class="btn-action secondary">
                    <i class="fas fa-tachometer-alt"></i> Retour Dashboard
                </a>
            </div>
        </div>

        <!-- Filtres -->
        <div class="filters-section">
            <h4 style="color: #006747; margin-bottom: 15px; font-size: 16px;">
                <i class="fas fa-filter"></i> Filtrer par criticité
            </h4>
            <div class="filters-grid">
                <button class="filter-btn active" onclick="filterByCriticite('all', this)">Toutes</button>
                <button class="filter-btn" onclick="filterByCriticite('CRITICAL', this)">Critiques</button>
                <button class="filter-btn" onclick="filterByCriticite('WARNING', this)">Avertissements</button>
                <button class="filter-btn" onclick="filterByCriticite('INFO', this)">Informations</button>
            </div>
        </div>

        <!-- Alertes Container -->
        <div id="alertesContainer">
            <div class="loading-spinner">
                <div class="spinner"></div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <div style="background: #f8f9fa; padding: 20px; text-align: center; color: #666; margin-top: 40px; border-top: 1px solid #dee2e6;">
        <p>GEID Supervision System © 2024</p>
    </div>

    <!-- JavaScript - VERSION SANS EL -->
    <script>
        let alertesData = [];
        let currentFilter = 'all';

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page chargée');
            loadAlertes();
        });

        // Charger les alertes
        function loadAlertes() {
            fetch('/alertes/api/alertes')
                .then(response => {
                    if (!response.ok) throw new Error('Erreur: ' + response.status);
                    return response.json();
                })
                .then(data => {
                    console.log('Données:', data);
                    alertesData = data;
                    displayAlertes(data);
                    updateStats();
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    document.getElementById('alertesContainer').innerHTML = `
                        <div style="text-align: center; padding: 50px; background: white; border-radius: 10px;">
                            <h3 style="color: #d50032;">Erreur de chargement</h3>
                            <p>${error.message}</p>
                            <button onclick="loadAlertes()" style="background: #006747; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">
                                Réessayer
                            </button>
                        </div>
                    `;
                });
        }

        // Afficher les alertes
        function displayAlertes(alertes) {
            const container = document.getElementById('alertesContainer');

            if (!alertes || alertes.length === 0) {
                container.innerHTML = `
                    <div style="text-align: center; padding: 50px; background: white; border-radius: 10px;">
                        <h3 style="color: green;">✅ Aucune alerte</h3>
                        <p>Tout fonctionne normalement</p>
                    </div>
                `;
                return;
            }

            let html = '<div class="alertes-grid">';

            alertes.forEach(alerte => {
                const criticite = alerte.criticite || 'INFO';
                const criticiteClass = criticite === 'CRITICAL' ? 'critical' :
                                     criticite === 'WARNING' ? 'warning' : 'info';

                // Date
                let dateStr = 'N/A';
                if (alerte.dateCreation) {
                    try {
                        dateStr = new Date(alerte.dateCreation).toLocaleString('fr-FR');
                    } catch (e) {
                        dateStr = 'Date invalide';
                    }
                }

                // Type alerte HTML
                let typeHtml = '';
                if (alerte.typeAlerte) {
                    typeHtml = '<span class="alert-tag type">' + alerte.typeAlerte + '</span>';
                }

                // Serveur HTML
                let serveurHtml = '';
                if (alerte.serveurCible) {
                    serveurHtml = '<div><i class="fas fa-server"></i> <strong>Serveur:</strong> ' + alerte.serveurCible + '</div>';
                }

                // Statut HTML
                const isResolved = alerte.resolue === true || alerte.resolue === 1;
                const statutHtml = isResolved ?
                    '<div><i class="fas fa-check-circle" style="color: #28a745;"></i> <strong>Statut:</strong> Résolue</div>' :
                    '<div><i class="fas fa-exclamation-circle" style="color: #d50032;"></i> <strong>Statut:</strong> Active</div>';

                // Construction du HTML avec concaténation simple
                html += '<div class="alerte-card ' + criticiteClass + '">' +
                    '<div class="alerte-header">' +
                        '<div class="alerte-icon ' + criticiteClass + '">' +
                            '<i class="fas fa-exclamation-circle"></i>' +
                        '</div>' +
                        '<div class="alerte-title">' +
                            '<h3>' + (alerte.titre || 'Sans titre') + '</h3>' +
                            '<div class="alert-tags">' +
                                '<span class="alert-tag ' + criticiteClass + '">' + criticite + '</span>' +
                                typeHtml +
                                '<span class="alert-tag timestamp">' + dateStr + '</span>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="alerte-description">' + (alerte.description || 'Pas de description') + '</div>' +
                    '<div class="alerte-meta">' +
                        serveurHtml +
                        statutHtml +
                        '<div style="margin-left: auto;">' +
                            '<a href="/alertes/view/' + alerte.id + '" class="btn-action" style="padding: 8px 16px; font-size: 13px;">' +
                                '<i class="fas fa-eye"></i> Voir détails' +
                            '</a>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            });

            html += '</div>';
            container.innerHTML = html;
        }

        // Filtrer
        function filterByCriticite(criticite, clickedElement) {
            currentFilter = criticite;

            let filtered;
            if (criticite === 'all') {
                filtered = alertesData;
            } else {
                filtered = alertesData.filter(function(a) {
                    return (a.criticite || '') === criticite;
                });
            }

            displayAlertes(filtered);

            // Boutons actifs
            var buttons = document.querySelectorAll('.filter-btn');
            buttons.forEach(function(btn) {
                btn.classList.remove('active');
            });
            if (clickedElement) {
                clickedElement.classList.add('active');
            }
        }

        // Stats
        function updateStats() {
            const critical = alertesData.filter(a => a.criticite === 'CRITICAL').length;
            const warning = alertesData.filter(a => a.criticite === 'WARNING').length;
            const info = alertesData.filter(a => a.criticite === 'INFO').length;
            const total = alertesData.length;

            document.getElementById('totalCount').textContent = total;
            document.getElementById('criticalCount').textContent = critical;
            document.getElementById('warningCount').textContent = warning;
            document.getElementById('infoCount').textContent = info;
        }

        // Rafraîchir
        function rafraichirAlertes() {
            const btn = event.target;
            const original = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Chargement...';
            btn.disabled = true;

            document.getElementById('alertesContainer').innerHTML = '<div class="loading-spinner"><div class="spinner"></div></div>';

            fetch('/alertes/api/alertes')
                .then(response => response.json())
                .then(data => {
                    alertesData = data;
                    displayAlertes(data);
                    updateStats();
                    btn.innerHTML = original;
                    btn.disabled = false;
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    btn.innerHTML = original;
                    btn.disabled = false;
                });
        }
    </script>
	<jsp:include page="../includes/footer.jsp"/>
</body>
</html>