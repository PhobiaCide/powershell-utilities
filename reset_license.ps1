# Powershell script to reset evaluation licenses for windows server variants

# Run the re arm command to reset the windows evaluation license
slmgr.vbs -rearm

# Requires Restart
Restart-Computer
