<#.SYNOPSIS
This PowerShell script configures a Windows 10 system's cryptographic settings by ensuring that the 
registry key for SSL configuration exists under HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002. 
It then sets the EccCurves registry value (of type REG_MULTI_SZ) to contain two values: "NistP384" and "NistP256". 
This setting specifies the allowed elliptic curves for SSL/TLS, which enhances the security of cryptographic operations.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000052).ps1 
#>


# Define the registry path for the SSL configuration.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL" -Name "00010002" -Force | Out-Null
    Write-Host "Created registry key: $regPath" -ForegroundColor Cyan
}

# Set the 'EccCurves' registry value to a multi-string with the values "NistP384" and "NistP256"
New-ItemProperty -Path $regPath -Name "EccCurves" -Value @("NistP384","NistP256") -PropertyType MultiString -Force | Out-Null
Write-Host "Set 'EccCurves' to 'NistP384' and 'NistP256'." -ForegroundColor Green
