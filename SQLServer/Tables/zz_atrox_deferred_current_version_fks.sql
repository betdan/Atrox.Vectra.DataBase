BEGIN TRY
    IF OBJECT_ID('ATROX.atrox_screen','U') IS NOT NULL
       AND OBJECT_ID('ATROX.atrox_screen_version','U') IS NOT NULL
       AND NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_atrox_screen_current_version' AND parent_object_id = OBJECT_ID('ATROX.atrox_screen'))
    BEGIN
        ALTER TABLE ATROX.atrox_screen
        ADD CONSTRAINT fk_atrox_screen_current_version
        FOREIGN KEY (sc_current_version_id) REFERENCES ATROX.atrox_screen_version (sv_id);
        PRINT '<<<CREATED FK ATROX.fk_atrox_screen_current_version>>>';
    END
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING FK ATROX.fk_atrox_screen_current_version>>>';
END CATCH;
GO

BEGIN TRY
    IF OBJECT_ID('ATROX.atrox_service','U') IS NOT NULL
       AND OBJECT_ID('ATROX.atrox_service_version','U') IS NOT NULL
       AND NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_atrox_service_current_version' AND parent_object_id = OBJECT_ID('ATROX.atrox_service'))
    BEGIN
        ALTER TABLE ATROX.atrox_service
        ADD CONSTRAINT fk_atrox_service_current_version
        FOREIGN KEY (se_current_version_id) REFERENCES ATROX.atrox_service_version (sv_id);
        PRINT '<<<CREATED FK ATROX.fk_atrox_service_current_version>>>';
    END
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING FK ATROX.fk_atrox_service_current_version>>>';
END CATCH;
GO

BEGIN TRY
    IF OBJECT_ID('ATROX.atrox_action','U') IS NOT NULL
       AND OBJECT_ID('ATROX.atrox_action_version','U') IS NOT NULL
       AND NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'fk_atrox_action_current_version' AND parent_object_id = OBJECT_ID('ATROX.atrox_action'))
    BEGIN
        ALTER TABLE ATROX.atrox_action
        ADD CONSTRAINT fk_atrox_action_current_version
        FOREIGN KEY (ac_current_version_id) REFERENCES ATROX.atrox_action_version (av_id);
        PRINT '<<<CREATED FK ATROX.fk_atrox_action_current_version>>>';
    END
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING FK ATROX.fk_atrox_action_current_version>>>';
END CATCH;
GO
