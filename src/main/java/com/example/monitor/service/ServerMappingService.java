package com.example.monitor.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

@Service
public class ServerMappingService {

	// Mapping des codes caisse vers les noms complets
	private final Map<String, String> caisseCodes = Map.ofEntries(Map.entry("DP", "Banque Chalus"),
			Map.entry("NE", "Nord-Est"), Map.entry("JP", "Champagne-Bourgogne"), Map.entry("NM", "Nord Midi-Pyrénées"),
			Map.entry("AL", "Alpes-Provence"), Map.entry("CS", "Charente-Maritime Deux-Sèvres"),
			Map.entry("CR", "Corse"), Map.entry("CA", "Côtes d'Armor"), Map.entry("CE", "Charente-Périgord"),
			Map.entry("FC", "Franche-Comté"), Map.entry("FI", "Finistère"), Map.entry("TO", "Toulouse"),
			Map.entry("AQ", "Aquitaine"), Map.entry("LA", "Languedoc"), Map.entry("IV", "Ille et Vilaine"),
			Map.entry("RP", "Sud Rhône-Alpes"), Map.entry("VF", "Val-de-France"), Map.entry("KP", "Loire Haute-Loire"),
			Map.entry("AV", "Atlantique-Vendée"), Map.entry("CL", "Centre-Loire"), Map.entry("MO", "Morbihan"),
			Map.entry("LO", "Lorraine"), Map.entry("NO", "Normandie"), Map.entry("NF", "Nord De France"),
			Map.entry("BP", "Centre-France"), Map.entry("PG", "Pyrénées-Gascogne"), Map.entry("SM", "Sud Méditerranée"),
			Map.entry("AO", "Alsace-Vosges"), Map.entry("LP", "Centre-Est"), Map.entry("AM", "Anjou-Maine"),
			Map.entry("AP", "Savoie"), Map.entry("IF", "Paris-Ile-de-France"), Map.entry("NS", "Normandie-Seine"),
			Map.entry("BI", "Brie-Picardie"), Map.entry("CP", "Provence-Côtes-d'Azur"),
			Map.entry("TP", "Touraine-Poitou"), Map.entry("CO", "Centre-Ouest"), Map.entry("GU", "Guadeloupe"),
			Map.entry("MA", "Martinique"), Map.entry("RE", "Réunion"));

