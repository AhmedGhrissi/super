// ===== INITIALISATION =====
document.addEventListener('DOMContentLoaded', function() {
    // Initialiser la modale comme cachée
    const modal = document.getElementById('confirmationModal');
    if (modal) {
        modal.style.display = 'none';
    }

    // Animation pour les cartes au chargement
    animateCards();

    // Effet de pulsation pour les badges actifs
    animateActiveBadges();

    // Initialiser les événements de la modale
    initModalEvents();

    // Initialiser les raccourcis clavier
    initKeyboardShortcuts();
});

// ===== ANIMATIONS =====
function animateCards() {
    const cards = document.querySelectorAll('.card, .stat-card, .detail-card');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';

        setTimeout(() => {
            card.style.transition = 'all 0.6s ease';
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 100);
    });
}

function animateActiveBadges() {
    const activeBadges = document.querySelectorAll('.status-badge.active');
    activeBadges.forEach(badgeElement => {
        badgeElement.style.animation = 'pulse 2s infinite';
    });

    // Ajouter le style d'animation si non présent
    if (!document.querySelector('#pulse-animation')) {
        const style = document.createElement('style');
        style.id = 'pulse-animation';
        style.textContent = `
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.05); }
                100% { transform: scale(1); }
            }
        `;
        document.head.appendChild(style);
    }
}

// ===== GESTION DES MODALES =====
let currentAction = null;

function showConfirmation(title, message, confirmCallback, danger = false) {
    const modal = document.getElementById('confirmationModal');
    if (!modal) {
        console.error('Modal non trouvée');
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

function closeModal() {
    const modal = document.getElementById('confirmationModal');
    if (modal) {
        modal.style.display = 'none';
    }
    currentAction = null;
}

function confirmAction() {
    if (currentAction) {
        currentAction();
    }
    closeModal();
}

function initModalEvents() {
    const modal = document.getElementById('confirmationModal');
    if (!modal) return;

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

// ===== RACCOURCIS CLAVIER =====
function initKeyboardShortcuts() {
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
        }

        // Ctrl+Shift+D pour dashboard
        if (e.ctrlKey && e.shiftKey && e.key === 'D') {
            e.preventDefault();
            window.location.href = '/dashboard';
        }

        // Ctrl+Shift+S pour serveurs
        if (e.ctrlKey && e.shiftKey && e.key === 'S') {
            e.preventDefault();
            window.location.href = '/serveurs';
        }
    });
}

// ===== FONCTIONS GLOBALES POUR LES TESTS =====
window.testerServeur = async function(serveurNom) {
    console.log('TEST SERVEUR - ' + serveurNom);

    try {
        const testResponse = await fetch('/api/tests/rapide/' + encodeURIComponent(serveurNom), {
            method: 'POST'
        });

        if (testResponse.ok) {
            showNotification('Test réussi - Serveur excellent', 'success');
        } else {
            showNotification('Serveur critique - Alerte envoyée', 'error');
        }

        setTimeout(() => location.reload(), 2000);

    } catch (error) {
        console.error('Erreur:', error);
        showNotification('Erreur réseau', 'error');
    }
};

async function confirmerLancementTests(cible) {
    return new Promise((resolve) => {
        if (!cible || cible.trim() === '') {
            cible = 'les éléments sélectionnés';
        }

        const message = 'Voulez-vous lancer l\'exécution de <strong>' + cible + '</strong> ?';

        if (typeof showConfirmation === 'function') {
            showConfirmation(
                'Confirmation',
                message,
                () => resolve(true),
                false
            );
        } else {
            const confirme = confirm('Lancer ' + cible + ' ?');
            resolve(confirme);
        }
    });
}

window.lancerTestsCategorie = async function(categorie) {
    if (!categorie) {
        showNotification('Catégorie non sélectionnée', 'warning');
        return;
    }

    const confirme = await confirmerLancementTests(categorie);
    if (!confirme) return;

    showNotification('Lancement en cours...', 'info');

    try {
        const url = '/tests/lancer-categorie/' + encodeURIComponent(categorie);
        const response = await fetch(url, { method: 'POST' });

        if (response.ok) {
            showNotification('Tests lancés avec succès !', 'success');
            setTimeout(() => location.reload(), 3000);
        } else {
            showNotification('Erreur lors du lancement', 'error');
        }
    } catch (error) {
        showNotification('Erreur réseau', 'error');
    }
};

