DROP TABLE IF EXISTS ATROX.atrox_version_status;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_version_status>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_version_status (
    vs_id BIGINT NOT NULL,
    vs_code VARCHAR(50) NOT NULL,
    vs_name VARCHAR(100) NOT NULL,
    vs_created_at TIMESTAMP NOT NULL,
    vs_created_by BIGINT NOT NULL,
    vs_updated_at TIMESTAMP NOT NULL,
    vs_updated_by BIGINT NOT NULL,
    vs_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_version_status PRIMARY KEY (vs_id),
    CONSTRAINT uq_atrox_version_status_code UNIQUE (vs_code)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_version_status>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_version_status>>>';
END
$do$;