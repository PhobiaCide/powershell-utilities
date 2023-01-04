# Powershell script to change the current server's dns address to a domain controller,
# And join the current server to the specified domain

# Example of running this script with arguments from command prompt
# (Where the script is located at C:\Users\Administrator\Desktop\join_domain.ps1)
# powershell "& ""C:\Users\Administrator\Desktop\join_domain.ps1""" "-domain test.domain" "-dns 192.168.1.1" "-username Administrator" "-password your_password"

# Set input parameters
param(
    [Parameter(Mandatory=$true,
    HelpMessage="The fully qualified domain name of the domain to connect to.")]
    [string]$domain="test.lab",

    [Parameter(Mandatory=$true,
    HelpMessage="The IP address of a domain controller already on the domain.")]
    [string]$dns="10.0.0.1",

    [Parameter(Mandatory=$true,
    HelpMessage="The username of a domain admin, used to join the server to the domain.")]
    [string]$username="Administrator",

    [Parameter(Mandatory=$true,
    HelpMessage="The password of a domain admin, used to join the server to the domain.")]
    [string]$password="password"
)

# Get the network interface index
$interface_index = (Get-NetAdapter).ifIndex

# Set the dns ip address (Domain controller in this case)
Set-DNSClientServerAddress -interfaceIndex $interface_index -ServerAddresses ($dns)

# Convert password to secure string
$secure_password = ConvertTo-SecureString -String $password -AsPlainText -Force

# Create PSCredential
$ps_credential = New-Object System.Management.Automation.PSCredential ($username, $secure_password)

# Join the current server to the domain and restart server
add-computer –domainname $domain -Credential $ps_credential -restart
