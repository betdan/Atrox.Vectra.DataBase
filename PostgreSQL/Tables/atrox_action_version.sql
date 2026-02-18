DROP TABLE IF EXISTS ATROX.atrox_action_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_action_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_action_version (
    av_id BIGINT NOT NULL,
    ac_id BIGINT NOT NULL,
    av_version_number BIGINT NOT NULL,
    vs_id BIGINT NOT NULL,
    av_content_definition TEXT NULL,
    av_input_definition TEXT NULL,
    av_output_definition TEXT NULL,
    av_created_at TIMESTAMP NOT NULL,
    av_created_by BIGINT NOT NULL,
    av_updated_at TIMESTAMP NOT NULL,
    av_updated_by BIGINT NOT NULL,
    av_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_action_version PRIMARY KEY (av_id),
    CONSTRAINT uq_atrox_action_version UNIQUE (ac_id, av_version_number),
    CONSTRAINT fk_atrox_action_version_action FOREIGN KEY (ac_id) REFERENCES ATROX.atrox_action (ac_id),
    CONSTRAINT fk_atrox_action_version_status FOREIGN KEY (vs_id) REFERENCES ATROX.atrox_version_status (vs_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_action_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_action_version>>>';
END
$do$;