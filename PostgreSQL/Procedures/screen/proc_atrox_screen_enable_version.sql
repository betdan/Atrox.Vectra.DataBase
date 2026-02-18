DROP PROCEDURE IF EXISTS ATROX.proc_atrox_screen_enable_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_enable_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_screen_enable_version(
    IN i_sc_id BIGINT,
    IN i_sv_id BIGINT,
    IN i_updated_by BIGINT,
    INOUT o_error INT DEFAULT 0,
    INOUT o_message VARCHAR(500) DEFAULT 'OK'
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_enabled BIGINT;
    v_disabled BIGINT;
    v_draft BIGINT;

    v_target_status BIGINT;
    v_new_version_number BIGINT;
    v_prev_enabled_version_id BIGINT;
    v_prev_version_number BIGINT;
    v_event_type VARCHAR(20);
BEGIN
    o_error := 0;
    o_message := 'OK';

    START TRANSACTION;
    BEGIN
        PERFORM 1
        FROM ATROX.atrox_screen_version
        WHERE sc_id = i_sc_id
        FOR UPDATE;

        SELECT vs_id INTO v_enabled FROM ATROX.atrox_version_status WHERE vs_code = 'ENABLED' AND vs_deleted = FALSE;
        SELECT vs_id INTO v_disabled FROM ATROX.atrox_version_status WHERE vs_code = 'DISABLED' AND vs_deleted = FALSE;
        SELECT vs_id INTO v_draft FROM ATROX.atrox_version_status WHERE vs_code = 'DRAFT' AND vs_deleted = FALSE;

        IF v_enabled IS NULL OR v_disabled IS NULL OR v_draft IS NULL THEN
            RAISE EXCEPTION 'Version status catalog is not configured.';
        END IF;

        SELECT sv.vs_id, sv.sv_version_number
        INTO v_target_status, v_new_version_number
        FROM ATROX.atrox_screen_version sv
        WHERE sv.sv_id = i_sv_id
          AND sv.sc_id = i_sc_id
          AND sv.sv_deleted = FALSE;

        IF v_target_status IS NULL THEN
            RAISE EXCEPTION 'Target screen version not found.';
        END IF;

        IF v_target_status NOT IN (v_draft, v_disabled, v_enabled) THEN
            RAISE EXCEPTION 'Only DRAFT or DISABLED versions can be enabled.';
        END IF;

        SELECT sv_id, sv_version_number
        INTO v_prev_enabled_version_id, v_prev_version_number
        FROM ATROX.atrox_screen_version
        WHERE sc_id = i_sc_id
          AND vs_id = v_enabled
          AND sv_deleted = FALSE
        ORDER BY sv_version_number DESC
        LIMIT 1;

        IF v_prev_enabled_version_id = i_sv_id THEN
            COMMIT;
            RETURN;
        END IF;

        UPDATE ATROX.atrox_screen_version
        SET
            vs_id = v_disabled,
            sv_updated_at = CURRENT_TIMESTAMP,
            sv_updated_by = i_updated_by
        WHERE sc_id = i_sc_id
          AND vs_id = v_enabled
          AND sv_deleted = FALSE;

        UPDATE ATROX.atrox_screen_version
        SET
            vs_id = v_enabled,
            sv_updated_at = CURRENT_TIMESTAMP,
            sv_updated_by = i_updated_by
        WHERE sv_id = i_sv_id
          AND sc_id = i_sc_id
          AND sv_deleted = FALSE;

        UPDATE ATROX.atrox_screen
        SET
            sc_current_version_id = i_sv_id,
            sc_updated_at = CURRENT_TIMESTAMP,
            sc_updated_by = i_updated_by
        WHERE sc_id = i_sc_id
          AND sc_deleted = FALSE;

        v_event_type := CASE
            WHEN v_prev_enabled_version_id IS NULL THEN 'ENABLE'
            WHEN v_new_version_number < v_prev_version_number THEN 'ROLLBACK'
            ELSE 'ENABLE'
        END;

        INSERT INTO ATROX.atrox_version_event (
            ve_entity_type,
            ve_entity_id,
            ve_previous_version_id,
            ve_new_version_id,
            ve_event_type,
            ve_executed_by
        )
        VALUES (
            'SCREEN',
            i_sc_id,
            v_prev_enabled_version_id,
            i_sv_id,
            v_event_type,
            i_updated_by
        );

        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        o_error := 1;
        o_message := LEFT(SQLERRM, 500);
    END;
END;
$$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_enable_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_enable_version>>>';
END
$do$;