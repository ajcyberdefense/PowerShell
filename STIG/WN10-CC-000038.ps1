<#.SYNOPSIS
This PowerShell script configures a Windows 10 system to enhance credential security by 
setting the Wdigest authentication parameter UseLogonCredential to 0. This registry setting 
prevents storing logon credentials in plain text in memory, thereby reducing the risk of 
credential exposure. The script first checks if the required registry key exists under 
HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\Wdigest and creates it if necessary, 
then sets the UseLogonCredential value to 0.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000038

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000038).ps1 
#>

# Define the registry path for the Wdigest settings.
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\Wdigest"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders" -Name "Wdigest" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the 'UseLogonCredential' registry value to 0 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "UseLogonCredential" -Value 0 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'UseLogonCredential' to 0."