	// Serveurs frontaux par caisse
	private final Map<String, List<String>> frontalServers = Map.ofEntries(
			Map.entry("DP", List.of("SWDPPAGEDC11", "SWDPPAGEDC12", "SWDPPAGEDC13", "SWDPPAGEDC14")),
			Map.entry("NE", List.of("SWNEPAGEDC11", "SWNEPAGEDC12", "SWNEPAGEDC13", "SWNEPAGEDC14")),
			Map.entry("JP", List.of("SWJPPAGEDC11", "SWJPPAGEDC12", "SWJPPAGEDC13", "SWJPPAGEDC14")),
			Map.entry("NM", List.of("SWNMPAGEDC11", "SWNMPAGEDC12", "SWNMPAGEDC13", "SWNMPAGEDC14")),
			Map.entry("AL", List.of("SWALPAGEDC11", "SWALPAGEDC12", "SWALPAGEDC13", "SWALPAGEDC14")),
			Map.entry("CS", List.of("SWCSPAGEDC11", "SWCSPAGEDC12", "SWCSPAGEDC13", "SWCSPAGEDC14")),
			Map.entry("CR", List.of("SWCRPAGEDC11", "SWCRPAGEDC12", "SWCRPAGEDC13", "SWCRPAGEDC14")),
			Map.entry("CA", List.of("SWCAPAGEDC11", "SWCAPAGEDC12", "SWCAPAGEDC13", "SWCAPAGEDC14")),
			Map.entry("CE", List.of("SWCEPAGEDC11", "SWCEPAGEDC12", "SWCEPAGEDC13", "SWCEPAGEDC14")),
			Map.entry("FC", List.of("SWFCPAGEDC11", "SWFCPAGEDC12", "SWFCPAGEDC13", "SWFCPAGEDC14")),
			Map.entry("FI", List.of("SWFIPAGEDC11", "SWFIPAGEDC12", "SWFIPAGEDC13", "SWFIPAGEDC14")),
			Map.entry("TO", List.of("SWTOPAGEDC11", "SWTOPAGEDC12", "SWTOPAGEDC13", "SWTOPAGEDC14")),
			Map.entry("AQ",
					List.of("SWAQPAGEDC11", "SWAQPAGEDC12", "SWAQPAGEDC13", "SWAQPAGEDC14", "SWAQPAGEDC20",
							"SWAQPAGEDC21", "SWAQPAGEDC22", "SWAQPAGEDC23")),
			Map.entry("LA", List.of("SWLAPAGEDC11", "SWLAPAGEDC12", "SWLAPAGEDC13", "SWLAPAGEDC14")),
			Map.entry("IV", List.of("SWIVPAGEDC11", "SWIVPAGEDC12", "SWIVPAGEDC13", "SWIVPAGEDC14")),
			Map.entry("RP", List.of("SWRPPAGEDC11", "SWRPPAGEDC12", "SWRPPAGEDC13", "SWRPPAGEDC14")),
			Map.entry("VF", List.of("SWVFPAGEDC11", "SWVFPAGEDC12", "SWVFPAGEDC13", "SWVFPAGEDC14")),
			Map.entry("KP", List.of("SWKPPAGEDC11", "SWKPPAGEDC12", "SWKPPAGEDC13", "SWKPPAGEDC14")),
			Map.entry("AV", List.of("SWAVPAGEDC11", "SWAVPAGEDC12", "SWAVPAGEDC13", "SWAVPAGEDC14")),
			Map.entry("CL", List.of("SWCLPAGEDC11", "SWCLPAGEDC12", "SWCLPAGEDC13", "SWCLPAGEDC14")),
			Map.entry("MO", List.of("SWMOPAGEDC11", "SWMOPAGEDC12", "SWMOPAGEDC13", "SWMOPAGEDC14")),
			Map.entry("LO", List.of("SWLOPAGEDC11", "SWLOPAGEDC12", "SWLOPAGEDC13", "SWLOPAGEDC14")),
			Map.entry("NO", List.of("SWNOPAGEDC11", "SWNOPAGEDC12", "SWNOPAGEDC13", "SWNOPAGEDC14")),
			Map.entry("NF", List.of("SWNFPAGEDC11", "SWNFPAGEDC12", "SWNFPAGEDC13", "SWNFPAGEDC14")),
			Map.entry("BP", List.of("SWBPPAGEDC11", "SWBPPAGEDC12", "SWBPPAGEDC13", "SWBPPAGEDC14")),
			Map.entry("PG", List.of("SWPGPAGEDC11", "SWPGPAGEDC12", "SWPGPAGEDC13", "SWPGPAGEDC14")),
			Map.entry("SM", List.of("SWSMPAGEDC11", "SWSMPAGEDC12", "SWSMPAGEDC13", "SWSMPAGEDC14")),
			Map.entry("AO", List.of("SWAOPAGEDC11", "SWAOPAGEDC12", "SWAOPAGEDC13", "SWAOPAGEDC14")),
			Map.entry("LP", List.of("SWLPPAGEDC11", "SWLPPAGEDC12", "SWLPPAGEDC13", "SWLPPAGEDC14")),
			Map.entry("AM", List.of("SWAMPAGEDC11", "SWAMPAGEDC12", "SWAMPAGEDC13", "SWAMPAGEDC14")),
			Map.entry("AP", List.of("SWAPPAGEDC11", "SWAPPAGEDC12", "SWAPPAGEDC13", "SWAPPAGEDC14")),
			Map.entry("IF",
					List.of("SWIFPAGEDC11", "SWIFPAGEDC12", "SWIFPAGEDC13", "SWIFPAGEDC14", "SWIFPAGEDC20",
							"SWIFPAGEDC21", "SWIFPAGEDC22", "SWIFPAGEDC23", "SWIFPAGEDC24")),
			Map.entry("NS", List.of("SWNSPAGEDC11", "SWNSPAGEDC12", "SWNSPAGEDC13", "SWNSPAGEDC14")),
			Map.entry("BI", List.of("SWBIPAGEDC11", "SWBIPAGEDC12", "SWBIPAGEDC13", "SWBIPAGEDC14")),
			Map.entry("CP", List.of("SWCPPAGEDC11", "SWCPPAGEDC12", "SWCPPAGEDC13", "SWCPPAGEDC14")),
			Map.entry("TP", List.of("SWTPPAGEDC11", "SWTPPAGEDC12", "SWTPPAGEDC13", "SWTPPAGEDC14")),
			Map.entry("CO", List.of("SWCOPAGEDC11", "SWCOPAGEDC12", "SWCOPAGEDC13", "SWCOPAGEDC14")),
			Map.entry("GU", List.of("SWGUPAGEDC11", "SWGUPAGEDC12", "SWGUPAGEDC13", "SWGUPAGEDC14")),
			Map.entry("MA", List.of("SWMAPAGEDC11", "SWMAPAGEDC12", "SWMAPAGEDC13", "SWMAPAGEDC14")),
			Map.entry("RE", List.of("SWREPAGEDC11", "SWREPAGEDC12", "SWREPAGEDC13", "SWREPAGEDC14")));

