# CredentialCertificate.ps1

This document describes how to use `CredentialCertificate.ps1` to create encryption certificates for secure DB credential files.

## Purpose

- Create a certificate for credential encryption/decryption.
- Export public key (`.cer`) to encrypt files.
- Optionally export private key (`.pfx`) to decrypt files on another machine.

## Parameters

- `-Subject`  
  Certificate subject name.  
  Default: `CN=AtroxCreds`.

- `-DaysValid`  
  Certificate validity in days.  
  Range: `1..3650`. Default: `365`.

- `-StoreLocation`  
  Backward-compatibility parameter.  
  In current file-only mode, certificate is not written to Windows store.
  Values kept: `CurrentUser`, `LocalMachine`. Default: `CurrentUser`.

- `-OutputDirectory`  
  Output folder for exported files (`.cer` and optionally `.pfx`).  
  Default: `.\certs`.

- `-ExportPrivateKey`  
  Switch. If present, exports private key as `.pfx`.

- `-PfxPassword`  
  `SecureString` password for `.pfx`.  
  If omitted and `-ExportPrivateKey` is used, script prompts interactively.

## Outputs

- Always:
  - Public certificate `.cer`
- Optional (`-ExportPrivateKey`):
  - Private certificate `.pfx` (password-protected)

## Usage Examples

## Basic (public certificate only)

```powershell
.\CredentialCertificate.ps1
```

## Export public and private keys

```powershell
.\CredentialCertificate.ps1 -ExportPrivateKey
```

## Export private key with provided password

```powershell
$pwd = Read-Host "PFX password" -AsSecureString
.\CredentialCertificate.ps1 -ExportPrivateKey -PfxPassword $pwd
```

## Full custom example

```powershell
.\CredentialCertificate.ps1 `
  -Subject "CN=AtroxCreds" `
  -DaysValid 365 `
  -StoreLocation CurrentUser `
  -OutputDirectory .\certs `
  -ExportPrivateKey
```

## Integration with DbCredentialFile.ps1

Use generated `.cer` to encrypt credentials in `CertificateCMS` mode:

```powershell
.\DbCredentialFile.ps1 `
  -DbType SqlServer `
  -Username sa `
  -ValidDays 30 `
  -EncryptionMode CertificateCMS `
  -CertificatePath .\certs\AtroxCreds_<THUMBPRINT>_expYYYYMMDD.cer
```

Install/Uninstall then uses `Secure Credential File` mode and decrypts with physical `.pfx` + password (no certificate store required).

## Security Notes

- Keep `.pfx` in a secure location and protect with a strong password.
- Never commit `.pfx` or plaintext credentials to source control.
- Share `.cer` freely for encryption; keep private key restricted.
