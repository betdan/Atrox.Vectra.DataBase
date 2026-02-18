IF OBJECT_ID('ATROX.atrox_user','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_user;
    PRINT '<<<DROPPED TABLE ATROX.atrox_user>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_user (
    us_id BIGINT NOT NULL,
    co_id BIGINT NOT NULL,
    us_username VARCHAR(150) NOT NULL,
    us_email VARCHAR(255) NOT NULL,
    us_password_hash VARCHAR(500) NOT NULL,
    us_is_active BIT NOT NULL,
    us_created_at DATETIME2 NOT NULL,
    us_created_by BIGINT NOT NULL,
    us_updated_at DATETIME2 NOT NULL,
    us_updated_by BIGINT NOT NULL,
    us_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_user PRIMARY KEY (us_id),
    CONSTRAINT uq_atrox_user_company_username UNIQUE (co_id, us_username),
    CONSTRAINT uq_atrox_user_company_email UNIQUE (co_id, us_email),
    CONSTRAINT fk_atrox_user_company FOREIGN KEY (co_id) REFERENCES ATROX.atrox_company (co_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_user>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_user>>>';
END CATCH;
GO