DROP TABLE IF EXISTS ATROX.atrox_application;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_application>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_application (
    ap_id BIGINT NOT NULL,
    co_id BIGINT NOT NULL,
    ap_name VARCHAR(200) NOT NULL,
    ap_code VARCHAR(100) NOT NULL,
    ap_description VARCHAR(500) NULL,
    ap_created_at TIMESTAMP NOT NULL,
    ap_created_by BIGINT NOT NULL,
    ap_updated_at TIMESTAMP NOT NULL,
    ap_updated_by BIGINT NOT NULL,
    ap_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_application PRIMARY KEY (ap_id),
    CONSTRAINT uq_atrox_application_company_code UNIQUE (co_id, ap_code),
    CONSTRAINT fk_atrox_application_company FOREIGN KEY (co_id) REFERENCES ATROX.atrox_company (co_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_application>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_application>>>';
END
$do$;