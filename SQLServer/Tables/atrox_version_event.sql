IF OBJECT_ID('ATROX.atrox_version_event','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_version_event;
    PRINT '<<<DROPPED TABLE ATROX.atrox_version_event>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_version_event (
    ve_id BIGINT IDENTITY(1,1) NOT NULL,
    ve_entity_type VARCHAR(20) NOT NULL,
    ve_entity_id BIGINT NOT NULL,
    ve_previous_version_id BIGINT NULL,
    ve_new_version_id BIGINT NOT NULL,
    ve_event_type VARCHAR(20) NOT NULL,
    ve_executed_by BIGINT NOT NULL,
    ve_executed_at DATETIME2 NOT NULL CONSTRAINT df_atrox_version_event_executed_at DEFAULT SYSUTCDATETIME(),
    CONSTRAINT pk_atrox_version_event PRIMARY KEY (ve_id),
    CONSTRAINT ck_atrox_version_event_entity_type CHECK (ve_entity_type IN ('SCREEN', 'SERVICE', 'ACTION')),
    CONSTRAINT ck_atrox_version_event_event_type CHECK (ve_event_type IN ('ENABLE', 'ROLLBACK'))
);

CREATE INDEX ix_atrox_version_event_entity ON ATROX.atrox_version_event (ve_entity_type, ve_entity_id, ve_executed_at);
    PRINT '<<<CREATED TABLE ATROX.atrox_version_event>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_version_event>>>';
END CATCH;
GO