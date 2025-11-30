package com.example.monitor.generator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.example.monitor.model.Serveur;
import com.example.monitor.model.Serveur.Environnement;
import com.example.monitor.model.Serveur.StatutServeur;
import com.example.monitor.model.Serveur.TypeServeur;

public class ServeurDataGenerator {

	// === CODES DE CAISSES ===
	public static final String[] CODES_CAISSES = { "DP", "NE", "JP", "NM", "AL", "CS", "CR", "CA", "CE", "FC", "FI",
			"TO", "AQ", "LA", "IV", "RP", "VF", "KP", "AV", "CL", "MO", "LO", "NO", "NF", "BP", "PG", "SM", "AO", "LP",
			"AM", "AP", "IF", "NS", "BI", "CP", "TP", "CO", "GU", "MA", "RE" };

	// === TYPES DE SERVEURS PAR PATRON ===
	private static final Map<String, TypeServeur> TYPE_SERVEUR_MAP = Map.of("PAGEDC", TypeServeur.APPLICATION, "PD1SQL",
			TypeServeur.BASE_DONNEES, "PAB93003", TypeServeur.WEB);

	// === ENVIRONNEMENTS PAR PATRON ===
	private static final Map<String, Environnement> ENV_SERVEUR_MAP = Map.of("PAGEDC", Environnement.PRODUCTION,
			"PD1SQL", Environnement.PREPRODUCTION, "PAB93003", Environnement.DEVELOPPEMENT);

	// === ADRESSES IP PAR DEFAUT (à adapter selon votre infrastructure)
	private static final Map<String, String> SUBNET_MAP = Map.of("PAGEDC", "192.168.1.", "PD1SQL", "192.168.2.",
			"PAB93003", "192.168.3.");

	/**
	 * Génère tous les serveurs selon la nomenclature
	 */
	public static List<Serveur> generateAllServeurs() {
		List<Serveur> serveurs = new ArrayList<>();

		// Serveurs frontaux (PAGEDC)
		serveurs.addAll(
				generateServeursParType("PAGEDC", Arrays.asList("11", "12", "13", "14", "20", "21", "22", "23", "24")));

		// Serveurs backoffice (PD1SQL)
		serveurs.addAll(generateServeursParType("PD1SQL", Arrays.asList("02", "03", "10")));

		// Serveurs betaweb (PAB93003)
		serveurs.addAll(generateServeursParType("PAB93003", Arrays.asList("03")));

		return serveurs;
	}

	/**
	 * Génère les serveurs pour un type donné
	 */
	private static List<Serveur> generateServeursParType(String typeServeur, List<String> suffixes) {
		List<Serveur> serveurs = new ArrayList<>();
		int ipCounter = 1;

		for (String codeCaisse : CODES_CAISSES) {
			for (String suffixe : suffixes) {
				String nomServeur = generateNomServeur(codeCaisse, typeServeur, suffixe);

				// Vérifier si ce serveur existe dans la nomenclature
				if (shouldCreateServeur(codeCaisse, typeServeur, suffixe)) {
					Serveur serveur = createServeur(nomServeur, codeCaisse, typeServeur, ipCounter++);
					serveurs.add(serveur);
				}
			}
		}

		return serveurs;
	}

	/**
	 * Génère le nom du serveur selon la nomenclature
	 */
	private static String generateNomServeur(String codeCaisse, String typeServeur, String suffixe) {
		return String.format("SW%s%s%s", codeCaisse, typeServeur, suffixe);
	}

	/**
	 * Détermine si un serveur doit être créé selon la nomenclature
	 */
	private static boolean shouldCreateServeur(String codeCaisse, String typeServeur, String suffixe) {
		// Pour PAGEDC, on a généralement 4 serveurs par caisse (11,12,13,14)
		// sauf pour certaines caisses spéciales
		if ("PAGEDC".equals(typeServeur)) {
			return isValidPagedcCombination(codeCaisse, suffixe);
		}

		// Pour PD1SQL et PAB93003, on crée tous les serveurs
		return true;
	}

	/**
	 * Vérifie les combinaisons valides pour PAGEDC
	 */
	private static boolean isValidPagedcCombination(String codeCaisse, String suffixe) {
		// Serveurs standards (11,12,13,14) pour toutes les caisses
		if (Arrays.asList("11", "12", "13", "14").contains(suffixe)) {
			return true;
		}

		// Serveurs supplémentaires pour certaines caisses
		if ("AQ".equals(codeCaisse) && Arrays.asList("20", "21", "22", "23").contains(suffixe)) {
			return true;
		}

		if ("IF".equals(codeCaisse) && Arrays.asList("20", "21", "22", "23", "24", "25").contains(suffixe)) {
			return true;
		}

		return false;
	}

