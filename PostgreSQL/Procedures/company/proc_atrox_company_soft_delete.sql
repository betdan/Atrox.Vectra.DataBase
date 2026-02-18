DROP PROCEDURE IF EXISTS ATROX.proc_atrox_company_soft_delete;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_company_soft_delete>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_company_soft_delete(IN i_co_id BIGINT,IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN UPDATE ATROX.atrox_company SET co_deleted=TRUE,co_updated_at=CURRENT_TIMESTAMP,co_updated_by=i_updated_by WHERE co_id=i_co_id AND co_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_company_soft_delete>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_company_soft_delete>>>';
END
$do$;