DROP TABLE IF EXISTS ATROX.atrox_function;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_function>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_function (
    fn_id BIGINT NOT NULL,
    co_id BIGINT NOT NULL,
    fn_name VARCHAR(200) NOT NULL,
    fn_code VARCHAR(100) NOT NULL,
    fn_description VARCHAR(500) NULL,
    fn_type VARCHAR(50) NOT NULL,
    fn_created_at TIMESTAMP NOT NULL,
    fn_created_by BIGINT NOT NULL,
    fn_updated_at TIMESTAMP NOT NULL,
    fn_updated_by BIGINT NOT NULL,
    fn_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_function PRIMARY KEY (fn_id),
    CONSTRAINT uq_atrox_function_company_code UNIQUE (co_id, fn_code),
    CONSTRAINT fk_atrox_function_company FOREIGN KEY (co_id) REFERENCES ATROX.atrox_company (co_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_function>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_function>>>';
END
$do$;