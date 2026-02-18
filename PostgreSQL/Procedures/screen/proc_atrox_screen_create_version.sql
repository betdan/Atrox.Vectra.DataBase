DROP PROCEDURE IF EXISTS ATROX.proc_atrox_screen_create_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_create_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_screen_create_version(IN i_sv_id BIGINT,IN i_sc_id BIGINT,IN i_sv_content_definition TEXT,IN i_sv_html_template_definition TEXT,IN i_created_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ DECLARE v_draft BIGINT; BEGIN BEGIN SELECT vs_id INTO v_draft FROM ATROX.atrox_version_status WHERE vs_code='DRAFT' AND vs_deleted=FALSE; INSERT INTO ATROX.atrox_screen_version(sv_id,sc_id,sv_version_number,vs_id,sv_content_definition,sv_html_template_definition,sv_created_at,sv_created_by,sv_updated_at,sv_updated_by,sv_deleted) VALUES(i_sv_id,i_sc_id,ATROX.fn_atrox_next_screen_version(i_sc_id),v_draft,i_sv_content_definition,i_sv_html_template_definition,CURRENT_TIMESTAMP,i_created_by,CURRENT_TIMESTAMP,i_created_by,FALSE);  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_create_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_create_version>>>';
END
$do$;