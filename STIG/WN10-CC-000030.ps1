<#.SYNOPSIS
This PowerShell script disables the sending of ICMP redirect messages on a Windows 
10 system. It does so by setting the registry value EnableICMPRedirect to 0 under 
the key HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters. The script first 
checks if the required registry key exists and creates it if necessary, then it sets 
the specified value, thereby enhancing system security by reducing the risk of malicious 
network routing modifications.


.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000030

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-CC-000030).ps1 
#>



# Define the registry path for the TCP/IP parameters.
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"

# Check if the registry key exists; if not, create it.
if (-not (Test-Path $regPath)) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip" -Name "Parameters" -Force | Out-Null
    Write-Host "Created registry key: $regPath"
}

# Set the 'EnableICMPRedirect' registry value to 0 (REG_DWORD).
New-ItemProperty -Path $regPath -Name "EnableICMPRedirect" -Value 0 -PropertyType DWord -Force | Out-Null
Write-Host "Set 'EnableICMPRedirect' to 0."
