<#.SYNOPSIS
This PowerShell script configures a Windows 10 system to disable the Shared Access User 
Interface by setting the registry value NC_ShowSharedAccessUI to 0 under the key 
HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections. The script checks if the 
required registry key exists and creates it if necessary before applying the specified 
value, ensuring that the Shared Access UI is suppressed as per security policies.


.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000044

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000044).ps1 
#>


# Define the registry path for the Network Connections policy.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Network Connections" -Force | Out-Null
    Write-Host "Created registry key: $regPath" -ForegroundColor Cyan
}

# Set the 'NC_ShowSharedAccessUI' registry value to 0 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "NC_ShowSharedAccessUI" -Value 0 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'NC_ShowSharedAccessUI' to 0." -ForegroundColor Green
