package com.example.monitor.dto;

public class TestExecutionRequest {
	private String categorie;
	private String caisseCode;
	private String typeTest;

	// Getters et Setters
	public String getCategorie() {
		return categorie;
	}

	public void setCategorie(String categorie) {
		this.categorie = categorie;
	}

	public String getCaisseCode() {
		return caisseCode;
	}

	public void setCaisseCode(String caisseCode) {
		this.caisseCode = caisseCode;
	}

	public String getTypeTest() {
		return typeTest;
	}

	public void setTypeTest(String typeTest) {
		this.typeTest = typeTest;
	}
}