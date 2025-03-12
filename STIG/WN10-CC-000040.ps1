<#.SYNOPSIS
This PowerShell script ensures that insecure guest authentication is disabled on a Windows 
10 system. It does this by setting the AllowInsecureGuestAuth registry value to 0 (REG_DWORD) 
under the key HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation. The script first 
checks if the registry key exists and creates it if necessary, then applies the required setting 
to enforce secure guest authentication.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000040

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000040).ps1 
#>


# Define the registry path for the LanmanWorkstation policy.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "LanmanWorkstation" -Force | Out-Null
    Write-Host "Created registry key: $regPath" -ForegroundColor Cyan
}

# Set the 'AllowInsecureGuestAuth' registry value to 0 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "AllowInsecureGuestAuth" -Value 0 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'AllowInsecureGuestAuth' to 0." -ForegroundColor Green
