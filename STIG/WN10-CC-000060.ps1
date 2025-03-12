<#.SYNOPSIS
This PowerShell script configures a Windows 10 system's Wireless Connection Manager 
Group Policy settings to block non-domain wireless connections. It does so by ensuring 
the registry key at HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy exists 
and then setting the fBlockNonDomain value to 1 (REG_DWORD). This setting enforces the 
policy that only domain-authenticated wireless connections are allowed, enhancing network 
security.


.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000060

.TESTED ON
    Date(s) Tested  : 2025-03-11
    Tested By       : 2025-03-11
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000060).ps1 
#>

# Define the registry path for the WcmSvc Group Policy settings.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc" -Name "GroupPolicy" -Force | Out-Null
    Write-Host "Created registry key: $regPath" -ForegroundColor Cyan
}

# Set the 'fBlockNonDomain' registry value to 1 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "fBlockNonDomain" -Value 1 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'fBlockNonDomain' to 1." -ForegroundColor Green
