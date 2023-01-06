# Powershell script to install the latest windows updates

Install-PackageProvider -Name Nuget -Force
Install-Module -Name PSWindowsUpdate -Force
Get-Package -Name PSWindowsUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
