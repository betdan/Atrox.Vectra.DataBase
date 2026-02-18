DROP PROCEDURE IF EXISTS ATROX.proc_atrox_screen_get_active_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_get_active_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_screen_get_active_version(IN i_sc_id BIGINT,INOUT o_result REFCURSOR DEFAULT 'cur_screen_active',INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN OPEN o_result FOR SELECT sv.* FROM ATROX.atrox_screen s INNER JOIN ATROX.atrox_screen_version sv ON sv.sv_id=s.sc_current_version_id WHERE s.sc_id=i_sc_id AND s.sc_deleted=FALSE AND sv.sv_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_get_active_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_get_active_version>>>';
END
$do$;