// Gestion du menu mobile
document.addEventListener('DOMContentLoaded', function() {
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mainNav = document.querySelector('.main-nav');
    const mainContent = document.getElementById('mainContent');

    if (mobileMenuBtn && mainNav) {
        mobileMenuBtn.addEventListener('click', function() {
            mainNav.classList.toggle('mobile-open');
            mobileMenuBtn.innerHTML = mainNav.classList.contains('mobile-open')
                ? '<i class="fas fa-times"></i>'
                : '<i class="fas fa-bars"></i>';
        });

        // Fermer le menu en cliquant sur le contenu
        if (mainContent) {
            mainContent.addEventListener('click', function() {
                if (mainNav.classList.contains('mobile-open')) {
                    mainNav.classList.remove('mobile-open');
                    mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
                }
            });
        }
    }

    // Gestion des notifications
    const notificationBtn = document.getElementById('notificationBtn');
    if (notificationBtn) {
        notificationBtn.addEventListener('click', function() {
            showNotification('Notifications', 'Fonctionnalité à implémenter', 'info');
        });
    }

    // Fonction de notification
    function showNotification(title, message, type = 'info') {
        // Créer une notification simple
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <strong>${title}</strong>
                <p>${message}</p>
            </div>
            <button class="notification-close" onclick="this.parentElement.remove()">
                <i class="fas fa-times"></i>
            </button>
        `;

        // Ajouter au body
        document.body.appendChild(notification);

        // Auto-remove après 5 secondes
        setTimeout(() => {
            if (notification.parentElement) {
                notification.remove();
            }
        }, 5000);
    }

    // Ajouter le CSS pour les notifications
    if (!document.querySelector('#notification-styles')) {
        const style = document.createElement('style');
        style.id = 'notification-styles';
        style.textContent = `
            .notification {
                position: fixed;
                top: 20px;
                right: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                padding: 1rem;
                min-width: 300px;
                max-width: 400px;
                z-index: 10000;
                animation: slideIn 0.3s ease;
                border-left: 4px solid #2e7d32;
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }

            .notification-info {
                border-left-color: #2196f3;
            }

            .notification-warning {
                border-left-color: #ff9800;
            }

            .notification-error {
                border-left-color: #f44336;
            }

            .notification-content {
                flex: 1;
            }

            .notification-content strong {
                display: block;
                margin-bottom: 0.25rem;
                color: #212121;
            }

            .notification-content p {
                margin: 0;
                color: #616161;
                font-size: 0.9rem;
            }

            .notification-close {
                background: none;
                border: none;
                color: #9e9e9e;
                cursor: pointer;
                padding: 0.25rem;
                margin-left: 0.5rem;
            }

            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
        `;
        document.head.appendChild(style);
    }
});