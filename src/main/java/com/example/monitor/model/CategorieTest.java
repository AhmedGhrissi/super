package com.example.monitor.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "categories_test")
public class CategorieTest {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "code_categorie", unique = true, length = 50, nullable = false)
	private String codeCategorie;

	@Column(name = "nom_categorie", length = 100, nullable = false)
	private String nomCategorie;

	@Column(name = "description", columnDefinition = "TEXT")
	private String description;

	@Column(name = "actif")
	private Boolean actif = true;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	// Constructeurs
	public CategorieTest() {
	}

	public CategorieTest(String codeCategorie, String nomCategorie, String description) {
		this.codeCategorie = codeCategorie;
		this.nomCategorie = nomCategorie;
		this.description = description;
	}

	// Getters et Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCodeCategorie() {
		return codeCategorie;
	}

	public void setCodeCategorie(String codeCategorie) {
		this.codeCategorie = codeCategorie;
	}

	public String getNomCategorie() {
		return nomCategorie;
	}

	public void setNomCategorie(String nomCategorie) {
		this.nomCategorie = nomCategorie;
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
		return "CategorieTest{id=" + id + ", codeCategorie='" + codeCategorie + "', nomCategorie='" + nomCategorie
				+ "'}";
	}
}