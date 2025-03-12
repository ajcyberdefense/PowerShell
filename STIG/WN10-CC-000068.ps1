<#.SYNOPSIS
This PowerShell script configures a Windows 10 system's Credentials Delegation policy by 
ensuring that the registry value AllowProtectedCreds is set to 1 (a REG_DWORD) under the 
key HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation. The script checks 
if the required registry key exists and creates it if necessary before applying the 
setting. This configuration enables the use of protected credentials, enhancing the 
security of delegated credentials.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000068

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000068).ps1 
#>

# Define the registry path for the Credentials Delegation policy.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Force | Out-Null
    Write-Host "Created registry key: $regPath" -ForegroundColor Cyan
}

# Set the 'AllowProtectedCreds' registry value to 1 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "AllowProtectedCreds" -Value 1 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'AllowProtectedCreds' to 1." -ForegroundColor Green
