IF OBJECT_ID('ATROX.atrox_installation','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_installation;
    PRINT '<<<DROPPED TABLE ATROX.atrox_installation>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_installation (
        in_id BIGINT NOT NULL,
        in_version VARCHAR(50) NOT NULL,
        in_installed_at DATETIME2 NOT NULL,
        in_installed_by VARCHAR(200) NOT NULL,
        CONSTRAINT pk_atrox_installation PRIMARY KEY (in_id),
        CONSTRAINT uq_atrox_installation_version UNIQUE (in_version)
    );
    PRINT '<<<CREATED TABLE ATROX.atrox_installation>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_installation>>>';
END CATCH;
GO