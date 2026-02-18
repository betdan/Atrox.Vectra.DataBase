IF OBJECT_ID('ATROX.atrox_role_function','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_role_function;
    PRINT '<<<DROPPED TABLE ATROX.atrox_role_function>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_role_function (
    rf_id BIGINT NOT NULL,
    ro_id BIGINT NOT NULL,
    fn_id BIGINT NOT NULL,
    rf_created_at DATETIME2 NOT NULL,
    rf_created_by BIGINT NOT NULL,
    rf_updated_at DATETIME2 NOT NULL,
    rf_updated_by BIGINT NOT NULL,
    rf_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_role_function PRIMARY KEY (rf_id),
    CONSTRAINT uq_atrox_role_function UNIQUE (ro_id, fn_id),
    CONSTRAINT fk_atrox_role_function_role FOREIGN KEY (ro_id) REFERENCES ATROX.atrox_role (ro_id),
    CONSTRAINT fk_atrox_role_function_function FOREIGN KEY (fn_id) REFERENCES ATROX.atrox_function (fn_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_role_function>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_role_function>>>';
END CATCH;
GO