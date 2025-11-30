<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="includes/header.jsp" %>

<%
// Gestion des valeurs nulles côté serveur
java.util.Map<String, Object> defaultValues = new java.util.HashMap<>();
defaultValues.put("totalServeurs", 0);
defaultValues.put("totalMAJ", 0);
defaultValues.put("totalTests", 0);
defaultValues.put("serveursActifs", 0);
defaultValues.put("majPlanifiees", 0);
defaultValues.put("activeTests", 0);
defaultValues.put("tauxDisponibilite", 0);
defaultValues.put("derniereMaj", "N/A");
defaultValues.put("majCetteSemaine", 0);
defaultValues.put("serveursActifsList", new java.util.ArrayList<>());
defaultValues.put("prochainesMAJ", new java.util.ArrayList<>());

for (java.util.Map.Entry<String, Object> entry : defaultValues.entrySet()) {
    if (request.getAttribute(entry.getKey()) == null) {
        request.setAttribute(entry.getKey(), entry.getValue());
    }
}
%>

<div class="dashboard">
   <!-- En-tête -->
   <div class="page-header">
      <h2>📊 Tableau de Bord de Supervision</h2>
      <div class="header-actions">
         <span class="update-badge">🟢 Système opérationnel</span>
      </div>
   </div>

   <!-- Messages de succès/erreur -->
   <c:if test="${not empty success}">
      <div class="alert alert-success">
         <strong>✅ Succès:</strong> ${success}
      </div>
   </c:if>

   <c:if test="${not empty error}">
      <div class="alert alert-error">
         <strong>❌ Erreur:</strong> ${error}
      </div>
   </c:if>

   <!-- Indicateur de statut -->
   <div style="background: linear-gradient(135deg, #4cc9f0, #4361ee); color: white; padding: 1rem; border-radius: 10px; margin-bottom: 1rem;">
      <div style="display: flex; justify-content: space-between; align-items: center;">
         <div>
            <strong>📊 Vue d'ensemble</strong>
            <div style="font-size: 0.9rem; opacity: 0.9;">
               ${totalServeurs} serveurs • ${totalMAJ} mises à jour • ${totalTests} tests
            </div>
         </div>
         <div style="font-size: 0.8rem; background: rgba(255,255,255,0.2); padding: 0.25rem 0.75rem; border-radius: 15px;">
            🟢 Système opérationnel
         </div>
      </div>
   </div>

   <!-- Section Actions Rapides -->
   <div style="background: rgba(255, 255, 255, 0.1); padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem; border: 1px solid rgba(255, 255, 255, 0.2);">
      <h3 style="color: white; margin-bottom: 1.5rem; text-align: center;">🚀 Actions Rapides</h3>

      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; align-items: start;">

         <!-- Lancer Tous les Tests -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <button type="button" onclick="lancerTousTests()"
                    style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center;"
                    onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
                    onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">🎯</span>
               <span>Lancer Tous les Tests</span>
            </button>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Exécute tous les tests actifs
            </div>
         </div>

         <!-- Tests par Catégorie -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <div style="display: flex; flex-direction: column; gap: 0.75rem;">
               <select id="categorieSelect"
                       style="padding: 0.75rem; border: 1px solid #ddd; border-radius: 8px; background: white; width: 100%; font-size: 0.9rem; cursor: pointer;">
                  <option value="">Choisir une catégorie</option>
                  <option value="conformite">Conformité</option>
                  <option value="processus_metier">Processus Métier</option>
                  <option value="surveillance">Surveillance</option>
                  <option value="ged">GED</option>
                  <option value="integration">Intégration</option>
                  <option value="web">Applications Web</option>
               </select>
               <button type="button" onclick="lancerTestsCategorieDashboard()"
                       style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #7209b7, #3a0ca3); color: white; border: none; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; width: 100%; justify-content: center;"
                       onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
                       onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                  <span style="font-size: 1.2rem;">📁</span>
                  <span>Tests par Catégorie</span>
               </button>
            </div>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Tests ciblés par catégorie
            </div>
         </div>

         <!-- Planifier MAJ -->
         <div style="display: flex; flex-direction: column; gap: 0.5rem;">
            <a href="/mises-a-jour/create"
               style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem 1.5rem; background: linear-gradient(135deg, #ff9e00, #ff6b6b); color: white; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease; width: 100%; justify-content: center;"
               onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.2)';"
               onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
               <span style="font-size: 1.2rem;">📅</span>
               <span>Planifier MAJ</span>
            </a>
            <div style="font-size: 0.8rem; color: rgba(255,255,255,0.8); text-align: center;">
               Nouvelle mise à jour
            </div>
         </div>

      </div>

      <!-- Indicateur Temps Réel -->
      <div style="text-align: center; margin-top: 1rem; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.2);">
         <div style="display: inline-flex; align-items: center; gap: 0.5rem; background: rgba(255,255,255,0.2); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.9rem;">
            <span>🔄</span>
            <span>Données temps réel</span>
            <span style="font-weight: bold;">•</span>
            <span>MAJ: ${derniereMaj}</span>
         </div>
      </div>
   </div>

   <!-- Cartes de statistiques -->
   <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
      <!-- Serveurs -->
      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">🖥️</div>
         <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;">${totalServeurs}</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Serveurs</div>
         <div style="font-size: 0.9rem; color: #6c757d;">${serveursActifs} actifs</div>
         <a href="/serveurs" style="display: inline-block; margin-top: 1rem; color: #4361ee; text-decoration: none; font-weight: 600; font-size: 0.9rem;">
            Voir les serveurs →
         </a>
      </div>

      <!-- Mises à Jour -->
      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">🔄</div>
         <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;">${totalMAJ}</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Mises à Jour</div>
         <div style="font-size: 0.9rem; color: #6c757d;">${majPlanifiees} planifiées</div>
         <a href="/mises-a-jour" style="display: inline-block; margin-top: 1rem; color: #4361ee; text-decoration: none; font-weight: 600; font-size: 0.9rem;">
            Voir le planning →
         </a>
      </div>

      <!-- Tests -->
      <div style="background: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">🧪</div>
         <div style="font-size: 3rem; font-weight: bold; color: #4361ee; margin-bottom: 0.5rem;">${totalTests}</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: #495057; margin-bottom: 0.25rem;">Tests</div>
         <div style="font-size: 0.9rem; color: #6c757d;">${activeTests} actifs</div>
         <a href="/tests" style="display: inline-block; margin-top: 1rem; color: #4361ee; text-decoration: none; font-weight: 600; font-size: 0.9rem;">
            Voir les tests →
         </a>
      </div>

      <!-- Disponibilité -->
      <div style="background: linear-gradient(135deg, #06d6a0, #118ab2); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
         <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">📈</div>
         <div style="font-size: 3rem; font-weight: bold; color: white; margin-bottom: 0.5rem;">${tauxDisponibilite}%</div>
         <div style="font-size: 1.2rem; font-weight: 600; color: white; margin-bottom: 0.25rem;">Disponibilité</div>
         <div style="font-size: 0.9rem; opacity: 0.9; color: white;">Global</div>
      </div>
   </div>

   <!-- Navigation rapide -->
   <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
      <a href="/serveurs" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #4361ee, #3a0ca3);">
         <span style="font-size: 1.5rem;">🖥️</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Gérer les Serveurs</span>
         <span style="background: rgba(255,255,255,0.2); padding: 0.5rem 1rem; border-radius: 20px; font-weight: bold; font-size: 0.9rem;">${totalServeurs}</span>
      </a>

      <a href="/mises-a-jour" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #7209b7, #560bad);">
         <span style="font-size: 1.5rem;">🔄</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Mises à Jour</span>
         <span style="background: rgba(255,255,255,0.2); padding: 0.5rem 1rem; border-radius: 20px; font-weight: bold; font-size: 0.9rem;">${totalMAJ}</span>
      </a>

      <a href="/tests" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #06d6a0, #118ab2);">
         <span style="font-size: 1.5rem;">🧪</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Gérer les Tests</span>
         <span style="background: rgba(255,255,255,0.2); padding: 0.5rem 1rem; border-radius: 20px; font-weight: bold; font-size: 0.9rem;">${totalTests}</span>
      </a>

      <a href="/rapports" style="display: flex; align-items: center; gap: 0.75rem; padding: 1.5rem; color: white; text-decoration: none; border-radius: 12px; transition: all 0.3s ease; background: linear-gradient(135deg, #ff9e00, #ff6b6b);">
         <span style="font-size: 1.5rem;">📈</span>
         <span style="flex: 1; font-weight: 600; font-size: 1.1rem;">Voir Rapports</span>
         <span style="background: rgba(255,255,255,0.2); padding: 0.5rem 1rem; border-radius: 20px; font-weight: bold; font-size: 0.9rem;">📊</span>
      </a>
   </div>

   <!-- Grille de contenu détaillé -->
   <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
      <!-- Serveurs Actifs -->
      <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden;">
         <div style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
            <h3 style="margin: 0; color: #4361ee; font-size: 1.3rem;">🖥️ Serveurs Actifs</h3>
            <span style="background: #4361ee; color: white; padding: 0.5rem 1rem; border-radius: 15px; font-size: 0.9rem; font-weight: 600;">${serveursActifs}/${totalServeurs}</span>
         </div>
         <div style="padding: 1rem; max-height: 400px; overflow-y: auto;">
            <c:choose>
               <c:when test="${not empty serveursActifsList}">
                  <c:forEach var="serveur" items="${serveursActifsList}" end="5">
                     <div style="display: flex; justify-content: space-between; align-items: flex-start; padding: 1rem; margin-bottom: 0.75rem; background: #f8f9fa; border-radius: 10px; border-left: 4px solid #4361ee; transition: background-color 0.2s ease;">
                        <div style="flex: 1;">
                           <strong style="color: #4361ee; display: block; font-weight: 600; font-size: 1rem; margin-bottom: 0.25rem;">${serveur.nom}</strong>
                           <span style="color: #495057; font-size: 0.9rem; display: block; margin-bottom: 0.5rem;">${serveur.adresseIP}</span>
                           <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                              <span style="background: #e9ecef; color: #495057; padding: 0.3rem 0.6rem; border-radius: 8px; font-size: 0.75rem; font-weight: 600;">${serveur.typeServeur}</span>
                              <span style="background: #e9ecef; color: #495057; padding: 0.3rem 0.6rem; border-radius: 8px; font-size: 0.75rem; font-weight: 600;">${serveur.environnement}</span>
                           </div>
                        </div>
                        <a href="/serveurs/view/${serveur.id}" style="background: #4361ee; color: white; padding: 0.5rem 0.75rem; border-radius: 12px; font-size: 0.8rem; font-weight: 600; text-decoration: none; border: 1px solid #4361ee;">Détails</a>
                     </div>
                  </c:forEach>
                  <c:if test="${serveursActifsList.size() > 6}">
                     <div style="text-align: center; margin-top: 1rem;">
                        <a href="/serveurs" style="color: #4361ee; text-decoration: none; font-weight: 600;">
                           Voir les ${serveursActifsList.size() - 6} autres serveurs →
                        </a>
                     </div>
                  </c:if>
               </c:when>
               <c:otherwise>
                  <div style="text-align: center; padding: 3rem 2rem; color: #6c757d;">
                     <div style="font-size: 4rem; margin-bottom: 1rem; opacity: 0.5;">🖥️</div>
                     <h4 style="margin-bottom: 0.5rem; color: #495057;">Aucun serveur actif</h4>
                     <p style="margin-bottom: 1.5rem; color: #8d99ae;">Tous les serveurs sont inactifs ou aucun serveur n'existe</p>
                     <a href="/serveurs/create" style="display: inline-block; padding: 0.75rem 1.5rem; background: #4361ee; color: white; text-decoration: none; border-radius: 25px; font-weight: 600; transition: all 0.3s ease;">Créer un serveur</a>
                  </div>
               </c:otherwise>
            </c:choose>
         </div>
      </div>

      <!-- Prochaines Mises à Jour -->
      <div style="background: white; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden;">
         <div style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; background: #f8f9fa; border-bottom: 1px solid #e9ecef;">
            <h3 style="margin: 0; color: #4361ee; font-size: 1.3rem;">📅 Prochaines MAJ</h3>
            <span style="background: #4361ee; color: white; padding: 0.5rem 1rem; border-radius: 15px; font-size: 0.9rem; font-weight: 600;">${majCetteSemaine}</span>
         </div>
         <div style="padding: 1rem; max-height: 400px; overflow-y: auto;">
            <c:choose>
               <c:when test="${not empty prochainesMAJ}">
                  <c:forEach var="maj" items="${prochainesMAJ}" end="5">
                     <div style="display: flex; justify-content: space-between; align-items: flex-start; padding: 1rem; margin-bottom: 0.75rem; background: #f8f9fa; border-radius: 10px; border-left: 4px solid #06d6a0; transition: background-color 0.2s ease;">
                        <div style="flex: 1;">
                           <strong style="color: #4361ee; display: block; font-weight: 600; font-size: 1rem; margin-bottom: 0.25rem;">${maj.description}</strong>
                           <span style="color: #495057; font-size: 0.9rem; display: block; margin-bottom: 0.5rem;">
                              <c:if test="${maj.serveur != null}">
                                 ${maj.serveur.nom} •
                              </c:if>
                              ${maj.typeMiseAJour}
                           </span>
                           <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
							<span style="background: #e9ecef; color: #495057; padding: 0.3rem 0.6rem; border-radius: 8px; font-size: 0.75rem; font-weight: 600;">
							    📅 ${maj.dateApplication}
							</span>
                              <span style="background: #e9ecef; color: #495057; padding: 0.3rem 0.6rem; border-radius: 8px; font-size: 0.75rem; font-weight: 600;">
                                 ${maj.statut}
                              </span>
                           </div>
                        </div>
                        <a href="/mises-a-jour" style="background: #06d6a0; color: white; padding: 0.5rem 0.75rem; border-radius: 12px; font-size: 0.8rem; font-weight: 600; text-decoration: none; border: 1px solid #06d6a0;">Voir</a>
                     </div>
                  </c:forEach>
                  <c:if test="${prochainesMAJ.size() > 6}">
                     <div style="text-align: center; margin-top: 1rem;">
                        <a href="/mises-a-jour" style="color: #4361ee; text-decoration: none; font-weight: 600;">
                           Voir les ${prochainesMAJ.size() - 6} autres MAJ →
                        </a>
                     </div>
                  </c:if>
               </c:when>
               <c:otherwise>
                  <div style="text-align: center; padding: 3rem 2rem; color: #6c757d;">
                     <div style="font-size: 4rem; margin-bottom: 1rem; opacity: 0.5;">📅</div>
                     <h4 style="margin-bottom: 0.5rem; color: #495057;">Aucune MAJ planifiée</h4>
                     <p style="margin-bottom: 1.5rem; color: #8d99ae;">Aucune mise à jour n'est planifiée pour le moment</p>
                     <a href="/mises-a-jour/create" style="display: inline-block; padding: 0.75rem 1.5rem; background: #4361ee; color: white; text-decoration: none; border-radius: 25px; font-weight: 600; transition: all 0.3s ease;">Planifier une MAJ</a>
                  </div>
               </c:otherwise>
            </c:choose>
         </div>
      </div>
   </div>

   <!-- Popup personnalisé pour le dashboard -->
   <div id="dashboardPopup" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 10000; justify-content: center; align-items: center;">
      <div style="background: white; padding: 2rem; border-radius: 15px; max-width: 500px; width: 90%; box-shadow: 0 10px 30px rgba(0,0,0,0.3);">
         <h3 id="dashboardPopupTitle" style="margin: 0 0 1rem 0; color: #4361ee; font-size: 1.5rem;"></h3>
         <div id="dashboardPopupMessage" style="margin-bottom: 2rem; color: #495057; line-height: 1.5;"></div>
         <div style="display: flex; gap: 1rem; justify-content: flex-end;">
            <button type="button" onclick="fermerDashboardPopup(false)"
                    style="padding: 0.75rem 1.5rem; background: #6c757d; color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;">
                Annuler
            </button>
            <button type="button" onclick="fermerDashboardPopup(true)"
                    style="padding: 0.75rem 1.5rem; background: #4361ee; color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;">
                Confirmer
            </button>
         </div>
      </div>
   </div>
