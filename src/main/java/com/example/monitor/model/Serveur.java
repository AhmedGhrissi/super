package com.example.monitor.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

@Entity
@Table(name = "serveurs")
public class Serveur {

	// === ENUMS ===

	public enum TypeServeur {
		APPLICATION, BASE_DONNEES, WEB, FICHIERS, MESSAGERIE, SAUVEGARDE, SUPERVISION, INTEGRATION
	}

	public enum Environnement {
		PRODUCTION, PREPRODUCTION, DEVELOPPEMENT, TEST, QUALIFICATION
	}

	public enum StatutServeur {
		ACTIF, MAINTENANCE, HORS_LIGNE, EN_PANNE, EN_TEST, ERREUR
	}

	// === CHAMPS ===

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false, unique = true)
	private String nom;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private TypeServeur typeServeur;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private Environnement environnement;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private StatutServeur statut;

	@Column(name = "caisse_code")
	private String caisseCode;

	@Column(name = "adresse_ip", nullable = false)
	private String adresseIP;

	@Column(name = "version_logiciel")
	private String versionLogiciel;

	@Column(name = "port_ssh")
	private Integer portSSH;

	@Column(length = 1000)
	private String description;

	private String notes;

	@Column(name = "date_creation")
	private LocalDateTime dateCreation;

	@Column(name = "date_modification")
	private LocalDateTime dateModification;

	// === CONSTRUCTEURS ===

	public Serveur() {
		this.dateCreation = LocalDateTime.now();
		this.dateModification = LocalDateTime.now();
	}

	public Serveur(String nom, TypeServeur typeServeur, Environnement environnement, StatutServeur statut,
			String adresseIP, String caisseCode) {
		this();
		this.nom = nom;
		this.typeServeur = typeServeur;
		this.environnement = environnement;
		this.statut = statut;
		this.adresseIP = adresseIP;
		this.caisseCode = caisseCode;
	}

	// === GETTERS & SETTERS ===

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public TypeServeur getTypeServeur() {
		return typeServeur;
	}

	public void setTypeServeur(TypeServeur typeServeur) {
		this.typeServeur = typeServeur;
	}

	public Environnement getEnvironnement() {
		return environnement;
	}

	public void setEnvironnement(Environnement environnement) {
		this.environnement = environnement;
	}

	public StatutServeur getStatut() {
		return statut;
	}

	public void setStatut(StatutServeur statut) {
		this.statut = statut;
		this.dateModification = LocalDateTime.now();
	}

	public String getCaisseCode() {
		return caisseCode;
	}

	public void setCaisseCode(String caisseCode) {
		this.caisseCode = caisseCode;
	}

	public String getAdresseIP() {
		return adresseIP;
	}

	public void setAdresseIP(String adresseIP) {
		this.adresseIP = adresseIP;
	}

	public String getVersionLogiciel() {
		return versionLogiciel;
	}

	public void setVersionLogiciel(String versionLogiciel) {
		this.versionLogiciel = versionLogiciel;
	}

	public Integer getPortSSH() {
		return portSSH;
	}

	public void setPortSSH(Integer portSSH) {
		this.portSSH = portSSH;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
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

	// === MÉTHODES UTILITAIRES ===

	@PreUpdate
	public void preUpdate() {
		this.dateModification = LocalDateTime.now();
	}

	public boolean estActif() {
		return this.statut == StatutServeur.ACTIF;
	}

	public boolean estEnProduction() {
		return this.environnement == Environnement.PRODUCTION;
	}

	@Override
	public String toString() {
		return "Serveur{" + "id=" + id + ", nom='" + nom + '\'' + ", typeServeur=" + typeServeur + ", environnement="
				+ environnement + ", statut=" + statut + ", caisseCode='" + caisseCode + '\'' + ", adresseIP='"
				+ adresseIP + '\'' + '}';
	}

	@ManyToOne
	@JoinColumn(name = "caisse_code", referencedColumnName = "code", insertable = false, updatable = false)
	private Caisse caisse;

	public Caisse getCaisse() {
		return caisse;
	}

	public void setCaisse(Caisse caisse) {
		this.caisse = caisse;
	}

	@Column(name = "temps_reponse")
	private Integer tempsReponse;

	// Ajoutez le getter et setter
	public Integer getTempsReponse() {
		return tempsReponse;
	}

	public void setTempsReponse(Integer tempsReponse) {
		this.tempsReponse = tempsReponse;
	}
}