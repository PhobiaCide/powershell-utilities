# Powershell script to install virtio drivers and qemu agent for proxmox virtual machines

# Virtio driver url
$driver_url = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.208-1/virtio-win-gt-x64.msi"

# Virtio guest tools installer url
$installer_url = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.208-1/virtio-win-guest-tools.exe"

function download_file {
    [CmdletBinding()]
	param(
		[Parameter()]
		[string] $url
	)

    # Download file and save to temp directory
    Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\$( Split-Path -Path $url -Leaf )" | Out-Null
    # Start the installer or executable
    Start-Process -FilePath "$env:TEMP\$( Split-Path -Path $url -Leaf )" -ArgumentList "/quiet /passive /norestart" -Wait
    # Delete the file afterwards
    Remove-item "$env:TEMP\$( Split-Path -Path $url -Leaf )"
}

# Download and install the virtio drivers
download_file($driver_url)
# Download and install the virtio installer
download_file($installer_url)
