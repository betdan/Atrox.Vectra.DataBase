param()

Clear-Host
Write-Host "============================================="
Write-Host " ATROX VECTRA DATABASE UNINSTALLER"
Write-Host "============================================="
Write-Host ""

function Read-SecureCredentialFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    if (-not (Test-Path -LiteralPath $FilePath)) {
        throw "Secure credential file not found: $FilePath"
    }

    $envelopeText = Get-Content -LiteralPath $FilePath -Raw
    $envelope = $envelopeText | ConvertFrom-Json

    if ([string]::IsNullOrWhiteSpace([string]$envelope.algorithm) -or [string]::IsNullOrWhiteSpace([string]$envelope.data)) {
        throw "Invalid secure credential file format."
    }

    $payloadText = $null
    if ($envelope.algorithm -eq "DPAPI") {
        $scope = [System.Security.Cryptography.DataProtectionScope]::CurrentUser
        if ($envelope.scope -eq "LocalMachine") {
            $scope = [System.Security.Cryptography.DataProtectionScope]::LocalMachine
        }

        $entropy = [System.Text.Encoding]::UTF8.GetBytes("Atrox.Vectra.DataBase.DbCredentialFile.v1")
        $cipherBytes = [Convert]::FromBase64String([string]$envelope.data)
        $plainBytes = [System.Security.Cryptography.ProtectedData]::Unprotect($cipherBytes, $entropy, $scope)
        $payloadText = [System.Text.Encoding]::UTF8.GetString($plainBytes)
    }
    elseif ($envelope.algorithm -eq "CertificateCMS") {
        $cmsMessage = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String([string]$envelope.data))
        $payloadText = Unprotect-CmsMessage -Content $cmsMessage
    }
    else {
        throw "Unsupported secure credential algorithm: $($envelope.algorithm)"
    }

    $payload = $payloadText | ConvertFrom-Json

    if ([string]::IsNullOrWhiteSpace([string]$payload.username) -or [string]::IsNullOrWhiteSpace([string]$payload.password)) {
        throw "Invalid credential payload. Username or password is missing."
    }

    $expiresUtc = [DateTime]::Parse([string]$payload.expiresUtc, $null, [System.Globalization.DateTimeStyles]::RoundtripKind)
    if ($expiresUtc -le [DateTime]::UtcNow) {
        throw "Secure credential file has expired: $($expiresUtc.ToString('o'))"
    }

    return [PSCustomObject]@{
        DbType     = [string]$payload.dbType
        Username   = [string]$payload.username
        Password   = [string]$payload.password
        ExpiresUtc = $expiresUtc
    }
}

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
    Write-Host "3) Secure Credential File"

    $authOption = Read-Host "Select authentication mode"

    switch ($authOption) {
        "1" { $authMode = "SQL" }
        "2" { $authMode = "Windows" }
        "3" { $authMode = "SecureFile" }
        default {
            Write-Host "Invalid authentication mode." -ForegroundColor Red
            exit 1
        }
    }

    Write-Host "Selected authentication: $authMode" -ForegroundColor Green
    Write-Host ""
}
else {
    Write-Host "Authentication Mode:"
    Write-Host "1) SQL Authentication"
    Write-Host "2) Secure Credential File"

    $authOption = Read-Host "Select authentication mode"

    switch ($authOption) {
        "1" { $authMode = "SQL" }
        "2" { $authMode = "SecureFile" }
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
elseif ($authMode -eq "SecureFile") {
    $credentialFilePath = Read-Host "Secure credential file path (.enc)"
    $secureCredential = Read-SecureCredentialFile -FilePath $credentialFilePath

    if (-not [string]::Equals($secureCredential.DbType, $engine, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Secure credential file DB type '$($secureCredential.DbType)' does not match selected engine '$engine'."
    }

    $user = $secureCredential.Username
    $password = $secureCredential.Password
    Write-Host "Secure credentials loaded. Expires at (UTC): $($secureCredential.ExpiresUtc.ToString('o'))" -ForegroundColor Green
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

        $sqlServerScriptDir = Split-Path -Parent $scriptPath
        Push-Location $sqlServerScriptDir
        try {
            if ($authMode -eq "Windows") {
                sqlcmd -S "$server,$port" -d $database -E -i $scriptPath -b 2>&1 | Tee-Object -FilePath $logFile | Out-Null
            }
            else {
                sqlcmd -S "$server,$port" -d $database -U $user -P $password -i $scriptPath -b 2>&1 | Tee-Object -FilePath $logFile | Out-Null
            }

            if ($LASTEXITCODE -ne 0) {
                throw "SQL Server uninstall failed (exit code $LASTEXITCODE). Check log file: $logFile"
            }
        }
        finally {
            Pop-Location
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

        psql -h $server -p $port -U $user -d $database -v ON_ERROR_STOP=1 -f $scriptPath 2>&1 | Tee-Object -FilePath $logFile | Out-Null

        if ($LASTEXITCODE -ne 0) {
            throw "PostgreSQL uninstall failed (exit code $LASTEXITCODE). Check log file: $logFile"
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

    $_ | Out-File -FilePath $logFile -Append
    exit 1
}
