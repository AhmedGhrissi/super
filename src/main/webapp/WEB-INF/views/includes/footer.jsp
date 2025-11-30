</main>

<footer style="
    background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
    color: white;
    padding: 1rem 2rem;
    margin-top: 3rem;
    border-top: 3px solid #4361ee;
    font-family: 'Segoe UI', Arial, sans-serif;
">
    <div style="max-width: 1400px; margin: 0 auto;">
        <!-- Ligne principale du footer -->
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
            <!-- Section gauche -->
            <div style="text-align: left; flex: 1;">
                <h3 style="color: #fff; margin: 0; font-size: 1.2rem; font-weight: 600;">
                    Machine Monitor
                </h3>
                <p style="color: #bdc3c7; margin: 0.3rem 0 0 0; font-size: 0.9rem;">
                    Syst&egrave;me de surveillance des caisses et tests automatis&eacute;s
                </p>
            </div>

            <!-- Section centrale -->
            <div style="text-align: center; flex: 1;">
                <p style="color: #ecf0f1; margin: 0; font-size: 0.85rem; font-weight: 500;">
                    &copy; 2025 Machine Monitor - Tous droits r&eacute;serv&eacute;s &bull; D&eacute;velopp&eacute; avec soin
                </p>
            </div>

            <!-- Section droite -->
            <div style="text-align: right; flex: 1;">
                <div style="display: flex; gap: 1.5rem; justify-content: flex-end; margin-bottom: 0.5rem;">
                    <span style="color: #ecf0f1; font-size: 0.9rem;">&#9881; Monitoring temps r&eacute;el</span>
                    <span style="color: #ecf0f1; font-size: 0.9rem;">&#9889; Performances</span>
                    <span style="color: #ecf0f1; font-size: 0.9rem;">&#128737; S&eacute;curit&eacute;</span>
                </div>
            </div>
        </div>

        <!-- Ligne secondaire -->
        <div style="margin-top: 1rem; padding-top: 0.8rem; border-top: 1px solid #4a6572;">
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <div style="color: #95a5a6; font-size: 0.8rem;">
                    &#127970; Gestion des partitions et CR &bull; &#129517; Tests de conformit&eacute;
                </div>
                <div style="color: #95a5a6; font-size: 0.8rem;">
                    &#128202; Dashboard &bull; &#127974; Caisses &bull; &#129517; Tests
                </div>
            </div>
        </div>
    </div>
</footer>

