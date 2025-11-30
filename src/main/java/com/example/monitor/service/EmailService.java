package com.example.monitor.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class EmailService {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Value("${app.alert.emails-destinataires:admin@entreprise.com,tech@entreprise.com}")
	private String[] destinataires;

	@Value("${app.alert.seuil-disponibilite:80.0}")
	private double seuilDisponibilite;

	/**
	 * Envoie une alerte critique pour un serveur
	 */
	public void envoyerAlerteCritique(String serveurNom, Double disponibilite) {
		String sujet = "🚨 Alerte Critique - Serveur " + serveurNom;
		String message = String.format(
				"Le serveur %s a une disponibilité critique: %.1f%% (seuil: %.1f%%)\n\n"
						+ "Veuillez vérifier l'état du serveur dans le dashboard de monitoring.",
				serveurNom, disponibilite, seuilDisponibilite);

		envoyerEmailSimple(sujet, message, "ALERTE_CRITIQUE", serveurNom);
	}

	/**
	 * Envoie un rapport quotidien
	 */
	public void envoyerRapportQuotidien(int serveursCritiques, int totalServeurs) {
		String sujet = "📊 Rapport Quotidien - Machine Monitor";
		String message = String.format(
				"Rapport quotidien de monitoring:\n\n" + "📈 Serveurs surveillés: %d\n" + "🚨 Serveurs critiques: %d\n"
						+ "✅ Taux de succès global: %.1f%%\n\n" + "Accédez au dashboard pour plus de détails.",
				totalServeurs, serveursCritiques,
				totalServeurs > 0 ? (100.0 - (serveursCritiques * 100.0 / totalServeurs)) : 100.0);

		envoyerEmailSimple(sujet, message, "RAPPORT_QUOTIDIEN", null);
	}

	/**
	 * Envoie un email de test
	 */
	public void envoyerTestEmail() {
		String sujet = "✅ Test Email - Machine Monitor";
		String message = "Ceci est un email de test pour vérifier la configuration SMTP.\n\n"
				+ "Si vous recevez cet email, la configuration est correcte !";

		envoyerEmailSimple(sujet, message, "TEST", null);
	}

	/**
	 * Envoie un email simple avec logging
	 */
	private void envoyerEmailSimple(String sujet, String message, String typeAlerte, String serveurCible) {
		try {
			SimpleMailMessage email = new SimpleMailMessage();
			email.setTo(destinataires);
			email.setSubject(sujet);
			email.setText(message);
			email.setFrom("noreply@machine-monitor.com");

			mailSender.send(email);
			System.out.println("📧 Email envoyé: " + sujet);

			// Logger en base
			loggerEmailEnBase(sujet, String.join(", ", destinataires), typeAlerte, serveurCible, "ENVOYE", null);

		} catch (Exception e) {
			System.err.println("❌ Erreur envoi email: " + e.getMessage());

			// Logger l'erreur en base
			loggerEmailEnBase(sujet, String.join(", ", destinataires), typeAlerte, serveurCible, "ERREUR",
					e.getMessage());

			throw new RuntimeException("Erreur lors de l'envoi de l'email: " + e.getMessage(), e);
		}
	}

	/**
	 * Logge un email dans la base de données
	 */
	private void loggerEmailEnBase(String sujet, String destinataires, String typeAlerte, String serveurCible,
			String statut, String erreur) {
		try {
			System.out.println("🎯 DEBUT INSERTION FORCEE");
			System.out.println("📝 Données reçues:");
			System.out.println("  - Sujet: " + sujet);
			System.out.println("  - Destinataires: " + destinataires);
			System.out.println("  - Type: " + typeAlerte);
			System.out.println("  - Serveur: " + serveurCible);
			System.out.println("  - Statut: " + statut);
			System.out.println("  - Erreur: " + erreur);

			// FORCER LE COMMIT MANUEL
			String sql = "INSERT INTO email_logs (sujet, destinataires, type_alerte, serveur_cible, statut, erreur) VALUES (?, ?, ?, ?, ?, ?)";

			int rows = jdbcTemplate.update(sql, sujet != null ? sujet : "", destinataires != null ? destinataires : "",
					typeAlerte != null ? typeAlerte : "", serveurCible != null ? serveurCible : "",
					statut != null ? statut : "", erreur != null ? erreur : "");

			System.out.println("✅ INSERTION FORCEE: " + rows + " lignes");

			// TEST DIRECT DE LECTURE
			String countSql = "SELECT COUNT(*) FROM email_logs";
			int total = jdbcTemplate.queryForObject(countSql, Integer.class);
			System.out.println("📊 TOTAL EN BASE: " + total + " lignes");

		} catch (Exception e) {
			System.err.println("❌ ERREUR CRITIQUE INSERTION:");
			System.err.println("   Message: " + e.getMessage());
			System.err.println("   Cause: " + e.getCause());
			e.printStackTrace();
		}
		System.out.println("🎯 === FIN INSERTION EMAIL_LOGS ===");
	}

	/**
	 * Récupère les logs d'emails
	 */
	public List<Map<String, Object>> getEmailLogs(int limit) {
		try {
			String sql = "SELECT * FROM email_logs ORDER BY date_envoi DESC LIMIT ?";
			return jdbcTemplate.queryForList(sql, limit);
		} catch (Exception e) {
			System.err.println("❌ Erreur récupération logs email: " + e.getMessage());
			return List.of();
		}
	}

	/**
	 * Récupère les logs d'emails récents formatés
	 */
	public List<Map<String, Object>> getRecentEmailLogsFormatted() {
		try {
			String sql = """
					SELECT
					    id,
					    sujet,
					    type_alerte,
					    serveur_cible,
					    statut,
					    erreur,
					    date_envoi,
					    CASE
					        WHEN LENGTH(destinataires) > 30 THEN CONCAT(SUBSTRING(destinataires, 1, 30), '...')
					        ELSE destinataires
					    END as destinataires_court
					FROM email_logs
					ORDER BY date_envoi DESC
					LIMIT 20
					""";

			return jdbcTemplate.queryForList(sql);
		} catch (Exception e) {
			System.err.println("❌ Erreur récupération logs récents: " + e.getMessage());
			return List.of();
		}
	}

	/**
	 * Vérifie la configuration email
	 */
	public boolean estConfigure() {
		return mailSender != null && destinataires != null && destinataires.length > 0;
	}

	/**
	 * Retourne la liste des destinataires
	 */
	public List<String> getDestinataires() {
		return Arrays.asList(destinataires);
	}

	/**
	 * Statistiques des emails
	 */
	public Map<String, Object> getEmailStatistics() {
		try {
			String sql = """
					SELECT
					    COUNT(*) as total_emails,
					    SUM(CASE WHEN statut = 'ENVOYE' THEN 1 ELSE 0 END) as emails_envoyes,
					    SUM(CASE WHEN statut = 'ERREUR' THEN 1 ELSE 0 END) as emails_erreur,
					    COUNT(DISTINCT type_alerte) as types_alertes_differents,
					    MIN(date_envoi) as premier_envoi,
					    MAX(date_envoi) as dernier_envoi
					FROM email_logs
					""";

			return jdbcTemplate.queryForMap(sql);
		} catch (Exception e) {
			System.err.println("❌ Erreur statistiques emails: " + e.getMessage());
			return Map.of("erreur", e.getMessage());
		}
	}
}