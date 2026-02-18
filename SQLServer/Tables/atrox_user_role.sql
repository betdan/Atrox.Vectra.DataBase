IF OBJECT_ID('ATROX.atrox_user_role','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_user_role;
    PRINT '<<<DROPPED TABLE ATROX.atrox_user_role>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_user_role (
    ur_id BIGINT NOT NULL,
    us_id BIGINT NOT NULL,
    ro_id BIGINT NOT NULL,
    ur_created_at DATETIME2 NOT NULL,
    ur_created_by BIGINT NOT NULL,
    ur_updated_at DATETIME2 NOT NULL,
    ur_updated_by BIGINT NOT NULL,
    ur_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_user_role PRIMARY KEY (ur_id),
    CONSTRAINT uq_atrox_user_role UNIQUE (us_id, ro_id),
    CONSTRAINT fk_atrox_user_role_user FOREIGN KEY (us_id) REFERENCES ATROX.atrox_user (us_id),
    CONSTRAINT fk_atrox_user_role_role FOREIGN KEY (ro_id) REFERENCES ATROX.atrox_role (ro_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_user_role>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_user_role>>>';
END CATCH;
GO