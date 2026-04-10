nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "new"
  environment     = "prd"
  businessunit    = "ea"
  identity        = "eid"
  tags = {
    "Business Owner" = "EID"
    "Business Unit"  = "EA"
    "Environment"    = "Prod"
  }
}

spoke_network = {
  address_space_vnet                     = ["172.30.15.0/24"]
  subnet_compute_address_prefix          = ["172.30.15.32/27"]
  subnet_private_endpoint_address_prefix = ["172.30.15.0/27"]
  subnet_nsg_association                 = false
  subnet_routetable_association          = false
}

shirVM = {
    vmSize                        = "Standard_D4as_v5"
    caching                       = "ReadWrite"
    storage_account_type          = "Premium_LRS"
    publisher                     = "MicrosoftWindowsServer"
    offer                         = "WindowsServer"
    sku                           = "2022-datacenter-azure-edition"
    version                       = "latest"
    disk_size_gb                  = 128
    private_ip_address_allocation = "Dynamic"
    identity_type                 = "SystemAssigned"
    admin_username                = "adminuser"
}

odgwVM = {
    vmSize                        = "Standard_D4as_v5"
    caching                       = "ReadWrite"
    storage_account_type          = "Premium_LRS"
    publisher                     = "MicrosoftWindowsServer"
    offer                         = "WindowsServer"
    sku                           = "2022-datacenter-azure-edition"
    version                       = "latest"
    disk_size_gb                  = 128
    private_ip_address_allocation = "Dynamic"
    identity_type                 = "SystemAssigned"
    admin_username                = "adminuser"
}
