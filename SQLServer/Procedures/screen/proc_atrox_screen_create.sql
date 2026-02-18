IF OBJECT_ID('ATROX.proc_atrox_screen_create','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_screen_create;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_screen_create>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_screen_create @i_sc_id BIGINT,
    @i_ap_id BIGINT = NULL,
    @i_sc_name VARCHAR(200) = NULL,
    @i_sc_code VARCHAR(100) = NULL,
    @i_sc_description VARCHAR(500) = NULL,
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
    ATROX.atrox_screen (
        sc_id,
        ap_id,
        sc_name,
        sc_code,
        sc_description,
        sc_created_at,
        sc_created_by,
        sc_updated_at,
        sc_updated_by,
        sc_deleted
    )
VALUES
    (
        @i_sc_id,
        @i_ap_id,
        @i_sc_name,
        @i_sc_code,
        @i_sc_description,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_screen_create>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_screen_create>>>';
END CATCH;
GO