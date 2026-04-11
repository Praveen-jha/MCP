variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Bastion and related resources will be deployed."
}

variable "bastion_name" {
  type        = string
  description = "The name of the Azure Bastion resource to be created, which provides secure RDP and SSH access."
}

variable "bastion_tags" {
  type = map(string)
}

variable "location" {
  type        = string
  description = "The Azure region where the Bastion and related resources will be deployed (e.g., East US, West Europe)."
}

variable "ip_configuration_name" {
  type        = string
  description = "The name of the IP configuration for the Bastion resource, used to manage its IP settings."
}

variable "subnet_id" {
  type        = string
  description = "The resource ID of the subnet in which the Bastion service will be deployed."
}

variable "public_ip_name" {
  type        = string
  description = "The name of the public IP address to be assigned to the Bastion resource."
}

variable "ip_allocation_method" {
  type        = string
  description = "The method used for allocating the public IP address. Options include 'Dynamic' or 'Static'."
}

variable "ip_sku" {
  type        = string
  description = "The SKU (Stock Keeping Unit) for the public"
}

# Tags associated with the public ip.
variable "PIP_tags" {
  type        = map(string)
  description = "Tags to be applied for the public ip."
}
