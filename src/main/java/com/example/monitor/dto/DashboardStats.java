package com.example.monitor.dto;

import java.time.LocalDateTime;

public class DashboardStats {
	private long totalCaisses;
	private long activeCaisses;
	private long totalTests;
	private long activeTests;
	private long testsExecutesAujourdhui;
	private double tauxReussite;
	private long tempsReponseMoyen;
	private long testsEnEchec;
	private long testsReussis;
	private LocalDateTime derniereMiseAJour;

	// Constructeurs
	public DashboardStats() {
	}

	public DashboardStats(long totalCaisses, long activeCaisses, long totalTests, long activeTests,
			long testsExecutesAujourdhui, double tauxReussite, long tempsReponseMoyen, long testsEnEchec,
			long testsReussis) {
		this.totalCaisses = totalCaisses;
		this.activeCaisses = activeCaisses;
		this.totalTests = totalTests;
		this.activeTests = activeTests;
		this.testsExecutesAujourdhui = testsExecutesAujourdhui;
		this.tauxReussite = tauxReussite;
		this.tempsReponseMoyen = tempsReponseMoyen;
		this.testsEnEchec = testsEnEchec;
		this.testsReussis = testsReussis;
		this.derniereMiseAJour = LocalDateTime.now();
	}

	// Getters et Setters
	public long getTotalCaisses() {
		return totalCaisses;
	}

	public void setTotalCaisses(long totalCaisses) {
		this.totalCaisses = totalCaisses;
	}

	public long getActiveCaisses() {
		return activeCaisses;
	}

	public void setActiveCaisses(long activeCaisses) {
		this.activeCaisses = activeCaisses;
	}

	public long getTotalTests() {
		return totalTests;
	}

	public void setTotalTests(long totalTests) {
		this.totalTests = totalTests;
	}

	public long getActiveTests() {
		return activeTests;
	}

	public void setActiveTests(long activeTests) {
		this.activeTests = activeTests;
	}

	public long getTestsExecutesAujourdhui() {
		return testsExecutesAujourdhui;
	}

	public void setTestsExecutesAujourdhui(long testsExecutesAujourdhui) {
		this.testsExecutesAujourdhui = testsExecutesAujourdhui;
	}

	public double getTauxReussite() {
		return tauxReussite;
	}

	public void setTauxReussite(double tauxReussite) {
		this.tauxReussite = tauxReussite;
	}

	public long getTempsReponseMoyen() {
		return tempsReponseMoyen;
	}

	public void setTempsReponseMoyen(long tempsReponseMoyen) {
		this.tempsReponseMoyen = tempsReponseMoyen;
	}

	public long getTestsEnEchec() {
		return testsEnEchec;
	}

	public void setTestsEnEchec(long testsEnEchec) {
		this.testsEnEchec = testsEnEchec;
	}

	public long getTestsReussis() {
		return testsReussis;
	}

	public void setTestsReussis(long testsReussis) {
		this.testsReussis = testsReussis;
	}

	public LocalDateTime getDerniereMiseAJour() {
		return derniereMiseAJour;
	}

	public void setDerniereMiseAJour(LocalDateTime derniereMiseAJour) {
		this.derniereMiseAJour = derniereMiseAJour;
	}
}