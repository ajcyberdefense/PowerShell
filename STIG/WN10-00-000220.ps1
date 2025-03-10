<#.SYNOPSIS
This PowerShell script checks for the presence of Bluetooth hardware on a Windows 10 system. 
If no Bluetooth devices are found, it reports that the control is not applicable. If Bluetooth 
hardware is detected, the script further checks if any devices are enabled (status "OK"). If 
enabled devices are found, it lists them and prompts the administrator to verify that an organizational 
policy is in place to disable Bluetooth when not in use, and that personnel are properly trained. If no 
enabled Bluetooth devices are found, the script reports that the system is compliant.
.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000220

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000220).ps1 
#>

# Retrieve Bluetooth devices using Get-PnpDevice
$bluetoothDevices = Get-PnpDevice -Class Bluetooth -ErrorAction SilentlyContinue

if (-not $bluetoothDevices) {
    Write-Host "No Bluetooth hardware detected. This control is Not Applicable." -ForegroundColor Cyan
} else {
    # Filter for devices that are enabled (i.e. in "OK" status)
    $enabledBluetooth = $bluetoothDevices | Where-Object { $_.Status -eq "OK" }
    
    if ($enabledBluetooth) {
        Write-Host "Bluetooth is enabled on this system. The following enabled Bluetooth devices were found:" -ForegroundColor Yellow
        $enabledBluetooth | Format-Table -AutoSize -Property FriendlyName, InstanceId, Status
        Write-Host "`nPlease verify that your organization has a policy to turn off Bluetooth when not in use and that personnel are trained accordingly."
    } else {
        Write-Host "Bluetooth devices are present, but none are currently enabled. The system appears compliant." -ForegroundColor Green
    }
}
