DROP TABLE IF EXISTS ATROX.atrox_action;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_action>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_action (
    ac_id BIGINT NOT NULL,
    se_id BIGINT NOT NULL,
    ac_name VARCHAR(200) NOT NULL,
    ac_code VARCHAR(100) NOT NULL,
    ac_description VARCHAR(500) NULL,
    ac_current_version_id BIGINT NULL,
    ac_created_at TIMESTAMP NOT NULL,
    ac_created_by BIGINT NOT NULL,
    ac_updated_at TIMESTAMP NOT NULL,
    ac_updated_by BIGINT NOT NULL,
    ac_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_action PRIMARY KEY (ac_id),
    CONSTRAINT uq_atrox_action_service_code UNIQUE (se_id, ac_code),
    CONSTRAINT fk_atrox_action_service FOREIGN KEY (se_id) REFERENCES ATROX.atrox_service (se_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_action>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_action>>>';
END
$do$;
