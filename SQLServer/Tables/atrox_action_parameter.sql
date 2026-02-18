IF OBJECT_ID('ATROX.atrox_action_parameter','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_action_parameter;
    PRINT '<<<DROPPED TABLE ATROX.atrox_action_parameter>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_action_parameter (
    pa_id BIGINT NOT NULL,
    ac_id BIGINT NOT NULL,
    pa_name VARCHAR(150) NOT NULL,
    pa_direction VARCHAR(10) NOT NULL,
    pa_data_type VARCHAR(100) NOT NULL,
    pa_is_required BIT NOT NULL,
    pa_default_value VARCHAR(500) NULL,
    pa_order INT NOT NULL,
    pa_created_at DATETIME2 NOT NULL,
    pa_created_by BIGINT NOT NULL,
    pa_updated_at DATETIME2 NOT NULL,
    pa_updated_by BIGINT NOT NULL,
    pa_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_action_parameter PRIMARY KEY (pa_id),
    CONSTRAINT fk_atrox_action_parameter_action FOREIGN KEY (ac_id) REFERENCES ATROX.atrox_action (ac_id)
);
    PRINT '<<<CREATED TABLE ATROX.atrox_action_parameter>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_action_parameter>>>';
END CATCH;
GO