	// Serveurs BackOffice
	private final Map<String, String> backOfficeServers = Map.ofEntries(Map.entry("AL", "SWALPD1SQL10"),
			Map.entry("AM", "SWAMPD1SQL02"), Map.entry("AO", "SWAOPD1SQL10"), Map.entry("AP", "SWAPPD1SQL10"),
			Map.entry("AQ", "SWAQPD1SQL02"), Map.entry("AV", "SWAVPD1SQL02"), Map.entry("BI", "SWBIPD1SQL10"),
			Map.entry("BP", "SWBPPD1SQL02"), Map.entry("CA", "SWCAPD1SQL02"), Map.entry("CE", "SWCEPD1SQL02"),
			Map.entry("CL", "SWCLPD1SQL10"), Map.entry("CO", "SWCOPD1SQL02"), Map.entry("CP", "SWCPPD1SQL02"),
			Map.entry("CR", "SWCRPD1SQL10"), Map.entry("CS", "SWCSPD1SQL10"), Map.entry("DP", "SWDPPD1SQL02"),
			Map.entry("FC", "SWFCPD1SQL10"), Map.entry("FI", "SWFIPD1SQL02"), Map.entry("GU", "SWGUPD1SQL02"),
			Map.entry("IF", "SWIFPD1SQL03"), Map.entry("IV", "SWIVPD1SQL10"), Map.entry("JP", "SWJPPD1SQL02"),
			Map.entry("KP", "SWKPPD1SQL02"), Map.entry("LA", "SWLAPD1SQL10"), Map.entry("LO", "SWLOPD1SQL10"),
			Map.entry("LP", "SWLPPD1SQL02"), Map.entry("MA", "SWMAPD1SQL02"), Map.entry("MO", "SWMOPD1SQL02"),
			Map.entry("NE", "SWNEPD1SQL02"), Map.entry("NF", "SWNFPD1SQL03"), Map.entry("NM", "SWNMPD1SQL10"),
			Map.entry("NO", "SWNOPD1SQL02"), Map.entry("NS", "SWNSPD1SQL02"), Map.entry("PG", "SWPGPD1SQL02"),
			Map.entry("RE", "SWREPD1SQL10"), Map.entry("RP", "SWRPPD1SQL10"), Map.entry("SM", "SWSMPD1SQL10"),
			Map.entry("TO", "SWTOPD1SQL10"), Map.entry("TP", "SWTPPD1SQL02"), Map.entry("VF", "SWVFPD1SQL02"));

	// Serveurs BetaWeb
	private final Map<String, String> betawebServers = Map.ofEntries(Map.entry("DP", "SWDPPAB93003"),
			Map.entry("NE", "SWNEPAB93003"), Map.entry("JP", "SWJPPAB93003"), Map.entry("NM", "SWNMPAB93003"),
			Map.entry("AL", "SWALPAB93003"), Map.entry("CS", "SWCSPAB93003"), Map.entry("CR", "SWCRPAB93003"),
			Map.entry("CA", "SWCAPAB93003"), Map.entry("CE", "SWCEPAB93003"), Map.entry("FC", "SWFCPAB93003"),
			Map.entry("FI", "SWFIPAB93003"), Map.entry("TO", "SWTOPAB93003"), Map.entry("AQ", "SWAQPAB93003"),
			Map.entry("LA", "SWLAPAB93003"), Map.entry("IV", "SWIVPAB93003"), Map.entry("RP", "SWRPPAB93003"),
			Map.entry("VF", "SWVFPAB93003"), Map.entry("KP", "SWKPPAB93003"), Map.entry("AV", "SWAVPAB93003"),
			Map.entry("CL", "SWCLPAB93003"), Map.entry("MO", "SWMOPAB93003"), Map.entry("LO", "SWLOPAB93003"),
			Map.entry("NO", "SWNOPAB93003"), Map.entry("NF", "SWNFPAB93003"), Map.entry("BP", "SWBPPAB93003"),
			Map.entry("PG", "SWPGPAB93003"), Map.entry("SM", "SWSMPAB93003"), Map.entry("AO", "SWAOPAB93003"),
			Map.entry("LP", "SWLPPAB93003"), Map.entry("AM", "SWAMPAB93003"), Map.entry("AP", "SWAPPAB93003"),
			Map.entry("IF", "SWIFPAB93003"), Map.entry("NS", "SWNSPAB93003"), Map.entry("BI", "SWBIPAB93003"),
			Map.entry("CP", "SWCPPAB93003"), Map.entry("TP", "SWTPPAB93003"), Map.entry("CO", "SWCOPAB93003"),
			Map.entry("GU", "SWGUPAB93003"), Map.entry("MA", "SWMAPAB93003"), Map.entry("RE", "SWREPAB93003"));

