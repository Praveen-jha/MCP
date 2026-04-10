nameConfig = {
  defaultLocation = "centralus"
  rg_creation     = "new"
  vnet_creation   = "new"
  nsg_creation    = "new"
  subnet_creation = "new"
  environment     = "dev"
  short_name      = "mr"
  product_name    = "crm"
  region_flag     = "cus"
  instance        = "04"
  application     = "sqlvm"
  tags = {
    "Environment" = "dev"
  }
}

network = {
  address_space_vnet            = ["10.1.0.0/16"]
  subnet_compute_address_prefix = ["10.1.1.0/24"]
  subnet_nsg_association        = false
  subnet_routetable_association = false
}

VM = {
  vmSize                        = "Standard_D2s_v3"
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
    sku = "Standard_LRS"
    properties = {
      createOption = "Empty"
      diskSizeGB   = 512
    }
  },
  {
    sku = "Premium_LRS"
    properties = {
      createOption = "Empty"
      diskSizeGB   = 1024
    }
  },
  {
    sku = "Premium_LRS"
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

sql_vm_storage_configuration = {
  disk_type                      = "NEW"     // Possible values: "NEW", "EXTEND", "ADD"
  storage_workload_type          = "GENERAL" // Possible values: "GENERAL", "OLTP", "DW"
  system_db_on_data_disk_enabled = false

  data_settings = {
    default_file_path = "F:\\data"
    luns              = [0]
  }

  log_settings = {
    default_file_path = "G:\\log"
    luns              = [1]
  }

  temp_db_settings = {
    default_file_path      = "H:\\tempDb"
    luns                   = [2]
    data_file_count        = 8
    data_file_growth_in_mb = 64
    data_file_size_mb      = 8
    log_file_growth_mb     = 64
    log_file_size_mb       = 8
  }
}

sql_instance         = {}
auto_patching        = {}
auto_backup          = {}
key_vault_credential = {}

existing_resource_group_name         = ""
existing_virtual_network_name        = ""
existing_subnet_name                 = ""
exisitng_network_security_group_name = ""

compute_nsg_security_rule = [
    {
      name                       = "Allow_RDP"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    }
]