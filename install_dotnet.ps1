# Powershell script to install the dotnet framework 4.8
$save_path = "$Env:Temp\ndp48-web.exe"

Start-BitsTransfer -Source 'https://go.microsoft.com/fwlink/?linkid=2088631' -Destination $save_path
Start-Process -FilePath $save_path -Args "/q /norestart /ChainingPackage ADMINDEPLOYMENT" -Verb RunAs -Wait

Remove-Item $save_path
Restart-Computer
