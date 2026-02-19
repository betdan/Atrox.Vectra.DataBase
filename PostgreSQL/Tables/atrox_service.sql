DROP TABLE IF EXISTS ATROX.atrox_service;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_service>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_service (
    se_id BIGINT NOT NULL,
    sc_id BIGINT NOT NULL,
    se_name VARCHAR(200) NOT NULL,
    se_code VARCHAR(100) NOT NULL,
    se_description VARCHAR(500) NULL,
    se_endpoint VARCHAR(500) NULL,
    se_http_method VARCHAR(20) NULL,
    se_current_version_id BIGINT NULL,
    se_created_at TIMESTAMP NOT NULL,
    se_created_by BIGINT NOT NULL,
    se_updated_at TIMESTAMP NOT NULL,
    se_updated_by BIGINT NOT NULL,
    se_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_service PRIMARY KEY (se_id),
    CONSTRAINT uq_atrox_service_screen_code UNIQUE (sc_id, se_code),
    CONSTRAINT fk_atrox_service_screen FOREIGN KEY (sc_id) REFERENCES ATROX.atrox_screen (sc_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_service>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_service>>>';
END
$do$;
