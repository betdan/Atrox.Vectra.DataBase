DROP PROCEDURE IF EXISTS ATROX.proc_atrox_company_update;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_company_update>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_company_update(
    IN i_co_id BIGINT,
    IN i_co_name VARCHAR(200),
    IN i_co_code VARCHAR(100),
    IN i_co_description VARCHAR(500),
    IN i_updated_by BIGINT,
    INOUT o_error INT DEFAULT 0,
    INOUT o_message VARCHAR(500) DEFAULT 'OK'
)
LANGUAGE plpgsql
AS $$
BEGIN
    o_error := 0;
    o_message := 'OK';

    START TRANSACTION;
    BEGIN
        UPDATE ATROX.atrox_company
        SET
            co_name = i_co_name,
            co_code = i_co_code,
            co_description = i_co_description,
            co_updated_at = CURRENT_TIMESTAMP,
            co_updated_by = i_updated_by
        WHERE co_id = i_co_id
          AND co_deleted = FALSE;

        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        o_error := 1;
        o_message := LEFT(SQLERRM, 500);
    END;
END;
$$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_company_update>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_company_update>>>';
END
$do$;