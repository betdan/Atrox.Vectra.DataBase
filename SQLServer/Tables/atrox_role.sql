IF OBJECT_ID('ATROX.atrox_role','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_role;
    PRINT '<<<DROPPED TABLE ATROX.atrox_role>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_role (
    ro_id BIGINT NOT NULL,
    co_id BIGINT NOT NULL,
    ro_name VARCHAR(150) NOT NULL,
    ro_code VARCHAR(100) NOT NULL,
    ro_description VARCHAR(500) NULL,
    ro_created_at DATETIME2 NOT NULL,
    ro_created_by BIGINT NOT NULL,
    ro_updated_at DATETIME2 NOT NULL,
    ro_updated_by BIGINT NOT NULL,
    ro_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_role PRIMARY KEY (ro_id),
    CONSTRAINT uq_atrox_role_company_code UNIQUE (co_id, ro_code),
    CONSTRAINT fk_atrox_role_company FOREIGN KEY (co_id) REFERENCES ATROX.atrox_company (co_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_role>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_role>>>';
END CATCH;
GO