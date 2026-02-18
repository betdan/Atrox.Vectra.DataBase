IF OBJECT_ID('ATROX.proc_atrox_service_create_version','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_service_create_version;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_service_create_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_service_create_version @i_sv_id BIGINT,
    @i_se_id BIGINT,
    @i_sv_content_definition VARCHAR(MAX) = NULL,
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
    ATROX.atrox_service_version(
        sv_id,
        se_id,
        sv_version_number,
        vs_id,
        sv_content_definition,
        sv_created_at,
        sv_created_by,
        sv_updated_at,
        sv_updated_by,
        sv_deleted
    )
VALUES
(
        @i_sv_id,
        @i_se_id,
        ATROX.fn_atrox_next_service_version(@i_se_id),
        @v_draft,
        @i_sv_content_definition,
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
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_service_create_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_service_create_version>>>';
END CATCH;
GO