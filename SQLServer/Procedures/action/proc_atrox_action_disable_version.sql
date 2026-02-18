IF OBJECT_ID('ATROX.proc_atrox_action_disable_version','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_action_disable_version;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_disable_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_action_disable_version @i_ac_id BIGINT,
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



DECLARE @v_disabled BIGINT;



BEGIN TRY BEGIN TRANSACTION;



SELECT
    @v_disabled = vs_id
FROM
    ATROX.atrox_version_status
WHERE
    vs_code = ''DISABLED''
    AND vs_deleted = 0;



UPDATE
    ATROX.atrox_action_version
SET
    vs_id = @v_disabled,
    av_updated_at = SYSUTCDATETIME(),
    av_updated_by = @i_updated_by
WHERE
    av_id = @i_av_id
    AND ac_id = @i_ac_id
    AND av_deleted = 0;



UPDATE
    ATROX.atrox_action
SET
    ac_current_version_id =CASE
        WHEN ac_current_version_id = @i_av_id THEN NULL
        ELSE ac_current_version_id
    END,
    ac_updated_at = SYSUTCDATETIME(),
    ac_updated_by = @i_updated_by
WHERE
    ac_id = @i_ac_id
    AND ac_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_action_disable_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_disable_version>>>';
END CATCH;
GO