# Script to create new self signed certificate and use it to bind HTTPS for the default web site

# Get the FQDN of the current sever
$fqdn = [System.Net.Dns]::GetHostByName($env:computerName).hostname
# Store certificates in personal store
$cert_path = "cert:\LocalMachine\My"
# Create self signed certificate
$certificate = New-SelfSignedCertificate -DnsName $fqdn -CertStoreLocation $cert_path
$certificate_thumbprint = $certificate.Thumbprint

# Create HTTPS binding using the self signed cert created above
New-IISSiteBinding -Name "Default Web Site" -BindingInformation "*:443:" -Protocol https -CertificateThumbPrint $certificate_thumbprint -CertStoreLocation $cert_path
