DROP TABLE IF EXISTS ATROX.atrox_role_function;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_role_function>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_role_function (
    rf_id BIGINT NOT NULL,
    ro_id BIGINT NOT NULL,
    fn_id BIGINT NOT NULL,
    rf_created_at TIMESTAMP NOT NULL,
    rf_created_by BIGINT NOT NULL,
    rf_updated_at TIMESTAMP NOT NULL,
    rf_updated_by BIGINT NOT NULL,
    rf_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_role_function PRIMARY KEY (rf_id),
    CONSTRAINT uq_atrox_role_function UNIQUE (ro_id, fn_id),
    CONSTRAINT fk_atrox_role_function_role FOREIGN KEY (ro_id) REFERENCES ATROX.atrox_role (ro_id),
    CONSTRAINT fk_atrox_role_function_function FOREIGN KEY (fn_id) REFERENCES ATROX.atrox_function (fn_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_role_function>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_role_function>>>';
END
$do$;