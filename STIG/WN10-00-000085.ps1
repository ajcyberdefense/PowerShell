<#.SYNOPSIS
This PowerShell script checks a domain-joined Windows 10 workstation for 
unauthorized local user accounts. It first verifies that the system is part 
of a domain and then enumerates all local user accounts. The script excludes 
allowed built-in accounts (Administrator, Guest, DefaultAccount, defaultuser0, 
WDAGUtilityAccount) and any account that is a member of the local Administrators 
group. Any remaining local accounts are reported as findings, indicating potential 
security issues.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000085

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000085).ps1 
#>

# Check if the system is domain joined.
$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
if (-not $computerSystem.PartOfDomain) {
    Write-Host "This system is not domain joined. Check is Not Applicable."
    return
}

$computerName = $env:COMPUTERNAME

# Get allowed built-in account names.
$allowedBuiltIn = @("Administrator", "Guest", "DefaultAccount", "defaultuser0", "WDAGUtilityAccount")

# Get members of the local Administrators group.
$adminGroup = [ADSI]"WinNT://$computerName/Administrators,group"
$adminMembers = @()
foreach ($member in $adminGroup.Invoke("Members")) {
    $adminMembers += $member.GetType().InvokeMember("Name", 'GetProperty', $null, $member, $null)
}

# Enumerate all local user accounts using ADSI.
$adsiComputer = [ADSI]("WinNT://$computerName")
$localUsers = $adsiComputer.Children | Where-Object { $_.SchemaClassName -eq 'user' }

# Prepare an array to collect unauthorized accounts.
$unauthorizedAccounts = @()

foreach ($user in $localUsers) {
    $userName = $user.Name

    # Exclude allowed built-in accounts and any account that is a member of the Administrators group.
    if (($allowedBuiltIn -contains $userName) -or ($adminMembers -contains $userName)) {
        continue
    }
    
    # If the account is not in the allowed list, mark it as unauthorized.
    $unauthorizedAccounts += $userName
}

# Report findings.
if ($unauthorizedAccounts.Count -gt 0) {
    Write-Host "Unauthorized local user accounts detected on this domain-joined system:" -ForegroundColor Red
    $unauthorizedAccounts | ForEach-Object { Write-Host "- $_" }
} else {
    Write-Host "No unauthorized local user accounts were found. The system is compliant." -ForegroundColor Green
}
