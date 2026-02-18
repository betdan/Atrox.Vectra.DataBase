DROP PROCEDURE IF EXISTS ATROX.proc_atrox_action_enable_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_enable_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_action_enable_version(
    IN i_ac_id BIGINT,
    IN i_av_id BIGINT,
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
        FROM ATROX.atrox_action_version
        WHERE ac_id = i_ac_id
        FOR UPDATE;

        SELECT vs_id INTO v_enabled FROM ATROX.atrox_version_status WHERE vs_code = 'ENABLED' AND vs_deleted = FALSE;
        SELECT vs_id INTO v_disabled FROM ATROX.atrox_version_status WHERE vs_code = 'DISABLED' AND vs_deleted = FALSE;
        SELECT vs_id INTO v_draft FROM ATROX.atrox_version_status WHERE vs_code = 'DRAFT' AND vs_deleted = FALSE;

        IF v_enabled IS NULL OR v_disabled IS NULL OR v_draft IS NULL THEN
            RAISE EXCEPTION 'Version status catalog is not configured.';
        END IF;

        SELECT av.vs_id, av.av_version_number
        INTO v_target_status, v_new_version_number
        FROM ATROX.atrox_action_version av
        WHERE av.av_id = i_av_id
          AND av.ac_id = i_ac_id
          AND av.av_deleted = FALSE;

        IF v_target_status IS NULL THEN
            RAISE EXCEPTION 'Target action version not found.';
        END IF;

        IF v_target_status NOT IN (v_draft, v_disabled, v_enabled) THEN
            RAISE EXCEPTION 'Only DRAFT or DISABLED versions can be enabled.';
        END IF;

        SELECT av_id, av_version_number
        INTO v_prev_enabled_version_id, v_prev_version_number
        FROM ATROX.atrox_action_version
        WHERE ac_id = i_ac_id
          AND vs_id = v_enabled
          AND av_deleted = FALSE
        ORDER BY av_version_number DESC
        LIMIT 1;

        IF v_prev_enabled_version_id = i_av_id THEN
            COMMIT;
            RETURN;
        END IF;

        UPDATE ATROX.atrox_action_version
        SET
            vs_id = v_disabled,
            av_updated_at = CURRENT_TIMESTAMP,
            av_updated_by = i_updated_by
        WHERE ac_id = i_ac_id
          AND vs_id = v_enabled
          AND av_deleted = FALSE;

        UPDATE ATROX.atrox_action_version
        SET
            vs_id = v_enabled,
            av_updated_at = CURRENT_TIMESTAMP,
            av_updated_by = i_updated_by
        WHERE av_id = i_av_id
          AND ac_id = i_ac_id
          AND av_deleted = FALSE;

        UPDATE ATROX.atrox_action
        SET
            ac_current_version_id = i_av_id,
            ac_updated_at = CURRENT_TIMESTAMP,
            ac_updated_by = i_updated_by
        WHERE ac_id = i_ac_id
          AND ac_deleted = FALSE;

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
            'ACTION',
            i_ac_id,
            v_prev_enabled_version_id,
            i_av_id,
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
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_action_enable_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_enable_version>>>';
END
$do$;