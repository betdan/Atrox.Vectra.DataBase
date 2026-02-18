DROP FUNCTION IF EXISTS ATROX.fn_atrox_next_action_version;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED FUNCTION ATROX.fn_atrox_next_action_version>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE OR REPLACE FUNCTION ATROX.fn_atrox_next_action_version(p_ac_id BIGINT)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
DECLARE
    v_next_version BIGINT;
BEGIN
    SELECT COALESCE(MAX(av_version_number), 0) + 1
      INTO v_next_version
      FROM ATROX.atrox_action_version
     WHERE ac_id = p_ac_id;

    RETURN v_next_version;
END;
$$;$sql$;
    RAISE NOTICE '<<<CREATED FUNCTION ATROX.fn_atrox_next_action_version>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING FUNCTION ATROX.fn_atrox_next_action_version>>>';
END
$do$;