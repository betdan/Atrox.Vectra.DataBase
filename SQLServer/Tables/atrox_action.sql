IF OBJECT_ID('ATROX.atrox_action','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_action;
    PRINT '<<<DROPPED TABLE ATROX.atrox_action>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_action (
    ac_id BIGINT NOT NULL,
    se_id BIGINT NOT NULL,
    ac_name VARCHAR(200) NOT NULL,
    ac_code VARCHAR(100) NOT NULL,
    ac_description VARCHAR(500) NULL,
    ac_current_version_id BIGINT NULL,
    ac_created_at DATETIME2 NOT NULL,
    ac_created_by BIGINT NOT NULL,
    ac_updated_at DATETIME2 NOT NULL,
    ac_updated_by BIGINT NOT NULL,
    ac_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_action PRIMARY KEY (ac_id),
    CONSTRAINT uq_atrox_action_service_code UNIQUE (se_id, ac_code),
    CONSTRAINT fk_atrox_action_service FOREIGN KEY (se_id) REFERENCES ATROX.atrox_service (se_id)
);



ALTER TABLE
    ATROX.atrox_action
ADD
    CONSTRAINT fk_atrox_action_current_version FOREIGN KEY (ac_current_version_id) REFERENCES ATROX.atrox_action_version (av_id);
    PRINT '<<<CREATED TABLE ATROX.atrox_action>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_action>>>';
END CATCH;
GO