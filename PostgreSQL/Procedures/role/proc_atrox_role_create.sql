DROP PROCEDURE IF EXISTS ATROX.proc_atrox_role_create;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_role_create>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_role_create(IN i_ro_id BIGINT,IN i_co_id BIGINT,IN i_ro_name VARCHAR(150),IN i_ro_code VARCHAR(100),IN i_ro_description VARCHAR(500),IN i_created_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN INSERT INTO ATROX.atrox_role(ro_id,co_id,ro_name,ro_code,ro_description,ro_created_at,ro_created_by,ro_updated_at,ro_updated_by,ro_deleted) VALUES(i_ro_id,i_co_id,i_ro_name,i_ro_code,i_ro_description,CURRENT_TIMESTAMP,i_created_by,CURRENT_TIMESTAMP,i_created_by,FALSE);  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_role_create>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_role_create>>>';
END
$do$;