	public List<String> getAllCaisseCodes() {
		return new ArrayList<>(caisseCodes.keySet());
	}

	public String getCaisseName(String caisseCode) {
		return caisseCodes.get(caisseCode);
	}

	public List<String> getFrontalServers(String caisseCode) {
		return frontalServers.getOrDefault(caisseCode, Collections.emptyList());
	}

	public String getBackOfficeServer(String caisseCode) {
		return backOfficeServers.get(caisseCode);
	}

	public String getBetawebServer(String caisseCode) {
		return betawebServers.get(caisseCode);
	}

	public Map<String, String> getServerRole(String serverName) {
		Map<String, String> role = new HashMap<>();

		if (serverName.contains("PAGEDC")) {
			role.put("type", "frontal");
			String caisseCode = serverName.substring(2, 4);
			role.put("caisse", caisseCode);
			role.put("caisse_name", caisseCodes.get(caisseCode));

			// Déterminer le rôle dans le groupe
			String serverNumber = serverName.substring(10, 12);
			switch (serverNumber) {
			case "11", "20", "24" -> role.put("role", "principal");
			case "12", "21", "25" -> role.put("role", "secondaire");
			case "13", "22", "30" -> role.put("role", "tertiaire");
			case "14", "23", "31" -> role.put("role", "quaternaire");
			default -> role.put("role", "membre");
			}
		} else if (serverName.contains("PD1SQL")) {
			role.put("type", "backoffice");
			String caisseCode = serverName.substring(2, 4);
			role.put("caisse", caisseCode);
			role.put("caisse_name", caisseCodes.get(caisseCode));
			role.put("role", "database");
		} else if (serverName.contains("PAB930")) {
			role.put("type", "betaweb");
			String caisseCode = serverName.substring(2, 4);
			role.put("caisse", caisseCode);
			role.put("caisse_name", caisseCodes.get(caisseCode));
			role.put("role", "web");
		} else {
			role.put("type", "inconnu");
			role.put("role", "inconnu");
		}

		return role;
	}

	public List<String> getAllServers() {
		List<String> allServers = new ArrayList<>();

		// Frontaux
		frontalServers.values().forEach(allServers::addAll);

		// BackOffice
		allServers.addAll(backOfficeServers.values());

		// BetaWeb
		allServers.addAll(betawebServers.values());

		return allServers;
	}

	public int getTotalServerCount() {
		int frontalCount = frontalServers.values().stream().mapToInt(List::size).sum();
		int backofficeCount = backOfficeServers.size();
		int betawebCount = betawebServers.size();

		return frontalCount + backofficeCount + betawebCount;
	}

	public Map<String, Object> getServerStatistics() {
		Map<String, Object> stats = new HashMap<>();

		stats.put("total_servers", getTotalServerCount());
		stats.put("frontal_servers", frontalServers.values().stream().mapToInt(List::size).sum());
		stats.put("backoffice_servers", backOfficeServers.size());
		stats.put("betaweb_servers", betawebServers.size());
		stats.put("caisses_count", caisseCodes.size());

		// Compter les serveurs par groupe
		Map<String, Long> frontalByRole = frontalServers.values().stream().flatMap(List::stream)
				.map(this::getServerRole).map(role -> role.get("role"))
				.collect(Collectors.groupingBy(role -> role, Collectors.counting()));

		stats.put("frontal_by_role", frontalByRole);

		return stats;
	}
}