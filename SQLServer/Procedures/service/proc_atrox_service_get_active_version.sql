IF OBJECT_ID('ATROX.proc_atrox_service_get_active_version','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_service_get_active_version;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_service_get_active_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_service_get_active_version @i_se_id BIGINT,
    @o_error INT OUTPUT,
    @o_message VARCHAR(500) OUTPUT AS BEGIN
SET
    NOCOUNT ON;



SET
    @o_error = 0;



SET
    @o_message = ''OK'';



BEGIN TRY BEGIN TRANSACTION;



SELECT
    sv.*
FROM
    ATROX.atrox_service s
    INNER JOIN ATROX.atrox_service_version sv ON sv.sv_id = s.se_current_version_id
WHERE
    s.se_id = @i_se_id
    AND s.se_deleted = 0
    AND sv.sv_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_service_get_active_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_service_get_active_version>>>';
END CATCH;
GO