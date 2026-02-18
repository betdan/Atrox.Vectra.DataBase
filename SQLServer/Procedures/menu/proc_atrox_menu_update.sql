IF OBJECT_ID('ATROX.proc_atrox_menu_update','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_menu_update;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_menu_update>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_menu_update @i_mn_id BIGINT,
    @i_ap_id BIGINT = NULL,
    @i_mn_parent_id BIGINT = NULL,
    @i_mn_name VARCHAR(200) = NULL,
    @i_mn_code VARCHAR(100) = NULL,
    @i_mn_order INT = NULL,
    @i_mn_path VARCHAR(300) = NULL,
    @i_mn_icon VARCHAR(100) = NULL,
    @i_mn_screen_id BIGINT = NULL,
    @i_mn_main_function_id BIGINT = NULL,
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
    ATROX.atrox_menu
SET
    ap_id = @i_ap_id,
    mn_parent_id = @i_mn_parent_id,
    mn_name = @i_mn_name,
    mn_code = @i_mn_code,
    mn_order = @i_mn_order,
    mn_path = @i_mn_path,
    mn_icon = @i_mn_icon,
    mn_screen_id = @i_mn_screen_id,
    mn_main_function_id = @i_mn_main_function_id,
    mn_updated_at = SYSUTCDATETIME(),
    mn_updated_by = @i_updated_by
WHERE
    mn_id = @i_mn_id
    AND mn_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_menu_update>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_menu_update>>>';
END CATCH;
GO