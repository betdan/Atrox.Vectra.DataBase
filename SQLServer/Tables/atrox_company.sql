IF OBJECT_ID('ATROX.atrox_company','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_company;
    PRINT '<<<DROPPED TABLE ATROX.atrox_company>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_company (
    co_id BIGINT NOT NULL,
    co_name VARCHAR(200) NOT NULL,
    co_code VARCHAR(100) NOT NULL,
    co_description VARCHAR(500) NULL,
    co_created_at DATETIME2 NOT NULL,
    co_created_by BIGINT NOT NULL,
    co_updated_at DATETIME2 NOT NULL,
    co_updated_by BIGINT NOT NULL,
    co_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_company PRIMARY KEY (co_id),
    CONSTRAINT uq_atrox_company_code UNIQUE (co_code)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_company>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_company>>>';
END CATCH;
GO