<script>
// Initialisation de la modale comme cachée
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('confirmationModal');
    if (modal) {
        modal.style.display = 'none';
    }

    // Animation pour les cartes au chargement
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
    activeBadges.forEach(badgeElement => {
        badgeElement.style.animation = 'pulse 2s infinite';
    });

    // Ajouter le style d'animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
    `;
    document.head.appendChild(style);
});

// Gestion des modales - DÉPLACÉ AVANT LES AUTRES FONCTIONS
let currentAction = null;

function showConfirmation(title, message, confirmCallback, danger = false) {
    const modal = document.getElementById('confirmationModal');
    if (!modal) return;

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

// Initialiser les événements de la modale
document.addEventListener('DOMContentLoaded', function() {
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

    // Raccourci clavier Échap
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });
});

// Fonctions globales pour les tests
window.testerServeur = async function(serveurNom) {
    console.log('TEST SERVEUR - ' + serveurNom);

    try {
        const testResponse = await fetch('/api/tests/rapide/' + encodeURIComponent(serveurNom), {
            method: 'POST'
        });

        if (testResponse.ok) {
            showNotification('Test r&eacute;ussi - Serveur excellent', 'success');
        } else {
            showNotification('Serveur critique - Alerte envoy&eacute;e', 'error');
        }

        setTimeout(() => location.reload(), 2000);

    } catch (error) {
        console.error('Erreur:', error);
        showNotification('Erreur r&eacute;seau', 'error');
    }
};

async function confirmerLancementTests(cible) {
    return new Promise((resolve) => {
        if (!cible || cible.trim() === '') {
            cible = 'les &eacute;l&eacute;ments s&eacute;lectionn&eacute;s';
        }

        const message = 'Voulez-vous lancer l ex&eacute;cution de <strong>' + cible + '</strong> ?';

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
        showNotification('Cat&eacute;gorie non s&eacute;lectionn&eacute;e', 'warning');
        return;
    }

    const confirme = await confirmerLancementTests(categorie);
    if (!confirme) return;

    showNotification('Lancement en cours...', 'info');

    try {
        const url = '/tests/lancer-categorie/' + encodeURIComponent(categorie);
        const response = await fetch(url, { method: 'POST' });

        if (response.ok) {
            showNotification('Tests lanc&eacute;s avec succ&egrave;s !', 'success');
            setTimeout(() => location.reload(), 3000);
        } else {
            showNotification('Erreur lors du lancement', 'error');
        }
    } catch (error) {
        showNotification('Erreur r&eacute;seau', 'error');
    }
};

window.lancerTousTests = async function() {
    const confirme = await confirmerLancementTests('tous les tests');
    if (!confirme) return;

    showNotification('Lancement en cours...', 'info');

    try {
        const response = await fetch('/tests/lancer-tous', { method: 'POST' });

        if (response.ok) {
            showNotification('Tests lanc&eacute;s !', 'success');
            setTimeout(() => location.reload(), 2000);
        } else {
            showNotification('Erreur', 'error');
        }
    } catch (error) {
        showNotification('Erreur r&eacute;seau', 'error');
    }
};

function showNotification(message, type) {
    try {
        const notification = document.createElement('div');
        notification.className = 'custom-notification';

        let backgroundColor = '#4361ee';
        if (type === 'success') backgroundColor = '#06d6a0';
        if (type === 'error') backgroundColor = '#ef476f';
        if (type === 'warning') backgroundColor = '#ff9e00';
        if (type === 'info') backgroundColor = '#4361ee';

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
            'background: ' + backgroundColor + ';';

        notification.innerHTML = message;
        document.body.appendChild(notification);

        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 4000);

    } catch (e) {
        console.log('Erreur notification:', e);
    }
}

// Notification Manager simplifié
if (typeof window.NotificationManager === 'undefined') {
    window.NotificationManager = {
        async requestPermission() {
            try {
                const permission = await Notification.requestPermission();
                return permission === 'granted';
            } catch (error) {
                return false;
            }
        }
    };
}
</script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- MODALE DE CONFIRMATION -->
<div id="confirmationModal" class="modal-overlay" style="display: none;">
    <div class="modal">
        <div class="modal-header">
            <h3 id="modalTitle">Confirmation</h3>
            <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <p id="modalMessage">&Ecirc;tes-vous s&ucirc;r de vouloir effectuer cette action ?</p>
        </div>
        <div class="modal-footer">
            <button class="modal-btn modal-btn-cancel" onclick="closeModal()">Annuler</button>
            <button class="modal-btn modal-btn-confirm" id="modalConfirmBtn">Confirmer</button>
        </div>
    </div>
</div>

<style>
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
}

.modal {
    background: white;
    border-radius: 10px;
    padding: 0;
    min-width: 400px;
    max-width: 500px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

.modal-header {
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    color: #2c3e50;
    font-size: 1.3rem;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: #6c757d;
}

.modal-body {
    padding: 1.5rem;
}

.modal-footer {
    padding: 1rem 1.5rem;
    border-top: 1px solid #e9ecef;
    display: flex;
    gap: 0.5rem;
    justify-content: flex-end;
}

.modal-btn {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
}

.modal-btn-cancel {
    background: #6c757d;
    color: white;
}

.modal-btn-confirm {
    background: #4361ee;
    color: white;
}

.modal-btn-danger {
    background: #ef476f;
    color: white;
}
</style>

</body>
</html>