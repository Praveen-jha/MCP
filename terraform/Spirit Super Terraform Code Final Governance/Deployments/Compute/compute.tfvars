nameConfig = {
    defaultLocation                = "australia east"
    existingComputeRGName          = "ngdp1t-compute-rg"
    existingNetworkRGName          = "ngdp1t-networking-rg"
    existingVnetName               = "platform1-aue-vnet1"
    deploymentEnvironment          = "test"
    identity                       = "ngdp"
    identity2                      = "platform"
    index                          = 1
    publicNetworkAccessEnabled     = true
    tags                           = {
        business_owner        = "Technology"
        managed_by            = "terraform"
        source                = ""
    }
}

shirVM = {
    vmSize                            = "Standard_D4s_v4"
    caching                           = "ReadWrite"
    storageAccountType                = "Premium_LRS"
    availabilityzone                  = null
    publisher                         = "MicrosoftWindowsServer"
    offer                             = "WindowsServer"
    sku                               = "2019-datacenter-gensecond"
    version                           = "latest"
    NIC_ip_configuration              = "ipconfig1"
    NIC_private_ip_address_allocation = "Dynamic"
}

opdgVM = {
    vmSize                            = "Standard_D4s_v4"
    caching                           = "ReadWrite"
    storageAccountType                = "Premium_LRS"
    availabilityzone                  = null
    publisher                         = "MicrosoftWindowsServer"
    offer                             = "WindowsServer"
    sku                               = "2019-datacenter-gensecond"
    version                           = "latest"
    NIC_ip_configuration              = "ipconfig1"
    NIC_private_ip_address_allocation = "Dynamic"
}

shirConfig = {
    shirRGName                = "storage-rg-01"
    shirStorageAccountName    = "statefilestorageacc01a"
    shirContainerName         = "shir"
    shirBlobName              = "gatewayinstall.ps1"
    synapseRGName             = "ngdp1t-application-rg"
}