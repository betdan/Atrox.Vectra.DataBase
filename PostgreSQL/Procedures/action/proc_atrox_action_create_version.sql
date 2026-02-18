DROP PROCEDURE IF EXISTS ATROX.proc_atrox_action_create_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_create_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_action_create_version(IN i_av_id BIGINT,IN i_ac_id BIGINT,IN i_av_content_definition TEXT,IN i_av_input_definition TEXT,IN i_av_output_definition TEXT,IN i_created_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ DECLARE v_draft BIGINT; BEGIN BEGIN SELECT vs_id INTO v_draft FROM ATROX.atrox_version_status WHERE vs_code='DRAFT' AND vs_deleted=FALSE; INSERT INTO ATROX.atrox_action_version(av_id,ac_id,av_version_number,vs_id,av_content_definition,av_input_definition,av_output_definition,av_created_at,av_created_by,av_updated_at,av_updated_by,av_deleted) VALUES(i_av_id,i_ac_id,ATROX.fn_atrox_next_action_version(i_ac_id),v_draft,i_av_content_definition,i_av_input_definition,i_av_output_definition,CURRENT_TIMESTAMP,i_created_by,CURRENT_TIMESTAMP,i_created_by,FALSE);  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_action_create_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_create_version>>>';
END
$do$;