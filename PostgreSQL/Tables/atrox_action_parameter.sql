DROP TABLE IF EXISTS ATROX.atrox_action_parameter;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_action_parameter>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_action_parameter (
    pa_id BIGINT NOT NULL,
    ac_id BIGINT NOT NULL,
    pa_name VARCHAR(150) NOT NULL,
    pa_direction VARCHAR(10) NOT NULL,
    pa_data_type VARCHAR(100) NOT NULL,
    pa_is_required BOOLEAN NOT NULL,
    pa_default_value VARCHAR(500) NULL,
    pa_order INT NOT NULL,
    pa_created_at TIMESTAMP NOT NULL,
    pa_created_by BIGINT NOT NULL,
    pa_updated_at TIMESTAMP NOT NULL,
    pa_updated_by BIGINT NOT NULL,
    pa_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_action_parameter PRIMARY KEY (pa_id),
    CONSTRAINT fk_atrox_action_parameter_action FOREIGN KEY (ac_id) REFERENCES ATROX.atrox_action (ac_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_action_parameter>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_action_parameter>>>';
END
$do$;