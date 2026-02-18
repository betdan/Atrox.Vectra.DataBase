IF OBJECT_ID('ATROX.proc_atrox_role_create','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_role_create;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_role_create>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_role_create @i_ro_id BIGINT,
    @i_co_id BIGINT = NULL,
    @i_ro_name VARCHAR(150) = NULL,
    @i_ro_code VARCHAR(100) = NULL,
    @i_ro_description VARCHAR(500) = NULL,
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
    ATROX.atrox_role (
        ro_id,
        co_id,
        ro_name,
        ro_code,
        ro_description,
        ro_created_at,
        ro_created_by,
        ro_updated_at,
        ro_updated_by,
        ro_deleted
    )
VALUES
    (
        @i_ro_id,
        @i_co_id,
        @i_ro_name,
        @i_ro_code,
        @i_ro_description,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_role_create>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_role_create>>>';
END CATCH;
GO