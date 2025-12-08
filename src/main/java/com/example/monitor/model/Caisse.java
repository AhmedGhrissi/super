package com.example.monitor.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "caisses")
public class Caisse {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "code", unique = true, length = 10, nullable = false)
	private String code;

	@Column(name = "nom", length = 100, nullable = false)
	private String nom;

	@Column(name = "code_partition", length = 10, nullable = false)
	private String codePartition;

	@Column(name = "code_cr", length = 10, nullable = false)
	private String codeCr;

	@Column(name = "actif")
	private Boolean actif = true;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	// Constructeurs
	public Caisse() {
	}

	public Caisse(String code, String nom, String codePartition, String codeCr) {
		this.code = code;
		this.nom = nom;
		this.codePartition = codePartition;
		this.codeCr = codeCr;
	}

	// Getters et Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getCodePartition() {
		return codePartition;
	}

	public void setCodePartition(String codePartition) {
		this.codePartition = codePartition;
	}

	public String getCodeCr() {
		return codeCr;
	}

	public void setCodeCr(String codeCr) {
		this.codeCr = codeCr;
	}

	public Boolean getActif() {
		return actif;
	}

	public void setActif(Boolean actif) {
		this.actif = actif;
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

	@Override
	public String toString() {
		return "Caisse{id=" + id + ", code='" + code + "', nom='" + nom + "'}";
	}

	// Relation optionnelle avec ConfigurationServeurs
	@OneToMany(mappedBy = "caisseId", fetch = FetchType.LAZY)
	private List<ConfigurationServeurs> configurationServeurs = new ArrayList<>();

	// Getters et Setters pour la relation
	public List<ConfigurationServeurs> getConfigurationServeurs() {
		return configurationServeurs;
	}

	public void setConfigurationServeurs(List<ConfigurationServeurs> configurationServeurs) {
		this.configurationServeurs = configurationServeurs;
	}

	@OneToMany(mappedBy = "caisse", fetch = FetchType.LAZY)
	private List<Serveur> serveurs = new ArrayList<>();

	// AJOUTER ces getters/setters
	public List<Serveur> getServeurs() {
		return serveurs;
	}

	public void setServeurs(List<Serveur> serveurs) {
		this.serveurs = serveurs;
	}

}