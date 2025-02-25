<#.SYNOPSIS
This PowerShell script checks for the existence of the FVE registry key under 
HKLM:\SOFTWARE\Policies\Microsoft and creates it if necessary. It then sets the 
MinimumPIN DWORD value to 6, ensuring that the minimum BitLocker PIN length is 
configured to be 6 (or greater).

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-02-24
    Last Modified   : 2025-02-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000032

.TESTED ON
    Date(s) Tested  : 2025-02-24
    Tested By       : 2025-02-24
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-00-000032).ps1 
#>

# Define the registry path for the FVE policy
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "FVE" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the MinimumPIN value to 6 (REG_DWORD)
New-ItemProperty -Path $regPath -Name "MinimumPIN" -Value 6 -PropertyType DWord -Force | Out-Null

Write-Host "Registry value 'MinimumPIN' has been set to 6 (or greater)."
