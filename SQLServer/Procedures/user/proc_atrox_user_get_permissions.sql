IF OBJECT_ID('ATROX.proc_atrox_user_get_permissions','P') IS NOT NULL
BEGIN
    DROP PROCEDURE ATROX.proc_atrox_user_get_permissions;
    PRINT '<<<DROPPED PROCEDURE ATROX.proc_atrox_user_get_permissions>>>';
END;
GO

BEGIN TRY
    EXEC(N'CREATE PROCEDURE ATROX.proc_atrox_user_get_permissions @i_us_id BIGINT,
    @o_error INT OUTPUT,
    @o_message VARCHAR(500) OUTPUT AS BEGIN
SET
    NOCOUNT ON;



SET
    @o_error = 0;



SET
    @o_message = ''OK'';



BEGIN TRY BEGIN TRANSACTION;



SELECT
    DISTINCT r.ro_code AS role_code,
    r.ro_name AS role_name,
    f.fn_code AS function_code,
    f.fn_name AS function_name,
    m.mn_code AS menu_code,
    m.mn_name AS menu_name,
    COALESCE(s1.sc_code, s2.sc_code) AS screen_code,
    COALESCE(s1.sc_name, s2.sc_name) AS screen_name
FROM
    ATROX.atrox_user u
    INNER JOIN ATROX.atrox_user_role ur ON ur.us_id = u.us_id
    AND ur.ur_deleted = 0
    INNER JOIN ATROX.atrox_role r ON r.ro_id = ur.ro_id
    AND r.ro_deleted = 0
    INNER JOIN ATROX.atrox_role_function rf ON rf.ro_id = r.ro_id
    AND rf.rf_deleted = 0
    INNER JOIN ATROX.atrox_function f ON f.fn_id = rf.fn_id
    AND f.fn_deleted = 0
    LEFT JOIN ATROX.atrox_menu m ON m.mn_main_function_id = f.fn_id
    AND m.mn_deleted = 0
    LEFT JOIN ATROX.atrox_screen s1 ON s1.sc_id = m.mn_screen_id
    AND s1.sc_deleted = 0
    LEFT JOIN ATROX.atrox_screen_function sf ON sf.fn_id = f.fn_id
    AND sf.sf_deleted = 0
    LEFT JOIN ATROX.atrox_screen s2 ON s2.sc_id = sf.sc_id
    AND s2.sc_deleted = 0
WHERE
    u.us_id = @i_us_id
    AND u.us_deleted = 0;



COMMIT TRANSACTION;



END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;



SET
    @o_error = ERROR_NUMBER();



SET
    @o_message = LEFT(ERROR_MESSAGE(), 500);



END CATCH
END;');
    PRINT '<<<CREATED PROCEDURE ATROX.proc_atrox_user_get_permissions>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_user_get_permissions>>>';
END CATCH;
GO