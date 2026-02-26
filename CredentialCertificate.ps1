[CmdletBinding()]
param(
    [string]$Subject = "CN=AtroxCreds",

    [ValidateRange(1, 10)]
    [int]$YearsValid = 2,

    [ValidateSet("CurrentUser", "LocalMachine")]
    [string]$StoreLocation = "CurrentUser",

    [string]$OutputDirectory = ".\certs",

    [switch]$ExportPrivateKey,

    [SecureString]$PfxPassword
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -Path $OutputDirectory -ItemType Directory -Force | Out-Null
}

$certStorePath = "Cert:\{0}\My" -f $StoreLocation
$notAfter = (Get-Date).AddYears($YearsValid)

try {
    $cert = New-SelfSignedCertificate `
        -Subject $Subject `
        -Type Custom `
        -CertStoreLocation $certStorePath `
        -KeyAlgorithm RSA `
        -KeyLength 2048 `
        -KeySpec KeyExchange `
        -KeyExportPolicy Exportable `
        -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
        -TextExtension @(
            "2.5.29.37={text}1.3.6.1.4.1.311.80.1"
        ) `
        -NotAfter $notAfter
}
catch {
    throw ("Failed to create credential certificate. Error: {0}" -f $_.Exception.Message)
}

$thumbprint = $cert.Thumbprint
$safeThumbprint = $thumbprint.ToUpperInvariant()
$expirationSuffix = $notAfter.ToString("yyyyMMdd")
$publicPath = Join-Path $OutputDirectory ("AtroxCreds_{0}_exp{1}.cer" -f $safeThumbprint, $expirationSuffix)

Export-Certificate -Cert $cert -FilePath $publicPath | Out-Null
if (-not (Test-Path -LiteralPath $publicPath)) {
    throw ("Public certificate export failed. File not found: {0}" -f $publicPath)
}

$privatePath = $null
if ($ExportPrivateKey) {
    if ($null -eq $PfxPassword) {
        $PfxPassword = Read-Host "PFX password" -AsSecureString
    }

    $privatePath = Join-Path $OutputDirectory ("AtroxCreds_{0}_exp{1}.pfx" -f $safeThumbprint, $expirationSuffix)
    try {
        Export-PfxCertificate -Cert $cert -FilePath $privatePath -Password $PfxPassword | Out-Null
    }
    catch {
        throw ("Private key export failed. Verify export policies and permissions. Error: {0}" -f $_.Exception.Message)
    }

    if (-not (Test-Path -LiteralPath $privatePath)) {
        throw ("Private key export failed. File not found: {0}" -f $privatePath)
    }

    $privateFile = Get-Item -LiteralPath $privatePath
    if ($privateFile.Length -le 0) {
        throw ("Private key export failed. Empty file: {0}" -f $privatePath)
    }
}

Write-Host ""
Write-Host "Credential certificate created successfully." -ForegroundColor Green
Write-Host ("  Subject:        {0}" -f $Subject)
Write-Host ("  Thumbprint:     {0}" -f $safeThumbprint)
Write-Host ("  Store Location: {0}" -f $certStorePath)
Write-Host ("  Expires:        {0}" -f $notAfter.ToString("o"))
Write-Host ("  Public (.cer):  {0}" -f $publicPath)
if ($ExportPrivateKey) {
    Write-Host ("  Private (.pfx): {0}" -f $privatePath)
}
Write-Host ""
Write-Host "Use .cer to encrypt credential files and install .pfx on target machines to decrypt."
