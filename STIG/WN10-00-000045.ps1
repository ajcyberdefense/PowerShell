<#.SYNOPSIS
This PowerShell script checks if antivirus software (Windows Defender, McAfee, Symantec) 
is installed and actively running on a Windows system. It searches through the system's 
services for antivirus-related processes based on predefined patterns. If it detects any 
matching services, it verifies if they're running, displays their status, and sets a flag 
accordingly. If no antivirus services are running, the script explicitly reports this as a 
security finding.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000045

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000045).ps1 
#>

# Initialize a flag to track if an anti-virus solution is found and running.
$avFound = $false

# Define a list of search patterns for anti-virus services.
$servicePatterns = @("*Defender*", "*mcafee*", "*symantec*")

foreach ($pattern in $servicePatterns) {
    # Find services matching the current pattern.
    $services = Get-Service | Where-Object { $_.DisplayName -like $pattern }
    
    if ($services) {
        # Filter for services that are running.
        $runningServices = $services | Where-Object { $_.Status -eq "Running" }
        if ($runningServices) {
            Write-Host "Found running anti-virus service(s) matching '$pattern':"
            $runningServices | Format-Table -AutoSize
            $avFound = $true
        } else {
            Write-Host "Found service(s) matching '$pattern' but none are running:"
            $services | Format-Table -AutoSize
        }
    } else {
        Write-Host "No anti-virus service matching '$pattern' found."
    }
}

if (-not $avFound) {
    Write-Host "No anti-virus solution is installed or running on this system. This is a finding."
}
