<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../includes/header.jsp" %>

<div class="dashboard">
   <!-- En-tête -->
   <div class="page-header">
      <h2>${title}</h2>
      <div class="header-actions">
         <span class="update-badge">🟢 Opération réussie</span>
      </div>
   </div>

   <!-- Carte de résultat -->
   <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 2rem;">
      <div style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white;">
         <h3 style="margin: 0; font-size: 1.5rem;">✅ ${title}</h3>
         <span style="background: rgba(255,255,255,0.2); padding: 0.5rem 1rem; border-radius: 15px; font-size: 0.9rem; font-weight: 600;">Succès</span>
      </div>
      <div style="padding: 2rem;">
         <div style="text-align: center; margin-bottom: 2rem;">
            <div style="font-size: 4rem; margin-bottom: 1rem;">🎯</div>
            <h4 style="color: #4361ee; margin-bottom: 1rem; font-size: 1.3rem;">${message}</h4>
         </div>

         <c:if test="${not empty details}">
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; margin-bottom: 2rem;">
               <h5 style="color: #495057; margin-bottom: 1rem; font-size: 1.1rem;">📊 Détails de l'opération</h5>
               <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                  <c:forEach var="detail" items="${details}">
                     <div style="text-align: center;">
                        <div style="font-size: 2rem; font-weight: bold; color: #4361ee;">${detail.value}</div>
                        <div style="color: #6c757d; font-size: 0.9rem; text-transform: capitalize;">${detail.key}</div>
                     </div>
                  </c:forEach>
               </div>
            </div>
         </c:if>

         <!-- Actions -->
         <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
            <a href="/admin/admin-dashboard"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; justify-content: center;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span>⚙️</span>
               <span>Dashboard Admin</span>
            </a>

            <a href="/api/grafana/advanced-metrics" target="_blank"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #7209b7, #560bad); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; justify-content: center;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span>📊</span>
               <span>Voir Métriques</span>
            </a>

            <a href="/debug/current-metrics"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; justify-content: center;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span>🔍</span>
               <span>Métriques Actuelles</span>
            </a>
         </div>
      </div>
   </div>
</div>

<%@ include file="../includes/footer.jsp" %>