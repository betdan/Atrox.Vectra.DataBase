DROP PROCEDURE IF EXISTS ATROX.proc_atrox_menu_update;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_menu_update>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_menu_update(IN i_mn_id BIGINT,IN i_ap_id BIGINT,IN i_mn_parent_id BIGINT,IN i_mn_name VARCHAR(200),IN i_mn_code VARCHAR(100),IN i_mn_order INT,IN i_mn_path VARCHAR(300),IN i_mn_icon VARCHAR(100),IN i_mn_screen_id BIGINT,IN i_mn_main_function_id BIGINT,IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN UPDATE ATROX.atrox_menu SET ap_id=i_ap_id,mn_parent_id=i_mn_parent_id,mn_name=i_mn_name,mn_code=i_mn_code,mn_order=i_mn_order,mn_path=i_mn_path,mn_icon=i_mn_icon,mn_screen_id=i_mn_screen_id,mn_main_function_id=i_mn_main_function_id,mn_updated_at=CURRENT_TIMESTAMP,mn_updated_by=i_updated_by WHERE mn_id=i_mn_id AND mn_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_menu_update>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_menu_update>>>';
END
$do$;