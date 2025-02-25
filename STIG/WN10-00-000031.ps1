<#.SYNOPSIS
    This PowerShell script configures BitLocker settings in the registry under
HKLM:\SOFTWARE\Policies\Microsoft\FVE. It creates the FVE key if it doesn't exist,
sets UseAdvancedStartup to 1, and then configures UseTPMPIN and UseTPMKeyPIN based
on whether BitLocker network unlock is in use—setting them to 1 by default or to 2 
if network unlock is enabled.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-02-24
    Last Modified   : 2025-02-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000031

.TESTED ON
    Date(s) Tested  : 2025-02-24
    Tested By       : 2025-02-24
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-00-000031).ps1 
#>

# Flag to indicate if BitLocker network unlock is used.
# Set to $true if network unlock is used; otherwise, leave as $false.
$useNetworkUnlock = $false

# Define the registry path for FVE policies.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

# Create the registry key if it doesn't already exist.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "FVE" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the UseAdvancedStartup value to 1 (REG_DWORD)
New-ItemProperty -Path $regPath -Name "UseAdvancedStartup" -Value 1 -PropertyType DWord -Force | Out-Null
Write-Host "Set UseAdvancedStartup to 1."

# Set UseTPMPIN and UseTPMKeyPIN based on network unlock usage.
if ($useNetworkUnlock -eq $true) {
    New-ItemProperty -Path $regPath -Name "UseTPMPIN" -Value 2 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "UseTPMKeyPIN" -Value 2 -PropertyType DWord -Force | Out-Null
    Write-Host "BitLocker network unlock is used. Set UseTPMPIN and UseTPMKeyPIN to 2."
} else {
    New-ItemProperty -Path $regPath -Name "UseTPMPIN" -Value 1 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path $regPath -Name "UseTPMKeyPIN" -Value 1 -PropertyType DWord -Force | Out-Null
    Write-Host "Set UseTPMPIN and UseTPMKeyPIN to 1."
}

Write-Host "Registry configuration complete."
