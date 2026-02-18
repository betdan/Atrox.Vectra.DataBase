DROP TABLE IF EXISTS ATROX.atrox_screen;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_screen>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_screen (
    sc_id BIGINT NOT NULL,
    ap_id BIGINT NOT NULL,
    sc_name VARCHAR(200) NOT NULL,
    sc_code VARCHAR(100) NOT NULL,
    sc_description VARCHAR(500) NULL,
    sc_current_version_id BIGINT NULL,
    sc_created_at TIMESTAMP NOT NULL,
    sc_created_by BIGINT NOT NULL,
    sc_updated_at TIMESTAMP NOT NULL,
    sc_updated_by BIGINT NOT NULL,
    sc_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_screen PRIMARY KEY (sc_id),
    CONSTRAINT uq_atrox_screen_app_code UNIQUE (ap_id, sc_code),
    CONSTRAINT fk_atrox_screen_application FOREIGN KEY (ap_id) REFERENCES ATROX.atrox_application (ap_id)
);


ALTER TABLE ATROX.atrox_screen
ADD CONSTRAINT fk_atrox_screen_current_version
FOREIGN KEY (sc_current_version_id) REFERENCES ATROX.atrox_screen_version (sv_id);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_screen>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_screen>>>';
END
$do$;