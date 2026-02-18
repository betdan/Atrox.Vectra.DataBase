DROP TABLE IF EXISTS ATROX.atrox_role;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_role>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_role (
    ro_id BIGINT NOT NULL,
    co_id BIGINT NOT NULL,
    ro_name VARCHAR(150) NOT NULL,
    ro_code VARCHAR(100) NOT NULL,
    ro_description VARCHAR(500) NULL,
    ro_created_at TIMESTAMP NOT NULL,
    ro_created_by BIGINT NOT NULL,
    ro_updated_at TIMESTAMP NOT NULL,
    ro_updated_by BIGINT NOT NULL,
    ro_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_role PRIMARY KEY (ro_id),
    CONSTRAINT uq_atrox_role_company_code UNIQUE (co_id, ro_code),
    CONSTRAINT fk_atrox_role_company FOREIGN KEY (co_id) REFERENCES ATROX.atrox_company (co_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_role>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_role>>>';
END
$do$;