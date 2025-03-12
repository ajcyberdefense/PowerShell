<#.SYNOPSIS
This PowerShell script configures a Windows 10 system to prevent the automatic release 
of NetBIOS names on demand. It does this by ensuring that the registry value NoNameReleaseOnDemand 
under the key HKLM:\SYSTEM\CurrentControlSet\Services\Netbt\Parameters is set to 1 (a REG_DWORD). 
The script first checks for the existence of the required registry key and creates it if necessary, 
then sets the specified value to enforce the desired configuration.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000045

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000045).ps1 
#>


# Define the registry path for the NetBT parameters.
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Netbt\Parameters"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netbt" -Name "Parameters" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the 'NoNameReleaseOnDemand' registry value to 1 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "NoNameReleaseOnDemand" -Value 1 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'NoNameReleaseOnDemand' to 1."
