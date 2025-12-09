<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détail Alerte - Supervision GEID</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* RESET ET BASES */
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            flex: 1;
        }

        /* ALERTE CARD */
        .alerte-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            border-left: 6px solid #d50032;
            margin-bottom: 30px;
        }

        .alerte-card.warning { border-left-color: #ffc107; }
        .alerte-card.info { border-left-color: #2196F3; }

        /* HEADER */
        .alerte-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 2px solid #e9ecef;
            flex-wrap: wrap;
            gap: 20px;
        }

        .alerte-titre {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .alerte-titre h1 {
            margin: 0;
            color: #343a40;
            font-size: 28px;
            max-width: 100%;
            word-wrap: break-word;
        }

        .badge-criticite {
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 14px;
            text-transform: uppercase;
        }

        .badge-criticite.CRITICAL { background: #d50032; color: white; }
        .badge-criticite.WARNING { background: #ffc107; color: #343a40; }
        .badge-criticite.INFO { background: #2196F3; color: white; }

        /* ACTIONS */
        .alerte-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            font-size: 14px;
            text-decoration: none;
        }

        .btn-resoudre {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-resoudre:hover {
            background: linear-gradient(135deg, #218838, #1ba87e);
            transform: translateY(-2px);
        }

        .btn-supprimer {
            background: linear-gradient(135deg, #dc3545, #d50032);
            color: white;
        }

        .btn-supprimer:hover {
            background: linear-gradient(135deg, #c82333, #b30029);
            transform: translateY(-2px);
        }

        /* DÉTAILS */
        .alerte-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .detail-label {
            font-size: 14px;
            color: #6c757d;
            font-weight: 500;
        }

        .detail-value {
            font-size: 16px;
            font-weight: 600;
            color: #343a40;
        }

        /* DESCRIPTION */
        .alerte-description {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
        }

        .alerte-description h3 {
            color: #006747;
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 20px;
        }

        .alerte-description p {
            color: #495057;
            line-height: 1.6;
            margin: 0;
            font-size: 15px;
        }

        /* HISTORIQUE */
        .historique-section {
            margin-top: 30px;
        }

        .historique-section h3 {
            color: #006747;
            margin-bottom: 20px;
            font-size: 20px;
        }

        .historique-list {
            background: white;
            border-radius: 12px;
            border: 1px solid #e9ecef;
            overflow: hidden;
        }

        .historique-item {
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .historique-item:last-child {
            border-bottom: none;
        }

        .historique-action {
            font-weight: 600;
            color: #343a40;
        }

        .historique-date {
            color: #6c757d;
            font-size: 14px;
        }

        /* BOUTON RETOUR */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 24px;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        /* STATUT */
        .status-resolved {
            color: #28a745;
            font-weight: 700;
            padding: 6px 12px;
            background: rgba(40, 167, 69, 0.1);
            border-radius: 6px;
            display: inline-block;
        }

        .status-active {
            color: #d50032;
            font-weight: 700;
            padding: 6px 12px;
            background: rgba(213, 0, 50, 0.1);
            border-radius: 6px;
            display: inline-block;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .container { padding: 15px; }
            .alerte-card { padding: 20px; }
            .alerte-header { flex-direction: column; align-items: stretch; }
            .alerte-titre h1 { font-size: 24px; }
            .alerte-actions { flex-direction: column; width: 100%; }
            .btn-action { width: 100%; justify-content: center; }
        }

        /* NOTIFICATION */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            z-index: 9999;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
        }

        .notification.success { background: #28a745; color: white; }
        .notification.error { background: #dc3545; color: white; }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* LOADING */
        .loading-spinner {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 100px 20px;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #006747;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <%@ include file="../includes/header.jsp" %>

    <!-- Main Content -->
    <div class="container">
        <div class="loading-spinner" id="loadingSpinner">
            <div class="spinner"></div>
        </div>

        <div id="alerteContent" style="display: none;">
            <div class="alerte-card" id="alerteCard">
                <div class="alerte-header">
                    <div class="alerte-titre">
                        <h1 id="alerteTitre">Chargement...</h1>
                        <span class="badge-criticite" id="badgeCriticite">--</span>
                    </div>
                    <div class="alerte-actions">
                        <button class="btn-action btn-resoudre" onclick="resoudreAlerte()">
                            <i class="fas fa-check-circle"></i> Marquer comme résolu
                        </button>
                        <button class="btn-action btn-supprimer" onclick="supprimerAlerte()">
                            <i class="fas fa-trash-alt"></i> Supprimer
                        </button>
                    </div>
                </div>

                <div class="alerte-details">
                    <div class="detail-item">
                        <span class="detail-label">Serveur</span>
                        <span class="detail-value" id="serveurValue">Chargement...</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Type</span>
                        <span class="detail-value" id="typeValue">Chargement...</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Date de création</span>
                        <span class="detail-value" id="dateCreationValue">Chargement...</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Statut</span>
                        <span class="detail-value" id="statutValue">Chargement...</span>
                    </div>
                </div>

                <div class="alerte-description">
                    <h3>Description</h3>
                    <p id="descriptionValue">Chargement...</p>
                </div>

                <div class="historique-section">
                    <h3>Historique des actions</h3>
                    <div class="historique-list" id="historiqueList">
                        <!-- Filled by JavaScript -->
                    </div>
                </div>

                <a href="/alertes" class="back-link">
                    <i class="fas fa-arrow-left"></i> Retour à la liste des alertes
                </a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="../includes/footer.jsp" %>

    <!-- JavaScript -->
    <script>
        // Variables
        let alerteData = null;
        let alerteId = null;

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page détail alerte chargée');
            // Extraire l'ID de l'URL
            alerteId = window.location.pathname.split('/').pop();
            console.log('ID alerte détecté:', alerteId);
            loadAlerteData();
        });

        // Charger les données de l'alerte depuis l'API
        function loadAlerteData() {
            console.log('Chargement alerte ID:', alerteId, 'depuis /alertes/api/alertes/' + alerteId);

            if (!alerteId || alerteId === 'view') {
                showError('ID alerte invalide');
                return;
            }

            fetch('/alertes/api/alertes/' + alerteId)
                .then(response => {
                    if (!response.ok) {
                        if (response.status === 404) {
                            throw new Error('Alerte non trouvée (404)');
                        }
                        throw new Error('Erreur réseau: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Données alerte reçues:', data);
                    alerteData = data;
                    displayAlerteData(alerteData);
                })
                .catch(error => {
                    console.error('Erreur API:', error);
                    showError('Impossible de charger l\'alerte: ' + error.message);
                });
        }

        // Afficher les données de l'alerte
        function displayAlerteData(data) {
            // Masquer le spinner et afficher le contenu
            document.getElementById('loadingSpinner').style.display = 'none';
            document.getElementById('alerteContent').style.display = 'block';

            // Mettre à jour les éléments
            document.getElementById('alerteTitre').textContent = data.titre || 'Alerte sans titre';

            // Gérer la criticité
            const criticite = data.criticite || 'INFO';
            document.getElementById('badgeCriticite').textContent = criticite;

            // Mettre à jour la classe de la carte selon la criticité
            const card = document.getElementById('alerteCard');
            card.className = 'alerte-card ' +
                (criticite === 'CRITICAL' ? 'critical' :
                 criticite === 'WARNING' ? 'warning' : 'info');

            // Mettre à jour le badge de criticité
            const badge = document.getElementById('badgeCriticite');
            badge.className = 'badge-criticite ' + criticite;

            // Mettre à jour les détails
            document.getElementById('serveurValue').textContent = data.serveurCible || 'Non spécifié';
            document.getElementById('typeValue').textContent = data.typeAlerte || 'Non spécifié';

            // Formatage de la date de création
            let dateCreationStr = 'Date inconnue';
            if (data.dateCreation) {
                const date = new Date(data.dateCreation);
                dateCreationStr = date.toLocaleString('fr-FR');
            }
            document.getElementById('dateCreationValue').textContent = dateCreationStr;

            // Mettre à jour le statut
            const statutValue = document.getElementById('statutValue');
            if (data.resolue) {
                statutValue.innerHTML = '<span class="status-resolved">RÉSOLU</span>';
                // Masquer le bouton "Résoudre" si déjà résolu
                const btnResoudre = document.querySelector('.btn-resoudre');
                if (btnResoudre) btnResoudre.style.display = 'none';

                // Afficher la date de résolution si disponible
                if (data.dateResolution) {
                    const dateRes = new Date(data.dateResolution);
                    statutValue.innerHTML += `<br><small>Résolu le: ${dateRes.toLocaleString('fr-FR')}</small>`;
                }
            } else {
                statutValue.innerHTML = '<span class="status-active">ACTIVE</span>';
            }

            // Mettre à jour la description
            document.getElementById('descriptionValue').textContent =
                data.description || 'Aucune description disponible';

            // Charger l'historique
            loadHistorique();
        }

        // Charger l'historique des actions
        function loadHistorique() {
            const historiqueList = document.getElementById('historiqueList');
            if (!alerteData) return;

            let historiqueHTML = '';

            // Création
            let creationDate = 'Date inconnue';
            if (alerteData.dateCreation) {
                const date = new Date(alerteData.dateCreation);
                creationDate = date.toLocaleString('fr-FR');
            }
            historiqueHTML += `
                <div class="historique-item">
                    <span class="historique-action">
                        <i class="fas fa-plus-circle" style="color: #28a745;"></i>
                        Alerte créée
                    </span>
                    <span class="historique-date">${creationDate}</span>
                </div>
            `;

            // Si résolue, ajouter la date de résolution
            if (alerteData.resolue && alerteData.dateResolution) {
                const resDate = new Date(alerteData.dateResolution);
                historiqueHTML += `
                    <div class="historique-item">
                        <span class="historique-action">
                            <i class="fas fa-check-circle" style="color: #28a745;"></i>
                            Alerte résolue
                        </span>
                        <span class="historique-date">${resDate.toLocaleString('fr-FR')}</span>
                    </div>
                `;
            }

            if (historiqueHTML === '') {
                historiqueHTML = '<div class="historique-item">Aucun historique disponible</div>';
            }

            historiqueList.innerHTML = historiqueHTML;
        }

        // Résoudre une alerte (appel API)
        function resoudreAlerte() {
            if (!alerteId) {
                showNotification('ID alerte manquant', 'error');
                return;
            }

            if (!confirm('Êtes-vous sûr de vouloir marquer cette alerte comme résolue ?')) {
                return;
            }

            const btn = document.querySelector('.btn-resoudre');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Traitement...';
            btn.disabled = true;

            fetch('/alertes/resoudre/' + alerteId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showNotification('Alerte marquée comme résolue', 'success');
                    // Recharger les données
                    setTimeout(() => {
                        loadAlerteData();
                    }, 1000);
                } else {
                    showNotification('Erreur: ' + data.message, 'error');
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            })
            .catch(error => {
                console.error('Erreur:', error);
                showNotification('Erreur lors de la résolution', 'error');
                btn.innerHTML = originalText;
                btn.disabled = false;
            });
        }

        // Supprimer une alerte (appel API)
        function supprimerAlerte() {
            if (!alerteId) {
                showNotification('ID alerte manquant', 'error');
                return;
            }

            if (!confirm('Êtes-vous sûr de vouloir supprimer cette alerte ? Cette action est irréversible.')) {
                return;
            }

            const btn = document.querySelector('.btn-supprimer');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Suppression...';
            btn.disabled = true;

            fetch('/alertes/supprimer/' + alerteId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showNotification('Alerte supprimée avec succès', 'success');
                    // Rediriger vers la liste après 2 secondes
                    setTimeout(() => {
                        window.location.href = '/alertes';
                    }, 2000);
                } else {
                    showNotification('Erreur: ' + data.message, 'error');
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            })
            .catch(error => {
                console.error('Erreur:', error);
                showNotification('Erreur lors de la suppression', 'error');
                btn.innerHTML = originalText;
                btn.disabled = false;
            });
        }

        // Afficher une notification
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'notification ' + type;
            notification.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check' : 'exclamation') + '-circle"></i> ' + message;

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.opacity = '0';
                notification.style.transform = 'translateX(100%)';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // Afficher une erreur
        function showError(message) {
            document.getElementById('loadingSpinner').style.display = 'none';

            const container = document.getElementById('alerteContent');
            container.innerHTML = `
                <div class="alerte-card" style="text-align: center; padding: 50px 20px;">
                    <div style="font-size: 64px; color: #dc3545; margin-bottom: 20px;">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <h2 style="color: #343a40; margin-bottom: 15px;">Erreur de chargement</h2>
                    <p style="color: #666; margin-bottom: 25px;">${message}</p>
                    <div style="display: flex; gap: 15px; justify-content: center; margin-top: 30px;">
                        <button onclick="loadAlerteData()" class="btn-action btn-resoudre" style="padding: 12px 24px;">
                            <i class="fas fa-redo"></i> Réessayer
                        </button>
                        <a href="/alertes" class="btn-action btn-supprimer" style="padding: 12px 24px;">
                            <i class="fas fa-arrow-left"></i> Retour à la liste
                        </a>
                    </div>
                </div>
            `;
            container.style.display = 'block';
        }
    </script>
</body>
</html>