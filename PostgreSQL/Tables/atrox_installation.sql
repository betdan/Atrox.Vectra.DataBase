DROP TABLE IF EXISTS ATROX.atrox_installation;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_installation>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE IF NOT EXISTS ATROX.atrox_installation (
    in_id BIGINT NOT NULL,
    in_version VARCHAR(50) NOT NULL,
    in_installed_at TIMESTAMP NOT NULL,
    in_installed_by VARCHAR(200) NOT NULL,
    CONSTRAINT pk_atrox_installation PRIMARY KEY (in_id),
    CONSTRAINT uq_atrox_installation_version UNIQUE (in_version)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_installation>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_installation>>>';
END
$do$;