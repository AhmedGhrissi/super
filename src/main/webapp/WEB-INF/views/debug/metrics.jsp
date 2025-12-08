<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles pour la page debug métriques */
.debug-metrics-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne */
.debug-header-modern {
    background: linear-gradient(135deg, #006747, #2e8b57);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: white;
    box-shadow: 0 8px 24px rgba(0, 103, 71, 0.2);
}

.debug-title-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.debug-title {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.debug-title h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
}

.debug-subtitle {
    font-size: 1rem;
    opacity: 0.9;
    margin: 0.5rem 0 0 0;
}

/* Cartes de métriques */
.metrics-grid-debug {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.metric-card-debug {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    text-align: center;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    transition: transform 0.3s ease;
}

.metric-card-debug:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}

.metric-icon-debug {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.metric-value-debug {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.metric-label-debug {
    font-size: 1.2rem;
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
}

/* Détails techniques */
.details-section-debug {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.details-header-debug {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.details-header-debug h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.details-grid-debug {
    padding: 1.5rem;
}

.metrics-details-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
}

.metric-item-debug {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 10px;
    border-left: 4px solid #006747;
}

.metric-key-debug {
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
    text-transform: capitalize;
    font-size: 0.9rem;
}

.metric-val-debug {
    font-size: 1.5rem;
    font-weight: bold;
    color: #006747;
}

/* Actions */
.actions-section-debug {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.action-button-debug {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    text-decoration: none;
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
    justify-content: center;
    border: none;
    cursor: pointer;
    width: 100%;
}

.action-button-debug:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.2);
    text-decoration: none;
    color: white;
}

.action-button-debug.secondary {
    background: linear-gradient(135deg, #4361ee, #3a0ca3);
}

.action-button-debug.tertiary {
    background: linear-gradient(135deg, #ff9e00, #ff6b6b);
}

.action-button-debug .icon {
    font-size: 1.2rem;
}

/* Responsive */
@media (max-width: 768px) {
    .debug-metrics-container {
        padding: 1rem;
    }

    .debug-title-section {
        flex-direction: column;
    }

    .metrics-grid-debug {
        grid-template-columns: 1fr;
    }

    .metrics-details-grid {
        grid-template-columns: 1fr;
    }

    .actions-section-debug {
        grid-template-columns: 1fr;
    }
}
</style>

<div class="debug-metrics-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="debug-header-modern">
        <div class="debug-title-section">
            <div>
                <div class="debug-title">
                    <h1>${title}</h1>
                </div>
                <p class="debug-subtitle">Métriques système en temps réel pour débogage</p>
            </div>
            <div style="background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1.5rem; border-radius: 20px; font-size: 0.9rem; font-weight: 600;">
                📊 Métriques temps réel
            </div>
        </div>
    </div>

    <!-- ========== CARTES DE MÉTRIQUES ========== -->
    <div class="metrics-grid-debug">
        <!-- Tests exécutés -->
        <div class="metric-card-debug animate-fade-in-up">
            <div class="metric-icon-debug">🎯</div>
            <div class="metric-value-debug" style="color: #006747;">${metrics.tests_executes}</div>
            <div class="metric-label-debug">Tests Exécutés</div>
            <div class="metric-desc-debug" style="color: #6c757d; font-size: 0.9rem;">
                Total des tests effectués
            </div>
        </div>

        <!-- Tests réussis -->
        <div class="metric-card-debug animate-fade-in-up" style="animation-delay: 0.1s;">
            <div class="metric-icon-debug">✅</div>
            <div class="metric-value-debug" style="color: #28a745;">${metrics.tests_reussis}</div>
            <div class="metric-label-debug">Tests Réussis</div>
            <div class="metric-desc-debug" style="color: #6c757d; font-size: 0.9rem;">
                Tests ayant réussi
            </div>
        </div>

        <!-- Tests échoués -->
        <div class="metric-card-debug animate-fade-in-up" style="animation-delay: 0.2s;">
            <div class="metric-icon-debug">❌</div>
            <div class="metric-value-debug" style="color: #ef476f;">${metrics.tests_echoues}</div>
            <div class="metric-label-debug">Tests Échoués</div>
            <div class="metric-desc-debug" style="color: #6c757d; font-size: 0.9rem;">
                Tests ayant échoué
            </div>
        </div>

        <!-- Taux de réussite -->
        <div class="metric-card-debug animate-fade-in-up" style="animation-delay: 0.3s; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white;">
            <div class="metric-icon-debug">📈</div>
            <div class="metric-value-debug">${metrics.taux_reussite}%</div>
            <div class="metric-label-debug">Taux Réussite</div>
            <div class="metric-desc-debug" style="color: rgba(255,255,255,0.9); font-size: 0.9rem;">
                Pourcentage de succès global
            </div>
        </div>
    </div>

    <!-- ========== DÉTAILS TECHNIQUES ========== -->
    <div class="details-section-debug">
        <div class="details-header-debug">
            <h2>🔍 Détails des Métriques</h2>
        </div>
        <div class="details-grid-debug">
            <div class="metrics-details-grid">
                <c:forEach var="metric" items="${metrics}">
                    <div class="metric-item-debug">
                        <div class="metric-key-debug">${metric.key}</div>
                        <div class="metric-val-debug">${metric.value}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- ========== ACTIONS ========== -->
    <div class="actions-section-debug">
        <a href="/admin/admin-dashboard" class="action-button-debug">
            <span class="icon">⚙️</span>
            <span>Dashboard Admin</span>
        </a>

        <a href="/debug/fix-metrics" class="action-button-debug secondary">
            <span class="icon">🎯</span>
            <span>Générer Données</span>
        </a>

        <a href="/debug/reset-metrics" class="action-button-debug tertiary">
            <span class="icon">🔄</span>
            <span>Réinitialiser</span>
        </a>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('Debug metrics page initialisée');

    // Animation des cartes
    const cards = document.querySelectorAll('.metric-card-debug');
    cards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
});
</script>

<jsp:include page="../includes/footer.jsp" />