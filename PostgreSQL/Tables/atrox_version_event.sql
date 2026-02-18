DROP TABLE IF EXISTS ATROX.atrox_version_event;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_version_event>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE IF NOT EXISTS ATROX.atrox_version_event (
    ve_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ve_entity_type VARCHAR(20) NOT NULL,
    ve_entity_id BIGINT NOT NULL,
    ve_previous_version_id BIGINT NULL,
    ve_new_version_id BIGINT NOT NULL,
    ve_event_type VARCHAR(20) NOT NULL,
    ve_executed_by BIGINT NOT NULL,
    ve_executed_at TIMESTAMP NOT NULL DEFAULT timezone('utc', now()),
    CONSTRAINT ck_atrox_version_event_entity_type CHECK (ve_entity_type IN ('SCREEN', 'SERVICE', 'ACTION')),
    CONSTRAINT ck_atrox_version_event_event_type CHECK (ve_event_type IN ('ENABLE', 'ROLLBACK'))
);

CREATE INDEX IF NOT EXISTS ix_atrox_version_event_entity
    ON ATROX.atrox_version_event (ve_entity_type, ve_entity_id, ve_executed_at);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_version_event>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_version_event>>>';
END
$do$;