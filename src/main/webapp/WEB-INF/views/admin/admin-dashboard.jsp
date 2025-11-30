<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
   <!-- En-tête -->
   <div class="page-header">
      <h2>⚙️ Tableau de Bord Admin</h2>
      <div class="header-actions">
         <span class="update-badge">🟢 Système opérationnel</span>
      </div>
   </div>

   <!-- Indicateur de statut -->
   <div style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 1rem;">
      <div style="display: flex; justify-content: space-between; align-items: center;">
         <div>
            <strong>📊 Administration & Monitoring</strong>
            <div style="font-size: 0.9rem; opacity: 0.9;">
               Outils avancés pour la supervision
            </div>
         </div>
         <div style="font-size: 0.8rem; background: rgba(255,255,255,0.2); padding: 0.25rem 0.75rem; border-radius: 15px;">
            🟢 Accès administrateur
         </div>
      </div>
   </div>

   <!-- Section Monitoring & Métriques -->
   <div style="background: rgba(255, 255, 255, 0.1); padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; border: 1px solid rgba(255, 255, 255, 0.2);">
      <h3 style="color: white; margin-bottom: 1.5rem; text-align: center;">📊 Monitoring & Métriques</h3>

      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; align-items: start;">

         <!-- Prometheus Metrics -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/monitoring/prometheus" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">📈</span>
               <span>Prometheus Metrics</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Métriques au format Prometheus
            </div>
         </div>

         <!-- API Grafana -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/api/grafana/advanced-metrics" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">🔧</span>
               <span>API Grafana</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Données JSON pour Grafana
            </div>
         </div>

         <!-- Health Check -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/monitoring/health" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">❤️</span>
               <span>Health Check</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               État de santé de l'application
            </div>
         </div>

      </div>
   </div>

   <!-- Section Outils de Débogage -->
   <div style="background: rgba(255, 255, 255, 0.1); padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; border: 1px solid rgba(255, 255, 255, 0.2);">
      <h3 style="color: white; margin-bottom: 1.5rem; text-align: center;">🔧 Outils de Débogage</h3>

      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; align-items: start;">

         <!-- Générer Données Test -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/debug/fix-metrics" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">🎯</span>
               <span>Générer Données Test</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Crée des données réalistes
            </div>
         </div>

         <!-- Métriques Actuelles -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/debug/current-metrics" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">📊</span>
               <span>Métriques Actuelles</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               État actuel des métriques
            </div>
         </div>

         <!-- Test API -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/api/grafana/test" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">🧪</span>
               <span>Test API</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Endpoint de test simple
            </div>
         </div>
		 <!-- Journal d'Audit -->
		 <div style="display: flex; flex-direction: column; gap: 0.5rem;">
			<!-- Dans votre admin-dashboard.jsp -->
				  <a href="/api/audit/view"
				     style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #7209b7, #3a0ca3);">
				      <span style="font-size: 1.5rem;">📋</span>
				      <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Journal d'Audit</span>
				      <span style="background: rgba(255,255,255,0.2); padding: 0.5rem 1rem; border-radius: 20px; font-weight: bold; font-size: 0.9rem;">Audit</span>
				  </a>
		     <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
		        Historique des actions utilisateurs
		     </div>
		 </div>
		 <!-- Gestion des Utilisateurs -->
		 <div style="display: flex; flex-direction: column; gap: 0.5rem;">
		    <a href="/admin/users"
		       style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #1a936f); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
		       onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
		       onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
		       <span style="font-size: 1.2rem;">👥</span>
		       <span>Gestion Utilisateurs</span>
		    </a>
		    <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
		       Gérer les comptes utilisateurs
		    </div>
		 </div>
      </div>
   </div>

   <!-- Section Documentation -->
   <div style="background: rgba(255, 255, 255, 0.1); padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; border: 1px solid rgba(255, 255, 255, 0.2);">
      <h3 style="color: white; margin-bottom: 1.5rem; text-align: center;">📚 Documentation & Export</h3>

      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; align-items: start;">

         <!-- Guide Complet -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/admin/download-documentation"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">📄</span>
               <span>Guide Complet</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Procédure d'installation
            </div>
         </div>

         <!-- Dashboards Grafana -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/admin/download-dashboards"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">📊</span>
               <span>Dashboards Grafana</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Fichiers JSON à importer
            </div>
         </div>

         <!-- Application Info -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/monitoring/info" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center; text-decoration: none;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">ℹ️</span>
               <span>Application Info</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Informations techniques
            </div>
         </div>

      </div>
   </div>

   <!-- Navigation rapide -->
   <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
      <a href="/dashboard" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #4361ee, #3a0ca3);">
         <span style="font-size: 1.5rem;">📊</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Dashboard Principal</span>
      </a>

      <a href="/tests" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #7209b7, #560bad);">
         <span style="font-size: 1.5rem;">🧪</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Gérer les Tests</span>
      </a>

      <a href="/caisses" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #06d6a0, #118ab2);">
         <span style="font-size: 1.5rem;">🏦</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Gérer les Caisses</span>
      </a>

      <a href="/rapports" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #ff9e00, #ff6b6b);">
         <span style="font-size: 1.5rem;">📈</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Voir les Rapports</span>
      </a>

   </div>

   <!-- Informations techniques -->
   <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 2rem;">
      <div style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
         <h3 style="margin: 0; color: #4361ee; font-size: 1.3rem;">ℹ️ Informations Techniques</h3>
      </div>
      <div style="padding: 1.5rem;">
         <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
            <div>
               <strong style="color: #4361ee; display: block; margin-bottom: 0.5rem;">Application</strong>
               <span style="color: #495057;">Machine Monitor</span>
            </div>
            <div>
               <strong style="color: #4361ee; display: block; margin-bottom: 0.5rem;">Version</strong>
               <span style="color: #495057;">1.0.0</span>
            </div>
            <div>
               <strong style="color: #4361ee; display: block; margin-bottom: 0.5rem;">Port</strong>
               <span style="color: #495057;">8080</span>
            </div>
            <div>
               <strong style="color: #4361ee; display: block; margin-bottom: 0.5rem;">Environnement</strong>
               <span style="color: #495057;">Développement</span>
            </div>
            <div>
               <strong style="color: #4361ee; display: block; margin-bottom: 0.5rem;">Base de données</strong>
               <span style="color: #495057;">MySQL</span>
            </div>
            <div>
               <strong style="color: #4361ee; display: block; margin-bottom: 0.5rem;">Monitoring</strong>
               <span style="color: #495057;">Spring Boot Actuator</span>
            </div>
         </div>
      </div>
   </div>

</div>

<style>
/* Styles de base pour la cohérence */
.dashboard {
   max-width: 1400px;
   margin: 0 auto;
   padding: 20px;
}

.page-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   margin-bottom: 2rem;
}

.update-badge {
   background: rgba(255, 255, 255, 0.2);
   color: white;
   padding: 0.5rem 1rem;
   border-radius: 20px;
   font-size: 0.9rem;
   font-weight: 600;
}

/* Effets de hover */
a:hover {
   transform: translateY(-2px);
   box-shadow: 0 8px 25px rgba(0,0,0,0.2);
   text-decoration: none;
   color: white;
}

/* Responsive */
@media (max-width: 1024px) {
   .dashboard {
      padding: 10px;
   }

   div[style*="grid-template-columns: 1fr 1fr"] {
      grid-template-columns: 1fr;
   }
}

@media (max-width: 768px) {
   .page-header {
      flex-direction: column;
      gap: 1rem;
      text-align: center;
   }

   div[style*="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr))"] {
      grid-template-columns: 1fr;
   }

   div[style*="grid-template-columns: repeat(auto-fit, minmax(300px, 1fr))"] {
      grid-template-columns: 1fr;
   }
}
</style>

<%@ include file="../includes/footer.jsp" %>