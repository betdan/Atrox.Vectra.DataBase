IF OBJECT_ID('ATROX.atrox_version_status','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_version_status;
    PRINT '<<<DROPPED TABLE ATROX.atrox_version_status>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_version_status (
    vs_id BIGINT NOT NULL,
    vs_code VARCHAR(50) NOT NULL,
    vs_name VARCHAR(100) NOT NULL,
    vs_created_at DATETIME2 NOT NULL,
    vs_created_by BIGINT NOT NULL,
    vs_updated_at DATETIME2 NOT NULL,
    vs_updated_by BIGINT NOT NULL,
    vs_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_version_status PRIMARY KEY (vs_id),
    CONSTRAINT uq_atrox_version_status_code UNIQUE (vs_code)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_version_status>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_version_status>>>';
END CATCH;
GO