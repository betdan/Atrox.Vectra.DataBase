DROP PROCEDURE IF EXISTS ATROX.proc_atrox_action_update;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_update>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_action_update(IN i_ac_id BIGINT,IN i_se_id BIGINT,IN i_ac_name VARCHAR(200),IN i_ac_code VARCHAR(100),IN i_ac_description VARCHAR(500),IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN UPDATE ATROX.atrox_action SET se_id=i_se_id,ac_name=i_ac_name,ac_code=i_ac_code,ac_description=i_ac_description,ac_updated_at=CURRENT_TIMESTAMP,ac_updated_by=i_updated_by WHERE ac_id=i_ac_id AND ac_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_action_update>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_update>>>';
END
$do$;