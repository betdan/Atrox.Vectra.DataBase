IF OBJECT_ID('ATROX.atrox_menu','U') IS NOT NULL
BEGIN
    DROP TABLE ATROX.atrox_menu;
    PRINT '<<<DROPPED TABLE ATROX.atrox_menu>>>';
END;
GO

BEGIN TRY
CREATE TABLE ATROX.atrox_menu (
    mn_id BIGINT NOT NULL,
    ap_id BIGINT NOT NULL,
    mn_parent_id BIGINT NULL,
    mn_name VARCHAR(200) NOT NULL,
    mn_code VARCHAR(100) NOT NULL,
    mn_order INT NOT NULL,
    mn_path VARCHAR(300) NULL,
    mn_icon VARCHAR(100) NULL,
    mn_screen_id BIGINT NULL,
    mn_main_function_id BIGINT NOT NULL,
    mn_created_at DATETIME2 NOT NULL,
    mn_created_by BIGINT NOT NULL,
    mn_updated_at DATETIME2 NOT NULL,
    mn_updated_by BIGINT NOT NULL,
    mn_deleted BIT NOT NULL,
    CONSTRAINT pk_atrox_menu PRIMARY KEY (mn_id),
    CONSTRAINT uq_atrox_menu_app_code UNIQUE (ap_id, mn_code),
    CONSTRAINT fk_atrox_menu_application FOREIGN KEY (ap_id) REFERENCES ATROX.atrox_application (ap_id),
    CONSTRAINT fk_atrox_menu_parent FOREIGN KEY (mn_parent_id) REFERENCES ATROX.atrox_menu (mn_id),
    CONSTRAINT fk_atrox_menu_main_function FOREIGN KEY (mn_main_function_id) REFERENCES ATROX.atrox_function (fn_id)
);


ALTER TABLE ATROX.atrox_menu
ADD CONSTRAINT fk_atrox_menu_screen FOREIGN KEY (mn_screen_id) REFERENCES ATROX.atrox_screen (sc_id);
    PRINT '<<<CREATED TABLE ATROX.atrox_menu>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING TABLE ATROX.atrox_menu>>>';
END CATCH;
GO