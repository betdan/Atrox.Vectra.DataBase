IF OBJECT_ID('ATROX.atrox_screen_version','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_screen_version;
    PRINT '<<<DROPPED TABLE ATROX.atrox_screen_version>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_screen_version (
    sv_id BIGINT NOT NULL,
    sc_id BIGINT NOT NULL,
    sv_version_number BIGINT NOT NULL,
    vs_id BIGINT NOT NULL,
    sv_content_definition VARCHAR(MAX) NULL,
    sv_html_template_definition VARCHAR(MAX) NOT NULL,
    sv_created_at DATETIME2 NOT NULL,
    sv_created_by BIGINT NOT NULL,
    sv_updated_at DATETIME2 NOT NULL,
    sv_updated_by BIGINT NOT NULL,
    sv_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_screen_version PRIMARY KEY (sv_id),
    CONSTRAINT uq_atrox_screen_version UNIQUE (sc_id, sv_version_number),
    CONSTRAINT fk_atrox_screen_version_screen FOREIGN KEY (sc_id) REFERENCES ATROX.atrox_screen (sc_id),
    CONSTRAINT fk_atrox_screen_version_status FOREIGN KEY (vs_id) REFERENCES ATROX.atrox_version_status (vs_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_screen_version>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_screen_version>>>';
END CATCH;
GO