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
$logFile = Join-Path $PSScriptRoot "uninstall_log_$timestamp.txt"

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

        $scriptPath = Join-Path $PSScriptRoot "SQLServer\99_Uninstall.sql"
        if (!(Test-Path $scriptPath)) {
            throw "SQL file not found: $scriptPath"
        }

        if ($authMode -eq "Windows") {
            sqlcmd -S "$server,$port" -d $database -E -i $scriptPath -b 2>&1 | Tee-Object -FilePath $logFile | Out-Host
        }
        else {
            sqlcmd -S "$server,$port" -d $database -U $user -P $password -i $scriptPath -b 2>&1 | Tee-Object -FilePath $logFile | Out-Host
        }

        if ($LASTEXITCODE -ne 0) {
            throw "Execution failed. Check log file."
        }

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

        $scriptPath = Join-Path $PSScriptRoot "PostgreSQL\99_Uninstall.sql"
        if (!(Test-Path $scriptPath)) {
            throw "SQL file not found: $scriptPath"
        }

        psql -h $server -p $port -U $user -d $database -v ON_ERROR_STOP=1 -f $scriptPath 2>&1 | Tee-Object -FilePath $logFile | Out-Host

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
