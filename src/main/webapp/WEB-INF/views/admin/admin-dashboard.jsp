<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/dashboard-modern.css">

<style>
/* Styles pour le dashboard admin - EXACTEMENT COMME DEBUG-METRICS */
.debug-metrics-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

/* Header moderne - EXACTEMENT COMME DEBUG-METRICS */
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

.period-badge {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    padding: 0.5rem 1.5rem;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 600;
}

/* Cartes de métriques - EXACTEMENT COMME DEBUG-METRICS */
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

.metric-desc-debug {
    font-size: 0.9rem;
    color: #6c757d;
}

/* Sections outils - STYLE SIMILAIRE */
.tools-section-debug {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.tools-header-debug {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.tools-header-debug h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.tools-grid-debug {
    padding: 1.5rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
}

.tool-card-debug {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 1.5rem;
    transition: all 0.3s ease;
    border-left: 4px solid #006747;
}

.tool-card-debug:hover {
    background: #e9ecef;
    transform: translateX(4px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.tool-icon-debug {
    font-size: 2rem;
    margin-bottom: 1rem;
    color: #006747;
}

.tool-title-debug {
    font-size: 1.1rem;
    font-weight: 600;
    color: #343a40;
    margin-bottom: 0.5rem;
}

.tool-description-debug {
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 1rem;
    line-height: 1.5;
}

.tool-link-debug {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    color: #006747;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    padding: 0.5rem 1rem;
    background: rgba(0, 103, 71, 0.1);
    border-radius: 8px;
}

.tool-link-debug:hover {
    color: white;
    background: #006747;
    text-decoration: none;
    transform: translateY(-2px);
}

/* Section navigation rapide */
.nav-section-debug {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 2rem;
}

.nav-header-debug {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.nav-header-debug h2 {
    margin: 0;
    color: #006747;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.nav-grid-debug {
    padding: 1.5rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
}

.nav-card-debug {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    transition: all 0.3s ease;
    border: 2px solid #e9ecef;
    text-decoration: none;
    color: #495057;
    display: flex;
    align-items: center;
    gap: 1rem;
}

.nav-card-debug:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
    border-color: #006747;
    text-decoration: none;
    color: #495057;
}

.nav-icon-debug {
    font-size: 1.5rem;
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #006747, #2e8b57);
    color: white;
    flex-shrink: 0;
}

.nav-info-debug {
    flex: 1;
}

.nav-title-debug {
    font-weight: 600;
    color: #343a40;
    font-size: 1rem;
    margin-bottom: 0.25rem;
}

.nav-description-debug {
    font-size: 0.85rem;
    color: #6c757d;
}

/* Actions - COMME DEBUG-METRICS */
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

.action-button-debug.success {
    background: linear-gradient(135deg, #06d6a0, #118ab2);
}

.action-button-debug .icon {
    font-size: 1.2rem;
}

/* Back button - COMME DEBUG-METRICS */
.back-button-debug {
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

.back-button-debug:hover {
    background: #5a6268;
    transform: translateY(-2px);
    text-decoration: none;
    color: white;
}

/* Responsive - COMME DEBUG-METRICS */
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

    .tools-grid-debug {
        grid-template-columns: 1fr;
    }

    .nav-grid-debug {
        grid-template-columns: 1fr;
    }

    .actions-section-debug {
        grid-template-columns: 1fr;
    }
}

/* Badges - COMME DEBUG-METRICS */
.badge-api {
    background: rgba(67, 97, 238, 0.1);
    color: #4361ee;
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-json {
    background: rgba(255, 193, 7, 0.1);
    color: #ffc107;
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-test {
    background: rgba(40, 167, 69, 0.1);
    color: #28a745;
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}

.badge-status {
    background: rgba(108, 117, 125, 0.1);
    color: #6c757d;
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 600;
    display: inline-block;
}
</style>

<div class="debug-metrics-container">
    <!-- ========== HEADER MODERNE ========== -->
    <div class="debug-header-modern">
        <div class="debug-title-section">
            <div>
                <div class="debug-title">
                    <h1>⚙️ Tableau de Bord Admin</h1>
                </div>
                <p class="debug-subtitle">Outils avancés pour la supervision et la gestion</p>
            </div>
            <div class="period-badge">
                🟢 Système opérationnel
            </div>
        </div>
    </div>

    <!-- ========== CARTES DE MÉTRIQUES ========== -->
    <div class="metrics-grid-debug">
        <!-- Utilisateurs -->
        <div class="metric-card-debug animate-fade-in-up">
            <div class="metric-icon-debug">👥</div>
            <div class="metric-value-debug" style="color: #006747;">${totalUsers}</div>
            <div class="metric-label-debug">Utilisateurs</div>
            <div class="metric-desc-debug">Total</div>
        </div>

        <!-- Monitoring -->
        <div class="metric-card-debug animate-fade-in-up" style="animation-delay: 0.1s;">
            <div class="metric-icon-debug">🖥️</div>
            <div class="metric-value-debug" style="color: #4361ee;">24/7</div>
            <div class="metric-label-debug">Monitoring</div>
            <div class="metric-desc-debug">Actif</div>
        </div>

        <!-- Disponibilité -->
        <div class="metric-card-debug animate-fade-in-up" style="animation-delay: 0.2s;">
            <div class="metric-icon-debug">📊</div>
            <div class="metric-value-debug" style="color: #28a745;">99.8%</div>
            <div class="metric-label-debug">Disponibilité</div>
            <div class="metric-desc-debug">+5%</div>
        </div>

        <!-- Version -->
        <div class="metric-card-debug animate-fade-in-up" style="animation-delay: 0.3s; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white;">
            <div class="metric-icon-debug">🔧</div>
            <div class="metric-value-debug">v1.0.0</div>
            <div class="metric-label-debug">Version</div>
            <div class="metric-desc-debug" style="color: rgba(255,255,255,0.9);">Optimisé</div>
        </div>
    </div>

    <!-- ========== OUTILS MONITORING ========== -->
    <div class="tools-section-debug">
        <div class="tools-header-debug">
            <h2>📊 Monitoring & Métriques</h2>
        </div>
        <div class="tools-grid-debug">
            <!-- Prometheus -->
            <div class="tool-card-debug">
                <div class="tool-icon-debug">📈</div>
                <div class="tool-title-debug">Prometheus Metrics</div>
                <div class="tool-description-debug">
                    Métriques système au format Prometheus pour l'analyse des performances
                </div>
                <a href="/monitoring/prometheus" target="_blank" class="tool-link-debug">
                    <span>Accéder</span>
                    <span class="badge-api">API</span>
                </a>
            </div>

            <!-- API Grafana -->
            <div class="tool-card-debug">
                <div class="tool-icon-debug">🔧</div>
                <div class="tool-title-debug">API Grafana</div>
                <div class="tool-description-debug">
                    Données JSON pour l'intégration avec les dashboards Grafana
                </div>
                <a href="/api/grafana/advanced-metrics" target="_blank" class="tool-link-debug">
                    <span>Accéder</span>
                    <span class="badge-json">JSON</span>
                </a>
            </div>

            <!-- Health Check -->
            <div class="tool-card-debug">
                <div class="tool-icon-debug">❤️</div>
                <div class="tool-title-debug">Health Check</div>
                <div class="tool-description-debug">
                    Vérification de l'état de santé de l'application et des services
                </div>
                <a href="/monitoring/health" target="_blank" class="tool-link-debug">
                    <span>Accéder</span>
                    <span class="badge-status">Status</span>
                </a>
            </div>
        </div>
    </div>

    <!-- ========== OUTILS DÉBOGAGE ========== -->
    <div class="tools-section-debug">
        <div class="tools-header-debug">
            <h2>🔧 Outils de Débogage</h2>
        </div>
        <div class="tools-grid-debug">
            <!-- Générer données -->
            <div class="tool-card-debug">
                <div class="tool-icon-debug">🎯</div>
                <div class="tool-title-debug">Générer Données Test</div>
                <div class="tool-description-debug">
                    Crée des données de test réalistes pour le développement
                </div>
                <a href="/debug/fix-metrics" target="_blank" class="tool-link-debug">
                    <span>Accéder</span>
                    <span class="badge-test">Test</span>
                </a>
            </div>

            <!-- Métriques -->
            <div class="tool-card-debug">
                <div class="tool-icon-debug">📊</div>
                <div class="tool-title-debug">Métriques Actuelles</div>
                <div class="tool-description-debug">
                    Visualisez les métriques système en temps réel
                </div>
                <a href="/debug/current-metrics" target="_blank" class="tool-link-debug">
                    <span>Accéder</span>
                    <span class="badge-api">Metrics</span>
                </a>
            </div>

            <!-- Test API -->
            <div class="tool-card-debug">
                <div class="tool-icon-debug">🧪</div>
                <div class="tool-title-debug">Test API</div>
                <div class="tool-description-debug">
                    Endpoint de test simple pour vérifier la connectivité
                </div>
                <a href="/api/grafana/test" target="_blank" class="tool-link-debug">
                    <span>Accéder</span>
                    <span class="badge-api">API</span>
                </a>
            </div>
        </div>
    </div>

    <!-- ========== NAVIGATION RAPIDE ========== -->
    <div class="nav-section-debug">
        <div class="nav-header-debug">
            <h2>🚀 Navigation Rapide</h2>
        </div>
        <div class="nav-grid-debug">
            <!-- Dashboard -->
            <a href="/dashboard" class="nav-card-debug">
                <div class="nav-icon-debug">📊</div>
                <div class="nav-info-debug">
                    <div class="nav-title-debug">Dashboard Principal</div>
                    <div class="nav-description-debug">Vue d'ensemble du système</div>
                </div>
            </a>

            <!-- Tests -->
            <a href="/tests" class="nav-card-debug">
                <div class="nav-icon-debug" style="background: linear-gradient(135deg, #4361ee, #3a0ca3);">🧪</div>
                <div class="nav-info-debug">
                    <div class="nav-title-debug">Gérer les Tests</div>
                    <div class="nav-description-debug">Supervision et exécution</div>
                </div>
            </a>

            <!-- Caisses -->
            <a href="/caisses" class="nav-card-debug">
                <div class="nav-icon-debug" style="background: linear-gradient(135deg, #06d6a0, #118ab2);">🏦</div>
                <div class="nav-info-debug">
                    <div class="nav-title-debug">Gérer les Caisses</div>
                    <div class="nav-description-debug">Configuration des caisses</div>
                </div>
            </a>

            <!-- Rapports -->
            <a href="/rapports" class="nav-card-debug">
                <div class="nav-icon-debug" style="background: linear-gradient(135deg, #ff9e00, #ff6b6b);">📈</div>
                <div class="nav-info-debug">
                    <div class="nav-title-debug">Voir les Rapports</div>
                    <div class="nav-description-debug">Analyse et statistiques</div>
                </div>
            </a>

            <!-- Journal Audit -->
            <a href="/api/audit/view" class="nav-card-debug">
                <div class="nav-icon-debug" style="background: linear-gradient(135deg, #6c757d, #495057);">📋</div>
                <div class="nav-info-debug">
                    <div class="nav-title-debug">Journal d'Audit</div>
                    <div class="nav-description-debug">Historique des actions</div>
                </div>
            </a>

            <!-- Gestion Utilisateurs -->
            <a href="/admin/users" class="nav-card-debug">
                <div class="nav-icon-debug" style="background: linear-gradient(135deg, #e83e8c, #d0006f);">👥</div>
                <div class="nav-info-debug">
                    <div class="nav-title-debug">Gestion Utilisateurs</div>
                    <div class="nav-description-debug">Comptes et permissions</div>
                </div>
            </a>
        </div>
    </div>

    <!-- ========== ACTIONS ========== -->
    <div class="actions-section-debug">
        <a href="/admin/download-documentation" class="action-button-debug">
            <span class="icon">📄</span>
            <span>Télécharger Guide</span>
        </a>

        <a href="/admin/download-dashboards" class="action-button-debug secondary">
            <span class="icon">📊</span>
            <span>Dashboards Grafana</span>
        </a>

        <a href="/monitoring/info" target="_blank" class="action-button-debug success">
            <span class="icon">ℹ️</span>
            <span>Informations Techniques</span>
        </a>
    </div>

    <!-- ========== BOUTON RETOUR ========== -->
    <a href="/dashboard" class="back-button-debug">
        ← Retour au Dashboard
    </a>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('Dashboard admin initialisé');

    // Animation des cartes
    const cards = document.querySelectorAll('.metric-card-debug');
    cards.forEach((card, index) => {
        card.style.animationDelay = (index * 0.1) + 's';
    });
});
</script>

<jsp:include page="../includes/footer.jsp" />