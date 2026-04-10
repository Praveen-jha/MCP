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

sql_disks_simplified_config = {
  data = {
    names              = ["sql-data-disk-a", "sql-data-disk-b"]
    total_size_gb      = 50684 
    number_of_disks    = 2
    iops               = 44490
    throughput         = 727
    caching            = "None"
    disk_type          = "PremiumV2_LRS"
    zone               = 1
  }
  log = {
    names              = ["sql-log-disk-a"]
    total_size_gb      = 21101 
    number_of_disks    = 1
    iops               = 3000
    throughput         = 125
    caching            = "None"
    disk_type          = "PremiumV2_LRS"
    zone               = 1
  }
  tempdb = {
    names              = ["sql-tempdb-disk-a"]
    total_size_gb      = 128
    number_of_disks    = 1
    iops               = 3000
    throughput         = 200
    caching            = "None"
    disk_type          = "PremiumV2_LRS"
    zone               = 1
  }
}

virtual_machine_config = {
  name                          = "sql-vmasdd1"
  computer_name                 = "sqlvm2i"
  vm_size                       = "Standard_D8s_v3"
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
  windows_vm_availability_zone  = true
  windows_vm_vm_zone            = "1"
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
  }

  log_settings = {
    default_file_path = "G:\\log"
  }

  temp_db_settings = {
    default_file_path      = "H:\\tempDb"
    data_file_count        = 8
    data_file_growth_in_mb = 64
    data_file_size_mb      = 8
    log_file_growth_mb     = 64
    log_file_size_mb       = 8
  }
}

existing_resource_group_sql_vm_name          = "sql-rg"
existing_resource_group_virtual_network_name = "sql-rg"
existing_virtual_network_name                = "sql-vnet"
existing_compute_subnet_name                 = "default"
