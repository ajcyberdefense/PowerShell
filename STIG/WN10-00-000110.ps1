<#.SYNOPSIS
This PowerShell script checks whether the "Simple TCP/IP Services" feature is 
installed on a Windows 10 system. It does so by querying the list of services 
for one with the display name "Simple TCP/IP Services". If the service is found, 
the script reports a finding, indicating that the feature is installed (which is 
not compliant with the security requirement). If the service is not found, the 
script confirms that the system is compliant.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000110

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000110).ps1 
#>

# Attempt to retrieve the "Simple TCP/IP Services" service
$tcpipService = Get-Service -DisplayName "Simple TCP/IP Services" -ErrorAction SilentlyContinue

if ($tcpipService) {
    Write-Host "Simple TCP/IP Services is installed. This is a finding." -ForegroundColor Red
} else {
    Write-Host "Simple TCP/IP Services is not installed. The system is compliant." -ForegroundColor Green
}
