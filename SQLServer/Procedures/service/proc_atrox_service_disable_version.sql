IF OBJECT_ID('ATROX.proc_atrox_service_disable_version','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_service_disable_version;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_service_disable_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_service_disable_version @i_se_id BIGINT,
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
    ATROX.atrox_service_version
SET
    vs_id = @v_disabled,
    sv_updated_at = SYSUTCDATETIME(),
    sv_updated_by = @i_updated_by
WHERE
    sv_id = @i_sv_id
    AND se_id = @i_se_id
    AND sv_deleted = 0;



UPDATE
    ATROX.atrox_service
SET
    se_current_version_id =CASE
        WHEN se_current_version_id = @i_sv_id THEN NULL
        ELSE se_current_version_id
    END,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_service_disable_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_service_disable_version>>>';
END CATCH;
GO