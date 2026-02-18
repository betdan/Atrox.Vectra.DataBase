DROP PROCEDURE IF EXISTS ATROX.proc_atrox_screen_update;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_update>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_screen_update(IN i_sc_id BIGINT,IN i_ap_id BIGINT,IN i_sc_name VARCHAR(200),IN i_sc_code VARCHAR(100),IN i_sc_description VARCHAR(500),IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN UPDATE ATROX.atrox_screen SET ap_id=i_ap_id,sc_name=i_sc_name,sc_code=i_sc_code,sc_description=i_sc_description,sc_updated_at=CURRENT_TIMESTAMP,sc_updated_by=i_updated_by WHERE sc_id=i_sc_id AND sc_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_update>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_update>>>';
END
$do$;