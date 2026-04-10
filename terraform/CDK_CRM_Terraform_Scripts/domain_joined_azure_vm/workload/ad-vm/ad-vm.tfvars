nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "new"
  environment     = "hub"
  businessunit    = "ea"
  identity        = "eid"
  tags = {
    "Workload Name"    = "Hub"
    "Tier"             = "Core"
    "Environment"      = "Test"
    "Environment Type" = "Test"
  }
}

hub_network = {
  address_space_vnet                     = ["172.30.12.0/23"]
  subnet_compute_address_prefix          = ["172.30.12.64/27"]
  subnet_nsg_association                 = false
  subnet_routetable_association          = false
}

shaVM = {
    vmSize                        = "Standard_D4s_v5"
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "MicrosoftWindowsServer"
    offer                         = "WindowsServer"
    sku                           = "2022-datacenter-azure-edition"
    version                       = "latest"
    disk_size_gb                  = 128
    private_ip_address_allocation = "Dynamic"
    identity_type                 = "SystemAssigned"
    admin_username                = "adminuser"
    admin_password                = "password@123"
}