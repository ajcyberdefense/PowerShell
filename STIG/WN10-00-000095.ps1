<#.SYNOPSIS
This PowerShell script first checks that the registry setting "EveryoneIncludesAnonymous" 
(which controls whether Everyone permissions apply to anonymous users) is set to 0 (Disabled)
under HKLM:\SYSTEM\CurrentControlSet\Control\Lsa. It then runs the icacls command on the 
directories C:, C:\Program Files, and C:\Windows to display their current permissions. The 
output should be reviewed to ensure that nonprivileged groups (like Users) have no more than 
Read & execute rights—confirming that the default secure file system permissions are maintained.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000095

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000095).ps1 
#>

# Check that "Network access: Let Everyone permissions apply to anonymous users" is disabled.
# This corresponds to the registry value "EveryoneIncludesAnonymous" in:
# HKLM:\SYSTEM\CurrentControlSet\Control\Lsa
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$regName = "EveryoneIncludesAnonymous"

try {
    $eaValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop | Select-Object -ExpandProperty $regName
    if ($eaValue -eq 0) {
        Write-Host "Registry setting: 'EveryoneIncludesAnonymous' is set to 0 (Disabled) [Compliant]."
    }
    else {
        Write-Host "Registry setting: 'EveryoneIncludesAnonymous' is set to $eaValue (Enabled) [Non-Compliant]."
    }
} catch {
    Write-Host "Error reading registry value '$regName' from $regPath. $_"
}

# Display the current file system permissions for key directories.
# These permissions should match the default secure settings.
$directories = @("C:\", "C:\Program Files", "C:\Windows")

foreach ($dir in $directories) {
    Write-Host "`nFile system permissions for $dir:" -ForegroundColor Cyan
    icacls $dir
}
