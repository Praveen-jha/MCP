# Variables for Hub Network Workload
variable "nameConfig" {
  type = object({
    defaultLocation = string      //Location for the Resource to be Deployed.
    tags            = map(string) //"Tags are key-value pairs that help organize and manage resources by categorizing them (e.g., by environment, department, or purpose)."
    rg_creation     = string      //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    environment     = string      //Deployment Environment (for example UAT or Prod).
    businessunit    = string      //Workload type of the resource
    identity        = string      //Flag to use in Naming Convention
  })
}

variable "spoke_network" {
  type = object({
    address_space_vnet                     = list(string) //The address space for the virtual network.
    subnet_compute_address_prefix          = list(string) //A list of address prefixes for the compute subnet.
    subnet_private_endpoint_address_prefix = list(string) //A list of address prefixes for the firewall subnet.
    subnet_nsg_association                 = bool         //subnet nsg assocation bool: defaults to true
    subnet_routetable_association          = bool         //subnet rt assocation bool: defaults to true
  })
}

variable "shirVM" {
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
  })
}

variable "odgwVM" {
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
  })
}
