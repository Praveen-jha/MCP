# Variables for Hub Network Workload
variable "nameConfig" {
  type = object({
    defaultLocation = string      //Location for the Resource to be Deployed.
    tags            = map(string) //"Tags are key-value pairs that help organize and manage resources by categorizing them (e.g., by environment, department, or purpose)."
    rg_creation     = string      //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    nsg_creation    = string      //"Flag to indicate whether a new NSG should be created or existing NSG is used."
    vnet_creation   = string      //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation = string      //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    environment     = string      //Deployment Environment (for example UAT or Prod).
    short_name      = string      //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name    = string      //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag     = string      //Central US (cus), East US 2 (eus2)
    instance        = string      //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application     = string      //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}

variable "network" {
  type = object({
    address_space_vnet            = list(string) //The address space for the virtual network.
    subnet_compute_address_prefix = list(string) //A list of address prefixes for the compute subnet.
    subnet_nsg_association        = bool         //subnet nsg assocation bool: defaults to true
    subnet_routetable_association = bool         //subnet rt assocation bool: defaults to true
  })
}

variable "VM" {
  type = object({
    vmSize                        = string //The size of the virtual machine, which defines its compute resources (e.g., 'Standard_F2').
    caching                       = string //The caching type for the virtual machine's OS disk (e.g., 'ReadWrite', 'ReadOnly').
    storage_account_type          = string //The type of storage account for the OS disk (e.g., 'Standard_LRS', 'Premium_LRS').
    publisher                     = string //The publisher of the Windows image for the virtual machine. For example, 'MicrosoftWindowsServer'.
    offer                         = string //The offer for the Windows image, which specifies the type of Windows OS (e.g., 'WindowsServer').
    sku                           = string //The SKU of the Windows image.
    version                       = string //The version of the Windows image to use for the virtual machine.
    disk_size_gb                  = number //The Size of the Internal OS Disk in GB.
    private_ip_address_allocation = string //The allocation method for the private IP address. Options include 'Dynamic' or 'Static'.
    identity_type                 = string //The type of managed identity (e.g., SystemAssigned, UserAssigned).
    admin_username                = string //The username for the administrator account to be created on the virtual machine.
    admin_password                = string //VM Password
  })
}

variable "dataDiskResources" {
  type = list(object({
    sku = string
    properties = object({
      createOption = string
      diskSizeGB   = number
    })
  }))
  description = "A list of managed disk resources to be created separately."
}

variable "sqlVM" {
  type = object({
    sql_license_type          = string // The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created.
    sqlAuthenticationLogin    = string // The SQL Authentication login username.
    sqlAuthenticationPassword = string // The SQL Authentication login password.
    sqlConnectivityType       = string // The SQL connectivity type (e.g., 'Private', 'Public').
    sqlPortNumber             = number // The port number for SQL connectivity.
  })
}


variable "existing_resource_group_name" {
  type        = string
  description = "Name of the Existing Resource Group"
}

variable "existing_virtual_network_name" {
  type        = string
  description = "Name of the Existing Virtual Network"
}

variable "existing_subnet_name" {
  type        = string
  description = "Name of the Existing Subnet"
}

variable "exisitng_network_security_group_name" {
  type        = string
  description = "Name of the Existing NSG"
}

variable "sql_vm_storage_configuration" {
  type     = any
  nullable = true
  default = {
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
  description = "Variable for Storage Configuration Values,The type of disk configuration to apply to the SQL Server, The type of storage workload, Specifies whether to set system databases (except tempDb) location to newly created data storage, The SQL Server default path, A list of Logical Unit Numbers for the disks, The SQL Server default file count, The SQL Server default file size,  "
}

variable "sql_instance" {
  type     = any
  nullable = true
  default = {
    adhoc_workloads_optimization_enabled = false
    collation                            = ""
    instant_file_initialization_enabled  = false
    lock_pages_in_memory_enabled         = false
    max_dop                              = 0
    max_server_memory_mb                 = 0
    min_server_memory_mb                 = 0
  }
  description = "Variable for SQL Instance Values, Colation, max dop, minimum server memory, maximum server memory, lock pages in memory enable, indstant file initializatin enabled and adhoc workload optimization enabled."
}

variable "key_vault_credential" {
  type     = any
  nullable = true
  default = {
    key_vault_url             = ""
    key_vault_credential_name = ""
    service_principal_name    = ""
    service_principal_secret  = ""
  }
  description = "Key Vault Credential for Key Vault Credential Name, Key Vault URL, Service Principal Name and Service Principal Secret"
}

variable "auto_patching" {
  type     = any
  nullable = true
  default = {
    day_of_week                            = ""
    maintenance_window_duration_in_minutes = 0
    maintenance_window_starting_hour       = 0
  }
  description = "Auto Patching for the day of week to apply the patch on, The Hour in the Virtual Machine Time-Zone when the patching maintenance window should begin and The size of the Maintenance Window in minutes."
}

variable "auto_backup" {
  type     = any
  nullable = true
  default = {
    encryption_password             = ""
    retention_period_in_days        = 0
    storage_account_access_key      = ""
    storage_blob_endpoint           = ""
    system_databases_backup_enabled = false
    manual_schedule = {
      days_of_week                    = [""]
      full_backup_frequency           = ""
      full_backup_start_hour          = 0
      full_backup_window_in_hours     = 0
      log_backup_frequency_in_minutes = 0
    }
  }
  description = "Auto backup for encryption password,manual schedule,retention period, storage blob endpoin, storage account access key and system databases backup enabled or not."
}

variable "compute_nsg_security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    destination_port_ranges    = list(string)
  }))
  description = "nsg rule with attributes."
}
