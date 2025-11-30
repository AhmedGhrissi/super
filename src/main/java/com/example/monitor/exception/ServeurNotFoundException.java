package com.example.monitor.exception;

public class ServeurNotFoundException extends BusinessException {
	/**
	 *
	 */
	private static final long serialVersionUID = -6840534285250680784L;

	public ServeurNotFoundException(String serveurNom) {
		super("SERVER_NOT_FOUND", "Serveur non trouvé: " + serveurNom,
				"Vérifiez le nom du serveur ou contactez l'administrateur");
	}
}