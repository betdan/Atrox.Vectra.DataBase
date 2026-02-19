param()

Clear-Host
Write-Host "============================================="
Write-Host " ATROX VECTRA DATABASE INSTALLER"
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
    Write-Host "The Database can't be empty. Installation cancelled." -ForegroundColor Red
    exit 0
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
Write-Host "You are about to install ATROX VECTRA schema into:"
Write-Host "Server   : $server"
Write-Host "Port     : $port"
Write-Host "Database : $database"
Write-Host ""

$confirm = Read-Host "Continue? (Y/N)"
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Installation cancelled."
    exit 0
}

# -------------------------------------------------
# LOG FILE
# -------------------------------------------------

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logFile = Join-Path $PSScriptRoot "install_log_$timestamp.txt"

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

        # Validate ATROX schema does not exist
        Write-Host "Validating ATROX schema does not exist..." -ForegroundColor Blue

        $query = "SELECT COUNT(*) FROM sys.schemas WHERE name = 'ATROX'"
        $command = $connection.CreateCommand()
        $command.CommandText = $query
        $schemaCount = $command.ExecuteScalar()

        if ($schemaCount -gt 0) {
            throw "Schema ATROX already exists. Installation aborted."
        }

        Write-Host "Schema ATROX not found." -ForegroundColor Green
        $connection.Close()

        $scriptPath = ".\SQLServer\00_Run_All.sql"

        if (!(Test-Path $scriptPath)) {
            throw "SQL file not found: $scriptPath"
        }

        if ($authMode -eq "Windows") {
            sqlcmd -S "$server,$port" -d $database -E -i $scriptPath -b -o $logFile
        }
        else {
            sqlcmd -S "$server,$port" -d $database -U $user -P $password -i $scriptPath -b -o $logFile
        }
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
        Write-Host "Validating ATROX schema does not exist..." -ForegroundColor Blue

        $schemaCountOutput = psql -h $server -p $port -U $user -d $database -q -t -A -c "SELECT COUNT(*) FROM information_schema.schemata WHERE schema_name = 'atrox';" | Out-String
        $schemaCountLines  = @($schemaCountOutput -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

        if ($schemaCountLines.Count -ne 1) {
            throw "Unable to determine schema state."
        }

        $schemaCountText = ([string]$schemaCountLines[0]).Trim()
        [int]$schemaCount = 0

        if (-not [int]::TryParse($schemaCountText, [ref]$schemaCount)) {
            throw "Unable to determine schema state."
        }

        if ($schemaCount -gt 0) {
            throw "Schema ATROX already exists. Installation aborted."
        }

        Write-Host "Schema ATROX not found." -ForegroundColor Green

        $scriptPath = Join-Path $PSScriptRoot "PostgreSQL\00_Run_All.sql"

        if (!(Test-Path $scriptPath)) {
            throw "SQL file not found: $scriptPath"
        }

        $postgresScriptDir = Split-Path -Parent $scriptPath
        Push-Location $postgresScriptDir
        try {
            $deployOutputLines = psql -h $server -p $port -U $user -d $database -v ON_ERROR_STOP=1 -f $scriptPath 2>&1 | Tee-Object -FilePath $logFile
            $deployOutputText = ($deployOutputLines | Out-String)

            if ($LASTEXITCODE -ne 0 -or $deployOutputText -match "<<<FAILED") {
                throw "Execution failed. Check log file."
            }
        }
        finally {
            Pop-Location
        }
    }

    if ($LASTEXITCODE -ne 0) {
        throw "Execution failed. Check log file."
    }

    # -------------------------------------------------
    # SUCCESS
    # -------------------------------------------------

    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Green
    Write-Host " INSTALLATION SUCCESSFUL" -ForegroundColor Green
    Write-Host " Log file: $logFile" -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Green

    exit 0
}
catch {

    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Red
    Write-Host " INSTALLATION FAILED" -ForegroundColor Red
    Write-Host " Check log file: $logFile" -ForegroundColor Red
    Write-Host "=============================================" -ForegroundColor Red

    $_ | Out-File $logFile
    exit 1
}
