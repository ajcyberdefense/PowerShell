<#.SYNOPSIS
This PowerShell script configures a Windows 10 system to disable IP source 
routing, which helps protect against IP spoofing attacks. It does this by 
ensuring that the registry value DisableIPSourceRouting is set to 2 under 
the path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters. If the 
registry key does not exist, the script creates it before setting the 
specified value.


.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000025

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000025).ps1 
#>

# Define the registry path for the TCP/IP parameters.
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip" -Name "Parameters" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the 'DisableIPSourceRouting' registry value to 2 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "DisableIPSourceRouting" -Value 2 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'DisableIPSourceRouting' to 2."
