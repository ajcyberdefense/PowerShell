<#.SYNOPSIS
This PowerShell script checks whether the TFTP Client is installed on a 
Windows 10 system by searching for the "tftp.exe" file in the Windows 
System32 directory. If the file is found, the script reports a finding, 
indicating that the TFTP Client is installed, which is not compliant with 
security policies. If the file is not found, it confirms that the system is 
compliant.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000120

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000120).ps1 
#>

# Define the System32 directory path
$system32Path = "$env:SystemRoot\System32"

# Search for the TFTP executable (tftp.exe) in the System32 directory
$tftpApp = Get-ChildItem -Path $system32Path -Filter "tftp.exe" -ErrorAction SilentlyContinue

if ($tftpApp) {
    Write-Host "TFTP Client is installed (tftp.exe found in $system32Path). This is a finding." -ForegroundColor Red
} else {
    Write-Host "TFTP Client is not installed. The system is compliant." -ForegroundColor Green
}
