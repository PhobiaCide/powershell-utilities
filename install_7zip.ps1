# Powershell script to install 7zip

# Modern websites require TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dlurl = "https://7-zip.org/" + (Invoke-WebRequest -UseBasicParsing -Uri "https://7-zip.org/" | Select-Object -ExpandProperty Links | Where-Object {($_.outerHTML -match "Download")-and ($_.href -like "a/*") -and ($_.href -like "*-x64.exe")} | Select-Object -First 1 | Select-Object -ExpandProperty href)
$installerPath = Join-Path $env:TEMP (Split-Path $dlurl -Leaf)
Invoke-WebRequest $dlurl -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/S" -Verb RunAs -Wait
Remove-Item $installerPath
