DROP TABLE IF EXISTS ATROX.atrox_service_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_service_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_service_version (
    sv_id BIGINT NOT NULL,
    se_id BIGINT NOT NULL,
    sv_version_number BIGINT NOT NULL,
    vs_id BIGINT NOT NULL,
    sv_content_definition TEXT NULL,
    sv_created_at TIMESTAMP NOT NULL,
    sv_created_by BIGINT NOT NULL,
    sv_updated_at TIMESTAMP NOT NULL,
    sv_updated_by BIGINT NOT NULL,
    sv_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_service_version PRIMARY KEY (sv_id),
    CONSTRAINT uq_atrox_service_version UNIQUE (se_id, sv_version_number),
    CONSTRAINT fk_atrox_service_version_service FOREIGN KEY (se_id) REFERENCES ATROX.atrox_service (se_id),
    CONSTRAINT fk_atrox_service_version_status FOREIGN KEY (vs_id) REFERENCES ATROX.atrox_version_status (vs_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_service_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_service_version>>>';
END
$do$;