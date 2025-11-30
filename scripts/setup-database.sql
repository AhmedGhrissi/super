-- =============================================
-- SCRIPT COMPLET MACHINE MONITOR - AVEC TOUTES LES INSERTIONS
-- =============================================

-- Création de la base de données
DROP DATABASE IF EXISTS machine_monitor;
CREATE DATABASE machine_monitor
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE machine_monitor;

-- ========================
-- TABLE DES CAISSES
-- ========================
CREATE TABLE caisses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) UNIQUE NOT NULL,
    nom VARCHAR(100) NOT NULL,
    code_partition VARCHAR(10) NOT NULL,
    code_cr VARCHAR(10) NOT NULL,
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_code (code),
    INDEX idx_actif (actif)
);

-- ========================
-- TYPES DE SERVEURS
-- ========================
CREATE TABLE types_serveur (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code_type VARCHAR(20) UNIQUE NOT NULL,
    nom_type VARCHAR(50) NOT NULL,
    description TEXT,
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_code_type (code_type)
);

-- ========================
-- CONFIGURATION DES SERVEURS PAR CAISSE
-- ========================
CREATE TABLE configuration_serveurs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    caisse_id BIGINT NOT NULL,
    type_serveur VARCHAR(20) NOT NULL,
    serveur_principal VARCHAR(100),
    serveur_secondaire VARCHAR(100),
    serveur_tertiaire VARCHAR(100),
    serveur_quaternaire VARCHAR(100),
    numero_groupe INT DEFAULT 1,
    url_base VARCHAR(500),
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (caisse_id) REFERENCES caisses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_caisse_type_groupe (caisse_id, type_serveur, numero_groupe),
    INDEX idx_type_serveur (type_serveur),
    INDEX idx_caisse_actif (caisse_id, actif)
);

-- ========================
-- CATÉGORIES DE TESTS
-- ========================
CREATE TABLE categories_test (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code_categorie VARCHAR(50) UNIQUE NOT NULL,
    nom_categorie VARCHAR(100) NOT NULL,
    description TEXT,
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- TESTS STANDARDS
-- ========================
CREATE TABLE tests_standard (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code_test VARCHAR(50) UNIQUE NOT NULL,
    nom_test VARCHAR(100) NOT NULL,
    categorie_id BIGINT NOT NULL,
    type_test VARCHAR(20) DEFAULT 'HTTP',
    methode_http VARCHAR(10) DEFAULT 'GET',
    endpoint VARCHAR(500),
    port INT DEFAULT 80,
    timeout_ms INT DEFAULT 30000,
    validation_type VARCHAR(20) DEFAULT 'STATUS_CODE',
    valeur_attendue VARCHAR(500),
    status_attendu INT DEFAULT 200,
    actif BOOLEAN DEFAULT TRUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categorie_id) REFERENCES categories_test(id),
    INDEX idx_code_test (code_test),
    INDEX idx_categorie (categorie_id)
);

-- ========================
-- CONFIGURATION DES TESTS PAR CAISSE
-- ========================
CREATE TABLE configuration_tests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    caisse_id BIGINT NOT NULL,
    test_id BIGINT NOT NULL,
    serveur_cible VARCHAR(100),
    url_complete VARCHAR(500),
    actif BOOLEAN DEFAULT TRUE,
    ordre_execution INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (caisse_id) REFERENCES caisses(id) ON DELETE CASCADE,
    FOREIGN KEY (test_id) REFERENCES tests_standard(id),
    UNIQUE KEY unique_caisse_test (caisse_id, test_id),
    INDEX idx_caisse_actif (caisse_id, actif),
    INDEX idx_serveur_cible (serveur_cible)
);

-- ========================
-- RÉSULTATS DES TESTS
-- ========================
CREATE TABLE resultats_tests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    config_test_id BIGINT NOT NULL,
    succes BOOLEAN DEFAULT FALSE,
    temps_reponse BIGINT,
    code_statut INT,
    message TEXT,
    date_execution TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    serveur_cible VARCHAR(100),
    caisse_code VARCHAR(10),
    type_serveur VARCHAR(20),
    FOREIGN KEY (config_test_id) REFERENCES configuration_tests(id) ON DELETE CASCADE,
    INDEX idx_date_execution (date_execution),
    INDEX idx_succes (succes),
    INDEX idx_serveur_cible (serveur_cible),
    INDEX idx_caisse_code (caisse_code),
    INDEX idx_type_serveur (type_serveur),
    INDEX idx_date_caisse (date_execution, caisse_code)
);

-- ========================
-- TABLE DE STATISTIQUES DES SERVEURS (NOUVELLE)
-- ========================
CREATE TABLE serveur_statistiques (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    serveur_nom VARCHAR(100) NOT NULL,
    type_serveur VARCHAR(20) NOT NULL,
    caisse_code VARCHAR(10),
    tests_total BIGINT DEFAULT 0,
    tests_succes BIGINT DEFAULT 0,
    tests_echec BIGINT DEFAULT 0,
    temps_reponse_moyen BIGINT DEFAULT 0,
    disponibilite_percent DECIMAL(5,2) DEFAULT 0,
    date_maj TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_serveur (serveur_nom),
    INDEX idx_serveur_nom (serveur_nom),
    INDEX idx_type_serveur (type_serveur),
    INDEX idx_caisse_code (caisse_code)
);

