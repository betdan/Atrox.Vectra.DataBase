DROP PROCEDURE IF EXISTS ATROX.proc_atrox_role_update;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_role_update>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_role_update(IN i_ro_id BIGINT,IN i_co_id BIGINT,IN i_ro_name VARCHAR(150),IN i_ro_code VARCHAR(100),IN i_ro_description VARCHAR(500),IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN UPDATE ATROX.atrox_role SET co_id=i_co_id,ro_name=i_ro_name,ro_code=i_ro_code,ro_description=i_ro_description,ro_updated_at=CURRENT_TIMESTAMP,ro_updated_by=i_updated_by WHERE ro_id=i_ro_id AND ro_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_role_update>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_role_update>>>';
END
$do$;