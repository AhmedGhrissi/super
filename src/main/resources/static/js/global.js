// ===== JAVASCRIPT GLOBAL POUR TOUTE L'APPLICATION =====

// 1. FONCTION DE NOTIFICATION GLOBALE
function showNotification(message, type) {
    // Créer une notification basique
    const notification = document.createElement('div');

    // Déterminer la couleur
    let backgroundColor;
    if (type === 'success') {
        backgroundColor = '#06d6a0';
    } else if (type === 'error') {
        backgroundColor = '#ef476f';
    } else {
        backgroundColor = '#4361ee';
    }

    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 1rem 1.5rem;
        border-radius: 10px;
        color: white;
        font-weight: 600;
        z-index: 10000;
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        max-width: 400px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: ${backgroundColor};
    `;

    notification.textContent = message;
    document.body.appendChild(notification);

    // Supprimer après 4 secondes
    setTimeout(() => {
        if (notification.parentNode) {
            notification.remove();
        }
    }, 4000);
}

// 2. FONCTION POUR TESTER UN SERVEUR (pour toutes les pages)
function testerServeur(serveurNom) {
    console.log('Test du serveur:', serveurNom);

    if (confirm('🚀 Lancer un test rapide sur ' + serveurNom + ' ?')) {
        showNotification('🔄 Test en cours sur ' + serveurNom + '...', 'info');

        // Simulation simple
        setTimeout(() => {
            const succes = Math.random() > 0.3;
            if (succes) {
                showNotification('✅ Test réussi sur ' + serveurNom + '!', 'success');
                setTimeout(() => {
                    location.reload();
                }, 3000);
            } else {
                showNotification('❌ Test échoué sur ' + serveurNom, 'error');
            }
        }, 2000);
    }
}

// 3. FONCTIONS POUR LES MODALES (globales)
let currentAction = null;

function showConfirmation(title, message, confirmCallback, danger = false) {
    const modal = document.getElementById('confirmationModal');
    if (!modal) {
        // Si la modale n'existe pas, utiliser confirm simple
        if (confirm(title + ': ' + message)) {
            confirmCallback();
        }
        return;
    }

    document.getElementById('modalTitle').textContent = title;
    document.getElementById('modalMessage').textContent = message;

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

// 4. FONCTIONS POUR LES TESTS (dashboard)
function lancerTestsMasse() {
    showConfirmation(
        'Lancer tous les tests',
        'Voulez-vous lancer l\'exécution de tous les tests actifs ?',
        function() {
            showNotification('🚀 Lancement des tests en cours...', 'success');
        }
    );
}

function lancerTestsCaisses() {
    showConfirmation(
        'Tester toutes les caisses',
        'Voulez-vous lancer les tests pour toutes les caisses actives ?',
        function() {
            showNotification('🏦 Tests des caisses en cours...', 'info');
        }
    );
}

// 5. FONCTIONS UTILITAIRES GLOBALES
function exporterStatistiques() {
    showNotification('📊 Export des statistiques en cours...', 'info');
    // Logique d'export à implémenter
}

function rafraichirPage() {
    location.reload();
}

// 6. INITIALISATION GLOBALE
document.addEventListener('DOMContentLoaded', function() {
    console.log('Application Machine Monitor - JavaScript global chargé');

    // Initialiser les événements de la modale si elle existe
    const modal = document.getElementById('confirmationModal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        const confirmBtn = document.getElementById('modalConfirmBtn');
        if (confirmBtn) {
            confirmBtn.addEventListener('click', confirmAction);
        }
    }

    // Raccourci clavier Échap global
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });

    // Animation des cartes sur toutes les pages
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

    // Effet de pulsation pour les badges actifs
    const activeBadges = document.querySelectorAll('.status-badge.active');
    activeBadges.forEach(badge => {
        badge.style.animation = 'pulse 2s infinite';
    });
});