IF OBJECT_ID('ATROX.proc_atrox_action_enable_version','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_action_enable_version;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_enable_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_action_enable_version @i_ac_id BIGINT,
    @i_av_id BIGINT,
    @i_updated_by BIGINT,
    @o_error INT OUTPUT,
    @o_message VARCHAR(500) OUTPUT AS BEGIN
SET
    NOCOUNT ON;



SET
    @o_error = 0;



SET
    @o_message = ''OK'';



DECLARE @v_enabled BIGINT;



DECLARE @v_disabled BIGINT;



DECLARE @v_draft BIGINT;



DECLARE @v_target_status BIGINT;



DECLARE @v_new_version_number BIGINT;



DECLARE @v_prev_enabled_version_id BIGINT;



DECLARE @v_prev_version_number BIGINT;



DECLARE @v_event_type VARCHAR(20);



BEGIN TRY BEGIN TRANSACTION;



SELECT
    av_id
FROM
    ATROX.atrox_action_version WITH (UPDLOCK, HOLDLOCK)
WHERE
    ac_id = @i_ac_id;



SELECT
    @v_enabled = vs_id
FROM
    ATROX.atrox_version_status
WHERE
    vs_code = ''ENABLED''
    AND vs_deleted = 0;



SELECT
    @v_disabled = vs_id
FROM
    ATROX.atrox_version_status
WHERE
    vs_code = ''DISABLED''
    AND vs_deleted = 0;



SELECT
    @v_draft = vs_id
FROM
    ATROX.atrox_version_status
WHERE
    vs_code = ''DRAFT''
    AND vs_deleted = 0;



IF @v_enabled IS NULL
OR @v_disabled IS NULL
OR @v_draft IS NULL THROW 51030,
''Version status catalog is not configured.'',
1;



SELECT
    @v_target_status = av.vs_id,
    @v_new_version_number = av.av_version_number
FROM
    ATROX.atrox_action_version av
WHERE
    av.av_id = @i_av_id
    AND av.ac_id = @i_ac_id
    AND av.av_deleted = 0;



IF @v_target_status IS NULL THROW 51031,
''Target action version not found.'',
1;



IF @v_target_status NOT IN (@v_draft, @v_disabled, @v_enabled) THROW 51032,
''Only DRAFT or DISABLED versions can be enabled.'',
1;



SELECT
    TOP (1) @v_prev_enabled_version_id = av_id,
    @v_prev_version_number = av_version_number
FROM
    ATROX.atrox_action_version
WHERE
    ac_id = @i_ac_id
    AND vs_id = @v_enabled
    AND av_deleted = 0
ORDER BY
    av_version_number DESC;



IF @v_prev_enabled_version_id = @i_av_id BEGIN COMMIT TRANSACTION;



RETURN;



END
UPDATE
    ATROX.atrox_action_version
SET
    vs_id = @v_disabled,
    av_updated_at = SYSUTCDATETIME(),
    av_updated_by = @i_updated_by
WHERE
    ac_id = @i_ac_id
    AND vs_id = @v_enabled
    AND av_deleted = 0;



UPDATE
    ATROX.atrox_action_version
SET
    vs_id = @v_enabled,
    av_updated_at = SYSUTCDATETIME(),
    av_updated_by = @i_updated_by
WHERE
    av_id = @i_av_id
    AND ac_id = @i_ac_id
    AND av_deleted = 0;



UPDATE
    ATROX.atrox_action
SET
    ac_current_version_id = @i_av_id,
    ac_updated_at = SYSUTCDATETIME(),
    ac_updated_by = @i_updated_by
WHERE
    ac_id = @i_ac_id
    AND ac_deleted = 0;



SET
    @v_event_type = CASE
        WHEN @v_prev_enabled_version_id IS NULL THEN ''ENABLE''
        WHEN @v_new_version_number < @v_prev_version_number THEN ''ROLLBACK''
        ELSE ''ENABLE''
    END;



INSERT INTO
    ATROX.atrox_version_event (
        ve_entity_type,
        ve_entity_id,
        ve_previous_version_id,
        ve_new_version_id,
        ve_event_type,
        ve_executed_by
    )
VALUES
    (
        ''ACTION'',
        @i_ac_id,
        @v_prev_enabled_version_id,
        @i_av_id,
        @v_event_type,
        @i_updated_by
    );



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_action_enable_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_enable_version>>>';
END CATCH;
GO