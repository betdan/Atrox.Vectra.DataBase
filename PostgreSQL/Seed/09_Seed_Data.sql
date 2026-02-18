DO $do$
BEGIN
INSERT INTO ATROX.atrox_version_status (
    vs_id, vs_code, vs_name, vs_created_at, vs_created_by, vs_updated_at, vs_updated_by, vs_deleted
)
SELECT 1, 'DRAFT', 'Draft', CURRENT_TIMESTAMP, 0, CURRENT_TIMESTAMP, 0, FALSE
WHERE NOT EXISTS (
    SELECT 1 FROM ATROX.atrox_version_status WHERE vs_code = 'DRAFT'
);

INSERT INTO ATROX.atrox_version_status (
    vs_id, vs_code, vs_name, vs_created_at, vs_created_by, vs_updated_at, vs_updated_by, vs_deleted
)
SELECT 2, 'ENABLED', 'Enabled', CURRENT_TIMESTAMP, 0, CURRENT_TIMESTAMP, 0, FALSE
WHERE NOT EXISTS (
    SELECT 1 FROM ATROX.atrox_version_status WHERE vs_code = 'ENABLED'
);

INSERT INTO ATROX.atrox_version_status (
    vs_id, vs_code, vs_name, vs_created_at, vs_created_by, vs_updated_at, vs_updated_by, vs_deleted
)
SELECT 3, 'DISABLED', 'Disabled', CURRENT_TIMESTAMP, 0, CURRENT_TIMESTAMP, 0, FALSE
WHERE NOT EXISTS (
    SELECT 1 FROM ATROX.atrox_version_status WHERE vs_code = 'DISABLED'
);

INSERT INTO ATROX.atrox_version_status (
    vs_id, vs_code, vs_name, vs_created_at, vs_created_by, vs_updated_at, vs_updated_by, vs_deleted
)
SELECT 4, 'ARCHIVED', 'Archived', CURRENT_TIMESTAMP, 0, CURRENT_TIMESTAMP, 0, FALSE
WHERE NOT EXISTS (
    SELECT 1 FROM ATROX.atrox_version_status WHERE vs_code = 'ARCHIVED'
);

    RAISE NOTICE '<<<CREATED SEED ATROX.atrox_version_status>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING SEED ATROX.atrox_version_status>>>';
END
$do$;