# Powershell script to install Internet Information Services (IIS)

# Install iis
Install-WindowsFeature -name Web-Server -IncludeManagementTools -IncludeAllSubFeature
# Install additional features generally needed for IIS applications
Install-WindowsFeature NET-WCF-HTTP-Activation45
Install-WindowsFeature NET-WCF-TCP-Activation45
