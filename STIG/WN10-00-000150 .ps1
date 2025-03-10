<#.SYNOPSIS
This PowerShell script ensures that Structured Exception Handling Overwrite 
Protection (SEHOP) is enabled on a Windows 10 system by configuring the 
registry value DisableExceptionChainValidation under the key 
HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel. If the registry 
key does not exist, the script creates it, then sets the value to 0, which enables 
SEHOP to help mitigate buffer overflow attacks.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000150

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000150).ps1 
#>

# Define the registry path for the SEHOP configuration.
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"

# Ensure the "kernel" key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name "kernel" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Check the current value of "DisableExceptionChainValidation"
$currentValue = (Get-ItemProperty -Path $regPath -Name "DisableExceptionChainValidation" -ErrorAction SilentlyContinue).DisableExceptionChainValidation

if ($null -eq $currentValue -or $currentValue -ne 0) {
    # Set the value to 0 (0x00000000) to enable SEHOP.
    New-ItemProperty -Path $regPath -Name "DisableExceptionChainValidation" -Value 0 -PropertyType DWord -Force | Out-Null
    Write-Host "Configured SEHOP: 'DisableExceptionChainValidation' set to 0 (SEHOP enabled)."
} else {
    Write-Host "'DisableExceptionChainValidation' is already set to 0 (SEHOP enabled)."
}
