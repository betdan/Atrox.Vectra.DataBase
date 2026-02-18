IF OBJECT_ID('ATROX.fn_atrox_next_action_version','FN') IS NOT NULL
BEGIN
    DROP FUNCTION ATROX.fn_atrox_next_action_version;
    PRINT '<<<DROPPED FUNCTION ATROX.fn_atrox_next_action_version>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE OR ALTER FUNCTION ATROX.fn_atrox_next_action_version (@ac_id BIGINT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @next_version BIGINT;

    SELECT @next_version = ISNULL(MAX(av_version_number), 0) + 1
    FROM ATROX.atrox_action_version
    WHERE ac_id = @ac_id;

    RETURN @next_version;
END;');
    PRINT '<<<CREATED FUNCTION ATROX.fn_atrox_next_action_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING FUNCTION ATROX.fn_atrox_next_action_version>>>';
END CATCH;
GO