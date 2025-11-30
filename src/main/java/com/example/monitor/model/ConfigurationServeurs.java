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
@Table(name = "configuration_serveurs")
public class ConfigurationServeurs {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "caisse_id", nullable = false)
	private Long caisseId;

	@Column(name = "type_serveur", length = 20, nullable = false)
	private String typeServeur;

	@Column(name = "serveur_principal", length = 100)
	private String serveurPrincipal;

	@Column(name = "serveur_secondaire", length = 100)
	private String serveurSecondaire;

	@Column(name = "serveur_tertiaire", length = 100)
	private String serveurTertiaire;

	@Column(name = "serveur_quaternaire", length = 100)
	private String serveurQuaternaire;

	@Column(name = "numero_groupe")
	private Integer numeroGroupe = 1;

	@Column(name = "url_base", length = 500)
	private String urlBase;

	@Column(name = "actif")
	private Boolean actif = true;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	// Constructeurs
	public ConfigurationServeurs() {
	}

	public ConfigurationServeurs(Long caisseId, String typeServeur, String serveurPrincipal) {
		this.caisseId = caisseId;
		this.typeServeur = typeServeur;
		this.serveurPrincipal = serveurPrincipal;
	}

	// Relation ManyToOne vers Caisse
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "caisse_id", insertable = false, updatable = false)
	private Caisse caisse;

	public Caisse getCaisse() {
		return caisse;
	}

	public void setCaisse(Caisse caisse) {
		this.caisse = caisse;
	}

	// Getters et Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getCaisseId() {
		return caisseId;
	}

	public void setCaisseId(Long caisseId) {
		this.caisseId = caisseId;
	}

	public String getTypeServeur() {
		return typeServeur;
	}

	public void setTypeServeur(String typeServeur) {
		this.typeServeur = typeServeur;
	}

	public String getServeurPrincipal() {
		return serveurPrincipal;
	}

	public void setServeurPrincipal(String serveurPrincipal) {
		this.serveurPrincipal = serveurPrincipal;
	}

	public String getServeurSecondaire() {
		return serveurSecondaire;
	}

	public void setServeurSecondaire(String serveurSecondaire) {
		this.serveurSecondaire = serveurSecondaire;
	}

	public String getServeurTertiaire() {
		return serveurTertiaire;
	}

	public void setServeurTertiaire(String serveurTertiaire) {
		this.serveurTertiaire = serveurTertiaire;
	}

	public String getServeurQuaternaire() {
		return serveurQuaternaire;
	}

	public void setServeurQuaternaire(String serveurQuaternaire) {
		this.serveurQuaternaire = serveurQuaternaire;
	}

	public Integer getNumeroGroupe() {
		return numeroGroupe;
	}

	public void setNumeroGroupe(Integer numeroGroupe) {
		this.numeroGroupe = numeroGroupe;
	}

	public String getUrlBase() {
		return urlBase;
	}

	public void setUrlBase(String urlBase) {
		this.urlBase = urlBase;
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
		return "ConfigurationServeurs{id=" + id + ", caisseId=" + caisseId + ", typeServeur='" + typeServeur + "'}";
	}
}