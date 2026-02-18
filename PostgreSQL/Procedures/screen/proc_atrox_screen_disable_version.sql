DROP PROCEDURE IF EXISTS ATROX.proc_atrox_screen_disable_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_disable_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_screen_disable_version(IN i_sc_id BIGINT,IN i_sv_id BIGINT,IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ DECLARE v_disabled BIGINT; BEGIN BEGIN SELECT vs_id INTO v_disabled FROM ATROX.atrox_version_status WHERE vs_code='DISABLED' AND vs_deleted=FALSE; UPDATE ATROX.atrox_screen_version SET vs_id=v_disabled,sv_updated_at=CURRENT_TIMESTAMP,sv_updated_by=i_updated_by WHERE sv_id=i_sv_id AND sc_id=i_sc_id AND sv_deleted=FALSE; UPDATE ATROX.atrox_screen SET sc_current_version_id=CASE WHEN sc_current_version_id=i_sv_id THEN NULL ELSE sc_current_version_id END,sc_updated_at=CURRENT_TIMESTAMP,sc_updated_by=i_updated_by WHERE sc_id=i_sc_id AND sc_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_disable_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_disable_version>>>';
END
$do$;