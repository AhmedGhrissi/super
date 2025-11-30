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
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

@Entity
@Table(name = "configuration_tests")
public class ConfigurationTests {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// === RELATIONS CORRIGÉES ===

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "caisse_id")
	private Caisse caisse;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "test_id")
	private TestStandard testStandard;

	// === CHAMPS EXISTANTS ===
	private String serveurCible;

	@Column(name = "url_complete")
	private String urlComplete;

	private Boolean actif = true;

	@Column(name = "ordre_execution")
	private Integer ordreExecution = 0;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	// === GETTERS/SETTERS POUR LES RELATIONS ===

	public Caisse getCaisse() {
		return caisse;
	}

	public void setCaisse(Caisse caisse) {
		this.caisse = caisse;
	}

	public TestStandard getTestStandard() {
		return testStandard;
	}

	public void setTestStandard(TestStandard testStandard) {
		this.testStandard = testStandard;
	}

	// === GETTERS/SETTERS EXISTANTS ===
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getServeurCible() {
		return serveurCible;
	}

	public void setServeurCible(String serveurCible) {
		this.serveurCible = serveurCible;
	}

	public String getUrlComplete() {
		return urlComplete;
	}

	public void setUrlComplete(String urlComplete) {
		this.urlComplete = urlComplete;
	}

	public Boolean getActif() {
		return actif;
	}

	public void setActif(Boolean actif) {
		this.actif = actif;
	}

	public Integer getOrdreExecution() {
		return ordreExecution;
	}

	public void setOrdreExecution(Integer ordreExecution) {
		this.ordreExecution = ordreExecution;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	// === MÉTHODES UTILITAIRES ===

	@PrePersist
	protected void onCreate() {
		createdAt = LocalDateTime.now();
		updatedAt = LocalDateTime.now();
	}

	@PreUpdate
	protected void onUpdate() {
		updatedAt = LocalDateTime.now();
	}
}