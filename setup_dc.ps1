# Powershell script to promote server to a domain controller and setup a new domain/forest

# Exmaple of running this script with arguments from command prompt
# powershell "& ""C:\Users\Administrator\Desktop\setup_dc.ps1""" "-domain test.lab" "-mode WinThreshold" "-password password"

# Set input parameters
param(
    [Parameter(Mandatory=$true,
    HelpMessage="Name of the new domain to be created.")]
    [string]$domain="lab.domain",
    
    [Parameter(Mandatory=$false,
    HelpMessage="Functional level of the domain. Default is Server 2012R2.")]
    [string]$mode="Win2012R2",

    [Parameter(Mandatory=$true,
    HelpMessage="Safe mode administrator password.")]
    [string]$password="password"
)

# Create the netbios name
$netbios = $domain.Split(".")[0].ToUpper()

# Convert the safe mode administrator password to a secure string
$secure_password = ConvertTo-SecureString -String $password -AsPlainText -Force

# Install domain services
Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools

# Import domain module
Import-Module ADDSDeployment

# Set properties for the domain
$forestProperties = @{

    DomainName           = $domain
    DomainNetbiosName    = $netbios
    ForestMode           = $mode
    DomainMode           = $mode
    CreateDnsDelegation  = $false
    InstallDns           = $true
    DatabasePath         = "C:\Windows\NTDS"
    LogPath              = "C:\Windows\NTDS"
    SysvolPath           = "C:\Windows\SYSVOL"
    NoRebootOnCompletion = $false
    Force                = $true

}

# Create domain
Install-ADDSForest @forestProperties -SafeModeAdministratorPassword $secure_password
