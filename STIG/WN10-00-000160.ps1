<#.SYNOPSIS
This PowerShell script checks whether the SMBv1 protocol (SMB1Protocol feature) 
is enabled on a Windows 10 system by querying the optional feature status. If 
the feature is enabled, the script disables it using the Disable-WindowsOptionalFeature 
cmdlet. If SMBv1 is already disabled, the script informs the user that no action is required. 
This helps mitigate vulnerabilities associated with the outdated SMBv1 protocol.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000160

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000160).ps1 
#>

# Retrieve the status of the SMB1Protocol optional feature
$smb1Feature = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

if ($smb1Feature.State -eq "Enabled") {
    Write-Host "SMB1Protocol is enabled. Disabling it now..." -ForegroundColor Yellow
    # Disable SMBv1 support. The -NoRestart switch prevents an immediate reboot.
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -Confirm:$false
    Write-Host "SMB1Protocol has been disabled." -ForegroundColor Green
} else {
    Write-Host "SMB1Protocol is already disabled. No action is required." -ForegroundColor Green
}
