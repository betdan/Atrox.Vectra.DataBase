DROP TABLE IF EXISTS ATROX.atrox_company;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_company>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_company (
    co_id BIGINT NOT NULL,
    co_name VARCHAR(200) NOT NULL,
    co_code VARCHAR(100) NOT NULL,
    co_description VARCHAR(500) NULL,
    co_created_at TIMESTAMP NOT NULL,
    co_created_by BIGINT NOT NULL,
    co_updated_at TIMESTAMP NOT NULL,
    co_updated_by BIGINT NOT NULL,
    co_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_company PRIMARY KEY (co_id),
    CONSTRAINT uq_atrox_company_code UNIQUE (co_code)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_company>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_company>>>';
END
$do$;