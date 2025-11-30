package com.example.monitor.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "types_serveur")
public class TypeServeur {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "code_type", unique = true, length = 20, nullable = false)
	private String codeType;

	@Column(name = "nom_type", length = 50, nullable = false)
	private String nomType;

	@Column(name = "description", columnDefinition = "TEXT")
	private String description;

	@Column(name = "actif")
	private Boolean actif = true;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	// Constructeurs
	public TypeServeur() {
	}

	public TypeServeur(String codeType, String nomType, String description) {
		this.codeType = codeType;
		this.nomType = nomType;
		this.description = description;
	}

	// Getters et Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCodeType() {
		return codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public String getNomType() {
		return nomType;
	}

	public void setNomType(String nomType) {
		this.nomType = nomType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	@Override
	public String toString() {
		return "TypeServeur{id=" + id + ", codeType='" + codeType + "', nomType='" + nomType + "'}";
	}
}