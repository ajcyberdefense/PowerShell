<#.SYNOPSIS
  This PowerShell script configures Windows telemetry settings by creating 
the necessary registry key if it doesn't already exist and setting the 
AllowTelemetry value to the desired level (0 for Security, 1 for Basic, or 2 
for Enhanced). The script is set to use Basic telemetry (1) and reminds 
administrators that if Enhanced telemetry is selected, additional configuration 
(per V-220833) is required to limit diagnostic data.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-02-24
    Last Modified   : 2025-02-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 2025-02-24
    Tested By       : 2025-02-24
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-CC-000205).ps1 
#>

# Set desired telemetry level:
# 0 - Security (Enterprise Only)
# 1 - Basic
# 2 - Enhanced (requires additional configuration per V-220833 to limit diagnostic data)
$telemetryLevel = 1

# Define the registry path for telemetry settings.
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\DataCollection"

# Create the DataCollection key if it doesn't exist.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows" -Name "DataCollection" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the AllowTelemetry value to the desired level.
New-ItemProperty -Path $regPath -Name "AllowTelemetry" -Value $telemetryLevel -PropertyType DWord -Force | Out-Null
Write-Host "Set AllowTelemetry to $telemetryLevel."

# If Enhanced telemetry is selected, remind the administrator that additional configuration is required.
if ($telemetryLevel -eq 2) {
    Write-Host "Enhanced telemetry is enabled. Ensure V-220833 is also configured to limit enhanced diagnostic data to the minimum required by Windows Analytics."
}
