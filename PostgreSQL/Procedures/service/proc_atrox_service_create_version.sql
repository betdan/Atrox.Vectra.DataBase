DROP PROCEDURE IF EXISTS ATROX.proc_atrox_service_create_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_service_create_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_service_create_version(IN i_sv_id BIGINT,IN i_se_id BIGINT,IN i_sv_content_definition TEXT,IN i_created_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ DECLARE v_draft BIGINT; BEGIN BEGIN SELECT vs_id INTO v_draft FROM ATROX.atrox_version_status WHERE vs_code='DRAFT' AND vs_deleted=FALSE; INSERT INTO ATROX.atrox_service_version(sv_id,se_id,sv_version_number,vs_id,sv_content_definition,sv_created_at,sv_created_by,sv_updated_at,sv_updated_by,sv_deleted) VALUES(i_sv_id,i_se_id,ATROX.fn_atrox_next_service_version(i_se_id),v_draft,i_sv_content_definition,CURRENT_TIMESTAMP,i_created_by,CURRENT_TIMESTAMP,i_created_by,FALSE);  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_service_create_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_service_create_version>>>';
END
$do$;