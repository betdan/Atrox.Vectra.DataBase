DROP PROCEDURE IF EXISTS ATROX.proc_atrox_service_create;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_service_create>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_service_create(IN i_se_id BIGINT,IN i_sc_id BIGINT,IN i_se_name VARCHAR(200),IN i_se_code VARCHAR(100),IN i_se_description VARCHAR(500),IN i_se_endpoint VARCHAR(500),IN i_se_http_method VARCHAR(20),IN i_created_by BIGINT,INOUT o_error INT DEFAULT 0,INOUT o_message VARCHAR(500) DEFAULT 'OK') LANGUAGE plpgsql AS $$ BEGIN o_error := 0; o_message := 'OK'; BEGIN INSERT INTO ATROX.atrox_service(se_id,sc_id,se_name,se_code,se_description,se_endpoint,se_http_method,se_current_version_id,se_created_at,se_created_by,se_updated_at,se_updated_by,se_deleted) VALUES(i_se_id,i_sc_id,i_se_name,i_se_code,i_se_description,i_se_endpoint,i_se_http_method,NULL,CURRENT_TIMESTAMP,i_created_by,CURRENT_TIMESTAMP,i_created_by,FALSE);  EXCEPTION WHEN OTHERS THEN o_error := 1; o_message := LEFT(SQLERRM, 500);  END; END; $$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_service_create>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_service_create>>>';
END
$do$;