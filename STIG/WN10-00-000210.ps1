<#.SYNOPSIS
This PowerShell script checks for the presence of Bluetooth hardware on a Windows 10 system 
by querying devices in the Bluetooth class. If no Bluetooth hardware is detected, it reports 
that the control is not applicable. If Bluetooth hardware is found, the script filters the 
devices by their status. If any Bluetooth device shows a status of "OK" (indicating that the 
Bluetooth radio is enabled), the script outputs these active devices as a potential vulnerability 
(unless organizationally approved). Otherwise, it confirms that the Bluetooth radio is turned off 
or disabled.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000210

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000210).ps1 
#>

# Check for Bluetooth hardware using Get-PnpDevice
$bluetoothDevices = Get-PnpDevice -Class Bluetooth -ErrorAction SilentlyContinue

if (-not $bluetoothDevices) {
    Write-Host "No Bluetooth hardware detected. This control is Not Applicable." -ForegroundColor Cyan
} else {
    # Filter for devices that are enabled (Status "OK")
    $enabledDevices = $bluetoothDevices | Where-Object { $_.Status -eq "OK" }
    
    if ($enabledDevices) {
        Write-Host "Bluetooth radio is enabled. The following Bluetooth devices are active:" -ForegroundColor Red
        $enabledDevices | Format-Table -Property FriendlyName, Status, Class -AutoSize
    } else {
        Write-Host "Bluetooth radio is turned off or disabled." -ForegroundColor Green
    }
}
