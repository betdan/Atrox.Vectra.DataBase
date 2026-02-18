BEGIN TRY
INSERT INTO
    ATROX.atrox_version_status (
        vs_id,
        vs_code,
        vs_name,
        vs_created_at,
        vs_created_by,
        vs_updated_at,
        vs_updated_by,
        vs_deleted
    )
SELECT
    1,
    'DRAFT',
    'Draft',
    SYSUTCDATETIME(),
    0,
    SYSUTCDATETIME(),
    0,
    0
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            ATROX.atrox_version_status
        WHERE
            vs_code = 'DRAFT'
    );



INSERT INTO
    ATROX.atrox_version_status (
        vs_id,
        vs_code,
        vs_name,
        vs_created_at,
        vs_created_by,
        vs_updated_at,
        vs_updated_by,
        vs_deleted
    )
SELECT
    2,
    'ENABLED',
    'Enabled',
    SYSUTCDATETIME(),
    0,
    SYSUTCDATETIME(),
    0,
    0
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            ATROX.atrox_version_status
        WHERE
            vs_code = 'ENABLED'
    );



INSERT INTO
    ATROX.atrox_version_status (
        vs_id,
        vs_code,
        vs_name,
        vs_created_at,
        vs_created_by,
        vs_updated_at,
        vs_updated_by,
        vs_deleted
    )
SELECT
    3,
    'DISABLED',
    'Disabled',
    SYSUTCDATETIME(),
    0,
    SYSUTCDATETIME(),
    0,
    0
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            ATROX.atrox_version_status
        WHERE
            vs_code = 'DISABLED'
    );



INSERT INTO
    ATROX.atrox_version_status (
        vs_id,
        vs_code,
        vs_name,
        vs_created_at,
        vs_created_by,
        vs_updated_at,
        vs_updated_by,
        vs_deleted
    )
SELECT
    4,
    'ARCHIVED',
    'Archived',
    SYSUTCDATETIME(),
    0,
    SYSUTCDATETIME(),
    0,
    0
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            ATROX.atrox_version_status
        WHERE
            vs_code = 'ARCHIVED'
    );
    PRINT '<<<CREATED SEED ATROX.atrox_version_status>>>';
END TRY
BEGIN CATCH
    PRINT '<<<FAILED CREATING SEED ATROX.atrox_version_status>>>';
END CATCH;