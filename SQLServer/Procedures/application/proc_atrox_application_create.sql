IF OBJECT_ID('ATROX.proc_atrox_application_create','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_application_create;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_application_create>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_application_create @i_ap_id BIGINT,
    @i_co_id BIGINT = NULL,
    @i_ap_name VARCHAR(200) = NULL,
    @i_ap_code VARCHAR(100) = NULL,
    @i_ap_description VARCHAR(500) = NULL,
    @i_created_by BIGINT,
    @o_error INT OUTPUT,
    @o_message VARCHAR(500) OUTPUT AS BEGIN
SET
    NOCOUNT ON;



SET
    @o_error = 0;



SET
    @o_message = ''OK'';



BEGIN TRY BEGIN TRANSACTION;



INSERT INTO
    ATROX.atrox_application (
        ap_id,
        co_id,
        ap_name,
        ap_code,
        ap_description,
        ap_created_at,
        ap_created_by,
        ap_updated_at,
        ap_updated_by,
        ap_deleted
    )
VALUES
    (
        @i_ap_id,
        @i_co_id,
        @i_ap_name,
        @i_ap_code,
        @i_ap_description,
        SYSUTCDATETIME(),
        @i_created_by,
        SYSUTCDATETIME(),
        @i_created_by,
        0
    );



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_application_create>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_application_create>>>';
END CATCH;
GO