window.lancerTousTests = async function() {
    const confirme = await confirmerLancementTests('tous les tests');
    if (!confirme) return;

    showNotification('Lancement en cours...', 'info');

    try {
        const response = await fetch('/tests/lancer-tous', { method: 'POST' });

        if (response.ok) {
            showNotification('Tests lancés !', 'success');
            setTimeout(() => location.reload(), 2000);
        } else {
            showNotification('Erreur', 'error');
        }
    } catch (error) {
        showNotification('Erreur réseau', 'error');
    }
};

// ===== NOTIFICATIONS =====
function showNotification(message, type) {
    try {
        const notification = document.createElement('div');
        notification.className = 'custom-notification';

        let backgroundColor = '#2e7d32'; // Vert par défaut
        if (type === 'success') backgroundColor = '#06d6a0';
        if (type === 'error') backgroundColor = '#d32f2f';
        if (type === 'warning') backgroundColor = '#ff9800';
        if (type === 'info') backgroundColor = '#2196f3';

        notification.style.cssText =
            'position: fixed;' +
            'top: 20px;' +
            'right: 20px;' +
            'padding: 1rem 1.5rem;' +
            'border-radius: 10px;' +
            'color: white;' +
            'font-weight: 600;' +
            'z-index: 10000;' +
            'box-shadow: 0 8px 25px rgba(0,0,0,0.3);' +
            'max-width: 400px;' +
            'font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;' +
            'background: ' + backgroundColor + ';' +
            'animation: notificationSlideIn 0.3s ease;';

        notification.innerHTML = message;
        document.body.appendChild(notification);

        // Auto-remove après 4 secondes
        setTimeout(() => {
            if (notification.parentNode) {
                notification.style.animation = 'notificationSlideOut 0.3s ease';
                setTimeout(() => {
                    if (notification.parentNode) {
                        notification.remove();
                    }
                }, 300);
            }
        }, 4000);

    } catch (e) {
        console.log('Erreur notification:', e);
    }
}

// Ajouter l'animation de sortie pour les notifications
if (!document.querySelector('#notification-animations')) {
    const style = document.createElement('style');
    style.id = 'notification-animations';
    style.textContent = `
        @keyframes notificationSlideIn {
            from {
                opacity: 0;
                transform: translateX(100%);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes notificationSlideOut {
            from {
                opacity: 1;
                transform: translateX(0);
            }
            to {
                opacity: 0;
                transform: translateX(100%);
            }
        }
    `;
    document.head.appendChild(style);
}

// ===== NOTIFICATION MANAGER =====
if (typeof window.NotificationManager === 'undefined') {
    window.NotificationManager = {
        async requestPermission() {
            try {
                // Vérifier si l'API Notification est supportée
                if (!('Notification' in window)) {
                    showNotification('Notifications non supportées par ce navigateur', 'warning');
                    return false;
                }

                const permission = await Notification.requestPermission();
                if (permission === 'granted') {
                    showNotification('🔔 Notifications activées !', 'success');
                    return true;
                } else {
                    showNotification('Permissions notifications refusées', 'warning');
                    return false;
                }
            } catch (error) {
                console.error('Erreur permissions notifications:', error);
                return false;
            }
        }
    };
}

// ===== FONCTIONS UTILITAIRES =====
function formatDate(dateString) {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric'
    });
}

function formatDateTime(dateTimeString) {
    if (!dateTimeString) return '';
    const date = new Date(dateTimeString);
    return date.toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

// ===== EXPORT DES FONCTIONS GLOBALES =====
window.showConfirmation = showConfirmation;
window.closeModal = closeModal;
window.showNotification = showNotification;
window.testerServeur = window.testerServeur;
window.lancerTestsCategorie = window.lancerTestsCategorie;
window.lancerTousTests = window.lancerTousTests;
window.formatDate = formatDate;
window.formatDateTime = formatDateTime;