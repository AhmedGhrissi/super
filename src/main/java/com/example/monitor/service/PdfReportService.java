package com.example.monitor.service;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.stereotype.Service;

@Service
public class PdfReportService {

	private static final Color PRIMARY_COLOR = new Color(41, 128, 185);
	private static final Color SUCCESS_COLOR = new Color(46, 204, 113);
	private static final Color WARNING_COLOR = new Color(230, 126, 34);
	private static final Color DANGER_COLOR = new Color(231, 76, 60);
	private static final Color LIGHT_GRAY = new Color(245, 245, 245);

	public byte[] generateRapportHebdomadairePdf(Map<String, Object> rapports) throws IOException {
		try (PDDocument document = new PDDocument(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {

			PDPage page = new PDPage(PDRectangle.A4);
			document.addPage(page);

			try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {

				// En-tête du rapport
				drawHeader(contentStream, page);

				// Titre principal
				drawTitle(contentStream, page, "RAPPORT HEBDOMADAIRE DE SUPERVISION");

				// Période et informations
				drawPeriod(contentStream, page, rapports.get("periode").toString());
				drawGenerationInfo(contentStream, page);

				// Indicateurs de performance
				drawPerformanceIndicators(contentStream, page, rapports);

				// Statistiques détaillées
				drawDetailedStatistics(contentStream, page, rapports);

				// Graphiques simulés (tableaux)
				drawPerformanceCharts(contentStream, page, rapports);

				// Pied de page
				drawFooter(contentStream, page);
			}

			document.save(out);
			return out.toByteArray();
		}
	}

	private void drawHeader(PDPageContentStream contentStream, PDPage page) throws IOException {
		// Fond de l'en-tête
		contentStream.setNonStrokingColor(PRIMARY_COLOR);
		contentStream.addRect(0, page.getMediaBox().getHeight() - 80, page.getMediaBox().getWidth(), 80);
		contentStream.fill();

		// Logo/Titre
		contentStream.setNonStrokingColor(Color.WHITE);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_BOLD, 18);
		contentStream.newLineAtOffset(50, page.getMediaBox().getHeight() - 45);
		contentStream.showText("MACHINE MONITOR");
		contentStream.endText();

		// Sous-titre
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA, 12);
		contentStream.newLineAtOffset(50, page.getMediaBox().getHeight() - 65);
		contentStream.showText("Rapport de Supervision Automatisée");
		contentStream.endText();
	}

