<#.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows system event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-02-24
    Last Modified   : 2025-02-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 2025-02-24
    Tested By       : 2025-02-24
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-AU-000505).ps1 
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"

# Check if the key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    # Create the "Security" subkey under EventLog
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog" -Name "Security" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the "MaxSize" property to 0x000fa000 (1024000 in decimal) as a DWORD value.
New-ItemProperty -Path $regPath -Name "MaxSize" -Value 0x000fa000 -PropertyType DWord -Force | Out-Null

Write-Host "Registry value 'MaxSize' updated to 0x000fa000 (1024000) successfully."
