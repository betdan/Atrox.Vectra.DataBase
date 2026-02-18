IF OBJECT_ID('ATROX.proc_atrox_action_create_version','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_action_create_version;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_action_create_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_action_create_version @i_av_id BIGINT,
    @i_ac_id BIGINT,
    @i_av_content_definition VARCHAR(MAX) = NULL,
    @i_av_input_definition VARCHAR(MAX) = NULL,
    @i_av_output_definition VARCHAR(MAX) = NULL,
    @i_created_by BIGINT,
    @o_error INT OUTPUT,
    @o_message VARCHAR(500) OUTPUT AS BEGIN
SET
    NOCOUNT ON;



SET
    @o_error = 0;



SET
    @o_message = ''OK'';



DECLARE @v_draft BIGINT;



BEGIN TRY BEGIN TRANSACTION;



SELECT
    @v_draft = vs_id
FROM
    ATROX.atrox_version_status
WHERE
    vs_code = ''DRAFT''
    AND vs_deleted = 0;



INSERT INTO
    ATROX.atrox_action_version(
        av_id,
        ac_id,
        av_version_number,
        vs_id,
        av_content_definition,
        av_input_definition,
        av_output_definition,
        av_created_at,
        av_created_by,
        av_updated_at,
        av_updated_by,
        av_deleted
    )
VALUES
(
        @i_av_id,
        @i_ac_id,
        ATROX.fn_atrox_next_action_version(@i_ac_id),
        @v_draft,
        @i_av_content_definition,
        @i_av_input_definition,
        @i_av_output_definition,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_action_create_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_action_create_version>>>';
END CATCH;
GO