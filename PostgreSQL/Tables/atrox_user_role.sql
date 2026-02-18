DROP TABLE IF EXISTS ATROX.atrox_user_role;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_user_role>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_user_role (
    ur_id BIGINT NOT NULL,
    us_id BIGINT NOT NULL,
    ro_id BIGINT NOT NULL,
    ur_created_at TIMESTAMP NOT NULL,
    ur_created_by BIGINT NOT NULL,
    ur_updated_at TIMESTAMP NOT NULL,
    ur_updated_by BIGINT NOT NULL,
    ur_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_user_role PRIMARY KEY (ur_id),
    CONSTRAINT uq_atrox_user_role UNIQUE (us_id, ro_id),
    CONSTRAINT fk_atrox_user_role_user FOREIGN KEY (us_id) REFERENCES ATROX.atrox_user (us_id),
    CONSTRAINT fk_atrox_user_role_role FOREIGN KEY (ro_id) REFERENCES ATROX.atrox_role (ro_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_user_role>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_user_role>>>';
END
$do$;