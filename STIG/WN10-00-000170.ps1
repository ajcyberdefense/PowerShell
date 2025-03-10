<#.SYNOPSIS
This PowerShell script disables the SMBv1 client driver by setting the registry 
value "Start" to 4 under the key HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10. 
If the registry key does not exist, the script creates it. Disabling the SMBv1 client 
driver mitigates vulnerabilities associated with the legacy SMBv1 protocol, and a 
system restart is required for the change to take effect.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000170

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000170).ps1 
#>

# Define the registry path for the SMBv1 client driver (mrxsmb10).
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services" -Name "mrxsmb10" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the "Start" registry value to 4 (disabling the SMBv1 client driver).
New-ItemProperty -Path $regPath -Name "Start" -Value 4 -PropertyType DWord -Force | Out-Null
Write-Host "Configured 'Start' registry value to 4. The SMBv1 client driver (MrxSmb10) is disabled."
Write-Host "A system restart is required for the changes to take effect."
