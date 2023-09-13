# Powershell script to install the latest version of python
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
$latest_url = (Invoke-RestMethod "https://www.python.org/downloads/") -match "\bhref=(?<url>.+?\.exe)"
$latest_url = $Matches.url
$latest_url = $latest_url.replace('"', "")

$latest_version = (Invoke-RestMethod "https://www.python.org/downloads/") -match "Download Python (?<version>\d+\.\d+\.\d+)"
$latest_version = $Matches.version

Write-Host "Installing Python version:" $latest_version
$installerPath = Join-Path $env:TEMP (Split-Path $latest_url -Leaf)

Invoke-WebRequest $latest_url -OutFile $installerPath
Start-Process -FilePath $installerPath -Args "/quiet InstallAllUsers=1 PrependPath=1" -Verb RunAs -Wait
Remove-Item $installerPath

# Add python and pip to PATH
$path_key = (Get-ChildItem -Path "HKLM:\SOFTWARE\Python\PythonCore\" -Recurse).Name -Like "*InstallPath"
$path_key = $path_key.replace("HKEY_LOCAL_MACHINE", "HKLM:")
$executable_path = (Get-ItemProperty -Path $path_key).ExecutablePath

# Create global and user paths for scripts
$split_version = $latest_version.Split(".")
$scripts_user_path = "c:\users\" + $Env:UserName + "\appdata\roaming\python\python" + $split_version[0] + $split_version[1] + "\Scripts\"
$scripts_global_path = $executable_path + "Scripts\"

setx path "%path%;$executable_path;$scripts_global_path;$scripts_user_path"
