package com.example.monitor.exception;

public class TestExecutionException extends BusinessException {
	/**
	 *
	 */
	private static final long serialVersionUID = -8376922868267893878L;

	public TestExecutionException(String serveurNom, String cause) {
		super("TEST_EXECUTION_FAILED", "Échec du test sur le serveur: " + serveurNom, "Cause: " + cause);
	}
}
