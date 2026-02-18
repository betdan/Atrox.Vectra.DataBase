DROP PROCEDURE IF EXISTS ATROX.proc_atrox_action_create;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_create>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_action_create(IN i_ac_id BIGINT,IN i_se_id BIGINT,IN i_ac_name VARCHAR(200),IN i_ac_code VARCHAR(100),IN i_ac_description VARCHAR(500),IN i_created_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN INSERT INTO ATROX.atrox_action(ac_id,se_id,ac_name,ac_code,ac_description,ac_current_version_id,ac_created_at,ac_created_by,ac_updated_at,ac_updated_by,ac_deleted) VALUES(i_ac_id,i_se_id,i_ac_name,i_ac_code,i_ac_description,NULL,CURRENT_TIMESTAMP,i_created_by,CURRENT_TIMESTAMP,i_created_by,FALSE);  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_action_create>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_create>>>';
END
$do$;