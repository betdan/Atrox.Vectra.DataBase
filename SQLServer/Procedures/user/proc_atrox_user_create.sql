IF OBJECT_ID('ATROX.proc_atrox_user_create','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_user_create;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_user_create>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_user_create @i_us_id BIGINT,
    @i_co_id BIGINT = NULL,
    @i_us_username VARCHAR(150) = NULL,
    @i_us_email VARCHAR(255) = NULL,
    @i_us_password_hash VARCHAR(500) = NULL,
    @i_us_is_active BIT = NULL,
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
    ATROX.atrox_user (
        us_id,
        co_id,
        us_username,
        us_email,
        us_password_hash,
        us_is_active,
        us_created_at,
        us_created_by,
        us_updated_at,
        us_updated_by,
        us_deleted
    )
VALUES
    (
        @i_us_id,
        @i_co_id,
        @i_us_username,
        @i_us_email,
        @i_us_password_hash,
        @i_us_is_active,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_user_create>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_user_create>>>';
END CATCH;
GO