<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles pour les rapports */
.rapports-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.rapports-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.rapports-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.rapports-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.rapports-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.rapports-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

.period-badge {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    padding: 0.5rem 1.5rem;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 600;
}

/* Cartes de statistiques */
.stats-grid-rapports {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card-rapports {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    text-align: center;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    transition: transform 0.3s ease;
}

.stat-card-rapports:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}

.stat-icon-rapports {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.stat-value-rapports {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.stat-label-rapports {
    font-size: 1.1rem;
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
}

.stat-period-rapports {
    font-size: 0.9rem;
    color: #6c757d;
}

/* Informations système */
.info-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.info-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.info-header-rapports h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.info-grid-rapports {
    padding: 1.5rem;
}

.info-details-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1.5rem;
}

.info-item-rapports {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.info-label-rapports {
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
}

.info-value-rapports {
    color: #006747;
    font-weight: 600;
    font-size: 1.1rem;
}

/* Actions */
.actions-section-rapports {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
}

.actions-header-rapports {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.actions-header-rapports h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.actions-grid-rapports {
    padding: 1.5rem;
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
}

.action-button-rapports {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    border-radius: 12px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
}

.action-button-rapports.primary {
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
}

.action-button-rapports.secondary {
    background: linear-gradient(135deg, #4361ee, #3a0ca3);
    color: white;
}

.action-button-rapports.print {
    background: linear-gradient(135deg, #ff9e00, #ff6b6b);
    color: white;
}

.action-button-rapports:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.2);
    text-decoration: none;
}

/* Back button */
.back-button-rapports {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    background: #6c757d;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    margin-top: 2rem;
}

.back-button-rapports:hover {
    background: #5a6268;
    transform: translateY(-2px);
    text-decoration: none;
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .rapports-container {
        padding: 1rem;
    }

    .rapports-title-section {
        flex-direction: column;
    }

    .stats-grid-rapports {
        grid-template-columns: 1fr;
    }

    .info-details-grid {
        grid-template-columns: 1fr;
    }

    .actions-grid-rapports {
        flex-direction: column;
    }

    .action-button-rapports {
        width: 100%;
        justify-content: center;
    }
}
</style>

<div class="rapports-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="rapports-header-modern">
        <div class="rapports-title-section">
            <div>
                <div class="rapports-title">
                    <h1>📈 Rapports de Supervision</h1>
                </div>
                <p class="rapports-subtitle">Analyse et statistiques hebdomadaires du système</p>
            </div>
            <div class="period-badge">
                📅 Période du ${rapports.periode}
            </div>
        </div>
    </div>

    <!-- ========== CARTES DE STATISTIQUES ========== -->
    <div class="stats-grid-rapports">
        <!-- Tests exécutés -->
        <div class="stat-card-rapports animate-fade-in-up">
            <div class="stat-icon-rapports">📊</div>
            <div class="stat-value-rapports" style="color: #006747;">${rapports.totalTests}</div>
            <div class="stat-label-rapports">Tests Exécutés</div>
            <div class="stat-period-rapports">Cette semaine</div>
        </div>

        <!-- Tests réussis -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.1s;">
            <div class="stat-icon-rapports">✅</div>
            <div class="stat-value-rapports" style="color: #28a745;">${rapports.testsReussis}</div>
            <div class="stat-label-rapports">Tests Réussis</div>
            <div class="stat-period-rapports">Cette semaine</div>
        </div>

        <!-- Taux de réussite -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.2s;">
            <div class="stat-icon-rapports">📈</div>
            <div class="stat-value-rapports" style="color: #ffc107;">${rapports.tauxReussite}%</div>
            <div class="stat-label-rapports">Taux de Réussite</div>
            <div class="stat-period-rapports">Moyenne hebdo</div>
        </div>

        <!-- Temps réponse -->
        <div class="stat-card-rapports animate-fade-in-up" style="animation-delay: 0.3s; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white;">
            <div class="stat-icon-rapports">⚡</div>
            <div class="stat-value-rapports">${rapports.tempsReponseMoyen}ms</div>
            <div class="stat-label-rapports">Temps Réponse</div>
            <div class="stat-period-rapports" style="color: rgba(255,255,255,0.9);">Moyen</div>
        </div>
    </div>

    <!-- ========== INFORMATIONS SYSTÈME ========== -->
    <div class="info-section-rapports">
        <div class="info-header-rapports">
            <h2>🏦 Informations Système</h2>
        </div>
        <div class="info-grid-rapports">
            <div class="info-details-grid">
                <div class="info-item-rapports">
                    <div class="info-label-rapports">Caisses Testées</div>
                    <div class="info-value-rapports">${rapports.caissesTestees}</div>
                </div>
                <div class="info-item-rapports">
                    <div class="info-label-rapports">Tests Actifs</div>
                    <div class="info-value-rapports">${rapports.testsActifs}</div>
                </div>
            </div>
        </div>
    </div>

    <!-- ========== ACTIONS ========== -->
    <div class="actions-section-rapports">
        <div class="actions-header-rapports">
            <h2>🚀 Actions</h2>
        </div>
        <div class="actions-grid-rapports">
            <button onclick="window.print()" class="action-button-rapports print">
                <span>🖨️</span>
                <span>Imprimer le Rapport</span>
            </button>

            <a href="/dashboard" class="action-button-rapports primary">
                <span>🏠</span>
                <span>Retour au Dashboard</span>
            </a>

            <a href="/rapports/hebdomadaire/pdf" class="action-button-rapports secondary">
                <span>📄</span>
                <span>Télécharger PDF</span>
            </a>
        </div>
    </div>

    <!-- ========== BOUTON RETOUR ========== -->
    <a href="/dashboard" class="back-button-rapports">
        ← Retour au Dashboard
    </a>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('Rapports page initialisée');

    // Animation des cartes
    const cards = document.querySelectorAll('.stat-card-rapports');
    cards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });

    // Configuration de l'impression
    window.addEventListener('beforeprint', function() {
        document.body.classList.add('printing');
    });

    window.addEventListener('afterprint', function() {
        document.body.classList.remove('printing');
        showNotification('📄 Rapport imprimé avec succès', 'success');
    });
});

// Fonction de notification compatible EL
window.showNotification = function(message, type) {
    // Valeur par défaut
    if (!type) type = 'info';

    // Déterminer l'icône (pas de ===, utiliser ==)
    var icon = 'ℹ️';
    if (type == 'success') icon = '✅';
    if (type == 'error') icon = '❌';
    if (type == 'warning') icon = '⚠️';

    // Créer la notification
    var notification = document.createElement('div');
    notification.className = 'notification ' + type;
    notification.innerHTML = '<span style="font-size: 1.2rem;">' + icon + '</span><span>' + message + '</span>';

    document.body.appendChild(notification);

    // Auto-suppression
    setTimeout(function() {
        if (notification.parentNode) {
            notification.parentNode.removeChild(notification);
        }
    }, 3000);
};

// Fonction de confirmation
window.showConfirmation = function(title, message, callback, danger) {
    if (confirm(title + ': ' + message)) {
        callback();
    }
};
</script>

<jsp:include page="../includes/footer.jsp" />