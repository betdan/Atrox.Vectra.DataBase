[CmdletBinding()]
param(
    [string]$Subject = "CN=AtroxDbCreds",

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

$cert = New-SelfSignedCertificate `
    -Subject $Subject `
    -Type DocumentEncryptionCert `
    -CertStoreLocation $certStorePath `
    -KeyExportPolicy Exportable `
    -NotAfter $notAfter

$thumbprint = $cert.Thumbprint
$safeThumbprint = $thumbprint.ToUpperInvariant()
$publicPath = Join-Path $OutputDirectory ("AtroxDbCreds_{0}.cer" -f $safeThumbprint)

Export-Certificate -Cert $cert -FilePath $publicPath | Out-Null

$privatePath = $null
if ($ExportPrivateKey) {
    if ($null -eq $PfxPassword) {
        $PfxPassword = Read-Host "PFX password" -AsSecureString
    }

    $privatePath = Join-Path $OutputDirectory ("AtroxDbCreds_{0}.pfx" -f $safeThumbprint)
    Export-PfxCertificate -Cert $cert -FilePath $privatePath -Password $PfxPassword | Out-Null
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
