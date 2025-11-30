package com.example.monitor.service;

import java.io.IOException;
import java.util.Optional;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.monitor.model.ServeurStatistiques; // ⚠️ LE BON NOM

import jakarta.servlet.http.HttpServletResponse;

@Service
public class ExportService {

	@Autowired
	private ServeurStatsService statsService;

	public void exportStatsExcel(String serveurNom, HttpServletResponse response) throws IOException {
		// ⚠️ UTILISE LA BONNE MÉTHODE
		Optional<ServeurStatistiques> statsOpt = statsService.findServeurStatsByNom(serveurNom);

		if (statsOpt.isEmpty()) {
			throw new IOException("Statistiques non trouvées pour le serveur: " + serveurNom);
		}

		ServeurStatistiques stats = statsOpt.get();

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=stats_" + serveurNom + ".xlsx");

		try (Workbook workbook = new XSSFWorkbook()) {
			Sheet sheet = workbook.createSheet("Statistiques " + serveurNom);

			// Style pour les en-têtes
			CellStyle headerStyle = workbook.createCellStyle();
			Font headerFont = workbook.createFont();
			headerFont.setBold(true);
			headerStyle.setFont(headerFont);
			headerStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
			headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

			// En-têtes
			Row headerRow = sheet.createRow(0);
			Cell headerCell1 = headerRow.createCell(0);
			headerCell1.setCellValue("Métrique");
			headerCell1.setCellStyle(headerStyle);

			Cell headerCell2 = headerRow.createCell(1);
			headerCell2.setCellValue("Valeur");
			headerCell2.setCellStyle(headerStyle);

			// Données
			int rowNum = 1;
			rowNum = addRow(sheet, rowNum, "Serveur", stats.getServeurNom());
			rowNum = addRow(sheet, rowNum, "Type Serveur", stats.getTypeServeur());
			rowNum = addRow(sheet, rowNum, "Code Caisse", stats.getCaisseCode());
			rowNum = addRow(sheet, rowNum, "Tests Total", String.valueOf(stats.getTestsTotal()));
			rowNum = addRow(sheet, rowNum, "Tests Réussis", String.valueOf(stats.getTestsSucces()));
			rowNum = addRow(sheet, rowNum, "Tests Échec", String.valueOf(stats.getTestsEchec()));

			double tauxReussite = stats.getTestsTotal() > 0 ? (stats.getTestsSucces() * 100.0 / stats.getTestsTotal())
					: 0;
			rowNum = addRow(sheet, rowNum, "Taux Réussite", String.format("%.1f%%", tauxReussite));

			rowNum = addRow(sheet, rowNum, "Disponibilité", String.format("%.1f%%", stats.getDisponibilitePercent()));
			rowNum = addRow(sheet, rowNum, "Temps Réponse Moyen", stats.getTempsReponseMoyen() + " ms");

			// Ajuster la largeur des colonnes
			sheet.autoSizeColumn(0);
			sheet.autoSizeColumn(1);

			workbook.write(response.getOutputStream());
		}
	}

	private int addRow(Sheet sheet, int rowNum, String metrique, String valeur) {
		Row row = sheet.createRow(rowNum);
		row.createCell(0).setCellValue(metrique);
		row.createCell(1).setCellValue(valeur);
		return rowNum + 1;
	}
}