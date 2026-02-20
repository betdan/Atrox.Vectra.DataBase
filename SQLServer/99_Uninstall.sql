DECLARE @schema SYSNAME = 'ATROX';

BEGIN TRY
    IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = @schema)
    BEGIN
        DECLARE @sql NVARCHAR(MAX) = N'';

        -- Drop foreign keys that belong to or reference tables in target schema
        SELECT @sql += N'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(fk.parent_object_id)) + N'.' + QUOTENAME(OBJECT_NAME(fk.parent_object_id)) +
                       N' DROP CONSTRAINT ' + QUOTENAME(fk.name) + N';' + CHAR(10)
        FROM sys.foreign_keys fk
        WHERE OBJECT_SCHEMA_NAME(fk.parent_object_id) = @schema
           OR OBJECT_SCHEMA_NAME(fk.referenced_object_id) = @schema;

        -- Drop procedures
        SELECT @sql += N'DROP PROCEDURE ' + QUOTENAME(SCHEMA_NAME(o.schema_id)) + N'.' + QUOTENAME(o.name) + N';' + CHAR(10)
        FROM sys.objects o
        WHERE o.schema_id = SCHEMA_ID(@schema)
          AND o.type IN ('P', 'PC');

        -- Drop functions
        SELECT @sql += N'DROP FUNCTION ' + QUOTENAME(SCHEMA_NAME(o.schema_id)) + N'.' + QUOTENAME(o.name) + N';' + CHAR(10)
        FROM sys.objects o
        WHERE o.schema_id = SCHEMA_ID(@schema)
          AND o.type IN ('FN', 'IF', 'TF', 'FS', 'FT');

        -- Drop views
        SELECT @sql += N'DROP VIEW ' + QUOTENAME(SCHEMA_NAME(o.schema_id)) + N'.' + QUOTENAME(o.name) + N';' + CHAR(10)
        FROM sys.objects o
        WHERE o.schema_id = SCHEMA_ID(@schema)
          AND o.type = 'V';

        -- Drop synonyms
        SELECT @sql += N'DROP SYNONYM ' + QUOTENAME(SCHEMA_NAME(sn.schema_id)) + N'.' + QUOTENAME(sn.name) + N';' + CHAR(10)
        FROM sys.synonyms sn
        WHERE sn.schema_id = SCHEMA_ID(@schema);

        -- Drop tables
        SELECT @sql += N'DROP TABLE ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) + N'.' + QUOTENAME(t.name) + N';' + CHAR(10)
        FROM sys.tables t
        WHERE t.schema_id = SCHEMA_ID(@schema);

        -- Drop sequences
        SELECT @sql += N'DROP SEQUENCE ' + QUOTENAME(SCHEMA_NAME(s.schema_id)) + N'.' + QUOTENAME(s.name) + N';' + CHAR(10)
        FROM sys.sequences s
        WHERE s.schema_id = SCHEMA_ID(@schema);

        -- Drop user-defined types
        SELECT @sql += N'DROP TYPE ' + QUOTENAME(SCHEMA_NAME(ty.schema_id)) + N'.' + QUOTENAME(ty.name) + N';' + CHAR(10)
        FROM sys.types ty
        WHERE ty.schema_id = SCHEMA_ID(@schema)
          AND ty.is_user_defined = 1;

        IF LEN(@sql) > 0
        BEGIN
            EXEC sp_executesql @sql;
        END

        DECLARE @dropSchemaSql NVARCHAR(MAX) = N'DROP SCHEMA ' + QUOTENAME(@schema) + N';';
        EXEC sp_executesql @dropSchemaSql;
        PRINT '<<<ATROX UNINSTALL COMPLETED>>>';
    END
    ELSE
    BEGIN
        PRINT '<<<ATROX SCHEMA NOT FOUND>>>';
    END
END TRY
BEGIN CATCH
    DECLARE @err NVARCHAR(4000) = ERROR_MESSAGE();
    PRINT '<<<ATROX UNINSTALL FAILED: ' + @err + '>>>';
    THROW;
END CATCH
