IF OBJECT_ID('ATROX.proc_atrox_company_create','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_company_create;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_company_create>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_company_create @i_co_id BIGINT,
    @i_co_name VARCHAR(200) = NULL,
    @i_co_code VARCHAR(100) = NULL,
    @i_co_description VARCHAR(500) = NULL,
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
    ATROX.atrox_company (
        co_id,
        co_name,
        co_code,
        co_description,
        co_created_at,
        co_created_by,
        co_updated_at,
        co_updated_by,
        co_deleted
    )
VALUES
    (
        @i_co_id,
        @i_co_name,
        @i_co_code,
        @i_co_description,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_company_create>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_company_create>>>';
END CATCH;
GO