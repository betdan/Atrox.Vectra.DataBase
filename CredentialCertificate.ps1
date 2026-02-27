[CmdletBinding()]
param(
    [string]$Subject = "CN=AtroxCreds",

    [ValidateRange(1, 3650)]
    [int]$DaysValid = 365,

    # Kept for backward compatibility with previous script calls.
    [ValidateSet("CurrentUser", "LocalMachine")]
    [string]$StoreLocation = "CurrentUser",

    [string]$OutputDirectory = ".\certs",

    [switch]$ExportPrivateKey,

    [SecureString]$PfxPassword
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

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    if (-not [System.IO.Path]::IsPathRooted($OutputDirectory)) {
        $OutputDirectory = Join-Path $PSScriptRoot $OutputDirectory
    }
    New-Item -Path $OutputDirectory -ItemType Directory -Force | Out-Null
}
else {
    if (-not [System.IO.Path]::IsPathRooted($OutputDirectory)) {
        $OutputDirectory = Join-Path $PSScriptRoot $OutputDirectory
    }
}

$notBefore = (Get-Date).AddMinutes(-5)
$notAfter = (Get-Date).AddDays($DaysValid)
$cert = $null
$rsa = $null

try {
    $rsa = [System.Security.Cryptography.RSA]::Create(2048)
    $request = [System.Security.Cryptography.X509Certificates.CertificateRequest]::new(
        $Subject,
        $rsa,
        [System.Security.Cryptography.HashAlgorithmName]::SHA256,
        [System.Security.Cryptography.RSASignaturePadding]::Pkcs1
    )

    $request.CertificateExtensions.Add(
        [System.Security.Cryptography.X509Certificates.X509BasicConstraintsExtension]::new($false, $false, 0, $true)
    )
    $request.CertificateExtensions.Add(
        [System.Security.Cryptography.X509Certificates.X509KeyUsageExtension]::new(
            [System.Security.Cryptography.X509Certificates.X509KeyUsageFlags]::KeyEncipherment,
            $true
        )
    )

    $ekuOids = [System.Security.Cryptography.OidCollection]::new()
    [void]$ekuOids.Add([System.Security.Cryptography.Oid]::new("1.3.6.1.4.1.311.80.1"))
    $request.CertificateExtensions.Add(
        [System.Security.Cryptography.X509Certificates.X509EnhancedKeyUsageExtension]::new($ekuOids, $false)
    )

    $cert = $request.CreateSelfSigned($notBefore, $notAfter)
}
catch {
    throw ("Failed to create credential certificate. Error: {0}" -f $_.Exception.Message)
}

$thumbprint = $cert.Thumbprint
$safeThumbprint = $thumbprint.ToUpperInvariant()
$expirationSuffix = $notAfter.ToString("yyyyMMdd")
$publicPath = Join-Path $OutputDirectory ("AtroxCreds_{0}_exp{1}.cer" -f $safeThumbprint, $expirationSuffix)

try {
    $cerBytes = $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
    [System.IO.File]::WriteAllBytes($publicPath, $cerBytes)
}
catch {
    throw ("Public certificate export failed. Error: {0}" -f $_.Exception.Message)
}

$privatePath = $null
if ($ExportPrivateKey) {
    if ($null -eq $PfxPassword) {
        $PfxPassword = Read-Host "PFX password" -AsSecureString
    }

    $privatePath = Join-Path $OutputDirectory ("AtroxCreds_{0}_exp{1}.pfx" -f $safeThumbprint, $expirationSuffix)
    try {
        $plainPfxPassword = Get-PlainTextFromSecureString -SecureValue $PfxPassword
        $pfxBytes = $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx, $plainPfxPassword)
        [System.IO.File]::WriteAllBytes($privatePath, $pfxBytes)
    }
    catch {
        throw ("Private key export failed. Error: {0}" -f $_.Exception.Message)
    }

    if (-not (Test-Path -LiteralPath $privatePath)) {
        throw ("Private key export failed. File not found: {0}" -f $privatePath)
    }

    $privateFile = Get-Item -LiteralPath $privatePath
    if ($privateFile.Length -le 0) {
        throw ("Private key export failed. Empty file: {0}" -f $privatePath)
    }
}

if ($null -ne $cert) {
    $cert.Dispose()
}
if ($null -ne $rsa) {
    $rsa.Dispose()
}

Write-Host ""
Write-Host "Credential certificate created successfully." -ForegroundColor Green
Write-Host ("  Subject:        {0}" -f $Subject)
Write-Host ("  Thumbprint:     {0}" -f $safeThumbprint)
Write-Host ("  Store Location: {0} (not used in file-only mode)" -f $StoreLocation)
Write-Host ("  Expires:        {0}" -f $notAfter.ToString("o"))
Write-Host ("  Public (.cer):  {0}" -f $publicPath)
if ($ExportPrivateKey) {
    Write-Host ("  Private (.pfx): {0}" -f $privatePath)
}
Write-Host ""
Write-Host "Use .cer to encrypt credential files and install .pfx on target machines to decrypt."
