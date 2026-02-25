IF OBJECT_ID('ATROX.atrox_security_client','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_security_client;
    PRINT '<<<DROPPED TABLE ATROX.atrox_security_client>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_security_client (
    client_id UNIQUEIDENTIFIER NOT NULL,
    company_id UNIQUEIDENTIFIER NOT NULL,
    client_name VARCHAR(150) NULL,
    api_key_hash VARCHAR(256) NOT NULL,
    is_active BIT NOT NULL CONSTRAINT df_atrox_security_client_is_active DEFAULT (1),
    created_at DATETIME2 NOT NULL CONSTRAINT df_atrox_security_client_created_at DEFAULT (SYSUTCDATETIME()),
    expires_at DATETIME2 NULL,
    last_used_at DATETIME2 NULL,
    CONSTRAINT pk_atrox_security_client PRIMARY KEY (client_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_security_client>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_security_client>>>';
END CATCH;
GO
