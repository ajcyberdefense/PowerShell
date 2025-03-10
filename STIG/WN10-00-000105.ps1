<#.SYNOPSIS
This PowerShell script checks for the presence of SNMP by searching the Windows System32 
directory for executable files that start with "snmp" (e.g., snmp.exe, snmptrap.exe). Since 
SNMP is not installed by default on Windows 10, finding any such files indicates that SNMP 
has been installed, which is considered a security finding. If no SNMP-related files are 
found, the script confirms that the system is compliant.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000105

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000105).ps1 
#>

# Define the System32 directory path
$system32Path = "$env:SystemRoot\System32"

# Search for any executable files related to SNMP in the System32 directory.
# The filter "snmp*.exe" will match files like snmp.exe, snmptrap.exe, etc.
$snmpFiles = Get-ChildItem -Path $system32Path -Filter "snmp*.exe" -ErrorAction SilentlyContinue

if ($snmpFiles -and $snmpFiles.Count -gt 0) {
    Write-Host "SNMP application files were found in $system32Path. This is a finding." -ForegroundColor Red
    $snmpFiles | ForEach-Object { Write-Host $_.FullName }
} else {
    Write-Host "No SNMP application files were found in $system32Path. The system is compliant." -ForegroundColor Green
}
