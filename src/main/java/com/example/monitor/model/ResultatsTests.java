package com.example.monitor.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "resultats_tests")
public class ResultatsTests {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "config_test_id")
	private ConfigurationTests configTest;

	private Boolean succes;
	private Long tempsReponse;
	private Integer codeStatut;
	private String message;

	@Column(name = "date_execution")
	private LocalDateTime dateExecution;

	@Column(name = "serveur_cible", length = 100)
	private String serveurCible;

	@Column(name = "caisse_code", length = 10)
	private String caisseCode;

	@Column(name = "type_serveur", length = 20)
	private String typeServeur;

	// GETTERS/SETTERS POUR LES NOUVEAUX CHAMPS
	public String getServeurCible() {
		return serveurCible;
	}

	public void setServeurCible(String serveurCible) {
		this.serveurCible = serveurCible;
	}

	public String getCaisseCode() {
		return caisseCode;
	}

	public void setCaisseCode(String caisseCode) {
		this.caisseCode = caisseCode;
	}

	public String getTypeServeur() {
		return typeServeur;
	}

	public void setTypeServeur(String typeServeur) {
		this.typeServeur = typeServeur;
	}

	public ConfigurationTests getConfigTest() {
		return configTest;
	}

	public void setConfigTest(ConfigurationTests configTest) {
		this.configTest = configTest;
	}

	public Boolean isSucces() {
		return succes;
	}

	public Boolean getSucces() {
		return succes;
	}

	public void setSucces(Boolean succes) {
		this.succes = succes;
	}

	// === GETTERS/SETTERS EXISTANTS ===
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getTempsReponse() {
		return tempsReponse;
	}

	public void setTempsReponse(Long tempsReponse) {
		this.tempsReponse = tempsReponse;
	}

	public Integer getCodeStatut() {
		return codeStatut;
	}

	public void setCodeStatut(Integer codeStatut) {
		this.codeStatut = codeStatut;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public LocalDateTime getDateExecution() {
		return dateExecution;
	}

	public void setDateExecution(LocalDateTime dateExecution) {
		this.dateExecution = dateExecution;
	}

}