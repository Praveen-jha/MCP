nameConfig = {
  defaultLocation = "eastus"
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
  address_space_vnet            = ["10.1.0.0/16"]
  subnet_compute_address_prefix = ["10.1.0.0/24"]
  subnet_ha1_address_prefix     = ["10.1.1.0/24"]
  subnet_ha2_address_prefix     = ["10.1.2.0/24"]
  subnet_nsg_association        = false
  subnet_routetable_association = false
}

shaVM = {
  vmSize                        = "Standard_D2ls_v5"
  caching                       = "ReadWrite"
  storage_account_type          = "Standard_LRS"
  publisher                     = "microsoftsqlserver"
  offer                         = "sql2022-ws2022"
  sku                           = "enterprise-gen2" //sqldev-gen2
  version                       = "latest"
  disk_size_gb                  = 128
  private_ip_address_allocation = "Dynamic"
  identity_type                 = "SystemAssigned"
  admin_username                = "adminuser"
  admin_password                = "password@123"
}

# Configuration for managed disk resources created separately
dataDiskResources = [
  {
    name = "managed-disk-a"
    sku  = "Standard_LRS"
    properties = {
      createOption = "Empty"
      diskSizeGB   = 512
    }
  },
  {
    name = "managed-disk-b"
    sku  = "Premium_LRS"
    properties = {
      createOption = "Empty"
      diskSizeGB   = 1024
    }
  }
]


# Configuration for SQL Virtual Machine settings
sqlVM = {
  sql_license_type          = "PAYG" // Possible values: "AHUB", "DR", "PAYG"
  sqlAuthenticationLogin    = "sqladmin"
  sqlAuthenticationPassword = "password@123" // Replace with a strong, secure password
  sqlConnectivityType       = "PRIVATE"      // Possible values: "PRIVATE", "PUBLIC"
  sqlPortNumber             = 1433
}


enable_high_availability = false
availability_zones       = ["1", "2"]