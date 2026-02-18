IF OBJECT_ID('ATROX.proc_atrox_company_list','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_company_list;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_company_list>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_company_list @o_error INT OUTPUT,
    @o_message VARCHAR(500) OUTPUT AS BEGIN
SET
    NOCOUNT ON;



SET
    @o_error = 0;



SET
    @o_message = ''OK'';



BEGIN TRY BEGIN TRANSACTION;



SELECT
    *
FROM
    ATROX.atrox_company
WHERE
    co_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_company_list>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_company_list>>>';
END CATCH;
GO