	private void drawTitle(PDPageContentStream contentStream, PDPage page, String title) throws IOException {
		contentStream.setNonStrokingColor(Color.BLACK);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_BOLD, 16);
		contentStream.newLineAtOffset(50, page.getMediaBox().getHeight() - 120);
		contentStream.showText(title);
		contentStream.endText();
	}

	private void drawPeriod(PDPageContentStream contentStream, PDPage page, String periode) throws IOException {
		contentStream.setNonStrokingColor(Color.DARK_GRAY);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA, 10);
		contentStream.newLineAtOffset(50, page.getMediaBox().getHeight() - 140);
		contentStream.showText("PÉRIODE : " + periode);
		contentStream.endText();
	}

	private void drawGenerationInfo(PDPageContentStream contentStream, PDPage page) throws IOException {
		String generationTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy à HH:mm"));

		contentStream.setNonStrokingColor(Color.GRAY);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA, 8);
		contentStream.newLineAtOffset(page.getMediaBox().getWidth() - 200, page.getMediaBox().getHeight() - 140);
		contentStream.showText("Généré le " + generationTime);
		contentStream.endText();
	}

	private void drawPerformanceIndicators(PDPageContentStream contentStream, PDPage page, Map<String, Object> rapports)
			throws IOException {
		float y = page.getMediaBox().getHeight() - 180;

		// Titre section
		contentStream.setNonStrokingColor(Color.BLACK);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
		contentStream.newLineAtOffset(50, y);
		contentStream.showText("INDICATEURS DE PERFORMANCE");
		contentStream.endText();

		y -= 30;

		// Récupération des indicateurs
		Map<String, Object> performanceIndicators = (Map<String, Object>) rapports.get("performanceIndicators");
		if (performanceIndicators == null) {
			return;
		}

		// Indicateurs sous forme de "cartes"
		float cardWidth = 150;
		float cardHeight = 60;
		float x = 50;

		// Disponibilité
		drawIndicatorCard(contentStream, x, y, cardWidth, cardHeight, "Disponibilité",
				performanceIndicators.get("disponibilite") + "%",
				getStatusColor((String) performanceIndicators.get("statutGlobal")),
				"Statut: " + performanceIndicators.get("statutGlobal"));

		// Taux de réussite
		x += cardWidth + 20;
		drawIndicatorCard(contentStream, x, y, cardWidth, cardHeight, "Taux Réussite",
				performanceIndicators.get("tauxReussite") + "%",
				getSuccessColor((Double) performanceIndicators.get("tauxReussite")), "Tests réussis");

		// Temps de réponse
		x = 50;
		y -= cardHeight + 20;
		drawIndicatorCard(contentStream, x, y, cardWidth, cardHeight, "Temps Réponse",
				performanceIndicators.get("tempsReponseMoyen") + " ms",
				getResponseTimeColor((Long) performanceIndicators.get("tempsReponseMoyen")), "Moyenne hebdo");
	}

	private void drawIndicatorCard(PDPageContentStream contentStream, float x, float y, float width, float height,
			String title, String value, Color color, String subtitle) throws IOException {
		// Fond de la carte
		contentStream.setNonStrokingColor(LIGHT_GRAY);
		contentStream.addRect(x, y - height, width, height);
		contentStream.fill();

		// Bordure colorée
		contentStream.setNonStrokingColor(color);
		contentStream.addRect(x, y - height, width, 3);
		contentStream.fill();

		// Titre
		contentStream.setNonStrokingColor(Color.DARK_GRAY);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_BOLD, 9);
		contentStream.newLineAtOffset(x + 5, y - height + 15);
		contentStream.showText(title);
		contentStream.endText();

		// Valeur
		contentStream.setNonStrokingColor(Color.BLACK);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_BOLD, 14);
		contentStream.newLineAtOffset(x + 5, y - height + 35);
		contentStream.showText(value);
		contentStream.endText();

		// Sous-titre
		contentStream.setNonStrokingColor(Color.GRAY);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA, 7);
		contentStream.newLineAtOffset(x + 5, y - height + 50);
		contentStream.showText(subtitle);
		contentStream.endText();
	}

	private void drawDetailedStatistics(PDPageContentStream contentStream, PDPage page, Map<String, Object> rapports)
			throws IOException {
		float y = page.getMediaBox().getHeight() - 350;

		contentStream.setNonStrokingColor(Color.BLACK);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
		contentStream.newLineAtOffset(50, y);
		contentStream.showText("STATISTIQUES DÉTAILLÉES");
		contentStream.endText();

		y -= 30;

		// Tableau des statistiques - SANS ÉMOJIS
		String[][] stats = { { "Tests exécutés", rapports.get("totalTests").toString(), "" },
				{ "Tests réussis", rapports.get("testsReussis").toString(), "[SUCCES]" },
				{ "Tests échoués", rapports.get("testsEchoues").toString(), "[ECHEC]" },
				{ "Taux de réussite", rapports.get("tauxReussite") + "%",
						getPerformanceText((Double) rapports.get("tauxReussite")) },
				{ "Temps réponse moyen", rapports.get("tempsReponseMoyen") + " ms", "[TEMPS]" },
				{ "Caisses testées", rapports.get("caissesTestees").toString(), "[CAISSES]" },
				{ "Tests actifs", rapports.get("testsActifs").toString(), "[ACTIFS]" } };

		for (String[] stat : stats) {
			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA_BOLD, 9);
			contentStream.newLineAtOffset(50, y);
			contentStream.showText(stat[2] + " " + stat[0]);
			contentStream.endText();

			contentStream.beginText();
			contentStream.setFont(PDType1Font.HELVETICA, 9);
			contentStream.newLineAtOffset(200, y);
			contentStream.showText(stat[1]);
			contentStream.endText();

			y -= 18;
		}
	}

	private void drawPerformanceCharts(PDPageContentStream contentStream, PDPage page, Map<String, Object> rapports)
			throws IOException {
		float y = page.getMediaBox().getHeight() - 520;

		contentStream.setNonStrokingColor(Color.BLACK);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
		contentStream.newLineAtOffset(50, y);
		contentStream.showText("ÉVOLUTION QUOTIDIENNE");
		contentStream.endText();

		y -= 30;

		// Simulation de graphique avec des barres simples
		Map<String, Object> statsParJour = (Map<String, Object>) rapports.get("statsParJour");
		if (statsParJour != null) {
			float x = 50;
			float maxBarHeight = 80;
			float barWidth = 20;
			float spacing = 25;

			for (String jour : statsParJour.keySet()) {
				Map<String, Object> statsJour = (Map<String, Object>) statsParJour.get(jour);
				Long total = (Long) statsJour.get("total");
				Long reussis = (Long) statsJour.get("reussis");

				if (total > 0) {
					float successRatio = (float) reussis / total;
					float barHeight = successRatio * maxBarHeight;

					// Barre de fond (total)
					contentStream.setNonStrokingColor(LIGHT_GRAY);
					contentStream.addRect(x, y - maxBarHeight, barWidth, maxBarHeight);
					contentStream.fill();

					// Barre de réussite
					contentStream.setNonStrokingColor(SUCCESS_COLOR);
					contentStream.addRect(x, y - barHeight, barWidth, barHeight);
					contentStream.fill();

					// Jour
					contentStream.setNonStrokingColor(Color.BLACK);
					contentStream.beginText();
					contentStream.setFont(PDType1Font.HELVETICA, 6);
					contentStream.newLineAtOffset(x, y - maxBarHeight - 10);
					contentStream.showText(jour);
					contentStream.endText();

					// Pourcentage
					contentStream.beginText();
					contentStream.setFont(PDType1Font.HELVETICA, 6);
					contentStream.newLineAtOffset(x, y - maxBarHeight - 20);
					contentStream.showText(String.format("%.0f%%", successRatio * 100));
					contentStream.endText();

					x += spacing;
				}
			}
		}
	}

	private void drawFooter(PDPageContentStream contentStream, PDPage page) throws IOException {
		String dateGeneration = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));

		contentStream.setNonStrokingColor(Color.GRAY);
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA_OBLIQUE, 8);
		contentStream.newLineAtOffset(50, 30);
		contentStream.showText("Généré le : " + dateGeneration + " | Machine Monitor v1.0 | Rapport confidentiel");
		contentStream.endText();

		// Numéro de page
		contentStream.beginText();
		contentStream.setFont(PDType1Font.HELVETICA, 8);
		contentStream.newLineAtOffset(page.getMediaBox().getWidth() - 50, 30);
		contentStream.showText("Page 1/1");
		contentStream.endText();
	}

	// Méthodes utilitaires pour les couleurs
	private Color getStatusColor(String statut) {
		if (statut == null) {
			return Color.GRAY;
		}

		switch (statut.toUpperCase()) {
		case "EXCELLENT":
			return SUCCESS_COLOR;
		case "BON":
			return new Color(52, 152, 219);
		case "MOYEN":
			return WARNING_COLOR;
		case "CRITIQUE":
			return DANGER_COLOR;
		default:
			return Color.GRAY;
		}
	}

	private Color getSuccessColor(Double taux) {
		if (taux == null) {
			return Color.GRAY;
		}
		if (taux >= 95) {
			return SUCCESS_COLOR;
		}
		if (taux >= 80) {
			return new Color(52, 152, 219);
		}
		if (taux >= 60) {
			return WARNING_COLOR;
		}
		return DANGER_COLOR;
	}

	private Color getResponseTimeColor(Long temps) {
		if (temps == null) {
			return Color.GRAY;
		}
		if (temps < 1000) {
			return SUCCESS_COLOR;
		}
		if (temps < 3000) {
			return WARNING_COLOR;
		}
		return DANGER_COLOR;
	}

	// REMPLACEMENT DES ÉMOJIS PAR DU TEXTE
	private String getPerformanceText(Double taux) {
		if (taux == null) {
			return "[N/A]";
		}
		if (taux >= 95) {
			return "[EXCELLENT]";
		}
		if (taux >= 80) {
			return "[BON]";
		}
		if (taux >= 60) {
			return "[MOYEN]";
		}
		return "[CRITIQUE]";
	}
}