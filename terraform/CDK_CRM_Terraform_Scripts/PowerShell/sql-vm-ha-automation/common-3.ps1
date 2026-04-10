#Configuring port exclusion to prevent other system processes from being dynamically assigned the same port on the VM

netsh int ipv4 add excludedportrange tcp startport=58888 numberofports=1 store=persistent
netsh int ipv4 add excludedportrange tcp startport=59999 numberofports=1 store=persistent
