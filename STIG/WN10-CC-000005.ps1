<#.SYNOPSIS
This PowerShell script configures the system's lock screen policy by ensuring that the registry value NoLockScreenCamera is set to 1 under the Personalization policy at HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization. This setting disables the lock screen camera, helping to enforce security measures related to camera usage on the lock screen. The script creates the necessary registry key if it doesn't exist and then sets the specified value.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000005).ps1 
#>


# Define the registry path for the Personalization policy.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Create the Personalization registry key if it doesn't exist.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Personalization" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the 'NoLockScreenCamera' registry value to 1 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "NoLockScreenCamera" -Value 1 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'NoLockScreenCamera' to 1."
