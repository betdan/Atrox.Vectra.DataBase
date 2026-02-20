IF OBJECT_ID('ATROX.atrox_service','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_service;
    PRINT '<<<DROPPED TABLE ATROX.atrox_service>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_service (
    se_id BIGINT NOT NULL,
    sc_id BIGINT NOT NULL,
    se_name VARCHAR(200) NOT NULL,
    se_code VARCHAR(100) NOT NULL,
    se_description VARCHAR(500) NULL,
    se_endpoint VARCHAR(500) NULL,
    se_http_method VARCHAR(20) NULL,
    se_current_version_id BIGINT NULL,
    se_created_at DATETIME2 NOT NULL,
    se_created_by BIGINT NOT NULL,
    se_updated_at DATETIME2 NOT NULL,
    se_updated_by BIGINT NOT NULL,
    se_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_service PRIMARY KEY (se_id),
    CONSTRAINT uq_atrox_service_screen_code UNIQUE (sc_id, se_code),
    CONSTRAINT fk_atrox_service_screen FOREIGN KEY (sc_id) REFERENCES ATROX.atrox_screen (sc_id)
);


    PRINT '<<<CREATED TABLE ATROX.atrox_service>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_service>>>';
END CATCH;
GO
