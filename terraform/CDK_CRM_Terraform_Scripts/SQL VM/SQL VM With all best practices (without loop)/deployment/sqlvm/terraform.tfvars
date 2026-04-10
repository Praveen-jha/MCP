location = "centralus"
tags     = { environment = "dev" }

name_config = {
  sql_vm_resource_group_creation          = "existing"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  network_security_group_creation         = "existing"
  subnet_creation                         = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "01"
  application                             = "sqlvm"
}

# Configuration for managed disk resources created separately
data_disk_resources = [
  {
    name = "data-disk-1"
    sku  = "Standard_LRS"
    properties = {
      create_option = "Empty"
      disk_sizegb   = 512
      lun           = 0
      caching       = "ReadOnly"
    }
  },
  {
    name = "data-disk-2"
    sku  = "Premium_LRS"
    properties = {
      create_option = "Empty"
      disk_sizegb   = 1024
      lun           = 1
      caching       = "ReadOnly"
    }
  },
  {
    name = "data-disk-3"
    sku  = "Premium_LRS"
    properties = {
      create_option = "Empty"
      disk_sizegb   = 1024
      lun           = 2
      caching       = "ReadOnly"
    }
  }
]

virtual_machine_config = {
  name                          = "sql-vm"
  computer_name                 = "sqlvm"
  vm_size                       = "Standard_D2s_v3"
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

virtual_machine_extension = {
  vm_extension_name                 = "sql-vm-AADLoginForWindows"
  vm_extension_publisher            = "Microsoft.Azure.ActiveDirectory"
  vm_extension_type                 = "AADLoginForWindows"
  vm_extension_type_handler_version = "1.0"
}

# Configuration for SQL Virtual Machine settings
sql_vm_config = {
  sql_license_type            = "PAYG" // Possible values: "AHUB", "DR", "PAYG"
  sql_authentication_login    = "sqladmin"
  sql_authentication_password = "password@123" // Replace with a strong, secure password
  sql_connectivity_type       = "PRIVATE"      // Possible values: "PRIVATE", "PUBLIC"
  sql_port_number             = 1433
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

existing_resource_group_sql_vm_name          = "rg-mr-crm-dev-cus-01"
existing_resource_group_virtual_network_name = "rg-mr-crm-dev-vnet-cus-01"
existing_virtual_network_name                = "vnet-mr-crm-dev-cus-01"
existing_compute_subnet_name                 = "snet-mr-crm-dev-compute-cus-01"
