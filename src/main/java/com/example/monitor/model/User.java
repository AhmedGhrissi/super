package com.example.monitor.model;

import java.time.LocalDateTime;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(unique = true, nullable = false, length = 50)
	private String username;

	@Column(nullable = false, length = 255)
	private String password;

	@Column(length = 100)
	private String email;

	@Column(name = "nom_complet", nullable = false, length = 100)
	private String nomComplet;

	@Column(length = 20)
	private String role = "OPERATEUR"; // Rôles: SUPER_ADMIN, SUPERVISEUR, TECHNICIEN, OPERATEUR, AUDITEUR

	@Column(name = "caisse_code", length = 10)
	private String caisseCode;

	@Column(name = "actif")
	private boolean actif = true;

	@Column(name = "date_creation")
	private LocalDateTime dateCreation = LocalDateTime.now();

	@Column(name = "date_derniere_connexion")
	private LocalDateTime dateDerniereConnexion;

	// === CONSTRUCTEURS ===
	public User() {
	}

	public User(String username, String password, String nomComplet, String role) {
		this.username = username;
		this.password = password;
		this.nomComplet = nomComplet;
		this.role = role;
	}

	// === MÉTHODES UTILES ===
	public boolean isSuperAdmin() {
		return "SUPER_ADMIN".equals(role);
	}

	public boolean isSuperviseur() {
		return "SUPERVISEUR".equals(role) || isSuperAdmin();
	}

	public boolean isTechnicien() {
		return "TECHNICIEN".equals(role) || isSuperviseur();
	}

	// === GETTERS/SETTERS ===
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNomComplet() {
		return nomComplet;
	}

	public void setNomComplet(String nomComplet) {
		this.nomComplet = nomComplet;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getCaisseCode() {
		return caisseCode;
	}

	public void setCaisseCode(String caisseCode) {
		this.caisseCode = caisseCode;
	}

	public boolean isActif() {
		return actif;
	}

	public void setActif(boolean actif) {
		this.actif = actif;
	}

	public LocalDateTime getDateCreation() {
		return dateCreation;
	}

	public void setDateCreation(LocalDateTime dateCreation) {
		this.dateCreation = dateCreation;
	}

	public LocalDateTime getDateDerniereConnexion() {
		return dateDerniereConnexion;
	}

	public void setDateDerniereConnexion(LocalDateTime dateDerniereConnexion) {
		this.dateDerniereConnexion = dateDerniereConnexion;
	}

	public Date getDateCreationAsDate() {
		return java.sql.Timestamp.valueOf(this.dateCreation);
	}

	public Date getDateDerniereConnexionAsDate() {
		return this.dateDerniereConnexion != null ? java.sql.Timestamp.valueOf(this.dateDerniereConnexion) : null;
	}
}