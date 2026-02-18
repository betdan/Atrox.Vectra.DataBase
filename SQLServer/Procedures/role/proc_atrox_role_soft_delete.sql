IF OBJECT_ID('ATROX.proc_atrox_role_soft_delete','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_role_soft_delete;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_role_soft_delete>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_role_soft_delete @i_ro_id BIGINT,
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
    ATROX.atrox_role
SET
    ro_deleted = 1,
    ro_updated_at = SYSUTCDATETIME(),
    ro_updated_by = @i_updated_by
WHERE
    ro_id = @i_ro_id
    AND ro_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_role_soft_delete>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_role_soft_delete>>>';
END CATCH;
GO