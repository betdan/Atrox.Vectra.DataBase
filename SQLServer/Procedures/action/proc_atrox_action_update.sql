IF OBJECT_ID('ATROX.proc_atrox_action_update','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_action_update;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_update>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_action_update @i_ac_id BIGINT,
    @i_se_id BIGINT = NULL,
    @i_ac_name VARCHAR(200) = NULL,
    @i_ac_code VARCHAR(100) = NULL,
    @i_ac_description VARCHAR(500) = NULL,
    @i_updated_by BIGINT,
    @o_error INT OUTPUT,
    @o_message VARCHAR(500) OUTPUT AS BEGIN
SET
    NOCOUNT ON;



SET
    @o_error = 0;



SET
    @o_message = ''OK'';



BEGIN TRY BEGIN TRANSACTION;



UPDATE
    ATROX.atrox_action
SET
    se_id = @i_se_id,
    ac_name = @i_ac_name,
    ac_code = @i_ac_code,
    ac_description = @i_ac_description,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_action_update>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_update>>>';
END CATCH;
GO