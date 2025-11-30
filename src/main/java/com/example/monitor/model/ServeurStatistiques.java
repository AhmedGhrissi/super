package com.example.monitor.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "serveur_statistiques")
public class ServeurStatistiques {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "serveur_nom", length = 100)
	private String serveurNom;

	@Column(name = "type_serveur", length = 20)
	private String typeServeur;

	@Column(name = "caisse_code", length = 10)
	private String caisseCode;

	@Column(name = "tests_total")
	private Long testsTotal;

	@Column(name = "tests_succes")
	private Long testsSucces;

	@Column(name = "tests_echec")
	private Long testsEchec;

	@Column(name = "temps_reponse_moyen")
	private Long tempsReponseMoyen;

	@Column(name = "disponibilite_percent", precision = 5, scale = 2)
	private BigDecimal disponibilitePercent;

	@Column(name = "date_maj")
	private LocalDateTime dateMaj;

	// === CONSTRUCTEURS ===
	public ServeurStatistiques() {
		this.testsTotal = 0L;
		this.testsSucces = 0L;
		this.testsEchec = 0L;
		this.tempsReponseMoyen = 0L;
		this.disponibilitePercent = BigDecimal.ZERO;
		this.dateMaj = LocalDateTime.now();
	}

	public ServeurStatistiques(String serveurNom, String typeServeur, String caisseCode) {
		this();
		this.serveurNom = serveurNom;
		this.typeServeur = typeServeur;
		this.caisseCode = caisseCode;
	}

	// === MÉTHODES DE GESTION DES TESTS ===

	public void ajouterTest(boolean succes, Long tempsReponse) {
		if (this.testsTotal == null) {
			this.testsTotal = 0L;
		}
		if (this.testsSucces == null) {
			this.testsSucces = 0L;
		}
		if (this.testsEchec == null) {
			this.testsEchec = 0L;
		}
		if (this.tempsReponseMoyen == null) {
			this.tempsReponseMoyen = 0L;
		}

		this.testsTotal++;

		if (succes) {
			this.testsSucces++;
		} else {
			this.testsEchec++;
		}

		// Calcul du temps de réponse moyen
		if (tempsReponse != null) {
			Long totalTemps = this.tempsReponseMoyen * (this.testsTotal - 1) + tempsReponse;
			this.tempsReponseMoyen = totalTemps / this.testsTotal;
		}

		calculerDisponibilite();
	}

	// Alias pour la compatibilité avec le code existant
	public void incrementerTests(boolean succes, Long tempsReponse) {
		this.ajouterTest(succes, tempsReponse);
	}

	// === MÉTHODE DE CALCUL ===
	public void calculerDisponibilite() {
		if (testsTotal != null && testsTotal > 0) {
			BigDecimal succes = BigDecimal.valueOf(testsSucces);
			BigDecimal total = BigDecimal.valueOf(testsTotal);
			BigDecimal pourcentage = succes.divide(total, 4, RoundingMode.HALF_UP).multiply(BigDecimal.valueOf(100))
					.setScale(2, RoundingMode.HALF_UP);
			this.disponibilitePercent = pourcentage;
		} else {
			this.disponibilitePercent = BigDecimal.ZERO;
		}
		this.dateMaj = LocalDateTime.now();
	}

	// === GETTERS ET SETTERS ===
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getServeurNom() {
		return serveurNom;
	}

	public void setServeurNom(String serveurNom) {
		this.serveurNom = serveurNom;
	}

	public String getTypeServeur() {
		return typeServeur;
	}

	public void setTypeServeur(String typeServeur) {
		this.typeServeur = typeServeur;
	}

	public String getCaisseCode() {
		return caisseCode;
	}

	public void setCaisseCode(String caisseCode) {
		this.caisseCode = caisseCode;
	}

	public Long getTestsTotal() {
		return testsTotal;
	}

	public void setTestsTotal(Long testsTotal) {
		this.testsTotal = testsTotal;
	}

	public Long getTestsSucces() {
		return testsSucces;
	}

	public void setTestsSucces(Long testsSucces) {
		this.testsSucces = testsSucces;
	}

	public Long getTestsEchec() {
		return testsEchec;
	}

	public void setTestsEchec(Long testsEchec) {
		this.testsEchec = testsEchec;
	}

	public Long getTempsReponseMoyen() {
		return tempsReponseMoyen;
	}

	public void setTempsReponseMoyen(Long tempsReponseMoyen) {
		this.tempsReponseMoyen = tempsReponseMoyen;
	}

	public BigDecimal getDisponibilitePercent() {
		return disponibilitePercent;
	}

	public void setDisponibilitePercent(BigDecimal disponibilitePercent) {
		this.disponibilitePercent = disponibilitePercent;
	}

	public LocalDateTime getDateMaj() {
		return dateMaj;
	}

	public void setDateMaj(LocalDateTime dateMaj) {
		this.dateMaj = dateMaj;
	}

	// Méthode utilitaire pour obtenir le pourcentage comme double (si nécessaire)
	public double getDisponibilitePercentAsDouble() {
		return disponibilitePercent != null ? disponibilitePercent.doubleValue() : 0.0;
	}
}