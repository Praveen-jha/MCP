variable "Firewall_Name" {
  type        = string
  description = "The name of the Azure Firewall resource to be created."
}

variable "Sku_Name" {
  type        = string
  description = "The SKU (Stock Keeping Unit) name for the Azure Firewall, which defines the performance and capacity (e.g., 'AZFW_VNet')."
}

variable "Sku_Tier" {
  type        = string
  description = "The SKU tier for the Azure Firewall, such as 'Standard' or 'Premium'."
}

variable "Ip_Configuration_name" {
  type        = string
  description = "The name of the IP configuration for the Azure Firewall, used to manage its IP settings."
}

variable "location" {
  type        = string
  description = "The Azure region where the Azure Firewall and related resources will be deployed (e.g., 'East US', 'West Europe')."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Azure Firewall and associated resources are located."
}

variable "subnet_id" {
  type        = string
  description = "The resource ID of the subnet where the Azure Firewall will be deployed."
}

variable "mgnt_subnet_id" {
  type        = string
  description = "The resource ID of the subnet where the Azure Firewall management  will be deployed."
}


variable "management_ip_configuration_name" {
  type        = string
  description = "The name of Firewall Management IP."
}

variable "PIP_Name" {
  type        = string
  description = "The name of the public IP address to be assigned to the Azure Firewall."
}

variable "mgnt_PIP_Name" {
  type        = string
  description = "The name of the management public IP address to be assigned to the Azure Firewall."
}

variable "Subnet_Allocation_Method" {
  type        = string
  description = "The method for allocating IP addresses for the subnet, such as 'Dynamic' or 'Static'."
}

variable "PIP_Sku" {
  type        = string
  description = "The SKU for the Public IP associated with the Azure Firewall, defining its performance or capacity."
}

# The name of the Azure Firewall Policy.
variable "firewall_policy_name" {
  type        = string
  description = "The name of the Azure Firewall Policy."
}

# Specifies if the proxy feature is enabled for the firewall policy.
# Set to "true" to enable or "false" to disable proxy functionality.
variable "proxy_enabled" {
  type        = string
  description = "Indicates whether the proxy feature is enabled for the firewall policy."
}

variable "dns_servers" {
  type = list(string)
  description = "IP of DNS Server"
}

# Defines the SKU for the firewall policy, which specifies the pricing and feature tier.
# Common values include 'Standard' or 'Premium' for enhanced features.
variable "firewall_policy_sku" {
  type        = string
  description = "The SKU for the firewall policy, specifying the pricing and feature tier."
}

# Tags associated with the firewall policy.
variable "firewall_policy_tags" {
  type        = map(string)
  description = "Tags for the firewall policy, used to organize and manage the policy in Azure."
}

# Tags associated with the firewall.
variable "firewall_tags" {
  type        =   map(string)
  description = "Tags to be applied for the azure firewall."
}

# Tags associated with the public ip.
variable "PIP_tags" {
  type        = map(string)
  description = "Tags to be applied for the public ip."
}

 