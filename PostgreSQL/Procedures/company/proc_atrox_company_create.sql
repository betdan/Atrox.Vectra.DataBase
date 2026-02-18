DROP PROCEDURE IF EXISTS ATROX.proc_atrox_company_create;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED PROCEDURE ATROX.proc_atrox_company_create>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE PROCEDURE ATROX.proc_atrox_company_create(
    IN i_co_id BIGINT,
    IN i_co_name VARCHAR(200),
    IN i_co_code VARCHAR(100),
    IN i_co_description VARCHAR(500),
    IN i_created_by BIGINT,
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
        INSERT INTO ATROX.atrox_company (
            co_id, co_name, co_code, co_description,
            co_created_at, co_created_by, co_updated_at, co_updated_by, co_deleted
        )
        VALUES (
            i_co_id, i_co_name, i_co_code, i_co_description,
            CURRENT_TIMESTAMP, i_created_by, CURRENT_TIMESTAMP, i_created_by, FALSE
        );

        COMMIT;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        o_error := 1;
        o_message := LEFT(SQLERRM, 500);
    END;
END;
$$;$sql$;
    RAISE NOTICE '<<<CREATED PROCEDURE ATROX.proc_atrox_company_create>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING PROCEDURE ATROX.proc_atrox_company_create>>>';
END
$do$;