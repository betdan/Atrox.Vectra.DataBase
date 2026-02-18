IF OBJECT_ID('ATROX.fn_atrox_next_screen_version','FN') IS NOT NULL
BEGIN
    DROP FUNCTION ATROX.fn_atrox_next_screen_version;
    PRINT '<<<DROPPED FUNCTION ATROX.fn_atrox_next_screen_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE OR ALTER FUNCTION ATROX.fn_atrox_next_screen_version (@sc_id BIGINT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @next_version BIGINT;

    SELECT @next_version = ISNULL(MAX(sv_version_number), 0) + 1
    FROM ATROX.atrox_screen_version
    WHERE sc_id = @sc_id;

    RETURN @next_version;
END;');
    PRINT '<<<CREATED FUNCTION ATROX.fn_atrox_next_screen_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING FUNCTION ATROX.fn_atrox_next_screen_version>>>';
END CATCH;
GO