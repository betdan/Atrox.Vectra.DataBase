DROP PROCEDURE IF EXISTS ATROX.proc_atrox_screen_create;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_create>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_screen_create(IN i_sc_id BIGINT,IN i_ap_id BIGINT,IN i_sc_name VARCHAR(200),IN i_sc_code VARCHAR(100),IN i_sc_description VARCHAR(500),IN i_created_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN INSERT INTO ATROX.atrox_screen(sc_id,ap_id,sc_name,sc_code,sc_description,sc_current_version_id,sc_created_at,sc_created_by,sc_updated_at,sc_updated_by,sc_deleted) VALUES(i_sc_id,i_ap_id,i_sc_name,i_sc_code,i_sc_description,NULL,CURRENT_TIMESTAMP,i_created_by,CURRENT_TIMESTAMP,i_created_by,FALSE);  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_create>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_create>>>';
END
$do$;