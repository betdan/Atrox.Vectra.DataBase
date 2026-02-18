IF OBJECT_ID('ATROX.proc_atrox_screen_enable_version','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_screen_enable_version;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_enable_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_screen_enable_version @i_sc_id BIGINT,
    @i_sv_id BIGINT,
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
    sv_id
FROM
    ATROX.atrox_screen_version WITH (UPDLOCK, HOLDLOCK)
WHERE
    sc_id = @i_sc_id;



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
OR @v_draft IS NULL THROW 51010,
''Version status catalog is not configured.'',
1;



SELECT
    @v_target_status = sv.vs_id,
    @v_new_version_number = sv.sv_version_number
FROM
    ATROX.atrox_screen_version sv
WHERE
    sv.sv_id = @i_sv_id
    AND sv.sc_id = @i_sc_id
    AND sv.sv_deleted = 0;



IF @v_target_status IS NULL THROW 51011,
''Target screen version not found.'',
1;



IF @v_target_status NOT IN (@v_draft, @v_disabled, @v_enabled) THROW 51012,
''Only DRAFT or DISABLED versions can be enabled.'',
1;



SELECT
    TOP (1) @v_prev_enabled_version_id = sv_id,
    @v_prev_version_number = sv_version_number
FROM
    ATROX.atrox_screen_version
WHERE
    sc_id = @i_sc_id
    AND vs_id = @v_enabled
    AND sv_deleted = 0
ORDER BY
    sv_version_number DESC;



IF @v_prev_enabled_version_id = @i_sv_id BEGIN COMMIT TRANSACTION;



RETURN;



END
UPDATE
    ATROX.atrox_screen_version
SET
    vs_id = @v_disabled,
    sv_updated_at = SYSUTCDATETIME(),
    sv_updated_by = @i_updated_by
WHERE
    sc_id = @i_sc_id
    AND vs_id = @v_enabled
    AND sv_deleted = 0;



UPDATE
    ATROX.atrox_screen_version
SET
    vs_id = @v_enabled,
    sv_updated_at = SYSUTCDATETIME(),
    sv_updated_by = @i_updated_by
WHERE
    sv_id = @i_sv_id
    AND sc_id = @i_sc_id
    AND sv_deleted = 0;



UPDATE
    ATROX.atrox_screen
SET
    sc_current_version_id = @i_sv_id,
    sc_updated_at = SYSUTCDATETIME(),
    sc_updated_by = @i_updated_by
WHERE
    sc_id = @i_sc_id
    AND sc_deleted = 0;



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
        ''SCREEN'',
        @i_sc_id,
        @v_prev_enabled_version_id,
        @i_sv_id,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_enable_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_enable_version>>>';
END CATCH;
GO