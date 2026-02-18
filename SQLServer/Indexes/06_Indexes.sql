IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_application_co_id' AND object_id = OBJECT_ID('ATROX.atrox_application','U'))
BEGIN
    DROP INDEX ix_atrox_application_co_id ON ATROX.atrox_application;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_application_co_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_application_co_id ON ATROX.atrox_application (co_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_application_co_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_application_co_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_function_co_id' AND object_id = OBJECT_ID('ATROX.atrox_function','U'))
BEGIN
    DROP INDEX ix_atrox_function_co_id ON ATROX.atrox_function;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_function_co_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_function_co_id ON ATROX.atrox_function (co_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_function_co_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_function_co_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_menu_ap_id' AND object_id = OBJECT_ID('ATROX.atrox_menu','U'))
BEGIN
    DROP INDEX ix_atrox_menu_ap_id ON ATROX.atrox_menu;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_menu_ap_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_menu_ap_id ON ATROX.atrox_menu (ap_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_menu_ap_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_ap_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_menu_parent_id' AND object_id = OBJECT_ID('ATROX.atrox_menu','U'))
BEGIN
    DROP INDEX ix_atrox_menu_parent_id ON ATROX.atrox_menu;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_menu_parent_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_menu_parent_id ON ATROX.atrox_menu (mn_parent_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_menu_parent_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_parent_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_menu_screen_id' AND object_id = OBJECT_ID('ATROX.atrox_menu','U'))
BEGIN
    DROP INDEX ix_atrox_menu_screen_id ON ATROX.atrox_menu;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_menu_screen_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_menu_screen_id ON ATROX.atrox_menu (mn_screen_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_menu_screen_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_screen_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_menu_main_function_id' AND object_id = OBJECT_ID('ATROX.atrox_menu','U'))
BEGIN
    DROP INDEX ix_atrox_menu_main_function_id ON ATROX.atrox_menu;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_menu_main_function_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_menu_main_function_id ON ATROX.atrox_menu (mn_main_function_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_menu_main_function_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_main_function_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_user_co_id' AND object_id = OBJECT_ID('ATROX.atrox_user','U'))
BEGIN
    DROP INDEX ix_atrox_user_co_id ON ATROX.atrox_user;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_user_co_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_user_co_id ON ATROX.atrox_user (co_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_user_co_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_user_co_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_user_role_us_id' AND object_id = OBJECT_ID('ATROX.atrox_user_role','U'))
BEGIN
    DROP INDEX ix_atrox_user_role_us_id ON ATROX.atrox_user_role;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_user_role_us_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_user_role_us_id ON ATROX.atrox_user_role (us_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_user_role_us_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_user_role_us_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_user_role_ro_id' AND object_id = OBJECT_ID('ATROX.atrox_user_role','U'))
BEGIN
    DROP INDEX ix_atrox_user_role_ro_id ON ATROX.atrox_user_role;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_user_role_ro_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_user_role_ro_id ON ATROX.atrox_user_role (ro_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_user_role_ro_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_user_role_ro_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_role_co_id' AND object_id = OBJECT_ID('ATROX.atrox_role','U'))
BEGIN
    DROP INDEX ix_atrox_role_co_id ON ATROX.atrox_role;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_role_co_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_role_co_id ON ATROX.atrox_role (co_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_role_co_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_role_co_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_role_function_ro_id' AND object_id = OBJECT_ID('ATROX.atrox_role_function','U'))
BEGIN
    DROP INDEX ix_atrox_role_function_ro_id ON ATROX.atrox_role_function;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_role_function_ro_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_role_function_ro_id ON ATROX.atrox_role_function (ro_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_role_function_ro_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_role_function_ro_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_role_function_fn_id' AND object_id = OBJECT_ID('ATROX.atrox_role_function','U'))
BEGIN
    DROP INDEX ix_atrox_role_function_fn_id ON ATROX.atrox_role_function;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_role_function_fn_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_role_function_fn_id ON ATROX.atrox_role_function (fn_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_role_function_fn_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_role_function_fn_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_screen_ap_id' AND object_id = OBJECT_ID('ATROX.atrox_screen','U'))
BEGIN
    DROP INDEX ix_atrox_screen_ap_id ON ATROX.atrox_screen;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_screen_ap_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_screen_ap_id ON ATROX.atrox_screen (ap_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_screen_ap_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_ap_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_screen_current_version_id' AND object_id = OBJECT_ID('ATROX.atrox_screen','U'))
BEGIN
    DROP INDEX ix_atrox_screen_current_version_id ON ATROX.atrox_screen;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_screen_current_version_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_screen_current_version_id ON ATROX.atrox_screen (sc_current_version_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_screen_current_version_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_current_version_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_screen_function_sc_id' AND object_id = OBJECT_ID('ATROX.atrox_screen_function','U'))
BEGIN
    DROP INDEX ix_atrox_screen_function_sc_id ON ATROX.atrox_screen_function;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_screen_function_sc_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_screen_function_sc_id ON ATROX.atrox_screen_function (sc_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_screen_function_sc_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_function_sc_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_screen_function_fn_id' AND object_id = OBJECT_ID('ATROX.atrox_screen_function','U'))
BEGIN
    DROP INDEX ix_atrox_screen_function_fn_id ON ATROX.atrox_screen_function;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_screen_function_fn_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_screen_function_fn_id ON ATROX.atrox_screen_function (fn_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_screen_function_fn_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_function_fn_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_service_sc_id' AND object_id = OBJECT_ID('ATROX.atrox_service','U'))
BEGIN
    DROP INDEX ix_atrox_service_sc_id ON ATROX.atrox_service;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_service_sc_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_service_sc_id ON ATROX.atrox_service (sc_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_service_sc_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_sc_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_service_current_version_id' AND object_id = OBJECT_ID('ATROX.atrox_service','U'))
BEGIN
    DROP INDEX ix_atrox_service_current_version_id ON ATROX.atrox_service;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_service_current_version_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_service_current_version_id ON ATROX.atrox_service (se_current_version_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_service_current_version_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_current_version_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_action_se_id' AND object_id = OBJECT_ID('ATROX.atrox_action','U'))
BEGIN
    DROP INDEX ix_atrox_action_se_id ON ATROX.atrox_action;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_action_se_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_action_se_id ON ATROX.atrox_action (se_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_action_se_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_se_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_action_current_version_id' AND object_id = OBJECT_ID('ATROX.atrox_action','U'))
BEGIN
    DROP INDEX ix_atrox_action_current_version_id ON ATROX.atrox_action;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_action_current_version_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_action_current_version_id ON ATROX.atrox_action (ac_current_version_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_action_current_version_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_current_version_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_action_parameter_ac_id' AND object_id = OBJECT_ID('ATROX.atrox_action_parameter','U'))
BEGIN
    DROP INDEX ix_atrox_action_parameter_ac_id ON ATROX.atrox_action_parameter;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_action_parameter_ac_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_action_parameter_ac_id ON ATROX.atrox_action_parameter (ac_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_action_parameter_ac_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_parameter_ac_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_screen_version_sc_id' AND object_id = OBJECT_ID('ATROX.atrox_screen_version','U'))
BEGIN
    DROP INDEX ix_atrox_screen_version_sc_id ON ATROX.atrox_screen_version;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_screen_version_sc_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_screen_version_sc_id ON ATROX.atrox_screen_version (sc_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_screen_version_sc_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_version_sc_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_screen_version_vs_id' AND object_id = OBJECT_ID('ATROX.atrox_screen_version','U'))
BEGIN
    DROP INDEX ix_atrox_screen_version_vs_id ON ATROX.atrox_screen_version;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_screen_version_vs_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_screen_version_vs_id ON ATROX.atrox_screen_version (vs_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_screen_version_vs_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_version_vs_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_service_version_se_id' AND object_id = OBJECT_ID('ATROX.atrox_service_version','U'))
BEGIN
    DROP INDEX ix_atrox_service_version_se_id ON ATROX.atrox_service_version;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_service_version_se_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_service_version_se_id ON ATROX.atrox_service_version (se_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_service_version_se_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_version_se_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_service_version_vs_id' AND object_id = OBJECT_ID('ATROX.atrox_service_version','U'))
BEGIN
    DROP INDEX ix_atrox_service_version_vs_id ON ATROX.atrox_service_version;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_service_version_vs_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_service_version_vs_id ON ATROX.atrox_service_version (vs_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_service_version_vs_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_version_vs_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_action_version_ac_id' AND object_id = OBJECT_ID('ATROX.atrox_action_version','U'))
BEGIN
    DROP INDEX ix_atrox_action_version_ac_id ON ATROX.atrox_action_version;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_action_version_ac_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_action_version_ac_id ON ATROX.atrox_action_version (ac_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_action_version_ac_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_version_ac_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ix_atrox_action_version_vs_id' AND object_id = OBJECT_ID('ATROX.atrox_action_version','U'))
BEGIN
    DROP INDEX ix_atrox_action_version_vs_id ON ATROX.atrox_action_version;
    PRINT '<<<DROPPED INDEX ATROX.ix_atrox_action_version_vs_id>>>';
END;
GO

BEGIN TRY
CREATE INDEX ix_atrox_action_version_vs_id ON ATROX.atrox_action_version (vs_id);
    PRINT '<<<CREATED INDEX ATROX.ix_atrox_action_version_vs_id>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_version_vs_id>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ux_atrox_company_co_code' AND object_id = OBJECT_ID('ATROX.atrox_company','U'))
BEGIN
    DROP INDEX ux_atrox_company_co_code ON ATROX.atrox_company;
    PRINT '<<<DROPPED INDEX ATROX.ux_atrox_company_co_code>>>';
END;
GO

BEGIN TRY
CREATE UNIQUE INDEX ux_atrox_company_co_code ON ATROX.atrox_company (co_code);
    PRINT '<<<CREATED INDEX ATROX.ux_atrox_company_co_code>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ux_atrox_company_co_code>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ux_atrox_application_ap_code' AND object_id = OBJECT_ID('ATROX.atrox_application','U'))
BEGIN
    DROP INDEX ux_atrox_application_ap_code ON ATROX.atrox_application;
    PRINT '<<<DROPPED INDEX ATROX.ux_atrox_application_ap_code>>>';
END;
GO

BEGIN TRY
CREATE UNIQUE INDEX ux_atrox_application_ap_code ON ATROX.atrox_application (ap_code);
    PRINT '<<<CREATED INDEX ATROX.ux_atrox_application_ap_code>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ux_atrox_application_ap_code>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ux_atrox_screen_sc_code' AND object_id = OBJECT_ID('ATROX.atrox_screen','U'))
BEGIN
    DROP INDEX ux_atrox_screen_sc_code ON ATROX.atrox_screen;
    PRINT '<<<DROPPED INDEX ATROX.ux_atrox_screen_sc_code>>>';
END;
GO

BEGIN TRY
CREATE UNIQUE INDEX ux_atrox_screen_sc_code ON ATROX.atrox_screen (sc_code);
    PRINT '<<<CREATED INDEX ATROX.ux_atrox_screen_sc_code>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ux_atrox_screen_sc_code>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ux_atrox_function_fn_code' AND object_id = OBJECT_ID('ATROX.atrox_function','U'))
BEGIN
    DROP INDEX ux_atrox_function_fn_code ON ATROX.atrox_function;
    PRINT '<<<DROPPED INDEX ATROX.ux_atrox_function_fn_code>>>';
END;
GO

BEGIN TRY
CREATE UNIQUE INDEX ux_atrox_function_fn_code ON ATROX.atrox_function (fn_code);
    PRINT '<<<CREATED INDEX ATROX.ux_atrox_function_fn_code>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ux_atrox_function_fn_code>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ux_atrox_screen_one_enabled' AND object_id = OBJECT_ID('ATROX.atrox_screen_version','U'))
BEGIN
    DROP INDEX ux_atrox_screen_one_enabled ON ATROX.atrox_screen_version;
    PRINT '<<<DROPPED INDEX ATROX.ux_atrox_screen_one_enabled>>>';
END;
GO

BEGIN TRY
CREATE UNIQUE INDEX ux_atrox_screen_one_enabled ON ATROX.atrox_screen_version (sc_id)
WHERE vs_id = 2 AND sv_deleted = 0;
    PRINT '<<<CREATED INDEX ATROX.ux_atrox_screen_one_enabled>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ux_atrox_screen_one_enabled>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ux_atrox_service_one_enabled' AND object_id = OBJECT_ID('ATROX.atrox_service_version','U'))
BEGIN
    DROP INDEX ux_atrox_service_one_enabled ON ATROX.atrox_service_version;
    PRINT '<<<DROPPED INDEX ATROX.ux_atrox_service_one_enabled>>>';
END;
GO

BEGIN TRY
CREATE UNIQUE INDEX ux_atrox_service_one_enabled ON ATROX.atrox_service_version (se_id)
WHERE vs_id = 2 AND sv_deleted = 0;
    PRINT '<<<CREATED INDEX ATROX.ux_atrox_service_one_enabled>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ux_atrox_service_one_enabled>>>';
END CATCH;
GO

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'ux_atrox_action_one_enabled' AND object_id = OBJECT_ID('ATROX.atrox_action_version','U'))
BEGIN
    DROP INDEX ux_atrox_action_one_enabled ON ATROX.atrox_action_version;
    PRINT '<<<DROPPED INDEX ATROX.ux_atrox_action_one_enabled>>>';
END;
GO

BEGIN TRY
CREATE UNIQUE INDEX ux_atrox_action_one_enabled ON ATROX.atrox_action_version (ac_id)
WHERE vs_id = 2 AND av_deleted = 0;
    PRINT '<<<CREATED INDEX ATROX.ux_atrox_action_one_enabled>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING INDEX ATROX.ux_atrox_action_one_enabled>>>';
END CATCH;
GO
