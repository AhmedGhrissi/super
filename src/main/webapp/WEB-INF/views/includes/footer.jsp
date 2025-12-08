<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
// FORCER L'ENCODAGE UTF-8 DANS LE FOOTER
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
%>
    </main>

    <!-- Footer -->
    <footer style="
        background: linear-gradient(135deg, #006747, #8DC63F);
        color: white;
        padding: 1.5rem 2rem;
        margin-top: auto;
        border-top: 4px solid #D50032;
        font-family: 'Segoe UI', Arial, sans-serif;
    ">
        <div style="max-width: 1400px; margin: 0 auto;">
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <div style="text-align: left; flex: 1;">
                    <h3 style="color: white; margin: 0; font-size: 1.2rem; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                        🏦 Supervision GEID
                    </h3>
                    <p style="color: rgba(255,255,255,0.9); margin: 0.3rem 0 0 0; font-size: 0.9rem;">
                        Système de surveillance des caisses et tests automatisés
                    </p>
                </div>

                <div style="text-align: center; flex: 1;">
                    <p style="color: rgba(255,255,255,0.9); margin: 0; font-size: 0.85rem; font-weight: 500;">
                        &copy; 2025 Supervision GEID - Crédit Agricole • Tous droits réservés
                    </p>
                </div>

                <div style="text-align: right; flex: 1;">
                    <div style="display: flex; gap: 1.5rem; justify-content: flex-end; margin-bottom: 0.5rem;">
                        <span style="color: rgba(255,255,255,0.9); font-size: 0.9rem; display: flex; align-items: center; gap: 0.25rem;">
                            📊 Monitoring temps réel
                        </span>
                        <span style="color: rgba(255,255,255,0.9); font-size: 0.9rem; display: flex; align-items: center; gap: 0.25rem;">
                            ⚡ Performances
                        </span>
                        <span style="color: rgba(255,255,255,0.9); font-size: 0.9rem; display: flex; align-items: center; gap: 0.25rem;">
                            🔒 Sécurité
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts généraux avec UTF-8 forcé -->
    <script>
    // Vérifier si showNotification existe déjà
    if (typeof window.showNotification !== 'function') {
        // Fonction de notification globale
        window.showNotification = function(message, type = 'info') {
            try {
                // Supprimer les anciennes notifications
                const oldNotifications = document.querySelectorAll('.custom-notification');
                oldNotifications.forEach(n => {
                    if (n.parentNode) n.remove();
                });

                const notification = document.createElement('div');
                notification.className = 'custom-notification';

                let backgroundColor = '#006747'; // Vert CA par défaut
                let icon = 'ℹ️';

                if (type === 'success') {
                    backgroundColor = '#4CAF50';
                    icon = '✅';
                } else if (type === 'error') {
                    backgroundColor = '#D50032';
                    icon = '❌';
                } else if (type === 'warning') {
                    backgroundColor = '#F57C00';
                    icon = '⚠️';
                }

                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    padding: 1rem 1.5rem;
                    border-radius: 12px;
                    color: white;
                    font-weight: 600;
                    z-index: 10000;
                    box-shadow: 0 8px 32px rgba(0,0,0,0.3);
                    max-width: 400px;
                    font-family: "Segoe UI", sans-serif;
                    background: ${backgroundColor};
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    animation: slideIn 0.3s ease;
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                `;

                notification.innerHTML = `${icon} ${message}`;
                document.body.appendChild(notification);

                // Auto-suppression après 4 secondes
                setTimeout(() => {
                    if (notification.parentNode) {
                        notification.style.animation = 'slideOut 0.3s ease';
                        setTimeout(() => {
                            if (notification.parentNode) {
                                notification.remove();
                            }
                        }, 300);
                    }
                }, 4000);

            } catch (e) {
                console.error('Erreur notification:', e);
            }
        };
    }

    // Override fetch pour forcer UTF-8 dans toutes les requêtes AJAX
    (function() {
        const originalFetch = window.fetch;
        window.fetch = function(url, options = {}) {
            // Forcer UTF-8 dans les headers
            if (!options.headers) {
                options.headers = {};
            }

            // Si c'est une requête POST avec du JSON
            if (options.method && options.method.toUpperCase() === 'POST') {
                if (!options.headers['Content-Type']) {
                    options.headers['Content-Type'] = 'application/json; charset=UTF-8';
                }
            }

            // S'assurer que l'encodage est présent
            if (options.headers['Content-Type'] && !options.headers['Content-Type'].includes('charset')) {
                options.headers['Content-Type'] += '; charset=UTF-8';
            }

            return originalFetch.call(this, url, options);
        };
    })();

    // Fonction pour encoder correctement les URLs
    function encodeURISafe(param) {
        try {
            // Encoder les caractères spéciaux mais garder les slashs
            return encodeURIComponent(param)
                .replace(/%20/g, '+')
                .replace(/%2F/g, '/');
        } catch (e) {
            console.warn('Erreur d\'encodage:', e);
            return param;
        }
    }

    // Gestion des modales - Renommer pour éviter les conflits
    let modalCurrentAction = null;

    function showConfirmationModal(title, message, confirmCallback, danger = false) {
        const modal = document.getElementById('confirmationModal');
        if (!modal) {
            // Fallback vers la confirmation native
            if (confirm(title + ': ' + message.replace(/<[^>]*>/g, ''))) {
                confirmCallback();
            }
            return;
        }

        const modalTitle = document.getElementById('modalTitle');
        const modalMessage = document.getElementById('modalMessage');

        if (modalTitle) modalTitle.textContent = title;
        if (modalMessage) modalMessage.innerHTML = message;

        const confirmBtn = document.getElementById('modalConfirmBtn');
        if (confirmBtn) {
            if (danger) {
                confirmBtn.className = 'modal-btn modal-btn-danger';
            } else {
                confirmBtn.className = 'modal-btn modal-btn-confirm';
            }
        }

        modalCurrentAction = confirmCallback;
        modal.style.display = 'flex';
    }

    function closeConfirmationModal() {
        const modal = document.getElementById('confirmationModal');
        if (modal) {
            modal.style.display = 'none';
        }
        modalCurrentAction = null;
    }

    function confirmModalAction() {
        if (modalCurrentAction) {
            modalCurrentAction();
        }
        closeConfirmationModal();
    }

    // Initialisation
    document.addEventListener('DOMContentLoaded', function() {
        const modal = document.getElementById('confirmationModal');
        if (modal) {
            modal.style.display = 'none';
            modal.addEventListener('click', function(e) {
                if (e.target === this) {
                    closeConfirmationModal();
                }
            });

            const confirmBtn = document.getElementById('modalConfirmBtn');
            if (confirmBtn) {
                confirmBtn.addEventListener('click', confirmModalAction);
            }
        }

        // Raccourci Échap
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeConfirmationModal();
            }
        });

        // Animation pour les éléments au chargement
        const cards = document.querySelectorAll('.card, .stat-card-modern, .detail-card-modern');
        cards.forEach((card, index) => {
            if (card && !card.hasAttribute('data-animated')) {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.setAttribute('data-animated', 'true');

                setTimeout(() => {
                    card.style.transition = 'all 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            }
        });
    });

    // Notification Manager - Vérifier s'il existe déjà
    if (typeof window.NotificationManager === 'undefined') {
        window.NotificationManager = {
            async requestPermission() {
                try {
                    if (!('Notification' in window)) {
                        if (window.showNotification) {
                            window.showNotification('Votre navigateur ne supporte pas les notifications', 'warning');
                        }
                        return false;
                    }

                    const permission = await Notification.requestPermission();
                    const granted = permission === 'granted';

                    if (granted && window.showNotification) {
                        window.showNotification('🔔 Notifications activées avec succès', 'success');
                    }

                    return granted;
                } catch (error) {
                    console.error('Erreur permission notification:', error);
                    return false;
                }
            },

            sendNotification(title, options = {}) {
                if (Notification.permission === 'granted') {
                    const notification = new Notification(title, {
                        icon: '/favicon.ico',
                        badge: '/favicon.ico',
                        requireInteraction: false,
                        ...options
                    });

                    // Fermer automatiquement après 5 secondes
                    setTimeout(() => notification.close(), 5000);

                    // Action au clic
                    notification.onclick = function() {
                        window.focus();
                        notification.close();
                    };

                    return notification;
                }
                return null;
            }
        };
    }

    // Fonctions globales pour les tests (avec encodage sécurisé)
    window.testerServeur = async function(serveurNom) {
        console.log('TEST SERVEUR - ' + serveurNom);

        try {
            const encodedNom = encodeURISafe(serveurNom);
            const testResponse = await fetch('/api/tests/rapide/' + encodedNom, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                }
            });

            if (testResponse.ok) {
                if (window.showNotification) {
                    window.showNotification('✅ Test réussi - Serveur excellent', 'success');
                }
            } else {
                if (window.showNotification) {
                    window.showNotification('❌ Serveur critique - Alerte envoyée', 'error');
                }
            }

            setTimeout(() => location.reload(), 2000);

        } catch (error) {
            console.error('Erreur:', error);
            if (window.showNotification) {
                window.showNotification('❌ Erreur réseau lors du test', 'error');
            }
        }
    };

    window.lancerTestsCategorie = async function(categorie) {
        if (!categorie) {
            if (window.showNotification) {
                window.showNotification('Catégorie non sélectionnée', 'warning');
            }
            return;
        }

        const confirme = await new Promise(resolve => {
            showConfirmationModal(
                'Lancer les tests',
                `Voulez-vous lancer l'exécution des tests de la catégorie <strong>"${categorie}"</strong> ?`,
                () => resolve(true),
                false
            );
        });

        if (!confirme) return;

        if (window.showNotification) {
            window.showNotification(`🔄 Lancement des tests ${categorie}...`, 'info');
        }

        try {
            const encodedCategorie = encodeURISafe(categorie);
            const response = await fetch('/tests/lancer-categorie/' + encodedCategorie, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                }
            });

            if (response.ok) {
                if (window.showNotification) {
                    window.showNotification('✅ Tests lancés avec succès !', 'success');
                }
                setTimeout(() => location.reload(), 3000);
            } else {
                if (window.showNotification) {
                    window.showNotification('❌ Erreur lors du lancement', 'error');
                }
            }
        } catch (error) {
            if (window.showNotification) {
                window.showNotification('❌ Erreur réseau', 'error');
            }
        }
    };

    window.lancerTousTests = async function() {
        const confirme = await new Promise(resolve => {
            showConfirmationModal(
                'Lancer tous les tests',
                'Voulez-vous lancer tous les tests ?',
                () => resolve(true),
                false
            );
        });

        if (!confirme) return;

        if (window.showNotification) {
            window.showNotification('🔄 Lancement en cours...', 'info');
        }

        try {
            const response = await fetch('/tests/lancer-tous', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                }
            });

            if (response.ok) {
                if (window.showNotification) {
                    window.showNotification('✅ Tests lancés !', 'success');
                }
                setTimeout(() => location.reload(), 2000);
            } else {
                if (window.showNotification) {
                    window.showNotification('❌ Erreur lors du lancement', 'error');
                }
            }
        } catch (error) {
            if (window.showNotification) {
                window.showNotification('❌ Erreur réseau', 'error');
            }
        }
    };

    // Formatter les dates en français
    function formatDateFR(dateString) {
        try {
            const date = new Date(dateString);
            return date.toLocaleDateString('fr-FR', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        } catch (e) {
            return dateString;
        }
    }

    // Mettre à jour l'heure dans le footer
    function updateFooterTime() {
        const now = new Date();
        const timeElement = document.getElementById('footer-time');
        if (timeElement) {
            const timeString = now.toLocaleTimeString('fr-FR', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
            timeElement.textContent = `Dernière mise à jour: ${timeString}`;
        }
    }

    // Initialiser l'heure si l'élément existe
    if (document.getElementById('footer-time')) {
        updateFooterTime();
        setInterval(updateFooterTime, 60000);
    }
    </script>

    <!-- Modale de confirmation -->
    <div id="confirmationModal" class="modal-overlay" style="display: none;">
        <div class="modal">
            <div class="modal-header">
                <h3 id="modalTitle">Confirmation</h3>
                <button class="modal-close" onclick="closeConfirmationModal()">&times;</button>
            </div>
            <div class="modal-body">
                <p id="modalMessage">Êtes-vous sûr de vouloir effectuer cette action ?</p>
            </div>
            <div class="modal-footer">
                <button class="modal-btn modal-btn-cancel" onclick="closeConfirmationModal()">Annuler</button>
                <button class="modal-btn modal-btn-confirm" id="modalConfirmBtn">Confirmer</button>
            </div>
        </div>
    </div>

    <style>
    /* Styles pour la modale */
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 10000;
        backdrop-filter: blur(4px);
    }

    .modal {
        background: white;
        border-radius: 16px;
        padding: 0;
        min-width: 400px;
        max-width: 500px;
        box-shadow: 0 20px 60px rgba(0, 103, 71, 0.2);
        border: 1px solid rgba(0, 103, 71, 0.1);
        overflow: hidden;
    }

    .modal-header {
        padding: 1.5rem;
        border-bottom: 1px solid rgba(0, 103, 71, 0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(135deg, rgba(0, 103, 71, 0.05), rgba(141, 198, 63, 0.05));
    }

    .modal-header h3 {
        margin: 0;
        color: #006747;
        font-size: 1.3rem;
        font-weight: 600;
    }

    .modal-close {
        background: none;
        border: none;
        font-size: 1.5rem;
        cursor: pointer;
        color: #6C757D;
        transition: color 0.2s ease;
        width: 30px;
        height: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
    }

    .modal-close:hover {
        background: rgba(0,0,0,0.05);
        color: #D50032;
    }

    .modal-body {
        padding: 1.5rem;
        color: #343A40;
        line-height: 1.6;
    }

    .modal-footer {
        padding: 1rem 1.5rem;
        border-top: 1px solid rgba(0, 103, 71, 0.1);
        display: flex;
        gap: 0.75rem;
        justify-content: flex-end;
        background: #F5F7FA;
    }

    .modal-btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s ease;
        min-width: 100px;
        font-family: inherit;
    }

    .modal-btn-cancel {
        background: #6C757D;
        color: white;
    }

    .modal-btn-cancel:hover {
        background: #5A6268;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
    }

    .modal-btn-confirm {
        background: linear-gradient(135deg, #006747, #8DC63F);
        color: white;
    }

    .modal-btn-confirm:hover {
        background: linear-gradient(135deg, #005738, #7CB839);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 103, 71, 0.3);
    }

    .modal-btn-danger {
        background: linear-gradient(135deg, #D50032, #FF5252);
        color: white;
    }

    .modal-btn-danger:hover {
        background: linear-gradient(135deg, #B30029, #FF4444);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(213, 0, 50, 0.3);
    }

    /* Animations pour les notifications */
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }

    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }

    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }

    .pulse-animation {
        animation: pulse 2s infinite;
    }
    </style>

</body>
</html>