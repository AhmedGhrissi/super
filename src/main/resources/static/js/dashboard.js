// ===== DASHBOARD SPECIFIC FUNCTIONS =====

// Variables globales pour la gestion des popups du dashboard
let dashboardPopupResolve = null;

/**
 * 📋 Afficher un popup de confirmation pour le dashboard
 */
function showDashboardPopup(title, message) {
    const popup = document.getElementById('dashboardPopup');
    const popupTitle = document.getElementById('dashboardPopupTitle');
    const popupMessage = document.getElementById('dashboardPopupMessage');

    if (popup && popupTitle && popupMessage) {
        popupTitle.textContent = title;
        popupMessage.innerHTML = message;
        popup.style.display = 'flex';

        // Retourner une promesse pour gérer la réponse
        return new Promise((resolve) => {
            dashboardPopupResolve = resolve;
        });
    } else {
        console.error('Éléments du popup dashboard non trouvés');
        // Fallback vers la confirmation native
        return Promise.resolve(confirm(title + ': ' + message.replace(/<[^>]*>/g, '')));
    }
}

/**
 * 📋 Fermer le popup du dashboard
 */
function fermerDashboardPopup(confirmed = false) {
    const popup = document.getElementById('dashboardPopup');
    if (popup) {
        popup.style.display = 'none';
    }
    if (dashboardPopupResolve) {
        dashboardPopupResolve(confirmed);
        dashboardPopupResolve = null;
    }
}

/**
 * 📁 Lancement des tests par catégorie - VERSION DASHBOARD
 */
async function lancerTestsCategorieDashboard() {
    const select = document.getElementById('categorieSelect');
    const categorie = select.value;

    if (!categorie) {
        showNotification('Veuillez s&eacute;lectionner une cat&eacute;gorie', 'warning');
        return;
    }

    // Récupérer le texte de l'option sélectionnée
    const nomCategorie = select.options[select.selectedIndex].text;

    // Utiliser la fonction showDashboardPopup
    const confirmed = await showDashboardPopup(
        'Lancer les tests',
        'Voulez-vous lancer l\'ex&eacute;cution des tests de la cat&eacute;gorie <strong>"' + nomCategorie + '"</strong> ?'
    );

    if (confirmed) {
        showNotification('🔄 Lancement des tests ' + nomCategorie + '...', 'info');

        try {
            const response = await fetch('/tests/lancer-categorie/' + encodeURIComponent(categorie), {
                method: 'POST'
            });

            if (response.ok) {
                showNotification('✅ Tests ' + nomCategorie + ' lanc&eacute;s avec succ&egrave;s !', 'success');
                setTimeout(() => location.reload(), 3000);
            } else {
                showNotification('❌ Erreur lors du lancement des tests', 'error');
            }
        } catch (error) {
            console.error('Erreur:', error);
            showNotification('❌ Erreur r&eacute;seau lors du lancement', 'error');
        }
    }
}

/**
 * 🎯 Lancement de tous les tests - VERSION DASHBOARD
 */
async function lancerTousTests() {
    // Utiliser la modale existante du footer
    if (typeof showConfirmation === 'function') {
        showConfirmation(
            'Lancer tous les tests',
            'Voulez-vous lancer tous les tests ?',
            async function() {
                showNotification('🔄 Lancement en cours...', 'info');

                try {
                    const response = await fetch('/tests/lancer-tous', {
                        method: 'POST'
                    });

                    if (response.ok) {
                        showNotification('✅ Tests lanc&eacute;s avec succ&egrave;s !', 'success');
                        setTimeout(() => location.reload(), 2000);
                    } else {
                        showNotification('❌ Erreur lors du lancement', 'error');
                    }
                } catch (error) {
                    showNotification('❌ Erreur r&eacute;seau', 'error');
                }
            },
            false
        );
    } else {
        // Fallback vers la confirmation native
        if (confirm('Voulez-vous lancer tous les tests ?')) {
            showNotification('🔄 Lancement en cours...', 'info');

            try {
                const response = await fetch('/tests/lancer-tous', {
                    method: 'POST'
                });

                if (response.ok) {
                    showNotification('✅ Tests lanc&eacute;s avec succ&egrave;s !', 'success');
                    setTimeout(() => location.reload(), 2000);
                } else {
                    showNotification('❌ Erreur lors du lancement', 'error');
                }
            } catch (error) {
                showNotification('❌ Erreur r&eacute;seau', 'error');
            }
        }
    }
}

// ===== INITIALISATION DASHBOARD =====
document.addEventListener('DOMContentLoaded', function() {
    // Animation des cartes au chargement
    animateDashboardCards();

    // Initialiser les popups dashboard
    initDashboardPopups();

    // Rendre les fonctions accessibles globalement
    window.lancerTestsCategorieDashboard = lancerTestsCategorieDashboard;
    window.lancerTousTests = lancerTousTests;
    window.showDashboardPopup = showDashboardPopup;
    window.fermerDashboardPopup = fermerDashboardPopup;
});

function animateDashboardCards() {
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

function initDashboardPopups() {
    const popup = document.getElementById('dashboardPopup');
    if (popup) {
        popup.addEventListener('click', function(e) {
            if (e.target === this) {
                fermerDashboardPopup(false);
            }
        });
    }

    // Raccourci clavier Échap pour le popup dashboard
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const popup = document.getElementById('dashboardPopup');
            if (popup && popup.style.display === 'flex') {
                fermerDashboardPopup(false);
            }
        }
    });
}