IF OBJECT_ID('ATROX.atrox_function','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_function;
    PRINT '<<<DROPPED TABLE ATROX.atrox_function>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_function (
    fn_id BIGINT NOT NULL,
    co_id BIGINT NOT NULL,
    fn_name VARCHAR(200) NOT NULL,
    fn_code VARCHAR(100) NOT NULL,
    fn_description VARCHAR(500) NULL,
    fn_type VARCHAR(50) NOT NULL,
    fn_created_at DATETIME2 NOT NULL,
    fn_created_by BIGINT NOT NULL,
    fn_updated_at DATETIME2 NOT NULL,
    fn_updated_by BIGINT NOT NULL,
    fn_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_function PRIMARY KEY (fn_id),
    CONSTRAINT uq_atrox_function_company_code UNIQUE (co_id, fn_code),
    CONSTRAINT fk_atrox_function_company FOREIGN KEY (co_id) REFERENCES ATROX.atrox_company (co_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_function>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_function>>>';
END CATCH;
GO