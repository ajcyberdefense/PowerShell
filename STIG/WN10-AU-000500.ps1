<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-02-13
    Last Modified   : 2025-02-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-AU-000500).ps1 
#>

# Define the registry path for the key
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Check if the key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    # Create the "Application" subkey under EventLog
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog" -Name "Application" -Force | Out-Null
}

# Set the "MaxSize" property to 0x8000 (hexadecimal) as a DWORD value.
New-ItemProperty -Path $regPath -Name "MaxSize" -Value 0x8000 -PropertyType DWord -Force | Out-Null

Write-Host "Registry key updated successfully."
