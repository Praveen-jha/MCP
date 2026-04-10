variable "nic_name" {
  type        = string
  description = "The name of the network interface card (NIC) for the virtual machine."
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The allocation method for the private IP address. Options include 'Dynamic' or 'Static'."
}

variable "linux_vm_name" {
  type        = string
  description = "The name of the linux virtual machine to be created."
}

variable "linux_publisher" {
  type        = string
  description = "The publisher of the linux image for the virtual machine. For example, 'MicrosoftlinuxServer'."
}

variable "linux_offer" {
  type        = string
  description = "The offer for the linux image, which specifies the type of linux OS (e.g., 'linuxServer')."
}

variable "linux_sku" {
  type        = string
  description = "The SKU of the linux image to be used for the VM, such as '2016-Datacenter'."
}

variable "size" {
  type        = string
  description = "The size of the virtual machine, which defines its compute resources (e.g., 'Standard_F2')."
}

variable "admin_username" {
  type        = string
  description = "The username for the administrator account on the linux virtual machine."
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

variable "disk_size_gb" {
  type        = number
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "image_version" {
  type        = string
  description = "The version of the linux image to use for the virtual machine."
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

variable "IP_allocation_method" {
  type        = string
  description = "The allocation method for the public IP address (e.g., 'Dynamic' or 'Static')."
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

variable "nic_accelerated_networking_enabled" {
  type = bool
  description = "Default is disabled, Before enable cross check if Virtual Machine sizes are supported for Accelerated Networking"
}

variable "disable_password_authentication" {
  type = bool
  description = "Disable Password"
}

# ---------------------------------
# variables for VM auto-shutdown
#----------------------------------

variable "shutdown_timezone" {
  description = "Timezone for auto shutdown"
  type = string
}
variable "shutdown_notification_enabled" {
  description = "Enable notification for auto shutdown"
  type = bool
}
variable "auto_shutdown_enable" {
  description = ""
  type = bool
}

variable "daily_recurrence_time" {
  type = string
}

variable "auto_shutdown_notification_email" {
  type = string
}

variable "vm_identity_type" {
  description = "(Optional) Specifies the type of Managed Service Identity that can be configured on this Virtual Machine. Possible values are SystemAssigned, UserAssigned."
  type        = string
  default     = "SystemAssigned"
}