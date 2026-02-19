param()

Clear-Host
Write-Host "============================================="
Write-Host " ATROX VECTRA DATABASE UNINSTALLER"
Write-Host "============================================="
Write-Host ""

# -------------------------------------------------
# ENGINE SELECTION
# -------------------------------------------------

Write-Host "Select Database Engine:"
Write-Host "1) SQL Server"
Write-Host "2) PostgreSQL"

$option = Read-Host "Enter option number"

switch ($option) {
    "1" { $engine = "SQLServer" }
    "2" { $engine = "PostgreSQL" }
    default {
        Write-Host "Invalid selection. Please select 1 or 2." -ForegroundColor Red
        exit 1
    }
}

Write-Host "Selected engine: $engine" -ForegroundColor Green
Write-Host ""

# -------------------------------------------------
# AUTHENTICATION (SQL SERVER ONLY)
# -------------------------------------------------

if ($engine -eq "SQLServer") {

    Write-Host "Authentication Mode:"
    Write-Host "1) SQL Authentication"
    Write-Host "2) Windows Authentication"

    $authOption = Read-Host "Select authentication mode"

    switch ($authOption) {
        "1" { $authMode = "SQL" }
        "2" { $authMode = "Windows" }
        default {
            Write-Host "Invalid authentication mode." -ForegroundColor Red
            exit 1
        }
    }

    Write-Host "Selected authentication: $authMode" -ForegroundColor Green
    Write-Host ""
}

# -------------------------------------------------
# CONNECTION DATA
# -------------------------------------------------

$server   = Read-Host "Server"
$port     = Read-Host "Port (Enter for default)"

if ([string]::IsNullOrWhiteSpace($port)) {
    if ($engine -eq "SQLServer")  { $port = "1433" }
    if ($engine -eq "PostgreSQL") { $port = "5432" }
    Write-Host "Using default port: $port" -ForegroundColor Green
}

$database = Read-Host "Database Name"

if ([string]::IsNullOrWhiteSpace($database)) {
    Write-Host "The Database can't be empty. Uninstall cancelled." -ForegroundColor Red
    exit 1
}

if ($engine -eq "SQLServer" -and $authMode -eq "Windows") {
    $user = $null
    $password = $null
}
else {
    $user = Read-Host "User"
    $securePassword = Read-Host "Password" -AsSecureString
    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)
    )
}

# -------------------------------------------------
# CONFIRMATION
# -------------------------------------------------

Write-Host ""
Write-Host "You are about to REMOVE ATROX objects from:"
Write-Host "Server   : $server"
Write-Host "Port     : $port"
Write-Host "Database : $database"
Write-Host ""
Write-Host "This operation cannot be undone." -ForegroundColor Yellow

$confirm = Read-Host "Continue? (Y/N)"
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Uninstall cancelled."
    exit 0
}

# -------------------------------------------------
# LOG FILE
# -------------------------------------------------

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logFile = "uninstall_log_$timestamp.txt"

Write-Host ""
Write-Host "Validating connection..." -ForegroundColor Blue

try {

    # =================================================
    # SQL SERVER
    # =================================================
    if ($engine -eq "SQLServer") {

        if ($authMode -eq "Windows") {
            $connectionString = "Server=$server,$port;Database=$database;Integrated Security=True;TrustServerCertificate=True;"
        }
        else {
            $connectionString = "Server=$server,$port;Database=$database;User Id=$user;Password=$password;TrustServerCertificate=True;"
        }

        $connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
        $connection.Open()
        Write-Host "Connection successful." -ForegroundColor Green

        Write-Host "Removing ATROX objects..." -ForegroundColor Blue

        $dropSql = @"
DECLARE @schema SYSNAME = 'ATROX';

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

    -- Drop tables
    SELECT @sql += N'DROP TABLE ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) + N'.' + QUOTENAME(t.name) + N';' + CHAR(10)
    FROM sys.tables t
    WHERE t.schema_id = SCHEMA_ID(@schema);

    -- Drop sequences
    SELECT @sql += N'DROP SEQUENCE ' + QUOTENAME(SCHEMA_NAME(s.schema_id)) + N'.' + QUOTENAME(s.name) + N';' + CHAR(10)
    FROM sys.sequences s
    WHERE s.schema_id = SCHEMA_ID(@schema);

    EXEC sp_executesql @sql;

    EXEC(N'DROP SCHEMA ' + QUOTENAME(@schema) + N';');
END
"@;

        $command = $connection.CreateCommand()
        $command.CommandText = $dropSql
        $command.CommandTimeout = 0
        [void]$command.ExecuteNonQuery()

        $connection.Close()
        Write-Host "ATROX objects removed successfully." -ForegroundColor Green
    }

    # =================================================
    # POSTGRESQL
    # =================================================
    if ($engine -eq "PostgreSQL") {

        $env:PGPASSWORD = $password

        psql -h $server -p $port -U $user -d $database -c "\q"

        if ($LASTEXITCODE -ne 0) {
            throw "Connection failed."
        }

        Write-Host "Connection successful." -ForegroundColor Green
        Write-Host "Removing ATROX objects..." -ForegroundColor Blue

        $dropOutput = psql -h $server -p $port -U $user -d $database -v ON_ERROR_STOP=1 -c "DROP SCHEMA IF EXISTS atrox CASCADE;" 2>&1 | Tee-Object -FilePath $logFile

        if ($LASTEXITCODE -ne 0) {
            throw "Execution failed. Check log file."
        }

        Write-Host "ATROX schema removed successfully." -ForegroundColor Green
    }

    # -------------------------------------------------
    # SUCCESS
    # -------------------------------------------------

    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Green
    Write-Host " UNINSTALL SUCCESSFUL" -ForegroundColor Green
    Write-Host " Log file: $logFile" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    exit 0
}
catch {

    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Red
    Write-Host " UNINSTALL FAILED" -ForegroundColor Red
    Write-Host " Check log file: $logFile" -ForegroundColor Red
    Write-Host "=============================================" -ForegroundColor Red

    $_ | Out-File $logFile
    exit 1
}