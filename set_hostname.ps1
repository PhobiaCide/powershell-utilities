# Powershell script to change the hostname of a server and reboot

# Exmaple of running this script with arguments from command prompt
# powershell "& ""C:\Users\Administrator\Desktop\set_hostname.ps1""" "-hostname app-server"


# Set input parameters
param(
    [Parameter(Mandatory=$true,
    HelpMessage="The hostname that the server should be assigned.")]
    [string]$hostname="test-vm"
)

# Rename the Computer and Restart
Rename-Computer -NewName $hostname -force
Restart-Computer
