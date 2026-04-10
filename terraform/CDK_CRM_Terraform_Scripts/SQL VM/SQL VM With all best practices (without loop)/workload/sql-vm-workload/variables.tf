variable "location" {
  description = "The Azure region where the Azure Resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Azure Resources."
  type        = map(string)
  default     = {}
}

variable "name_config" {
  type = object({
    sql_vm_resource_group_creation          = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_resource_group_creation = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation                = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation                         = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    network_security_group_creation         = string //"Flag to indicate whether a new NSG should be created or existing NSG is used."
    environment                             = string //Deployment Environment (for example UAT or Prod).
    short_name                              = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name                            = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag                             = string //Central US (cus), East US 2 (eus2)
    instance                                = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application                             = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}

variable "data_disk_resources" {
  description = "A list of managed disk resources to be created separately."
  type = list(object({
    name = string //(Required) The name of the managed data disk.
    sku  = string //(Required) The type of storage account (e.g., Standard_LRS, Premium_LRS).
    properties = object({
      create_option = string //(Required) Specifies how the managed disk is created (e.g., Empty, Copy, FromImage).
      disk_sizegb   = number //The size of the disk in gigabytes.
      lun           = number //(Required) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine.
      caching       = string //(Required) Specifies the caching type for the data disk. Possible values: None, ReadOnly, ReadWrite.
    })
  }))
}

variable "virtual_machine_config" {
  type = object({
    name                          = string //(Required) Name of the Windows virtual machine.
    computer_name                 = string //Computer name for the VM.
    vm_size                       = string //The size of the virtual machine, which defines its compute resources (e.g., 'Standard_F2').
    admin_username                = string //The username for the administrator account to be created on the virtual machine.
    admin_password                = string //VM Password
    caching                       = string //The caching type for the virtual machine's OS disk (e.g., 'ReadWrite', 'ReadOnly').
    storage_account_type          = string //The type of storage account for the OS disk (e.g., 'Standard_LRS', 'Premium_LRS').
    disk_size_gb                  = number //The Size of the Internal OS Disk in GB.
    publisher                     = string //The publisher of the Windows image for the virtual machine. For example, 'MicrosoftWindowsServer'.
    offer                         = string //The offer for the Windows image, which specifies the type of Windows OS (e.g., 'WindowsServer').
    sku                           = string //The SKU of the Windows image.
    version                       = string //The version of the Windows image to use for the virtual machine.
    identity_type                 = string //The type of managed identity (e.g., SystemAssigned, UserAssigned).
    private_ip_address_allocation = string //The allocation method for the private IP address. Options include 'Dynamic' or 'Static'.
  })
}

variable "virtual_machine_extension" {
  description = "An Object defining the details of Windows Extension."
  type = object({
    vm_extension_name                            = string //(Required) The name of the virtual machine extension.
    vm_extension_publisher                       = string //(Required) The publisher of the extension.
    vm_extension_type                            = string //(Required) The type of extension.
    vm_extension_type_handler_version            = string //(Required) Specifies the version of the extension to use.
  })
}

variable "sql_vm_config" {
  type = object({
    sql_license_type            = string // The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created.
    sql_authentication_login    = string // The SQL Authentication login username.
    sql_authentication_password = string // The SQL Authentication login password.
    sql_connectivity_type       = string // The SQL connectivity type (e.g., 'Private', 'Public').
    sql_port_number             = number // The port number for SQL connectivity.
  })
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

variable "existing_resource_group_sql_vm_name" {
  type        = string
  description = "Name of the Existing Resource Group in which SQL VM is to be created."
}

variable "existing_resource_group_virtual_network_name" {
  type        = string
  description = "Name of the Existing Resource Group in which Virtual Network is created."
}

variable "existing_virtual_network_name" {
  description = "Name of the Existing Virtual Network"
  type        = string
}

variable "existing_compute_subnet_name" {
  description = "Name of the Existing Subnet"
  type        = string
}
