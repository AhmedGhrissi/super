// ========== GESTION DES MODALES ==========
let currentAction = null;

/**
 * Affiche une modale de confirmation
 * @param {string} title - Titre de la modale
 * @param {string} message - Message à afficher
 * @param {function} confirmCallback - Fonction à exécuter sur confirmation
 * @param {boolean} danger - Style danger (rouge) si vrai
 */
function showConfirmation(title, message, confirmCallback, danger = false) {
    const modal = document.getElementById('confirmationModal');
    if (!modal) {
        console.error('Modal de confirmation non trouvée');
        if (confirm(title + ': ' + message)) {
            confirmCallback();
        }
        return;
    }

    document.getElementById('modalTitle').textContent = title;
    document.getElementById('modalMessage').innerHTML = message;

    const confirmBtn = document.getElementById('modalConfirmBtn');
    if (danger) {
        confirmBtn.className = 'modal-btn modal-btn-danger';
    } else {
        confirmBtn.className = 'modal-btn modal-btn-confirm';
    }

    currentAction = confirmCallback;
    modal.style.display = 'flex';
}

/**
 * Ferme la modale
 */
function closeModal() {
    const modal = document.getElementById('confirmationModal');
    if (modal) {
        modal.style.display = 'none';
    }
    currentAction = null;
}

/**
 * Confirme l'action en cours
 */
function confirmAction() {
    if (currentAction && typeof currentAction === 'function') {
        currentAction();
    }
    closeModal();
}

// ========== NOTIFICATIONS ==========
/**
 * Affiche une notification
 * @param {string} message - Message à afficher
 * @param {string} type - Type de notification (success, error, warning, info)
 */
function showNotification(message, type = 'info') {
    try {
        // Supprimer les notifications précédentes
        const oldNotifications = document.querySelectorAll('.custom-notification');
        oldNotifications.forEach(notification => {
            if (notification.parentNode) {
                notification.remove();
            }
        });

        // Créer la nouvelle notification
        const notification = document.createElement('div');
        notification.className = 'custom-notification';

        // Définir les couleurs selon le type
        let backgroundColor = '';
        switch(type) {
            case 'success':
                backgroundColor = '#2e7d32'; // Vert
                break;
            case 'error':
                backgroundColor = '#d32f2f'; // Rouge
                break;
            case 'warning':
                backgroundColor = '#f57c00'; // Orange
                break;
            case 'info':
            default:
                backgroundColor = '#1976d2'; // Bleu
                break;
        }

        notification.style.backgroundColor = backgroundColor;
        notification.innerHTML = message;

        // Ajouter au DOM
        document.body.appendChild(notification);

        // Supprimer automatiquement après 4 secondes
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 4000);

    } catch (error) {
        console.error('Erreur lors de l\'affichage de la notification:', error);
        alert(message); // Fallback
    }
}

// ========== FONCTIONS DE TEST ==========
/**
 * Test rapide d'un serveur
 * @param {string} serveurNom - Nom du serveur à tester
 */
window.testerServeur = async function(serveurNom) {
    if (!serveurNom) {
        showNotification('Nom du serveur manquant', 'warning');
        return;
    }

    showNotification(`Test du serveur ${serveurNom} en cours...`, 'info');

    try {
        const response = await fetch(`/api/tests/rapide/${encodeURIComponent(serveurNom)}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            showNotification(`✅ Serveur ${serveurNom} - Test réussi`, 'success');
        } else {
            showNotification(`❌ Serveur ${serveurNom} - Échec du test`, 'error');
        }

        // Recharger la page après 2 secondes
        setTimeout(() => {
            window.location.reload();
        }, 2000);

    } catch (error) {
        console.error('Erreur lors du test du serveur:', error);
        showNotification('Erreur réseau lors du test', 'error');
    }
};

/**
 * Lancement de tests par catégorie
 * @param {string} categorie - Catégorie de tests à lancer
 */
window.lancerTestsCategorie = async function(categorie) {
    if (!categorie) {
        showNotification('Catégorie non sélectionnée', 'warning');
        return;
    }

    const confirmed = await new Promise(resolve => {
        showConfirmation(
            'Lancer les tests',
            `Voulez-vous lancer l'exécution des tests de la catégorie <strong>"${categorie}"</strong> ?`,
            () => resolve(true),
            false
        );
    });

    if (!confirmed) return;

    showNotification(`Lancement des tests ${categorie}...`, 'info');

    try {
        const response = await fetch(`/tests/lancer-categorie/${encodeURIComponent(categorie)}`, {
            method: 'POST'
        });

        if (response.ok) {
            showNotification(`✅ Tests ${categorie} lancés avec succès`, 'success');
            setTimeout(() => window.location.reload(), 3000);
        } else {
            showNotification('❌ Erreur lors du lancement des tests', 'error');
        }
    } catch (error) {
        console.error('Erreur:', error);
        showNotification('❌ Erreur réseau', 'error');
    }
};

/**
 * Lancement de tous les tests
 */
window.lancerTousTests = async function() {
    showConfirmation(
        'Lancer tous les tests',
        'Voulez-vous lancer l\'exécution de tous les tests ?',
        async function() {
            showNotification('🔄 Lancement de tous les tests...', 'info');

            try {
                const response = await fetch('/tests/lancer-tous', {
                    method: 'POST'
                });

                if (response.ok) {
                    showNotification('✅ Tous les tests ont été lancés', 'success');
                    setTimeout(() => window.location.reload(), 2000);
                } else {
                    showNotification('❌ Erreur lors du lancement', 'error');
                }
            } catch (error) {
                showNotification('❌ Erreur réseau', 'error');
            }
        },
        false
    );
};

