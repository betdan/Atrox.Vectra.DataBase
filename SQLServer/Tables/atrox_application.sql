IF OBJECT_ID('ATROX.atrox_application','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_application;
    PRINT '<<<DROPPED TABLE ATROX.atrox_application>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_application (
    ap_id BIGINT NOT NULL,
    co_id BIGINT NOT NULL,
    ap_name VARCHAR(200) NOT NULL,
    ap_code VARCHAR(100) NOT NULL,
    ap_description VARCHAR(500) NULL,
    ap_created_at DATETIME2 NOT NULL,
    ap_created_by BIGINT NOT NULL,
    ap_updated_at DATETIME2 NOT NULL,
    ap_updated_by BIGINT NOT NULL,
    ap_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_application PRIMARY KEY (ap_id),
    CONSTRAINT uq_atrox_application_company_code UNIQUE (co_id, ap_code),
    CONSTRAINT fk_atrox_application_company FOREIGN KEY (co_id) REFERENCES ATROX.atrox_company (co_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_application>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_application>>>';
END CATCH;
GO