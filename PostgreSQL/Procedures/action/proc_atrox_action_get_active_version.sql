DROP PROCEDURE IF EXISTS ATROX.proc_atrox_action_get_active_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_get_active_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_action_get_active_version(IN i_ac_id BIGINT,INOUT o_result REFCURSOR DEFAULT 'cur_action_active',INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN OPEN o_result FOR SELECT av.* FROM ATROX.atrox_action a INNER JOIN ATROX.atrox_action_version av ON av.av_id=a.ac_current_version_id WHERE a.ac_id=i_ac_id AND a.ac_deleted=FALSE AND av.av_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_action_get_active_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_get_active_version>>>';
END
$do$;