package com.example.monitor.model;

import java.time.LocalDateTime;

import com.example.monitor.model.enums.CriticiteAlerte;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "alertes")
public class Alert {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false)
	private String titre;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private CriticiteAlerte criticite;

	@Column(name = "type_alerte")
	private String typeAlerte;

	@Column(name = "serveur_cible")
	private String serveurCible;

	@Column(name = "date_creation", nullable = false)
	private LocalDateTime dateCreation;

	@Column(name = "date_resolution")
	private LocalDateTime dateResolution;

	@Column(nullable = false)
	private Boolean resolue = false;

	// Constructeurs
	public Alert() {
		this.dateCreation = LocalDateTime.now();
	}

	public Alert(String titre, String description, CriticiteAlerte criticite) {
		this();
		this.titre = titre;
		this.description = description;
		this.criticite = criticite;
	}

	// Getters et Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitre() {
		return titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public CriticiteAlerte getCriticite() {
		return criticite;
	}

	public void setCriticite(CriticiteAlerte criticite) {
		this.criticite = criticite;
	}

	public String getTypeAlerte() {
		return typeAlerte;
	}

	public void setTypeAlerte(String typeAlerte) {
		this.typeAlerte = typeAlerte;
	}

	public String getServeurCible() {
		return serveurCible;
	}

	public void setServeurCible(String serveurCible) {
		this.serveurCible = serveurCible;
	}

	public LocalDateTime getDateCreation() {
		return dateCreation;
	}

	public void setDateCreation(LocalDateTime dateCreation) {
		this.dateCreation = dateCreation;
	}

	public LocalDateTime getDateResolution() {
		return dateResolution;
	}

	public void setDateResolution(LocalDateTime dateResolution) {
		this.dateResolution = dateResolution;
	}

	public Boolean getResolue() {
		return resolue;
	}

	public void setResolue(Boolean resolue) {
		this.resolue = resolue;
	}

	@Override
	public String toString() {
		return "Alert{" + "id=" + id + ", titre='" + titre + '\'' + ", criticite=" + criticite + ", dateCreation="
				+ dateCreation + ", resolue=" + resolue + '}';
	}
}