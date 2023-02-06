# Powershell script to install notepad++

# Modern websites require TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$BaseUri = "https://notepad-plus-plus.org"
$BasePage = Invoke-WebRequest -Uri $BaseUri -UseBasicParsing
$ChildPath = $BasePage.Links | Where-Object { $_.outerHTML -like "*Current Version*" } | Select-Object -ExpandProperty href
# Now let's go to the latest version's page and find the installer
$DownloadPageUri = $BaseUri + $ChildPath
$DownloadPage = Invoke-WebRequest -Uri $DownloadPageUri -UseBasicParsing
# Determine bit-ness of O/S and download accordingly
$DownloadUrl = $DownloadPage.Links | Where-Object { $_.outerHTML -like "*npp.*.Installer.x64.exe*" } | Select-Object -ExpandProperty href -Unique
$DownloadUrl = $DownloadUrl.split()
$DownloadUrl = $DownloadUrl[0]
Invoke-WebRequest -Uri $DownloadUrl -OutFile "$env:TEMP\$( Split-Path -Path $DownloadUrl -Leaf )" | Out-Null
Start-Process -FilePath "$env:TEMP\$( Split-Path -Path $DownloadUrl -Leaf )" -ArgumentList "/S" -Wait
