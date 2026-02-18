DROP PROCEDURE IF EXISTS ATROX.proc_atrox_service_soft_delete;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_service_soft_delete>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_service_soft_delete(IN i_se_id BIGINT,IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN UPDATE ATROX.atrox_service SET se_deleted=TRUE,se_updated_at=CURRENT_TIMESTAMP,se_updated_by=i_updated_by WHERE se_id=i_se_id AND se_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_service_soft_delete>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_service_soft_delete>>>';
END
$do$;