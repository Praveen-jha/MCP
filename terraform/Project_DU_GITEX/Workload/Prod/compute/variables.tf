# Variable to define tags for the NIC
variable "nic_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual network Interface."
}

# Variable to define tags for the virtual machine
variable "vm_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual machine."
}

# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

# Variable for the Business unit name
variable "bu_name" {
  type        = string
  description = "The name of the Business unit."
}

# The username for the administrator account to be created on the virtual machine.
# This is the account that will have admin privileges on the VM.
variable "admin_username" {
  type        = string
  description = "The username for the administrator account to be created on the virtual machine."
}

# The password for the administrator account. It is recommended to use a strong password.
# Ensure to avoid using weak or default passwords in production environments.
variable "password" {
  type        = string
  description = "The password for the administrator account. Make sure to use a strong password in production environments."
}

# The publisher of the Windows image for the virtual machine.
variable "windows_publisher" {
  type        = string
  description = "The publisher of the Windows image for the virtual machine."
}

# The offer of the Windows image for the virtual machine.
variable "windows_offer" {
  type        = string
  description = "The offer of the Windows image for the virtual machine."
}

# The SKU of the Windows image to be used for the virtual machine.
variable "windows_sku" {
  type        = string
  description = "The SKU of the Windows image."
}

# The publisher of the Windows image for the Power BI virtual machine.
variable "windows_publisher_pbi_vm" {
  type        = string
  description = "The publisher of the Windows image for the virtual machine."
}

# The offer of the Windows image for the Power BI virtual machine.
variable "windows_offer_pbi_vm" {
  type        = string
  description = "The offer of the Windows image for the virtual machine."
}

# The SKU of the Windows image to be used for the Power BI virtual machine.
variable "windows_sku_pbi_vm" {
  type        = string
  description = "The SKU of the Windows image."
}

# The size of the virtual machine, which determines the compute resources allocated (CPU, RAM, etc.).
variable "size" {
  type        = string
  description = "The size of the virtual machine. Default is Standard_F2."
}

# The size of the virtual machine, which determines the compute resources allocated (CPU, RAM, etc.).
variable "dev_vm_size" {
  type        = string
  description = "The size of the virtual machine. Default is Standard_F2."
}

# The name of the subnet to retrieve information for.
variable "compute_subnet_name" {
  type        = string
  description = "The name of the subnet."
}

# The name of the virtual network containing the subnet.
variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network containing the subnet."
}

# The name of the resource group where the virtual network and subnet reside.
variable "subnet_resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual network and subnet are located."
}

# The type of managed identity (e.g., SystemAssigned, UserAssigned).
variable "identity_type" {
  type        = string
  description = "The type of managed identity (e.g., SystemAssigned, UserAssigned)."
}

# Name of the resource group containing the Key Vault
variable "data_resource_group_name" {
  description = "The name of the resource group containing the Key Vault."
  type        = string
}

# Name of the User Assigned Identity (UAID) for resource authentication
variable "uaid_name" {
  description = "Name of the User Assigned Identity."
  type        = string
}