	/**
	 * Crée un serveur avec ses propriétés
	 */
	private static Serveur createServeur(String nom, String codeCaisse, String typePatron, int ipCounter) {
		Serveur serveur = new Serveur();
		serveur.setNom(nom);
		serveur.setCaisseCode(codeCaisse);
		serveur.setTypeServeur(TYPE_SERVEUR_MAP.get(typePatron));
		serveur.setEnvironnement(ENV_SERVEUR_MAP.get(typePatron));
		serveur.setStatut(generateStatutAleatoire());
		serveur.setAdresseIP(generateAdresseIP(typePatron, ipCounter));
		serveur.setVersionLogiciel(generateVersionLogiciel(typePatron));
		serveur.setDescription(generateDescription(nom, typePatron));
		serveur.setPortSSH(22); // Port SSH par défaut

		return serveur;
	}

	/**
	 * Génère une adresse IP unique
	 */
	private static String generateAdresseIP(String typePatron, int counter) {
		String subnet = SUBNET_MAP.get(typePatron);
		return subnet + counter;
	}

	/**
	 * Génère un statut aléatoire (pour les démos)
	 */
	private static StatutServeur generateStatutAleatoire() {
		StatutServeur[] statuts = StatutServeur.values();
		double rand = Math.random();

		if (rand < 0.7) {
			return StatutServeur.ACTIF; // 70% actifs
		}
		if (rand < 0.85) {
			return StatutServeur.MAINTENANCE; // 15% maintenance
		}
		if (rand < 0.95) {
			return StatutServeur.EN_TEST; // 10% en test
		}
		return StatutServeur.HORS_LIGNE; // 5% hors ligne
	}

	/**
	 * Génère une version logicielle réaliste
	 */
	private static String generateVersionLogiciel(String typePatron) {
		Map<String, String> versions = Map.of("PAGEDC", "2.5." + (int) (Math.random() * 10), "PD1SQL",
				"2019." + (int) (Math.random() * 5), "PAB93003", "1.3." + (int) (Math.random() * 8));
		return versions.get(typePatron);
	}

	/**
	 * Génère une description automatique
	 */
	private static String generateDescription(String nom, String typePatron) {
		Map<String, String> descriptions = Map.of("PAGEDC", "Serveur frontal applicatif", "PD1SQL",
				"Serveur de base de données", "PAB93003", "Serveur web beta");
		return descriptions.get(typePatron) + " - " + nom;
	}

	// === MÉTHODES UTILITAIRES POUR LES CONTROLLERS ===

	/**
	 * Extrait le code caisse depuis le nom du serveur
	 */
	public static String extractCodeCaisse(String nomServeur) {
		if (nomServeur != null && nomServeur.length() >= 4) {
			return nomServeur.substring(2, 4);
		}
		return null;
	}

	/**
	 * Extrait le numéro de serveur depuis le nom
	 */
	public static String extractNumeroServeur(String nomServeur) {
		if (nomServeur != null && nomServeur.length() >= 12) {
			return nomServeur.substring(10);
		}
		return null;
	}

	/**
	 * Extrait le type de serveur depuis le nom
	 */
	public static String extractTypePatron(String nomServeur) {
		if (nomServeur != null && nomServeur.length() >= 10) {
			String middlePart = nomServeur.substring(4, 10);
			if (middlePart.startsWith("PAGE")) {
				return "PAGEDC";
			}
			if (middlePart.startsWith("PD1")) {
				return "PD1SQL";
			}
			if (middlePart.startsWith("PAB")) {
				return "PAB93003";
			}
		}
		return "UNKNOWN";
	}

	/**
	 * Vérifie si c'est un serveur primaire (se terminant par 11, 20, 24, 32, 36)
	 */
	public static boolean isServeurPrimaire(String nomServeur) {
		String numero = extractNumeroServeur(nomServeur);
		return numero != null && Arrays.asList("11", "20", "24", "32", "36").contains(numero);
	}

	/**
	 * Vérifie si c'est un serveur secondaire (se terminant par 12, 21, 25, 33, 37)
	 */
	public static boolean isServeurSecondaire(String nomServeur) {
		String numero = extractNumeroServeur(nomServeur);
		return numero != null && Arrays.asList("12", "21", "25", "33", "37").contains(numero);
	}

	/**
	 * Obtient tous les serveurs d'une caisse spécifique
	 */
	public static List<Serveur> filterByCaisse(List<Serveur> serveurs, String codeCaisse) {
		return serveurs.stream().filter(s -> codeCaisse.equals(extractCodeCaisse(s.getNom()))).toList();
	}

	/**
	 * Obtient les serveurs par type
	 */
	public static List<Serveur> filterByType(List<Serveur> serveurs, String typePatron) {
		return serveurs.stream().filter(s -> typePatron.equals(extractTypePatron(s.getNom()))).toList();
	}
}