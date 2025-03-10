<#.SYNOPSIS
This PowerShell script checks the configuration of the "Secondary Logon" 
service (service name: "seclogon") on a Windows 10 system. It verifies 
whether the service's startup type is set to "Disabled" and whether the 
service is running. If the startup type is not disabled, the script sets 
it to "Disabled". If the service is running, it stops the service. This 
configuration helps mitigate the risk of credential exposure by preventing 
the use of alternate credentials in a standard user session.

.NOTES
    Author          : Anthony Joseph Jr
    LinkedIn        : www.linkedin.com/in/anthony-joseph-jr-1271ab1b8
    GitHub          : github.com/ajcyberdefense
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 2025-03-10
    Tested By       : 2025-03-10
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(WN10-00-000175).ps1 
#>

# Retrieve the "Secondary Logon" service using its service name "seclogon"
$service = Get-CimInstance -ClassName Win32_Service -Filter "Name='seclogon'"

# Check and disable the service's startup type if it is not already disabled.
if ($service.StartMode -ne "Disabled") {
    Write-Host "Secondary Logon service startup type is '$($service.StartMode)'. Disabling the service..."
    Set-Service -Name "seclogon" -StartupType Disabled
} else {
    Write-Host "Secondary Logon service startup type is already 'Disabled'."
}

# Check and stop the service if it is currently running.
if ($service.State -eq "Running") {
    Write-Host "Secondary Logon service is currently running. Stopping the service..."
    Stop-Service -Name "seclogon" -Force
} else {
    Write-Host "Secondary Logon service is not running."
}

Write-Host "Secondary Logon service has been disabled and stopped."
