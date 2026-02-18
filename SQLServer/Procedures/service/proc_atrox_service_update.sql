IF OBJECT_ID('ATROX.proc_atrox_service_update','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_service_update;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_service_update>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_service_update @i_se_id BIGINT,
    @i_sc_id BIGINT = NULL,
    @i_se_name VARCHAR(200) = NULL,
    @i_se_code VARCHAR(100) = NULL,
    @i_se_description VARCHAR(500) = NULL,
    @i_se_endpoint VARCHAR(500) = NULL,
    @i_se_http_method VARCHAR(20) = NULL,
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
    ATROX.atrox_service
SET
    sc_id = @i_sc_id,
    se_name = @i_se_name,
    se_code = @i_se_code,
    se_description = @i_se_description,
    se_endpoint = @i_se_endpoint,
    se_http_method = @i_se_http_method,
    se_updated_at = SYSUTCDATETIME(),
    se_updated_by = @i_updated_by
WHERE
    se_id = @i_se_id
    AND se_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_service_update>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_service_update>>>';
END CATCH;
GO