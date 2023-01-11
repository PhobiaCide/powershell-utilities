# Powershell script to install Microsoft SQL 2022 Developer Edition
# And Microsoft SQL Management Studio
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install SQL
# https://learn.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt?view=sql-server-ver16
$sql_dev_url = "https://go.microsoft.com/fwlink/p/?linkid=2215158&clcid=0x409&culture=en-us&country=us"
$sql_install_path = "$env:TEMP\SQL2022-SSEI-Dev.exe"

Invoke-WebRequest $sql_dev_url -OutFile $sql_install_path
Start-Process -FilePath $sql_install_path -Args "/Q /IACCEPTSQLSERVERLICENSETERMS /ACTION='install'" -Verb RunAs -Wait
Remove-Item $sql_install_path

# Enabled remote TCP/IP connections to the sql database(s)
# https://learn.microsoft.com/en-us/sql/powershell/how-to-enable-tcp-sqlps?view=sql-server-ver16
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SqlWmiManagement')

$wmi = New-Object 'Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer' localhost

$tcp = $wmi.ServerInstances['MSSQLSERVER'].ServerProtocols['Tcp']
$tcp.IsEnabled = $true  
$tcp.Alter()  

Restart-Service -Name MSSQLSERVER -Force

# Install Management Studio
$ssms_url = "https://aka.ms/ssmsfullsetup"
$ssms_install_path = "$env:TEMP\SSMS-Setup-ENU.exe"

Invoke-WebRequest $ssms_url -OutFile $ssms_install_path
Start-Process -FilePath $ssms_install_path -Args "/install /passive /quiet" -Verb RunAs -Wait
Remove-Item $ssms_install_path

Restart-Computer -Force
