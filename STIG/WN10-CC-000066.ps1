<#.SYNOPSIS
This PowerShell script configures the system's audit settings by ensuring that the registry 
value ProcessCreationIncludeCmdLine_Enabled is set to 1 under the key 
HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit. Setting this value 
to 1 enables the inclusion of command line details in process creation audit events, which 
enhances the ability to analyze and troubleshoot security incidents. The script checks for 
the existence of the registry key and creates it if necessary before applying the setting.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000066

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000066).ps1 
#>

# Define the registry path for the audit settings.
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "Audit" -Force | Out-Null
    Write-Host "Created registry key: $regPath" -ForegroundColor Cyan
}

# Set the 'ProcessCreationIncludeCmdLine_Enabled' registry value to 1 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'ProcessCreationIncludeCmdLine_Enabled' to 1." -ForegroundColor Green
