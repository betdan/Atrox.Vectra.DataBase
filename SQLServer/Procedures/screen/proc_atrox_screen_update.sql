IF OBJECT_ID('ATROX.proc_atrox_screen_update','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_screen_update;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_update>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_screen_update @i_sc_id BIGINT,
    @i_ap_id BIGINT = NULL,
    @i_sc_name VARCHAR(200) = NULL,
    @i_sc_code VARCHAR(100) = NULL,
    @i_sc_description VARCHAR(500) = NULL,
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
    ATROX.atrox_screen
SET
    ap_id = @i_ap_id,
    sc_name = @i_sc_name,
    sc_code = @i_sc_code,
    sc_description = @i_sc_description,
    sc_updated_at = SYSUTCDATETIME(),
    sc_updated_by = @i_updated_by
WHERE
    sc_id = @i_sc_id
    AND sc_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_update>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_update>>>';
END CATCH;
GO