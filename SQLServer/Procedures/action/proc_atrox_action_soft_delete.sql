IF OBJECT_ID('ATROX.proc_atrox_action_soft_delete','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_action_soft_delete;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_soft_delete>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_action_soft_delete @i_ac_id BIGINT,
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
    ac_deleted = 1,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_action_soft_delete>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_soft_delete>>>';
END CATCH;
GO