/**
 * Confirmation pour le lancement de tests (utilisé dans le dashboard)
 */
async function confirmerLancementTests(cible) {
    return new Promise((resolve) => {
        if (!cible || cible.trim() === '') {
            cible = 'les éléments sélectionnés';
        }

        showConfirmation(
            'Confirmation',
            `Voulez-vous lancer l'exécution de <strong>${cible}</strong> ?`,
            () => resolve(true),
            false
        );
    });
}

// ========== GESTION DES NOTIFICATIONS NAVIGATEUR ==========
if (typeof window.NotificationManager === 'undefined') {
    window.NotificationManager = {
        /**
         * Demande la permission pour les notifications
         * @returns {Promise<boolean>} Permission accordée ou non
         */
        async requestPermission() {
            try {
                // Vérifier si les notifications sont supportées
                if (!('Notification' in window)) {
                    showNotification('Votre navigateur ne supporte pas les notifications', 'warning');
                    return false;
                }

                // Demander la permission
                const permission = await Notification.requestPermission();

                if (permission === 'granted') {
                    showNotification('🔔 Notifications activées avec succès', 'success');
                    return true;
                } else if (permission === 'denied') {
                    showNotification('Notifications refusées', 'warning');
                    return false;
                } else {
                    return false;
                }
            } catch (error) {
                console.error('Erreur lors de la demande de permission:', error);
                return false;
            }
        },

        /**
         * Envoie une notification
         * @param {string} title - Titre de la notification
         * @param {object} options - Options de la notification
         */
        sendNotification(title, options = {}) {
            if (Notification.permission === 'granted') {
                const notification = new Notification(title, {
                    icon: '/images/notification-icon.png',
                    badge: '/images/badge-icon.png',
                    ...options
                });

                // Fermer automatiquement après 5 secondes
                setTimeout(() => {
                    notification.close();
                }, 5000);

                // Action au clic
                notification.onclick = function() {
                    window.focus();
                    notification.close();
                };
            }
        }
    };
}

// ========== DASHBOARD SPECIFIC ==========
/**
 * Popup spécifique pour le dashboard
 */
let dashboardPopupResolve = null;

function showDashboardPopup(title, message) {
    // Réutiliser la modale existante
    return new Promise((resolve) => {
        showConfirmation(title, message, () => resolve(true), false);
    });
}

// ========== INITIALISATION ==========
document.addEventListener('DOMContentLoaded', function() {
    console.log('Supervision GEID - Script initialisé');

    // Initialiser les événements de la modale
    const modal = document.getElementById('confirmationModal');
    if (modal) {
        // Fermer la modale en cliquant à l'extérieur
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        // Lier le bouton de confirmation
        const confirmBtn = document.getElementById('modalConfirmBtn');
        if (confirmBtn) {
            confirmBtn.addEventListener('click', confirmAction);
        }
    }

    // Raccourci clavier Échap pour fermer la modale
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });

    // Animation pour les cartes au chargement
    const cards = document.querySelectorAll('.card, .stat-card');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';

        setTimeout(() => {
            card.style.transition = 'all 0.6s ease';
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 100);
    });

    // Effet de pulsation pour les badges actifs
    const activeBadges = document.querySelectorAll('.badge-success');
    activeBadges.forEach(badgeElement => {
        badgeElement.classList.add('pulse');
    });

    // Ajouter des événements pour les liens de navigation
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (this.getAttribute('href') === '#') {
                e.preventDefault();
            }
        });
    });

    // Mise à jour de l'heure dans le footer (optionnel)
    function updateFooterTime() {
        const now = new Date();
        const timeString = now.toLocaleTimeString('fr-FR', {
            hour: '2-digit',
            minute: '2-digit'
        });
        const dateString = now.toLocaleDateString('fr-FR', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });

        const timeElement = document.getElementById('footer-time');
        if (timeElement) {
            timeElement.textContent = `Dernière mise à jour: ${timeString}`;
        }
    }

    // Mettre à jour l'heure toutes les minutes
    updateFooterTime();
    setInterval(updateFooterTime, 60000);
});

// ========== FONCTIONS UTILITAIRES ==========
/**
 * Formate une date
 * @param {string} dateString - Date à formater
 * @returns {string} Date formatée
 */
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    const date = new Date(dateString);
    return date.toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

/**
 * Tronque un texte
 * @param {string} text - Texte à tronquer
 * @param {number} maxLength - Longueur maximale
 * @returns {string} Texte tronqué
 */
function truncateText(text, maxLength = 50) {
    if (!text) return '';
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
}

/**
 * Affiche un spinner de chargement
 * @param {boolean} show - Afficher ou cacher
 */
function showLoading(show = true) {
    let spinner = document.getElementById('loading-spinner');

    if (show) {
        if (!spinner) {
            spinner = document.createElement('div');
            spinner.id = 'loading-spinner';
            spinner.style.cssText = `
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: rgba(0, 100, 0, 0.9);
                color: white;
                padding: 2rem;
                border-radius: 8px;
                z-index: 9999;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 1rem;
            `;
            spinner.innerHTML = `
                <div class="spinner"></div>
                <span>Chargement...</span>
            `;
            document.body.appendChild(spinner);

            // Ajouter le style du spinner
            const style = document.createElement('style');
            style.textContent = `
                .spinner {
                    width: 30px;
                    height: 30px;
                    border: 3px solid rgba(255,255,255,0.3);
                    border-radius: 50%;
                    border-top-color: white;
                    animation: spin 1s linear infinite;
                }
                @keyframes spin {
                    to { transform: rotate(360deg); }
                }
            `;
            document.head.appendChild(style);
        }
    } else {
        if (spinner && spinner.parentNode) {
            spinner.remove();
        }
    }
}