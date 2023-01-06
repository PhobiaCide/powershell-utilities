# Powershell script to install the latest windows updates
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-PackageProvider -Name Nuget -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PSWindowsUpdate -Force
Get-Package -Name PSWindowsUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -ForceDownload -ForceInstall -AutoReboot

Add-WUServiceManager -MicrosoftUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -ForceDownload -ForceInstall -AutoReboot

$Updates = Get-WindowsUpdate      
$InstallKB = ($Updates).KB | Select-Object -First 2
$InstallKB
Get-WindowsUpdate -KBArticleID $InstallKB -ForceDownload -ForceInstall -Confirm -AcceptAll -IgnoreReboot 

Restart-Computer
