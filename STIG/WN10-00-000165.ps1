<#.SYNOPSIS
This PowerShell script configures the system to disable the legacy SMBv1 protocol by 
setting the registry value "SMB1" under HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters 
to 0. If the key does not exist, the script creates it. Disabling SMBv1 helps mitigate vulnerabilities 
associated with the MD5 algorithm and legacy protocol weaknesses. Note that a system restart is required 
for the change to take effect.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000165

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000165).ps1 
#>

# Define the registry path for the SMB1 configuration under the LanmanServer parameters.
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer" -Name "Parameters" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the "SMB1" registry value to 0 (disabled).
New-ItemProperty -Path $regPath -Name "SMB1" -Value 0 -PropertyType DWord -Force | Out-Null
Write-Host "Configured 'SMB1' registry value to 0. A system restart is required for the change to take effect."