-- ========================
-- TABLE DES SERVEURS (EXISTANTE - DOIT ÊTRE CRÉÉE EN PREMIER)
-- ========================
CREATE TABLE serveurs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    type_serveur ENUM('APPLICATION', 'BASE_DONNEES', 'WEB', 'FICHIERS'),
    environnement ENUM('PRODUCTION', 'PREPRODUCTION', 'DEVELOPPEMENT', 'TEST', 'QUALIFICATION'),
    statut ENUM('ACTIF', 'MAINTENANCE', 'HORS_LIGNE', 'EN_PANNE', 'EN_TEST'),
    caisse_code VARCHAR(10),
    adresse_ip VARCHAR(15),
    version_logiciel VARCHAR(20),
    port_ssh INTEGER,
    description TEXT,
    notes TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nom (nom),
    INDEX idx_caisse_code (caisse_code),
    INDEX idx_statut (statut),
    INDEX idx_environnement (environnement)
);

-- ========================
-- ========================
-- TABLE DES MISES À JOUR
-- ========================
CREATE TABLE mises_a_jour (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    serveur_id BIGINT,
    version VARCHAR(50) NOT NULL,
    date_application DATE NOT NULL,
    type_mise_a_jour ENUM('CRITIQUE', 'SECURITE', 'FONCTIONNEL', 'CORRECTIF'),
    description TEXT,
    responsable VARCHAR(100),
    statut ENUM('PLANIFIEE', 'EN_COURS', 'TERMINEE', 'ECHEC'),
    -- AJOUT DES COLONNES MANQUANTES
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- CONTRAINTES
    FOREIGN KEY (serveur_id) REFERENCES serveurs(id),
    INDEX idx_date_application (date_application),
    INDEX idx_statut (statut)
);

-- ========================
-- TABLE DES UTILISATEURS
-- ========================
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    nom_complet VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'OPERATEUR',
    caisse_code VARCHAR(10),
    actif BOOLEAN DEFAULT TRUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_derniere_connexion TIMESTAMP NULL,
    INDEX idx_username (username),
    INDEX idx_role (role),
    INDEX idx_caisse (caisse_code)
);

-- ========================
-- RÔLES DISPONIBLES
-- ========================
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code_role VARCHAR(20) UNIQUE NOT NULL,
    nom_role VARCHAR(50) NOT NULL,
    permissions TEXT,
    description TEXT
);

CREATE TABLE IF NOT EXISTS email_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sujet VARCHAR(255) NOT NULL,
    destinataires TEXT NOT NULL,
    type_alerte VARCHAR(50),
    serveur_cible VARCHAR(100),
    date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut VARCHAR(20) DEFAULT 'ENVOYE',
    erreur TEXT,

    INDEX idx_date_envoi (date_envoi),
    INDEX idx_serveur_cible (serveur_cible),
    INDEX idx_type_alerte (type_alerte)
);

-- ========================
-- TABLE DES LOGS D'AUDIT
-- ========================
CREATE TABLE IF NOT EXISTS audit_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50) NOT NULL,
    resource VARCHAR(50) NOT NULL,
    resource_id VARCHAR(100) NOT NULL,
    description TEXT,
    username VARCHAR(100) NOT NULL,
    user_role VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    success BOOLEAN DEFAULT TRUE,
    error_message TEXT,
    execution_time BIGINT,

    -- Index pour les performances
    INDEX idx_timestamp (timestamp),
    INDEX idx_username (username),
    INDEX idx_action (action),
    INDEX idx_resource (resource),
    INDEX idx_success (success),
    INDEX idx_resource_id (resource_id),
    INDEX idx_user_role (user_role),
    INDEX idx_timestamp_username (timestamp, username)
);

-- ========================
-- VUE POUR LES STATISTIQUES D'AUDIT
-- ========================
CREATE OR REPLACE VIEW vue_audit_stats AS
SELECT
    COUNT(*) as total_actions,
    SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) as successful_actions,
    SUM(CASE WHEN success = FALSE THEN 1 ELSE 0 END) as failed_actions,
    CASE
        WHEN COUNT(*) > 0 THEN ROUND((SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2)
        ELSE 0
    END as success_rate,
    COUNT(DISTINCT username) as unique_users,
    COUNT(DISTINCT resource) as unique_resources,
    MIN(timestamp) as first_action,
    MAX(timestamp) as last_action
FROM audit_logs;

-- ========================
-- VUE POUR L'ACTIVITÉ RÉCENTE (24H)
-- ========================
CREATE OR REPLACE VIEW vue_activite_recente AS
SELECT
    DATE(timestamp) as date_action,
    HOUR(timestamp) as heure_action,
    COUNT(*) as total_actions,
    SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) as successful_actions,
    SUM(CASE WHEN success = FALSE THEN 1 ELSE 0 END) as failed_actions,
    resource,
    action
FROM audit_logs
WHERE timestamp >= NOW() - INTERVAL 24 HOUR
GROUP BY DATE(timestamp), HOUR(timestamp), resource, action
ORDER BY date_action DESC, heure_action DESC;

