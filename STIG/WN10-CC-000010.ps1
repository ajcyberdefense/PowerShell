<#.SYNOPSIS
This PowerShell script configures the lock screen settings on a Windows 10 
system by creating (if necessary) and setting a registry value under the 
Personalization policy. Specifically, it sets the NoLockScreenSlideshow value 
to 1, which disables the lock screen slideshow feature, helping to enforce a 
consistent lock screen experience as per organizational policy.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000010).ps1 
#>


# Define the registry path for the Personalization policy.
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Create the registry key if it does not exist.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Personalization" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the 'NoLockScreenSlideshow' registry value to 1 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "NoLockScreenSlideshow" -Value 1 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'NoLockScreenSlideshow' to 1."
