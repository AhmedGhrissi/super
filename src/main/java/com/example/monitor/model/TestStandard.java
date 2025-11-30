package com.example.monitor.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tests_standard")
public class TestStandard {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "code_test", unique = true, length = 50, nullable = false)
	private String codeTest;

	@Column(name = "nom_test", length = 100, nullable = false)
	private String nomTest;

	@Column(name = "categorie_id", nullable = false)
	private Long categorieId;

	@Column(name = "type_test", length = 20)
	private String typeTest = "HTTP";

	@Column(name = "methode_http", length = 10)
	private String methodeHttp = "GET";

	@Column(name = "endpoint", length = 500)
	private String endpoint;

	@Column(name = "port")
	private Integer port = 80;

	@Column(name = "timeout_ms")
	private Integer timeoutMs = 30000;

	@Column(name = "validation_type", length = 20)
	private String validationType = "STATUS_CODE";

	@Column(name = "valeur_attendue", length = 500)
	private String valeurAttendue;

	@Column(name = "status_attendu")
	private Integer statusAttendu = 200;

	@Column(name = "actif")
	private Boolean actif = true;

	@Column(name = "description", columnDefinition = "TEXT")
	private String description;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	// Constructeurs
	public TestStandard() {
	}

	public TestStandard(String codeTest, String nomTest, Long categorieId, String endpoint) {
		this.codeTest = codeTest;
		this.nomTest = nomTest;
		this.categorieId = categorieId;
		this.endpoint = endpoint;
	}

	// Getters et Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCodeTest() {
		return codeTest;
	}

	public void setCodeTest(String codeTest) {
		this.codeTest = codeTest;
	}

	public String getNomTest() {
		return nomTest;
	}

	public void setNomTest(String nomTest) {
		this.nomTest = nomTest;
	}

	public Long getCategorieId() {
		return categorieId;
	}

	public void setCategorieId(Long categorieId) {
		this.categorieId = categorieId;
	}

	public String getTypeTest() {
		return typeTest;
	}

	public void setTypeTest(String typeTest) {
		this.typeTest = typeTest;
	}

	public String getMethodeHttp() {
		return methodeHttp;
	}

	public void setMethodeHttp(String methodeHttp) {
		this.methodeHttp = methodeHttp;
	}

	public String getEndpoint() {
		return endpoint;
	}

	public void setEndpoint(String endpoint) {
		this.endpoint = endpoint;
	}

	public Integer getPort() {
		return port;
	}

	public void setPort(Integer port) {
		this.port = port;
	}

	public Integer getTimeoutMs() {
		return timeoutMs;
	}

	public void setTimeoutMs(Integer timeoutMs) {
		this.timeoutMs = timeoutMs;
	}

	public String getValidationType() {
		return validationType;
	}

	public void setValidationType(String validationType) {
		this.validationType = validationType;
	}

	public String getValeurAttendue() {
		return valeurAttendue;
	}

	public void setValeurAttendue(String valeurAttendue) {
		this.valeurAttendue = valeurAttendue;
	}

	public Integer getStatusAttendu() {
		return statusAttendu;
	}

	public void setStatusAttendu(Integer statusAttendu) {
		this.statusAttendu = statusAttendu;
	}

	public Boolean getActif() {
		return actif;
	}

	public void setActif(Boolean actif) {
		this.actif = actif;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "TestStandard{id=" + id + ", codeTest='" + codeTest + "', nomTest='" + nomTest + "'}";
	}
}