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
    STIG-ID         : WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 2025-02-24
    Tested By       : 2025-02-24
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-AU-000510).ps1 
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    # Create the "System" subkey under EventLog (and its parent key if necessary)
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog" -Name "System" -Force | Out-Null
    Write-Host "Created key: $regPath"
}

# Set the "MaxSize" property to 0x8000 (32768 in decimal) as a DWORD.
New-ItemProperty -Path $regPath -Name "MaxSize" -Value 0x8000 -PropertyType DWord -Force | Out-Null
Write-Host "Set MaxSize to 0x8000 in $regPath"
