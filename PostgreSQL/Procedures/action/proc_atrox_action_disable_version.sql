DROP PROCEDURE IF EXISTS ATROX.proc_atrox_action_disable_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_disable_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_action_disable_version(IN i_ac_id BIGINT,IN i_av_id BIGINT,IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ DECLARE v_disabled BIGINT; BEGIN BEGIN SELECT vs_id INTO v_disabled FROM ATROX.atrox_version_status WHERE vs_code='DISABLED' AND vs_deleted=FALSE; UPDATE ATROX.atrox_action_version SET vs_id=v_disabled,av_updated_at=CURRENT_TIMESTAMP,av_updated_by=i_updated_by WHERE av_id=i_av_id AND ac_id=i_ac_id AND av_deleted=FALSE; UPDATE ATROX.atrox_action SET ac_current_version_id=CASE WHEN ac_current_version_id=i_av_id THEN NULL ELSE ac_current_version_id END,ac_updated_at=CURRENT_TIMESTAMP,ac_updated_by=i_updated_by WHERE ac_id=i_ac_id AND ac_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_action_disable_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_disable_version>>>';
END
$do$;