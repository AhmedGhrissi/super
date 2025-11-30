<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
   <!-- En-tête -->
   <div class="page-header">
      <h2>${title}</h2>
      <div class="header-actions">
         <span class="update-badge">📊 Métriques temps réel</span>
      </div>
   </div>

   <!-- Cartes de métriques -->
   <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">🎯</div>
         <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;">${metrics.tests_executes}</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Tests Exécutés</div>
      </div>

      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">✅</div>
         <div style="font-size: 3rem; font-weight: bold; color: #06d6a0; margin-bottom: 0.5rem;">${metrics.tests_reussis}</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Tests Réussis</div>
      </div>

      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">❌</div>
         <div style="font-size: 3rem; font-weight: bold; color: #ef476f; margin-bottom: 0.5rem;">${metrics.tests_echoues}</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Tests Échoués</div>
      </div>

      <div style="background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📈</div>
         <div style="font-size: 3rem; font-weight: bold; margin-bottom: 0.5rem;">${metrics.taux_reussite}%</div>
         <div style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem;">Taux Réussite</div>
      </div>
   </div>

   <!-- Détails techniques -->
   <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 2rem;">
      <div style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
         <h3 style="margin: 0; color: #4361ee; font-size: 1.3rem;">🔍 Détails des Métriques</h3>
      </div>
      <div style="padding: 1.5rem;">
         <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
            <c:forEach var="metric" items="${metrics}">
               <div style="background: #f8f9fa; padding: 1rem; border-radius: 10px; border-left: 4px solid #4361ee;">
                  <div style="font-weight: 600; color: #4361ee; margin-bottom: 0.5rem; text-transform: capitalize;">${metric.key}</div>
                  <div style="font-size: 1.5rem; font-weight: bold; color: #495057;">${metric.value}</div>
               </div>
            </c:forEach>
         </div>
      </div>
   </div>

   <!-- Actions -->
   <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
      <a href="/admin/admin-dashboard"
         style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; justify-content: center;"
         onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
         onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
         <span>⚙️</span>
         <span>Dashboard Admin</span>
      </a>

      <a href="/debug/fix-metrics"
         style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; justify-content: center;"
         onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
         onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
         <span>🎯</span>
         <span>Générer Données</span>
      </a>

      <a href="/debug/reset-metrics"
         style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; justify-content: center;"
         onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
         onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
         <span>🔄</span>
         <span>Réinitialiser</span>
      </a>
   </div>
</div>

<%@ include file="../includes/footer.jsp" %>