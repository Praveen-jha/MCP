variable "vm_names" {
  description = "A list of VM names for replicas."
  type        = list(string)
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The allocation method for the private IP address. Options include 'Dynamic' or 'Static'."
}

variable "windows_publisher" {
  type        = string
  description = "The publisher of the Windows image for the virtual machine. For example, 'MicrosoftWindowsServer'."
}

variable "windows_offer" {
  type        = string
  description = "The offer for the Windows image, which specifies the type of Windows OS (e.g., 'WindowsServer')."
}

variable "windows_sku" {
  type        = string
  description = "The SKU of the Windows image to be used for the VM, such as '2016-Datacenter'."
}

variable "size" {
  type        = string
  description = "The size of the virtual machine, which defines its compute resources (e.g., 'Standard_F2')."
}

variable "admin_username" {
  type        = string
  description = "The username for the administrator account on the Windows virtual machine."
}

variable "password" {
  type        = string
  description = "The password for the administrator account. Ensure a strong password is used."
}

variable "caching" {
  type        = string
  description = "The caching type for the virtual machine's OS disk (e.g., 'ReadWrite', 'ReadOnly')."
}

variable "storage_account_type" {
  type        = string
  description = "The type of storage account for the OS disk (e.g., 'Standard_LRS', 'Premium_LRS')."
}

variable "image_version" {
  type        = string
  description = "The version of the Windows image to use for the virtual machine."
}

variable "disk_size_gb" {
  type        = number
  description = "The Size of the Internal OS Disk in GB."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual machine and related resources are located."
}

variable "location" {
  type        = string
  description = "The Azure region where the virtual machine and related resources will be deployed."
}

variable "vm_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Virtual Network."
}

variable "nic_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Virtual Network."
}

variable "identity_type" {
  description = "The type of managed identity"
  type        = string
}

variable "identity_ids" {
  description = "The list of identity IDs"
  type        = list(string)
  default     = null
}

variable "dataDiskResources" {
  type = list(object({
    name = string
    sku  = string
    properties = object({
      createOption = string
      diskSizeGB   = number
    })
  }))
  description = "A list of managed disk resources to be created separately."
}

variable "availability_zones" {
  description = "A list of Availability Zones for the VMs (e.g., ['1', '2', '3'])."
  type        = list(string)
}

variable "domain_user_name" {
  description = "The domain user account used to create FCI name in Active Directory and join VMs to Domain."
  type        = string
}

variable "domain_user_password" {
  description = "The password for the domain user account."
  type        = string
  sensitive   = true
}

variable "domain_fqdn" {
  description = "The Domain FQDN where the virtual machine will be joined."
  type        = string
}

variable "OUPath" {
  type        = string
  description = "OU Path"
}

variable "existing_virtual_network_name" {
  description = "The name of the existing virtual network."
  type        = string
}

variable "subnet_names" {
  description = "A list of subnet names, one for each VM replica."
  type        = list(string)
}

variable "vm_subnet_map" {
  description = "A map from VM name to a map containing subnet_name."
  type = map(object({
    subnet_name = string
  }))
  default = {
    "vm1" = {
      subnet_name = "subnet1"
    }
    "vm2" = {
      subnet_name = "subnet2"
    }
  }
}
