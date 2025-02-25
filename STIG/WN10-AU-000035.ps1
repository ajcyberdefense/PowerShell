<#.SYNOPSIS
   This PowerShell script configures the Windows audit policy for 
   "User Account Management" events. It uses the native auditpol.exe 
   utility to enable auditing for failed events while disabling auditing 
   for successful events, ensuring that only failure events are logged for 
   user account management.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-02-24
    Last Modified   : 2025-02-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 2025-02-24
    Tested By       : 2025-02-24
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-AU-000035).ps1 
#>

# Configure "Audit User Account Management" to audit failures only.
# This corresponds to:
# Computer Configuration >> Windows Settings >> Security Settings >> Advanced Audit Policy Configuration >>
# System Audit Policies >> Account Management >> Audit User Account Management
# with "Failure" selected and "Success" disabled.

$auditSubcategory = "User Account Management"

# Set the policy: Enable failure auditing and disable success auditing.
auditpol.exe /set /subcategory:"$auditSubcategory" /failure:enable /success:disable

# Check if the command was successful.
if ($LASTEXITCODE -eq 0) {
    Write-Host "Audit policy for '$auditSubcategory' configured successfully (Failure only)."
} else {
    Write-Host "Failed to configure audit policy for '$auditSubcategory'."
}