</div>

<script>
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
 * 📁 Lancement des tests par catégorie - VERSION DASHBOARD CORRIGÉE
 */
async function lancerTestsCategorieDashboard() {
    const select = document.getElementById('categorieSelect');
    const categorie = select.value;

    if (!categorie) {
        showNotification('Veuillez sélectionner une catégorie', 'warning');
        return;
    }

    // Récupérer le texte de l'option sélectionnée directement
    const nomCategorie = select.options[select.selectedIndex].text;

    // Utiliser la fonction showDashboardPopup au lieu de showPopup
    const confirmed = await showDashboardPopup(
        'Lancer les tests',
        'Voulez-vous lancer l\'exécution des tests de la catégorie <strong>"' + nomCategorie + '"</strong> ?'
    );

    if (confirmed) {
        showNotification('🔄 Lancement des tests ' + nomCategorie + '...', 'info');

        try {
            const response = await fetch('/tests/lancer-categorie/' + encodeURIComponent(categorie), {
                method: 'POST'
            });

            if (response.ok) {
                showNotification('✅ Tests ' + nomCategorie + ' lancés avec succès !', 'success');
                setTimeout(() => location.reload(), 3000);
            } else {
                showNotification('❌ Erreur lors du lancement des tests', 'error');
            }
        } catch (error) {
            console.error('Erreur:', error);
            showNotification('❌ Erreur réseau lors du lancement', 'error');
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
                        showNotification('✅ Tests lancés avec succès !', 'success');
                        setTimeout(() => location.reload(), 2000);
                    } else {
                        showNotification('❌ Erreur lors du lancement', 'error');
                    }
                } catch (error) {
                    showNotification('❌ Erreur réseau', 'error');
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
                    showNotification('✅ Tests lancés avec succès !', 'success');
                    setTimeout(() => location.reload(), 2000);
                } else {
                    showNotification('❌ Erreur lors du lancement', 'error');
                }
            } catch (error) {
                showNotification('❌ Erreur réseau', 'error');
            }
        }
    }
}

// Gestion des événements de clic en dehors du popup
document.addEventListener('DOMContentLoaded', function() {
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
});
</script>

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

/* Scrollbar personnalisée */
div[style*="overflow-y: auto"]::-webkit-scrollbar {
   width: 6px;
}

div[style*="overflow-y: auto"]::-webkit-scrollbar-track {
   background: #f1f1f1;
   border-radius: 3px;
}

div[style*="overflow-y: auto"]::-webkit-scrollbar-thumb {
   background: #c1c1c1;
   border-radius: 3px;
}

div[style*="overflow-y: auto"]::-webkit-scrollbar-thumb:hover {
   background: #a8a8a8;
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

<%@ include file="includes/footer.jsp" %>