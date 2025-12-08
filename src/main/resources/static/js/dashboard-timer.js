// dashboard-timer.js
let timerSeconds = 300;
let timerInterval = null;

// Fonction GARANTIE pour afficher les notifications
window.showNotification = function(title, message, type = 'info', duration = 4000) {
    console.log(`[NOTIF ${type}] ${title}: ${message}`);

    // 1. Créer un container s'il n'existe pas
    let container = document.getElementById('notificationContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'notificationContainer';
        container.style.cssText = `
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 999998;
            max-width: 400px;
        `;
        document.body.appendChild(container);
    }

    // 2. Créer la notification
    const notification = document.createElement('div');
    notification.style.cssText = `
        background: ${type === 'success' ? '#d4edda' :
                     type === 'error' ? '#f8d7da' :
                     type === 'warning' ? '#fff3cd' : '#d1ecf1'};
        border-left: 4px solid ${type === 'success' ? '#28a745' :
                               type === 'error' ? '#dc3545' :
                               type === 'warning' ? '#ffc107' : '#17a2b8'};
        padding: 12px 16px;
        margin-bottom: 10px;
        border-radius: 4px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        animation: slideIn 0.3s ease;
    `;

    let icon = 'ℹ️';
    if (type === 'success') icon = '✅';
    else if (type === 'error') icon = '❌';
    else if (type === 'warning') icon = '⚠️';

    notification.innerHTML = `
        <div style="display: flex; align-items: center; gap: 10px;">
            <div style="font-size: 18px;">${icon}</div>
            <div>
                <div style="font-weight: bold; color: #333; margin-bottom: 2px;">${title}</div>
                <div style="color: #666; font-size: 14px;">${message}</div>
            </div>
            <button onclick="this.parentElement.parentElement.remove()"
                    style="margin-left: auto; background: none; border: none; font-size: 20px; cursor: pointer; color: #999;">×</button>
        </div>
    `;

    container.appendChild(notification);

    // 3. Auto-suppression
    if (duration > 0) {
        setTimeout(() => {
            if (notification.parentNode) {
                notification.style.opacity = '0';
                notification.style.transform = 'translateX(20px)';
                setTimeout(() => notification.remove(), 300);
            }
        }, duration);
    }

    return notification;
};

// Fonction pour créer/démarrer le timer
function startTimer() {
    console.log('⏱️ TIMER - DÉMARRAGE FORCÉ');

    // 1. Nettoyer l'ancien
    const oldTimer = document.getElementById('dashboardTimer');
    if (oldTimer) oldTimer.remove();

    // 2. Créer un NOUVEL élément
    const timerDiv = document.createElement('div');
    timerDiv.id = 'dashboardTimer';
    timerDiv.style.cssText = `
        position: fixed !important;
        top: 20px !important;
        right: 20px !important;
        background: linear-gradient(135deg, #28a745, #20c997) !important;
        color: white !important;
        padding: 15px 25px !important;
        border-radius: 10px !important;
        font-size: 22px !important;
        font-weight: bold !important;
        font-family: 'Arial', sans-serif !important;
        z-index: 999999 !important;
        box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3) !important;
        text-align: center !important;
        min-width: 140px !important;
        border: 3px solid white !important;
    `;

    document.body.appendChild(timerDiv);

    // 3. Réinitialiser le compteur
    timerSeconds = 300;
    updateTimerDisplay(timerDiv);

    // 4. Démarrer l'intervalle
    if (timerInterval) clearInterval(timerInterval);

    timerInterval = setInterval(() => {
        timerSeconds--;
        updateTimerDisplay(timerDiv);

        // Changer la couleur quand < 1 minute
        if (timerSeconds <= 60) {
            timerDiv.style.background = 'linear-gradient(135deg, #dc3545, #fd7e14)';
        }

        // Rafraîchir à 0
        if (timerSeconds <= 0) {
            clearInterval(timerInterval);
            timerDiv.innerHTML = '🔄 Rafraîchissement...';
            timerDiv.style.background = 'linear-gradient(135deg, #007bff, #6610f2)';

            setTimeout(() => {
                location.reload();
            }, 1500);
        }
    }, 1000);

    console.log('✅ Timer démarré avec succès');
    showNotification('Timer activé', 'Rafraîchissement automatique dans 5 minutes', 'success', 4000);
}

// Mettre à jour l'affichage
function updateTimerDisplay(element) {
    const minutes = Math.floor(timerSeconds / 60);
    const seconds = timerSeconds % 60;
    element.textContent = `⏱️ ${minutes}:${seconds.toString().padStart(2, '0')}`;
}

// ========== INITIALISATION ==========

// Ajouter les styles CSS
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateX(30px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
`;
document.head.appendChild(style);

// Démarrer IMMÉDIATEMENT
startTimer();

// Redémarrer après 3s au cas où
setTimeout(startTimer, 3000);

// Test manuel
window.debugTimer = function() {
    alert(`TIMER DEBUG:
    • Secondes restantes: ${timerSeconds}
    • Prochaine actualisation: dans ${Math.floor(timerSeconds/60)}m ${timerSeconds%60}s
    • Intervalle actif: ${timerInterval ? 'OUI' : 'NON'}`);

    const timer = document.getElementById('dashboardTimer');
    if (timer) {
        timer.style.border = '3px solid yellow';
        setTimeout(() => timer.style.border = '3px solid white', 1000);
    }
};

console.log('🎯 Timer initialisé - Vérifiez le coin supérieur droit!');