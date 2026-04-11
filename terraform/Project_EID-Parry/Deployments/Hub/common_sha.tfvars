nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "existing"
  environment     = "hub"
  businessunit    = "ea"
  identity        = "eid"
  tags = {
    "Business Owner" = "EID"
    "Business Unit"  = "EA"
    "Environment"    = "Hub"
  }
}
shaVM = {
    vmSize                        = "Standard_D4s_v5"
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