-- ========================
-- VUE POUR LES ACTIONS PAR UTILISATEUR
-- ========================
CREATE OR REPLACE VIEW vue_actions_utilisateur AS
SELECT
    username,
    user_role,
    COUNT(*) as total_actions,
    SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) as successful_actions,
    SUM(CASE WHEN success = FALSE THEN 1 ELSE 0 END) as failed_actions,
    CASE
        WHEN COUNT(*) > 0 THEN ROUND((SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2)
        ELSE 0
    END as success_rate,
    AVG(execution_time) as avg_execution_time,
    MIN(timestamp) as first_action,
    MAX(timestamp) as last_action
FROM audit_logs
GROUP BY username, user_role
ORDER BY total_actions DESC;

-- ========================
-- VUE POUR LES RESSOURCES LES PLUS UTILISÉES
-- ========================
CREATE OR REPLACE VIEW vue_ressources_utilisees AS
SELECT
    resource,
    action,
    COUNT(*) as total_actions,
    SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) as successful_actions,
    SUM(CASE WHEN success = FALSE THEN 1 ELSE 0 END) as failed_actions,
    CASE
        WHEN COUNT(*) > 0 THEN ROUND((SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2)
        ELSE 0
    END as success_rate,
    AVG(execution_time) as avg_execution_time
FROM audit_logs
GROUP BY resource, action
ORDER BY total_actions DESC;

-- ========================
-- INSERTION DE DONNÉES D'AUDIT EXEMPLES
-- ========================
INSERT INTO audit_logs (action, resource, resource_id, description, username, user_role, ip_address, user_agent, success, execution_time) VALUES
('READ', 'DASHBOARD', 'MAIN', 'Consultation du tableau de bord principal', 'admin', 'SUPERVISEUR', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', TRUE, 150),
('EXECUTE', 'TEST', 'SWIFPAGEDC11', 'Lancement test rapide sur le serveur', 'technicien.idf', 'TECHNICIEN', '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', TRUE, 2300),
('READ', 'SERVEUR', 'SWAQPAGEDC20', 'Consultation des détails du serveur', 'operateur.aq', 'OPERATEUR', '192.168.1.102', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36', TRUE, 80),
('CREATE', 'RAPPORT', 'HEBDOMADAIRE_2024', 'Génération rapport hebdomadaire', 'admin', 'SUPERVISEUR', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', TRUE, 4500),
('READ', 'STATISTIQUES', 'GLOBAL', 'Consultation des statistiques globales', 'consultant', 'CONSULTANT', '192.168.1.103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', TRUE, 120);

-- ========================
-- PROCÉDURE POUR NETTOYER LES VIEUX LOGS (AUTOMATISATION)
-- ========================
DELIMITER //

CREATE PROCEDURE nettoyer_logs_audit(IN jours_retention INT)
BEGIN
    DELETE FROM audit_logs
    WHERE timestamp < NOW() - INTERVAL jours_retention DAY;

    SELECT CONCAT('Logs d''audit nettoyés. ', ROW_COUNT(), ' enregistrements supprimés.') as resultat;
END//

DELIMITER ;

-- ========================
-- ÉVÉNEMENT POUR NETTOYAGE AUTOMATIQUE (90 JOURS)
-- ========================
DELIMITER //

CREATE EVENT IF NOT EXISTS nettoyage_automatique_audit
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
BEGIN
    CALL nettoyer_logs_audit(90);
END//

DELIMITER ;

-- ========================
-- FONCTION POUR STATISTIQUES D'AUDIT
-- ========================
DELIMITER //

CREATE FUNCTION get_audit_stats_period(debut TIMESTAMP, fin TIMESTAMP)
RETURNS JSON
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE stats JSON;

    SELECT JSON_OBJECT(
        'total_actions', COUNT(*),
        'successful_actions', SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END),
        'failed_actions', SUM(CASE WHEN success = FALSE THEN 1 ELSE 0 END),
        'success_rate', CASE
            WHEN COUNT(*) > 0 THEN ROUND((SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2)
            ELSE 0
        END,
        'unique_users', COUNT(DISTINCT username),
        'avg_execution_time', ROUND(AVG(execution_time), 2),
        'top_resource', (
            SELECT resource
            FROM audit_logs
            WHERE timestamp BETWEEN debut AND fin
            GROUP BY resource
            ORDER BY COUNT(*) DESC
            LIMIT 1
        ),
        'top_user', (
            SELECT username
            FROM audit_logs
            WHERE timestamp BETWEEN debut AND fin
            GROUP BY username
            ORDER BY COUNT(*) DESC
            LIMIT 1
        )
    ) INTO stats
    FROM audit_logs
    WHERE timestamp BETWEEN debut AND fin;

    RETURN stats;
END//

DELIMITER ;

-- ========================
-- MISE À JOUR DES PRIVILÈGES
-- ========================
GRANT EXECUTE ON PROCEDURE machine_monitor.nettoyer_logs_audit TO 'monitor_user'@'localhost';
GRANT EXECUTE ON FUNCTION machine_monitor.get_audit_stats_period TO 'monitor_user'@'localhost';

-- ========================
-- VÉRIFICATION DE LA MISE À JOUR
-- ========================
SELECT '==========================================' as '';
SELECT 'MISE À JOUR BDD AUDIT TERMINÉE!' as '';
SELECT '==========================================' as '';
SELECT '' as '';
SELECT 'Tables créées:' as '';
SHOW TABLES LIKE '%audit%';
SELECT '' as '';
SELECT 'Vues créées:' as '';
SHOW TABLES LIKE 'vue%';
SELECT '' as '';
SELECT 'Données d''exemple insérées:' as '';
SELECT COUNT(*) as 'Logs d''audit' FROM audit_logs;
SELECT '' as '';
SELECT 'Test de la vue statistiques:' as '';
SELECT * FROM vue_audit_stats;
SELECT '' as '';
SELECT 'TOP 5 utilisateurs les plus actifs:' as '';
SELECT username, user_role, total_actions, success_rate
FROM vue_actions_utilisateur
ORDER BY total_actions DESC
LIMIT 5;
SELECT '' as '';
SELECT 'Ressources les plus utilisées:' as '';
SELECT resource, action, total_actions, success_rate
FROM vue_ressources_utilisees
ORDER BY total_actions DESC
LIMIT 5;

-- ========================
-- INSERTION DES DONNÉES DE BASE
-- ========================

-- Insertion des caisses
INSERT INTO caisses (code, nom, code_partition, code_cr) VALUES
('AL', 'Alpes-Provence', 'CRA0', '813'),
('AM', 'Anjou-Maine', 'CRA2', '879'),
('AO', 'Alsace-Vosges', 'CRA4', '872'),
('IF', 'Paris-Ile-de-France', 'CRA6', '882'),
('AQ', 'Aquitaine', 'CRA8', '833'),
('AV', 'Atlantique-Vendée', 'CRB0', '847'),
('BI', 'Brie-Picardie', 'CRB2', '887'),
('CA', 'Côtes d''Armor', 'CRB6', '822'),
('CE', 'Charente-Périgord', 'CRB8', '824'),
('CL', 'Centre-Loire', 'CRC0', '848'),
('CO', 'Centre-Ouest', 'CRC2', '895'),
('CR', 'Corse', 'CRC6', '820'),
('CS', 'Charente-Maritime Deux-Sèvres', 'CRC8', '817'),
('FI', 'Finistère', 'CRD2', '829'),
('GU', 'Guadeloupe', 'CRD4', '900'),
('FC', 'Franche-Comté', 'CRE0', '825'),
('LA', 'Languedoc', 'CRE4', '835'),
('LO', 'Lorraine', 'CRE6', '861'),
('MA', 'Martinique', 'CRF0', '902'),
('MO', 'Morbihan', 'CRF2', '860'),
('NE', 'Nord-Est', 'CRF4', '802'),
('NF', 'Nord De France', 'CRF6', '867'),
('NM', 'Nord Midi-Pyrénées', 'CRF8', '812'),
('NO', 'Normandie', 'CRG0', '866'),
('NS', 'Normandie-Seine', 'CRG2', '883'),
('PG', 'Pyrénées-Gascogne', 'CRG4', '869'),
('RE', 'Réunion', 'CRG6', '903'),
('IV', 'Ille et Vilaine', 'CRG8', '836'),
('SM', 'Sud Méditerranée', 'CRH0', '871'),
('TO', 'Toulouse', 'CRH2', '831'),
('TP', 'Touraine-Poitou', 'CRH4', '894'),
('VF', 'Val-de-France', 'CRH6', '844'),
('AP', 'Savoie', 'CRH8', '881'),
('BP', 'Centre-France', 'CRI0', '868'),
('CP', 'Provence-Côtes-d''Azur', 'CRI2', '891'),
('RP', 'Sud Rhône-Alpes', 'CRI4', '839'),
('JP', 'Champagne-Bourgogne', 'CRI6', '810'),
('KP', 'Loire Haute-Loire', 'CRI8', '845'),
('LP', 'Centre-Est', 'CRK6', '878'),
('DP', 'Banque Chalus', 'BAN2', '764');

-- Insertion des types de serveurs
INSERT INTO types_serveur (code_type, nom_type, description) VALUES
('frontal', 'Serveur Frontal', 'Serveur frontal pour les applications caisses'),
('backoffice', 'Serveur BackOffice', 'Serveur backoffice SQL'),
('betaweb', 'Serveur BetaWeb', 'Serveur BetaWeb pour interface web'),
('filenet', 'Serveur FileNet', 'Serveur FileNet pour la GED');

-- Insertion des catégories de tests
INSERT INTO categories_test (code_categorie, nom_categorie, description) VALUES
('conformite', 'Tests Conformité', 'Tests relatifs à la conformité des documents'),
('processus_metier', 'Processus Métier', 'Tests des processus métier Geide'),
('surveillance', 'Surveillance', 'Tests de surveillance des services'),
('ged', 'GED', 'Tests de la Gestion Electronique de Documents'),
('integration', 'Intégration', 'Tests d''intégration et interfaces'),
('web', 'Applications Web', 'Tests des applications web');

-- Insertion des tests standards
INSERT INTO tests_standard (code_test, nom_test, categorie_id, type_test, endpoint, validation_type, valeur_attendue, description) VALUES
('conformite_cold', 'Conformité Cold', 1, 'HTTP', '/geidecamservicesconformite/SGPGeideServer', 'STATUS_CODE', '200', 'Test conformité cold'),
('conformite_image', 'Conformité Image', 1, 'HTTP', '/geidecamservicesconformite/SGPGeideServer', 'STATUS_CODE', '200', 'Test conformité image'),
('check_vip', 'Check VIP', 3, 'HTTP', '/SurveillanceTomcat/ControleServlet', 'RESPONSE_TEXT', 'Retour : success', 'Test VIP sur les frontaux'),
('divers_tomcat', 'Divers Tomcat', 3, 'HTTP', '/SurveillanceTomcat', 'STATUS_CODE', '200', 'Test divers Tomcat'),
('pm1', 'PM1', 2, 'HTTP', '/geidecamservicesconformite', 'STATUS_CODE', '200', 'Test PM1'),
('pm1b', 'PM1B', 2, 'HTTP', '/greengeidecamservices', 'STATUS_CODE', '200', 'Test PM1B'),
('pm1b_cold', 'PM1B Cold', 2, 'HTTP', '/greengeidecamservices/SGPGeideServer', 'STATUS_CODE', '200', 'Test PM1B cold'),
('pm1b_image', 'PM1B Image', 2, 'HTTP', '/greengeidecamservices/SGPGeideServer', 'STATUS_CODE', '200', 'Test PM1B image'),
('pm1c', 'PM1C', 2, 'HTTP', '/servicesgeidecam', 'STATUS_CODE', '200', 'Test PM1C'),
('pm2', 'PM2', 2, 'HTTP', '/processusmetierbam', 'STATUS_CODE', '200', 'Test PM2'),
('pm4', 'PM4', 2, 'HTTP', '/pmtranscodageged/SGPGeideServer', 'STATUS_CODE', '200', 'Test PM4'),
('pm5', 'PM5', 2, 'HTTP', '/pmrechlistdocged', 'STATUS_CODE', '200', 'Test PM5'),
('cold_transfert', 'Cold Transfert', 4, 'HTTP', '/pmtransfererdocumentsged/SGPGeideServer', 'STATUS_CODE', '200', 'Nouveau test cold'),
('integration_dnc', 'Intégration DNC', 4, 'HTTP', '/pmimagededocumentDNC/SGPGeideServer', 'STATUS_CODE', '200', 'Nouveau test integration'),
('pm3_image', 'PM3 Image', 4, 'HTTP', '/pmimagededocumentged/SGPGeideServer', 'STATUS_CODE', '200', 'Nouveau test pm3'),
('restitution', 'Restitution', 6, 'HTTP', '/restitutioncredit', 'STATUS_CODE', '200', 'Test restitution'),
('betaview', 'BetaView', 6, 'HTTPS', '/betaview/start.action', 'STATUS_CODE', '200', 'Test BetaView'),
('spark', 'Spark Archives', 6, 'HTTP', '/spark_archives/spark/login', 'STATUS_CODE', '200', 'Test Spark'),
('filenet_ws', 'FileNet WebService', 5, 'HTTP', '/wsi/FNCEWS40MTOM', 'STATUS_CODE', '200', 'Test FileNet WebService'),
('filenet_health', 'FileNet Health', 5, 'HTTP', '/P8CE/Health', 'STATUS_CODE', '200', 'Test FileNet Health');

-- ========================
-- CONFIGURATION DES SERVEURS PAR CAISSE - TOUS LES SERVEURS
-- ========================

-- Configuration des serveurs frontaux (Groupes 1 - Toutes les caisses)
INSERT INTO configuration_serveurs (caisse_id, type_serveur, serveur_principal, serveur_secondaire, serveur_tertiaire, serveur_quaternaire, numero_groupe)
SELECT id, 'frontal',
    CONCAT('SW', code, 'PAGEDC11'),
    CONCAT('SW', code, 'PAGEDC12'),
    CONCAT('SW', code, 'PAGEDC13'),
    CONCAT('SW', code, 'PAGEDC14'),
    1
FROM caisses
WHERE code IN ('DP','NE','JP','NM','AL','CS','CR','CA','CE','FC','FI','TO','LA','IV','RP','VF','KP','AV','CL','MO','LO','NO','NF','BP','PG','SM','AO','LP','AM','AP','NS','BI','CP','TP','CO','GU','MA','RE');

-- Configuration groupes supplémentaires pour IDF
INSERT INTO configuration_serveurs (caisse_id, type_serveur, serveur_principal, serveur_secondaire, serveur_tertiaire, serveur_quaternaire, numero_groupe)
SELECT id, 'frontal', 'SWIFPAGEDC20', 'SWIFPAGEDC21', 'SWIFPAGEDC22', 'SWIFPAGEDC23', 2
FROM caisses WHERE code = 'IF';

INSERT INTO configuration_serveurs (caisse_id, type_serveur, serveur_principal, serveur_secondaire, numero_groupe)
SELECT id, 'frontal', 'SWIFPAGEDC24', 'SWIFPAGEDC25', 3
FROM caisses WHERE code = 'IF';

-- Configuration groupes supplémentaires pour Aquitaine
INSERT INTO configuration_serveurs (caisse_id, type_serveur, serveur_principal, serveur_secondaire, serveur_tertiaire, serveur_quaternaire, numero_groupe)
SELECT id, 'frontal', 'SWAQPAGEDC20', 'SWAQPAGEDC21', 'SWAQPAGEDC22', 'SWAQPAGEDC23', 2
FROM caisses WHERE code = 'AQ';

-- Configuration BackOffice
INSERT INTO configuration_serveurs (caisse_id, type_serveur, serveur_principal, numero_groupe)
SELECT c.id, 'backoffice',
    CASE c.code
        WHEN 'AL' THEN 'SWALPD1SQL10' WHEN 'AM' THEN 'SWAMPD1SQL02' WHEN 'AO' THEN 'SWAOPD1SQL10'
        WHEN 'AP' THEN 'SWAPPD1SQL10' WHEN 'AQ' THEN 'SWAQPD1SQL02' WHEN 'AV' THEN 'SWAVPD1SQL02'
        WHEN 'BI' THEN 'SWBIPD1SQL10' WHEN 'BP' THEN 'SWBPPD1SQL02' WHEN 'CA' THEN 'SWCAPD1SQL02'
        WHEN 'CE' THEN 'SWCEPD1SQL02' WHEN 'CL' THEN 'SWCLPD1SQL10' WHEN 'CO' THEN 'SWCOPD1SQL02'
        WHEN 'CP' THEN 'SWCPPD1SQL02' WHEN 'CR' THEN 'SWCRPD1SQL10' WHEN 'CS' THEN 'SWCSPD1SQL10'
        WHEN 'DP' THEN 'SWDPPD1SQL02' WHEN 'FC' THEN 'SWFCPD1SQL10' WHEN 'FI' THEN 'SWFIPD1SQL02'
        WHEN 'GU' THEN 'SWGUPD1SQL02' WHEN 'IF' THEN 'SWIFPD1SQL03' WHEN 'IV' THEN 'SWIVPD1SQL10'
        WHEN 'JP' THEN 'SWJPPD1SQL02' WHEN 'KP' THEN 'SWKPPD1SQL02' WHEN 'LA' THEN 'SWLAPD1SQL10'
        WHEN 'LO' THEN 'SWLOPD1SQL10' WHEN 'LP' THEN 'SWLPPD1SQL02' WHEN 'MA' THEN 'SWMAPD1SQL02'
        WHEN 'MO' THEN 'SWMOPD1SQL02' WHEN 'NE' THEN 'SWNEPD1SQL02' WHEN 'NF' THEN 'SWNFPD1SQL03'
        WHEN 'NM' THEN 'SWNMPD1SQL10' WHEN 'NO' THEN 'SWNOPD1SQL02' WHEN 'NS' THEN 'SWNSPD1SQL02'
        WHEN 'PG' THEN 'SWPGPD1SQL02' WHEN 'RE' THEN 'SWREPD1SQL10' WHEN 'RP' THEN 'SWRPPD1SQL10'
        WHEN 'SM' THEN 'SWSMPD1SQL10' WHEN 'TO' THEN 'SWTOPD1SQL10' WHEN 'TP' THEN 'SWTPPD1SQL02'
        WHEN 'VF' THEN 'SWVFPD1SQL02'
    END,
    1
FROM caisses c WHERE c.code != 'CP';

-- Configuration BetaWeb
INSERT INTO configuration_serveurs (caisse_id, type_serveur, serveur_principal, numero_groupe)
SELECT c.id, 'betaweb',
    CASE c.code
        WHEN 'DP' THEN 'SWDPPAB93003' WHEN 'NE' THEN 'SWNEPAB93003' WHEN 'JP' THEN 'SWJPPAB93003'
        WHEN 'NM' THEN 'SWNMPAB93003' WHEN 'AL' THEN 'SWALPAB93003' WHEN 'CS' THEN 'SWCSPAB93003'
        WHEN 'CR' THEN 'SWCRPAB93003' WHEN 'CA' THEN 'SWCAPAB93003' WHEN 'CE' THEN 'SWCEPAB93003'
        WHEN 'FC' THEN 'SWFCPAB93003' WHEN 'FI' THEN 'SWFIPAB93003' WHEN 'TO' THEN 'SWTOPAB93003'
        WHEN 'AQ' THEN 'SWAQPAB93003' WHEN 'LA' THEN 'SWLAPAB93003' WHEN 'IV' THEN 'SWIVPAB93003'
        WHEN 'RP' THEN 'SWRPPAB93003' WHEN 'VF' THEN 'SWVFPAB93003' WHEN 'KP' THEN 'SWKPPAB93003'
        WHEN 'AV' THEN 'SWAVPAB93003' WHEN 'CL' THEN 'SWCLPAB93003' WHEN 'MO' THEN 'SWMOPAB93003'
        WHEN 'LO' THEN 'SWLOPAB93003' WHEN 'NO' THEN 'SWNOPAB93003' WHEN 'NF' THEN 'SWNFPAB93003'
        WHEN 'BP' THEN 'SWBPPAB93003' WHEN 'PG' THEN 'SWPGPAB93003' WHEN 'SM' THEN 'SWSMPAB93003'
        WHEN 'AO' THEN 'SWAOPAB93003' WHEN 'LP' THEN 'SWLPPAB93003' WHEN 'AM' THEN 'SWAMPAB93003'
        WHEN 'AP' THEN 'SWAPPAB93003' WHEN 'IF' THEN 'SWIFPAB93003' WHEN 'NS' THEN 'SWNSPAB93003'
        WHEN 'BI' THEN 'SWBIPAB93003' WHEN 'CP' THEN 'SWCPPAB93003' WHEN 'TP' THEN 'SWTPPAB93003'
        WHEN 'CO' THEN 'SWCOPAB93003' WHEN 'GU' THEN 'SWGUPAB93003' WHEN 'MA' THEN 'SWMAPAB93003'
        WHEN 'RE' THEN 'SWREPAB93003'
    END,
    1
FROM caisses c;

-- ========================
-- CONFIGURATION DES TESTS
-- ========================

-- Tests VIP sur tous les serveurs principaux frontaux
INSERT INTO configuration_tests (caisse_id, test_id, serveur_cible, ordre_execution)
SELECT c.id, t.id, cs.serveur_principal, 1
FROM caisses c
CROSS JOIN tests_standard t
JOIN configuration_serveurs cs ON cs.caisse_id = c.id AND cs.type_serveur = 'frontal' AND cs.numero_groupe = 1
WHERE t.code_test = 'check_vip' AND c.actif = TRUE;

-- Tests Tomcat sur tous les serveurs frontaux
INSERT INTO configuration_tests (caisse_id, test_id, serveur_cible, ordre_execution)
SELECT c.id, t.id, cs.serveur_principal, 2
FROM caisses c
CROSS JOIN tests_standard t
JOIN configuration_serveurs cs ON cs.caisse_id = c.id AND cs.type_serveur = 'frontal' AND cs.numero_groupe = 1
WHERE t.code_test = 'divers_tomcat' AND c.actif = TRUE;

-- Tests BetaView spécifiques
INSERT INTO configuration_tests (caisse_id, test_id, serveur_cible, url_complete, ordre_execution)
SELECT c.id, t.id, cs.serveur_principal,
    CONCAT('https://', LOWER(c.code), 'p10-b930-betaview.ca-technologies.fr/betaview/start.action'),
    10
FROM caisses c
CROSS JOIN tests_standard t
JOIN configuration_serveurs cs ON cs.caisse_id = c.id AND cs.type_serveur = 'betaweb'
WHERE t.code_test = 'betaview' AND c.actif = TRUE;

-- Tests Spark sur serveurs frontaux
INSERT INTO configuration_tests (caisse_id, test_id, serveur_cible, ordre_execution)
SELECT c.id, t.id, cs.serveur_principal, 15
FROM caisses c
CROSS JOIN tests_standard t
JOIN configuration_serveurs cs ON cs.caisse_id = c.id AND cs.type_serveur = 'frontal' AND cs.numero_groupe = 1
WHERE t.code_test = 'spark' AND c.actif = TRUE;

-- Tests FileNet pour les caisses principales
INSERT INTO configuration_tests (caisse_id, test_id, serveur_cible, ordre_execution)
SELECT c.id, t.id, 'hlmupp1was01.zres.ztech', 20
FROM caisses c
CROSS JOIN tests_standard t
WHERE t.code_test IN ('filenet_ws', 'filenet_health')
AND c.code IN ('IF', 'AQ', 'RP', 'BI')  -- Caisses principales avec FileNet
AND c.actif = TRUE;

-- Tests processus métier sur serveurs frontaux
INSERT INTO configuration_tests (caisse_id, test_id, serveur_cible, ordre_execution)
SELECT c.id, t.id, cs.serveur_principal, 5
FROM caisses c
CROSS JOIN tests_standard t
JOIN configuration_serveurs cs ON cs.caisse_id = c.id AND cs.type_serveur = 'frontal' AND cs.numero_groupe = 1
WHERE t.code_test IN ('pm1', 'pm1b', 'pm2', 'pm4', 'pm5') AND c.actif = TRUE;

-- ========================
-- INSERTION DES SERVEURS DANS LA TABLE SERVEURS (POUR COMPATIBILITÉ)
-- ========================

-- Insertion des serveurs frontaux
INSERT IGNORE INTO serveurs (nom, type_serveur, environnement, statut, caisse_code, adresse_ip, version_logiciel)
SELECT
    cs.serveur_principal,
    'APPLICATION',
    'PRODUCTION',
    'ACTIF',
    c.code,
    CONCAT('192.168.1.', FLOOR(RAND() * 255)),
    '2.5.0'
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_principal IS NOT NULL AND cs.type_serveur = 'frontal';

INSERT IGNORE INTO serveurs (nom, type_serveur, environnement, statut, caisse_code, adresse_ip, version_logiciel)
SELECT
    cs.serveur_secondaire,
    'APPLICATION',
    'PRODUCTION',
    'ACTIF',
    c.code,
    CONCAT('192.168.1.', FLOOR(RAND() * 255)),
    '2.5.0'
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_secondaire IS NOT NULL AND cs.type_serveur = 'frontal';

-- Insertion des serveurs backoffice
INSERT IGNORE INTO serveurs (nom, type_serveur, environnement, statut, caisse_code, adresse_ip, version_logiciel)
SELECT
    cs.serveur_principal,
    'BASE_DONNEES',
    'PREPRODUCTION',
    'ACTIF',
    c.code,
    CONCAT('192.168.2.', FLOOR(RAND() * 255)),
    '2019.0'
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_principal IS NOT NULL AND cs.type_serveur = 'backoffice';

-- Insertion des serveurs betaweb
INSERT IGNORE INTO serveurs (nom, type_serveur, environnement, statut, caisse_code, adresse_ip, version_logiciel)
SELECT
    cs.serveur_principal,
    'WEB',
    'DEVELOPPEMENT',
    'ACTIF',
    c.code,
    CONCAT('192.168.3.', FLOOR(RAND() * 255)),
    '1.3.0'
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_principal IS NOT NULL AND cs.type_serveur = 'betaweb';

-- ========================
-- INITIALISATION DES STATISTIQUES SERVEURS (NOUVELLE TABLE)
-- ========================

-- Insertion des serveurs frontaux dans les statistiques
INSERT IGNORE INTO serveur_statistiques (serveur_nom, type_serveur, caisse_code)
SELECT DISTINCT serveur_principal, 'frontal', c.code
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_principal IS NOT NULL
  AND cs.serveur_principal != '';

INSERT IGNORE INTO serveur_statistiques (serveur_nom, type_serveur, caisse_code)
SELECT DISTINCT serveur_secondaire, 'frontal', c.code
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_secondaire IS NOT NULL
  AND cs.serveur_secondaire != '';

INSERT IGNORE INTO serveur_statistiques (serveur_nom, type_serveur, caisse_code)
SELECT DISTINCT serveur_tertiaire, 'frontal', c.code
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_tertiaire IS NOT NULL
  AND cs.serveur_tertiaire != '';

INSERT IGNORE INTO serveur_statistiques (serveur_nom, type_serveur, caisse_code)
SELECT DISTINCT serveur_quaternaire, 'frontal', c.code
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.serveur_quaternaire IS NOT NULL
  AND cs.serveur_quaternaire != '';

-- Insertion des serveurs BackOffice
INSERT IGNORE INTO serveur_statistiques (serveur_nom, type_serveur, caisse_code)
SELECT DISTINCT serveur_principal, 'backoffice', c.code
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.type_serveur = 'backoffice'
  AND cs.serveur_principal IS NOT NULL
  AND cs.serveur_principal != '';

-- Insertion des serveurs BetaWeb
INSERT IGNORE INTO serveur_statistiques (serveur_nom, type_serveur, caisse_code)
SELECT DISTINCT serveur_principal, 'betaweb', c.code
FROM configuration_serveurs cs
JOIN caisses c ON cs.caisse_id = c.id
WHERE cs.type_serveur = 'betaweb'
  AND cs.serveur_principal IS NOT NULL
  AND cs.serveur_principal != '';

-- ========================
-- INSERTION DES RÔLES
-- ========================
INSERT INTO roles (code_role, nom_role, permissions, description) VALUES
('SUPERVISEUR', 'Superviseur', 'READ,WRITE,EXECUTE,ADMIN', 'Accès complet à toutes les fonctionnalités'),
('OPERATEUR', 'Opérateur', 'READ,EXECUTE', 'Peut visualiser et lancer des tests'),
('TECHNICIEN', 'Technicien', 'READ,WRITE', 'Peut configurer les tests'),
('CONSULTANT', 'Consultant', 'READ', 'Accès lecture seule');

-- ========================
-- UTILISATEURS PAR DÉFAUT
-- ========================
INSERT INTO users (username, password, email, nom_complet, role, caisse_code) VALUES
('admin', '$2a$12$ABCDE1234567890ABCDEFO.abcdefghijklmnopqrstuvwxyzABCD', 'admin@monitor.fr', 'Administrateur Système', 'SUPERVISEUR', NULL),
('technicien.idf', '$2a$12$ABCDE1234567890ABCDEFO.abcdefghijklmnopqrstuvwxyzABCD', 'tech.idf@monitor.fr', 'Technicien IDF', 'TECHNICIEN', 'IF'),
('operateur.aq', '$2a$12$ABCDE1234567890ABCDEFO.abcdefghijklmnopqrstuvwxyzABCD', 'op.aq@monitor.fr', 'Opérateur Aquitaine', 'OPERATEUR', 'AQ'),
('consultant', '$2a$12$ABCDE1234567890ABCDEFO.abcdefghijklmnopqrstuvwxyzABCD', 'consult@monitor.fr', 'Consultant Externe', 'CONSULTANT', NULL);

-- Note: Les mots de passe sont "Monitor123!" cryptés avec BCrypt

-- ========================
-- VUES POUR RAPPORTS
-- ========================

-- Vue pour les statistiques globales
CREATE VIEW vue_statistiques_globales AS
SELECT
    COUNT(DISTINCT caisse_code) as total_caisses,
    COUNT(*) as total_serveurs,
    SUM(CASE WHEN type_serveur = 'frontal' THEN 1 ELSE 0 END) as serveurs_frontaux,
    SUM(CASE WHEN type_serveur = 'backoffice' THEN 1 ELSE 0 END) as serveurs_backoffice,
    SUM(CASE WHEN type_serveur = 'betaweb' THEN 1 ELSE 0 END) as serveurs_betaweb,
    AVG(disponibilite_percent) as disponibilite_moyenne,
    SUM(tests_total) as total_tests,
    SUM(tests_succes) as total_succes,
    SUM(tests_echec) as total_echecs,
    CASE
        WHEN SUM(tests_total) > 0 THEN ROUND((SUM(tests_succes) / SUM(tests_total)) * 100, 2)
        ELSE 0
    END as taux_succes_global
FROM serveur_statistiques;

-- Vue pour les statistiques par caisse
CREATE VIEW vue_statistiques_par_caisse AS
SELECT
    c.code,
    c.nom,
    COUNT(ss.serveur_nom) as nombre_serveurs,
    SUM(ss.tests_total) as total_tests,
    SUM(ss.tests_succes) as tests_succes,
    SUM(ss.tests_echec) as tests_echecs,
    CASE
        WHEN SUM(ss.tests_total) > 0 THEN ROUND((SUM(ss.tests_succes) / SUM(ss.tests_total)) * 100, 2)
        ELSE 0
    END as taux_succes,
    ROUND(AVG(ss.disponibilite_percent), 2) as disponibilite_moyenne,
    ROUND(AVG(ss.temps_reponse_moyen), 2) as temps_reponse_moyen
FROM caisses c
LEFT JOIN serveur_statistiques ss ON ss.caisse_code = c.code
GROUP BY c.id, c.code, c.nom
ORDER BY taux_succes DESC;

-- ========================
-- CRÉATION UTILISATEUR ET PRIVILÈGES
-- ========================
DROP USER IF EXISTS 'monitor_user'@'localhost';
CREATE USER 'monitor_user'@'localhost' IDENTIFIED BY 'Monitor123!';
GRANT ALL PRIVILEGES ON machine_monitor.* TO 'monitor_user'@'localhost';
FLUSH PRIVILEGES;

-- ========================
-- MESSAGE DE CONFIRMATION
-- ========================
SELECT '==========================================' as '';
SELECT 'BASE DE DONNÉES CRÉÉE AVEC SUCCÈS!' as '';
SELECT '==========================================' as '';
SELECT '' as '';
SELECT 'Résumé de la création:' as '';
SELECT CONCAT('Caisses: ', COUNT(*)) FROM caisses;
SELECT CONCAT('Types serveurs: ', COUNT(*)) FROM types_serveur;
SELECT CONCAT('Tests standards: ', COUNT(*)) FROM tests_standard;
SELECT CONCAT('Configurations serveurs: ', COUNT(*)) FROM configuration_serveurs;
SELECT CONCAT('Configurations tests: ', COUNT(*)) FROM configuration_tests;
SELECT CONCAT('Serveurs dans statistiques: ', COUNT(*)) FROM serveur_statistiques;
SELECT CONCAT('Serveurs dans table serveurs: ', COUNT(*)) FROM serveurs;
SELECT '' as '';
SELECT 'Détail par type de serveur:' as '';
SELECT CONCAT('Frontaux: ', COUNT(*)) FROM serveur_statistiques WHERE type_serveur = 'frontal';
SELECT CONCAT('BackOffice: ', COUNT(*)) FROM serveur_statistiques WHERE type_serveur = 'backoffice';
SELECT CONCAT('BetaWeb: ', COUNT(*)) FROM serveur_statistiques WHERE type_serveur = 'betaweb';
SELECT '' as '';
SELECT 'TOP 5 caisses les plus équipées:' as '';
SELECT c.code, c.nom, COUNT(DISTINCT ss.serveur_nom) as total_serveurs
FROM caisses c
LEFT JOIN serveur_statistiques ss ON ss.caisse_code = c.code
GROUP BY c.id
ORDER BY total_serveurs DESC
LIMIT 5;
SELECT '' as '';
SELECT 'Configuration terminée - Système prêt pour la supervision!' as '';


-- Ajouter ces lignes à votre script existant
-- Configuration des timezones
-- SET GLOBAL time_zone = '+01:00';
-- SET time_zone = '+01:00';

-- Optimisation des paramètres MySQL pour le monitoring
-- SET GLOBAL innodb_flush_log_at_trx_commit = 2;
-- SET GLOBAL sync_binlog = 0;

-- Création des privilèges étendus pour l'utilisateur monitor
-- GRANT PROCESS, REPLICATION CLIENT ON *.* TO 'monitor_user'@'%';

-- Application des changements
-- FLUSH PRIVILEGES;