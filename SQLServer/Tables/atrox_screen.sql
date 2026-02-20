IF OBJECT_ID('ATROX.atrox_screen','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_screen;
    PRINT '<<<DROPPED TABLE ATROX.atrox_screen>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_screen (
    sc_id BIGINT NOT NULL,
    ap_id BIGINT NOT NULL,
    sc_name VARCHAR(200) NOT NULL,
    sc_code VARCHAR(100) NOT NULL,
    sc_description VARCHAR(500) NULL,
    sc_current_version_id BIGINT NULL,
    sc_created_at DATETIME2 NOT NULL,
    sc_created_by BIGINT NOT NULL,
    sc_updated_at DATETIME2 NOT NULL,
    sc_updated_by BIGINT NOT NULL,
    sc_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_screen PRIMARY KEY (sc_id),
    CONSTRAINT uq_atrox_screen_app_code UNIQUE (ap_id, sc_code),
    CONSTRAINT fk_atrox_screen_application FOREIGN KEY (ap_id) REFERENCES ATROX.atrox_application (ap_id)
);


    PRINT '<<<CREATED TABLE ATROX.atrox_screen>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_screen>>>';
END CATCH;
GO
