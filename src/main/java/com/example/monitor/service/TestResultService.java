package com.example.monitor.service;

import com.example.monitor.model.ConfigurationTests;

/**
 * Service de résultat de test - encapsule les résultats des exécutions de tests
 * Pattern DTO (Data Transfer Object) pour le transfert entre services
 */
public class TestResultService {

	private final ConfigurationTests configuration;
	private final boolean success;
	private final long responseTime;
	private final int statusCode;
	private final String message;

	// Constructeur privé pour forcer l'utilisation des factory methods
	private TestResultService(ConfigurationTests configuration, boolean success, long responseTime, int statusCode,
			String message) {
		this.configuration = configuration;
		this.success = success;
		this.responseTime = responseTime;
		this.statusCode = statusCode;
		this.message = message;
	}

	// === FACTORY METHODS (pattern factory) ===

	/**
	 * Crée un résultat de test réussi
	 */
	public static TestResultService success(ConfigurationTests config, long responseTime, int statusCode) {
		return new TestResultService(config, true, responseTime, statusCode, "Succès");
	}

	/**
	 * Crée un résultat de test échoué avec message d'erreur
	 */
	public static TestResultService failure(ConfigurationTests config, String errorMessage) {
		return new TestResultService(config, false, 0, 0, errorMessage);
	}

	/**
	 * Crée un résultat de test échoué avec code statut spécifique
	 */
	public static TestResultService failure(ConfigurationTests config, int statusCode, String errorMessage) {
		return new TestResultService(config, false, 0, statusCode, errorMessage);
	}

	// === GETTERS (immutabilité) ===

	public boolean isSuccess() {
		return success;
	}

	public long getResponseTime() {
		return responseTime;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public String getMessage() {
		return message;
	}

	public ConfigurationTests getConfiguration() {
		return configuration;
	}

	// === MÉTHODES UTILITAIRES ===

	/**
	 * Vérifie si le test a échoué
	 */
	public boolean isFailure() {
		return !success;
	}

	/**
	 * Retourne le temps de réponse en secondes
	 */
	public double getResponseTimeInSeconds() {
		return responseTime / 1000.0;
	}

	/**
	 * Représentation textuelle pour le logging
	 */
	@Override
	public String toString() {
		return String.format("TestResultService{success=%s, responseTime=%dms, statusCode=%d, message='%s'}", success,
				responseTime, statusCode, message);
	}
}