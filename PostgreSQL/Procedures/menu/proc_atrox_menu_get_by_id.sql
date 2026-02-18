DROP PROCEDURE IF EXISTS ATROX.proc_atrox_menu_get_by_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_menu_get_by_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_menu_get_by_id(IN i_mn_id BIGINT,INOUT o_result REFCURSOR DEFAULT 'cur_menu_get_by_id',INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN OPEN o_result FOR SELECT * FROM ATROX.atrox_menu WHERE mn_id=i_mn_id AND mn_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_menu_get_by_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_menu_get_by_id>>>';
END
$do$;