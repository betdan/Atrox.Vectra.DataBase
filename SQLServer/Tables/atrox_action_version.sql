IF OBJECT_ID('ATROX.atrox_action_version','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_action_version;
    PRINT '<<<DROPPED TABLE ATROX.atrox_action_version>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_action_version (
    av_id BIGINT NOT NULL,
    ac_id BIGINT NOT NULL,
    av_version_number BIGINT NOT NULL,
    vs_id BIGINT NOT NULL,
    av_content_definition VARCHAR(MAX) NULL,
    av_input_definition VARCHAR(MAX) NULL,
    av_output_definition VARCHAR(MAX) NULL,
    av_created_at DATETIME2 NOT NULL,
    av_created_by BIGINT NOT NULL,
    av_updated_at DATETIME2 NOT NULL,
    av_updated_by BIGINT NOT NULL,
    av_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_action_version PRIMARY KEY (av_id),
    CONSTRAINT uq_atrox_action_version UNIQUE (ac_id, av_version_number),
    CONSTRAINT fk_atrox_action_version_action FOREIGN KEY (ac_id) REFERENCES ATROX.atrox_action (ac_id),
    CONSTRAINT fk_atrox_action_version_status FOREIGN KEY (vs_id) REFERENCES ATROX.atrox_version_status (vs_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_action_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_action_version>>>';
END CATCH;
GO