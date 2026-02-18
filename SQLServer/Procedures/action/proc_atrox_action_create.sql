IF OBJECT_ID('ATROX.proc_atrox_action_create','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_action_create;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_create>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_action_create @i_ac_id BIGINT,
    @i_se_id BIGINT = NULL,
    @i_ac_name VARCHAR(200) = NULL,
    @i_ac_code VARCHAR(100) = NULL,
    @i_ac_description VARCHAR(500) = NULL,
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
    ATROX.atrox_action (
        ac_id,
        se_id,
        ac_name,
        ac_code,
        ac_description,
        ac_created_at,
        ac_created_by,
        ac_updated_at,
        ac_updated_by,
        ac_deleted
    )
VALUES
    (
        @i_ac_id,
        @i_se_id,
        @i_ac_name,
        @i_ac_code,
        @i_ac_description,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_action_create>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_create>>>';
END CATCH;
GO