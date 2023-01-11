# Powershell script to install Microsoft SQL 2022 Developer Edition
# And Microsoft SQL Management Studio
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install SQL
$sql_dev_url = "https://go.microsoft.com/fwlink/p/?linkid=2215158&clcid=0x409&culture=en-us&country=us"
$sql_install_path = "$env:TEMP\SQL2022-SSEI-Dev.exe"

Invoke-WebRequest $sql_dev_url -OutFile $sql_install_path
Start-Process -FilePath $sql_install_path -Args "/Q /IACCEPTSQLSERVERLICENSETERMS /ACTION='install'" -Verb RunAs -Wait
Remove-Item $sql_install_path

# Install Management Studio
$ssms_url = "https://aka.ms/ssmsfullsetup"
$ssms_install_path = "$env:TEMP\SSMS-Setup-ENU.exe"

Invoke-WebRequest $ssms_url -OutFile $ssms_install_path
Start-Process -FilePath $ssms_install_path -Args "/install /passive /quiet" -Verb RunAs -Wait
Remove-Item $ssms_install_path

Restart-Computer -Force
