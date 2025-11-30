package com.example.monitor.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

@Entity
@Table(name = "mises_a_jour")
public class MiseAJour {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "serveur_id")
	private Serveur serveur;

	@Column(name = "version", nullable = false, length = 50)
	private String version;

	@Column(name = "date_application", nullable = false)
	private LocalDate dateApplication;

	@Enumerated(EnumType.STRING)
	@Column(name = "type_mise_a_jour")
	private TypeMiseAJour typeMiseAJour;

	@Column(name = "description", columnDefinition = "TEXT")
	private String description;

	@Column(name = "responsable", length = 100)
	private String responsable;

	@Enumerated(EnumType.STRING)
	@Column(name = "statut")
	private StatutMiseAJour statut;

	@Column(name = "date_creation")
	private LocalDateTime dateCreation;

	@Column(name = "date_modification")
	private LocalDateTime dateModification;

	// Enums
	public enum TypeMiseAJour {
		CRITIQUE, SECURITE, FONCTIONNEL, CORRECTIF
	}

	public enum StatutMiseAJour {
		PLANIFIEE, EN_COURS, TERMINEE, ECHEC
	}

	// Constructeurs
	public MiseAJour() {
		this.dateCreation = LocalDateTime.now();
		this.dateModification = LocalDateTime.now();
	}

	public MiseAJour(Serveur serveur, String version, LocalDate dateApplication) {
		this();
		this.serveur = serveur;
		this.version = version;
		this.dateApplication = dateApplication;
		this.statut = StatutMiseAJour.PLANIFIEE; // Statut par défaut
	}

	// Getters et Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Serveur getServeur() {
		return serveur;
	}

	public void setServeur(Serveur serveur) {
		this.serveur = serveur;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public LocalDate getDateApplication() {
		return dateApplication;
	}

	public void setDateApplication(LocalDate dateApplication) {
		this.dateApplication = dateApplication;
	}

	public TypeMiseAJour getTypeMiseAJour() {
		return typeMiseAJour;
	}

	public void setTypeMiseAJour(TypeMiseAJour typeMiseAJour) {
		this.typeMiseAJour = typeMiseAJour;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getResponsable() {
		return responsable;
	}

	public void setResponsable(String responsable) {
		this.responsable = responsable;
	}

	public StatutMiseAJour getStatut() {
		return statut;
	}

	public void setStatut(StatutMiseAJour statut) {
		this.statut = statut;
		this.dateModification = LocalDateTime.now();
	}

	public LocalDateTime getDateCreation() {
		return dateCreation;
	}

	public void setDateCreation(LocalDateTime dateCreation) {
		this.dateCreation = dateCreation;
	}

	public LocalDateTime getDateModification() {
		return dateModification;
	}

	public void setDateModification(LocalDateTime dateModification) {
		this.dateModification = dateModification;
	}

	@PreUpdate
	public void preUpdate() {
		this.dateModification = LocalDateTime.now();
	}

	public String getDateApplicationFormatee() {
		return dateApplication.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
	}

	@Override
	public String toString() {
		return String.format("MiseAJour{id=%d, version='%s', statut=%s}", id, version, statut);
	}
}