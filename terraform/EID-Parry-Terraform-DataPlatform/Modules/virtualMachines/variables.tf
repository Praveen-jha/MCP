variable "nic_name" {
  type        = string
  description = "The name of the network interface card (NIC) for the virtual machine."
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The allocation method for the private IP address. Options include 'Dynamic' or 'Static'."
}

variable "windows_vm_name" {
  type        = string
  description = "The name of the Windows virtual machine to be created."
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

variable "subnet_id" {
  type        = string
  description = "The resource ID of the subnet where the virtual machine will be deployed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual machine and related resources are located."
}

variable "location" {
  type        = string
  description = "The Azure region where the virtual machine and related resources will be deployed."
}

variable "computer_name" {
  type        = string
  description = "The computer name for the virtual machine, as it appears within the OS."
}

variable "nic_ip_configuration_name" {
  type        = string
  description = "The name of the IP configuration for the virtual machine's network interface card (NIC)."
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
}