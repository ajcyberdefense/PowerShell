<#.SYNOPSIS
This PowerShell script configures the system's local account token filter policy by 
ensuring that the registry value LocalAccountTokenFilterPolicy is set to 0 (a REG_DWORD) 
under the key HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System. If the 
registry key does not exist, the script creates it before applying the setting. This 
configuration helps manage token filtering for local accounts as per the system's security 
policy.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000037

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000037).ps1 
#>


# Define the registry path for the System policies.
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies" -Name "System" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the 'LocalAccountTokenFilterPolicy' registry value to 0 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "LocalAccountTokenFilterPolicy" -Value 0 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'LocalAccountTokenFilterPolicy' to 0."
