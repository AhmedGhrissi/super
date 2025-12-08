<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../includes/header.jsp" />
<link rel="stylesheet" href="/css/global-styles.css">
<div class="container">
    <!-- En-tête -->
    <div class="page-header" style="margin-bottom: 2rem;">
        <h1 style="color: #4361ee; margin-bottom: 0.5rem;">
            📊 Détails du Serveur
        </h1>
        <p style="color: #6c757d; font-size: 1.1rem;">
            ${statistiques.serveurNom}
        </p>
    </div>

    <!-- Cartes de statistiques -->
    <div class="stats-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
        <div style="background: linear-gradient(135deg, #4361ee, #3a0ca3); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);">
            <div style="font-size: 2.5rem; margin-bottom: 1rem;">📈</div>
            <div style="font-size: 2rem; font-weight: bold; margin-bottom: 0.5rem;">
                <fmt:formatNumber value="${statistiques.disponibilitePercent}" pattern="0.0"/>%
            </div>
            <div style="font-size: 1rem; opacity: 0.9;">Disponibilité</div>
        </div>

        <div style="background: linear-gradient(135deg, #06d6a0, #04a777); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 15px rgba(6, 214, 160, 0.3);">
            <div style="font-size: 2.5rem; margin-bottom: 1rem;">✅</div>
            <div style="font-size: 2rem; font-weight: bold; margin-bottom: 0.5rem;">
                ${statistiques.testsSucces}
            </div>
            <div style="font-size: 1rem; opacity: 0.9;">Tests Réussis</div>
        </div>

        <div style="background: linear-gradient(135deg, #ef476f, #ff6b6b); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 15px rgba(239, 71, 111, 0.3);">
            <div style="font-size: 2.5rem; margin-bottom: 1rem;">❌</div>
            <div style="font-size: 2rem; font-weight: bold; margin-bottom: 0.5rem;">
                ${statistiques.testsEchec}
            </div>
            <div style="font-size: 1rem; opacity: 0.9;">Tests Échoués</div>
        </div>

        <div style="background: linear-gradient(135deg, #7209b7, #560bad); color: white; padding: 2rem; border-radius: 15px; text-align: center; box-shadow: 0 4px 15px rgba(114, 9, 183, 0.3);">
            <div style="font-size: 2.5rem; margin-bottom: 1rem;">⏱️</div>
            <div style="font-size: 2rem; font-weight: bold; margin-bottom: 0.5rem;">
                ${statistiques.tempsReponseMoyen}ms
            </div>
            <div style="font-size: 1rem; opacity: 0.9;">Temps Réponse</div>
        </div>
    </div>

    <!-- Informations détaillées -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
        <!-- Carte Informations Serveur -->
        <div style="background: white; padding: 2rem; border-radius: 15px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
            <h3 style="color: #4361ee; margin-bottom: 1.5rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                ℹ️ Informations Serveur
            </h3>
            <div style="display: grid; gap: 1rem;">
                <div style="display: flex; justify-content: space-between; border-bottom: 1px solid #f8f9fa; padding: 0.5rem 0;">
                    <span style="font-weight: 600; color: #495057;">Nom:</span>
                    <span style="color: #4361ee; font-weight: 600;">${statistiques.serveurNom}</span>
                </div>
                <div style="display: flex; justify-content: space-between; border-bottom: 1px solid #f8f9fa; padding: 0.5rem 0;">
                    <span style="font-weight: 600; color: #495057;">Type:</span>
                    <span class="badge" style="background: linear-gradient(135deg, #3498db, #2980b9); color: white; padding: 0.25rem 0.75rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;">
                        ${statistiques.typeServeur}
                    </span>
                </div>
                <div style="display: flex; justify-content: space-between; border-bottom: 1px solid #f8f9fa; padding: 0.5rem 0;">
                    <span style="font-weight: 600; color: #495057;">Caisse:</span>
                    <span style="color: #6c757d;">${statistiques.caisseCode}</span>
                </div>
                <div style="display: flex; justify-content: space-between; border-bottom: 1px solid #f8f9fa; padding: 0.5rem 0;">
                    <span style="font-weight: 600; color: #495057;">Dernière mise à jour:</span>
                    <span style="color: #6c757d; font-size: 0.9rem;">
                        <c:set var="dateMaj" value="${statistiques.dateMaj}"/>
                        ${dateMaj.dayOfMonth}/${dateMaj.monthValue}/${dateMaj.year} ${dateMaj.hour}:${dateMaj.minute}
                    </span>
                </div>
            </div>
        </div>

        <!-- Carte Performances -->
        <div style="background: white; padding: 2rem; border-radius: 15px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
            <h3 style="color: #4361ee; margin-bottom: 1.5rem; border-bottom: 2px solid #e9ecef; padding-bottom: 0.5rem;">
                📊 Performances
            </h3>
            <div style="display: grid; gap: 1.5rem;">
                <!-- Barre de disponibilité -->
                <div>
                    <div style="display: flex; justify-content: between; margin-bottom: 0.5rem;">
                        <span style="font-weight: 600; color: #495057;">Disponibilité</span>
                        <span style="font-weight: 600; color: #4361ee;">
                            <fmt:formatNumber value="${statistiques.disponibilitePercent}" pattern="0.0"/>%
                        </span>
                    </div>
                    <div style="height: 10px; background: #e9ecef; border-radius: 5px; overflow: hidden;">
                        <div style="height: 100%; background: linear-gradient(135deg, #06d6a0, #04a777); width: ${statistiques.disponibilitePercent}%;"></div>
                    </div>
                </div>

                <!-- Taux de réussite -->
                <div>
                    <div style="display: flex; justify-content: between; margin-bottom: 0.5rem;">
                        <span style="font-weight: 600; color: #495057;">Taux de réussite</span>
                        <span style="font-weight: 600; color: #4361ee;">
                            <c:if test="${statistiques.testsTotal > 0}">
                                <fmt:formatNumber value="${statistiques.testsSucces * 100.0 / statistiques.testsTotal}" pattern="0.0"/>%
                            </c:if>
                            <c:if test="${statistiques.testsTotal == 0}">N/A</c:if>
                        </span>
                    </div>
                    <div style="height: 10px; background: #e9ecef; border-radius: 5px; overflow: hidden;">
                        <div style="height: 100%; background: linear-gradient(135deg, #4361ee, #3a0ca3); width: ${statistiques.testsTotal > 0 ? (statistiques.testsSucces * 100.0 / statistiques.testsTotal) : 0}%;"></div>
                    </div>
                </div>

                <!-- Total des tests -->
                <div style="text-align: center; padding: 1rem; background: #f8f9fa; border-radius: 10px;">
                    <div style="font-size: 0.9rem; color: #6c757d; margin-bottom: 0.25rem;">Total des tests</div>
                    <div style="font-size: 1.5rem; font-weight: bold; color: #4361ee;">${statistiques.testsTotal}</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Boutons d'action -->
    <div style="display: flex; gap: 1rem; justify-content: center; margin-top: 2rem;">
        <a href="/serveurs-stats" class="btn" style="background: #6c757d; color: white; padding: 0.75rem 1.5rem; border-radius: 25px; text-decoration: none; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
            ↩️ Retour à la liste
        </a>
        <a href="/serveurs-stats/export/${statistiques.serveurNom}" class="btn" style="background: #4361ee; color: white; padding: 0.75rem 1.5rem; border-radius: 25px; text-decoration: none; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
            📄 Exporter PDF
        </a>
    </div>
</div>



<jsp:include page="../includes/footer.jsp" />