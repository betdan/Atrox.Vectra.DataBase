[CmdletBinding()]
param(
    [ValidateSet("SqlServer", "PostgreSql")]
    [string]$DbType,

    [string]$Username,

    [SecureString]$Password,

    [ValidateRange(1, 3650)]
    [int]$ValidDays = 7,

    [ValidateSet("DPAPI", "CertificateCMS")]
    [string]$EncryptionMode = "DPAPI",

    [ValidateSet("CurrentUser", "LocalMachine")]
    [string]$Scope = "CurrentUser",

    [string]$CertificateThumbprint,

    [string]$CertificatePath,

    [string]$OutputDirectory = "."
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-PlainTextFromSecureString {
    param(
        [Parameter(Mandatory = $true)]
        [SecureString]$SecureValue
    )

    $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureValue)
    try {
        return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
    }
    finally {
        if ($bstr -ne [IntPtr]::Zero) {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
        }
    }
}

function Resolve-CmsRecipient {
    param(
        [string]$Thumbprint,
        [string]$Path
    )

    if (-not [string]::IsNullOrWhiteSpace($Thumbprint)) {
        throw "Certificate thumbprint mode is not supported in file-only mode. Use -CertificatePath with a .cer file."
    }

    if (-not [string]::IsNullOrWhiteSpace($Path)) {
        if (-not (Test-Path -LiteralPath $Path)) {
            throw "Certificate file not found: $Path"
        }
        return $Path
    }

    throw "For CertificateCMS mode, provide -CertificatePath (.cer)."
}

if ([string]::IsNullOrWhiteSpace($DbType)) {
    $DbType = Read-Host "Database type (SqlServer/PostgreSql)"
}

if ([string]::IsNullOrWhiteSpace($Username)) {
    $Username = Read-Host "Database username"
}

if ($null -eq $Password) {
    $Password = Read-Host "Database password" -AsSecureString
}

if ([string]::IsNullOrWhiteSpace($Username)) {
    throw "Username is required."
}

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
}

$createdUtc = [DateTime]::UtcNow
$expiresUtc = $createdUtc.AddDays($ValidDays)
$plainPassword = Get-PlainTextFromSecureString -SecureValue $Password

if ([string]::IsNullOrWhiteSpace($plainPassword)) {
    throw "Password is required."
}

$payload = [ordered]@{
    version     = 1
    dbType      = $DbType
    username    = $Username
    password    = $plainPassword
    createdUtc  = $createdUtc.ToString("o")
    expiresUtc  = $expiresUtc.ToString("o")
    generatedBy = [Environment]::UserName
}

$payloadJson = $payload | ConvertTo-Json -Compress
$envelope = [ordered]@{
    version    = 1
    algorithm  = $EncryptionMode
    dbType     = $DbType
    username   = $Username
    createdUtc = $createdUtc.ToString("o")
    expiresUtc = $expiresUtc.ToString("o")
}

if ($EncryptionMode -eq "DPAPI") {
    $payloadBytes = [System.Text.Encoding]::UTF8.GetBytes($payloadJson)
    $entropy = [System.Text.Encoding]::UTF8.GetBytes("Atrox.Vectra.DataBase.DbCredentialFile.v1")
    $dpapiScope = [System.Security.Cryptography.DataProtectionScope]::$Scope
    $encryptedBytes = [System.Security.Cryptography.ProtectedData]::Protect($payloadBytes, $entropy, $dpapiScope)
    $envelope.scope = $Scope
    $envelope.data = [Convert]::ToBase64String($encryptedBytes)
}
else {
    $recipient = Resolve-CmsRecipient -Thumbprint $CertificateThumbprint -Path $CertificatePath
    $cmsMessage = Protect-CmsMessage -To $recipient -Content $payloadJson
    $envelope.data = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($cmsMessage))

    if (-not [string]::IsNullOrWhiteSpace($CertificatePath)) {
        $envelope.certificatePath = $CertificatePath
    }
}

$normalizedDbType = $DbType.ToUpperInvariant()
$fileName = ".env_{0}_{1}.enc" -f $normalizedDbType, $createdUtc.ToString("yyyyMMddTHHmmssZ")
$outputPath = Join-Path -Path $OutputDirectory -ChildPath $fileName

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($outputPath, ($envelope | ConvertTo-Json -Compress), $utf8NoBom)

Write-Host ""
Write-Host "Encrypted credential file created:" -ForegroundColor Green
Write-Host $outputPath
Write-Host ""
Write-Host "Metadata:"
Write-Host ("  DbType:     {0}" -f $DbType)
Write-Host ("  Username:   {0}" -f $Username)
Write-Host ("  Algorithm:  {0}" -f $EncryptionMode)
if ($EncryptionMode -eq "DPAPI") {
    Write-Host ("  Scope:      {0}" -f $Scope)
}
Write-Host ("  CreatedUtc: {0}" -f $createdUtc.ToString("o"))
Write-Host ("  ExpiresUtc: {0}" -f $expiresUtc.ToString("o"))
Write-Host ""
Write-Host "Keep the encrypted file secure and separate from private keys."
