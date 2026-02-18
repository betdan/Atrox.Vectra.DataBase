IF OBJECT_ID('ATROX.atrox_screen_function','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_screen_function;
    PRINT '<<<DROPPED TABLE ATROX.atrox_screen_function>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_screen_function (
    sf_id BIGINT NOT NULL,
    sc_id BIGINT NOT NULL,
    fn_id BIGINT NOT NULL,
    sf_sequence INT NOT NULL,
    sf_created_at DATETIME2 NOT NULL,
    sf_created_by BIGINT NOT NULL,
    sf_updated_at DATETIME2 NOT NULL,
    sf_updated_by BIGINT NOT NULL,
    sf_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_screen_function PRIMARY KEY (sf_id),
    CONSTRAINT uq_atrox_screen_function UNIQUE (sc_id, fn_id),
    CONSTRAINT fk_atrox_screen_function_screen FOREIGN KEY (sc_id) REFERENCES ATROX.atrox_screen (sc_id),
    CONSTRAINT fk_atrox_screen_function_function FOREIGN KEY (fn_id) REFERENCES ATROX.atrox_function (fn_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_screen_function>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_screen_function>>>';
END CATCH;
GO