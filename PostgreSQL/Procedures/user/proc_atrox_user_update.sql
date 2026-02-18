DROP PROCEDURE IF EXISTS ATROX.proc_atrox_user_update;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_user_update>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_user_update(IN i_us_id BIGINT,IN i_co_id BIGINT,IN i_us_username VARCHAR(150),IN i_us_email VARCHAR(255),IN i_us_password_hash VARCHAR(500),IN i_us_is_active BOOLEAN,IN i_updated_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN UPDATE ATROX.atrox_user SET co_id=i_co_id,us_username=i_us_username,us_email=i_us_email,us_password_hash=i_us_password_hash,us_is_active=i_us_is_active,us_updated_at=CURRENT_TIMESTAMP,us_updated_by=i_updated_by WHERE us_id=i_us_id AND us_deleted=FALSE;  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_user_update>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_user_update>>>';
END
$do$;