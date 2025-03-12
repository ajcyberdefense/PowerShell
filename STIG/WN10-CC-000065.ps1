<#.SYNOPSIS
This PowerShell script configures a Windows 10 system's Wi-Fi network manager settings by 
ensuring that the registry value AutoConnectAllowedOEM is set to 0 (a REG_DWORD) under the 
key HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config. The script checks if the 
necessary registry key exists and creates it if needed, then sets the value to disable 
automatic connections to OEM-approved Wi-Fi networks. This enhances system security by 
preventing unauthorized or unintended Wi-Fi connections.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000065

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000065).ps1 
#>

# Define the registry path for the Wi-Fi Network Manager configuration.
$regPath = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager" -Name "config" -Force | Out-Null
    Write-Host "Created registry key: $regPath" -ForegroundColor Cyan
}

# Set the 'AutoConnectAllowedOEM' registry value to 0 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "AutoConnectAllowedOEM" -Value 0 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'AutoConnectAllowedOEM' to 0." -ForegroundColor Green
