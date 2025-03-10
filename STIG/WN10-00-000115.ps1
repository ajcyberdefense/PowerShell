<#.SYNOPSIS
This PowerShell script checks whether the Telnet Client is installed on a Windows 10 system by 
searching for the "telnet.exe" file in the Windows System32 directory. If the file is found, the 
script reports that the Telnet Client is installed (which is a security finding). If the file is 
not present, it indicates that the system is compliant.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000115

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000115).ps1 
#>

# Define the System32 directory path
$system32Path = "$env:SystemRoot\System32"

# Search for the telnet.exe file in the System32 directory
$telnetApp = Get-ChildItem -Path $system32Path -Filter "telnet.exe" -ErrorAction SilentlyContinue

if ($telnetApp) {
    Write-Host "Telnet Client is installed (telnet.exe found in $system32Path). This is a finding." -ForegroundColor Red
} else {
    Write-Host "Telnet Client is not installed. The system is compliant." -ForegroundColor Green
}
