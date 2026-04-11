variable "public_ip_name" {
  type        = string
  description = "Specifies the name of the Public IP. [Registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where this Public IP should exist."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the Public IP should exist."
}

variable "allocation_method" {
  type        = string
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "allocation_method must be 'Static' or 'Dynamic'."
  }
}

variable "zones" {
  type        = list(string)
  default     = null
  description = "A collection containing the availability zones to allocate the Public IP in."
}

variable "ddos_protection_mode" {
  type        = string
  default     = "VirtualNetworkInherited"
  description = "The DDoS protection mode of the public IP. Possible values: Disabled, Enabled, VirtualNetworkInherited."
  validation {
    condition     = contains(["Disabled", "Enabled", "VirtualNetworkInherited"], var.ddos_protection_mode)
    error_message = "ddos_protection_mode must be 'Disabled', 'Enabled', or 'VirtualNetworkInherited'."
  }
}

variable "ddos_protection_plan_id" {
  type        = string
  default     = null
  description = "ID of DDoS protection plan associated with the public IP."
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "Label for the Domain Name. Will be used to make up the FQDN."
}

variable "domain_name_label_scope" {
  type        = string
  default     = null
  description = "Scope for the domain name label. Possible values: NoReuse, ResourceGroupReuse, SubscriptionReuse, TenantReuse."
}

variable "edge_zone" {
  type        = string
  default     = null
  description = "Specifies the Edge Zone within the Azure Region where this Public IP should exist."
}

variable "idle_timeout_in_minutes" {
  type        = number
  default     = null
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
}

variable "ip_tags" {
  type        = map(string)
  default     = null
  description = "A mapping of IP tags to assign to the public IP."
}

variable "ip_version" {
  type        = string
  default     = "IPv4"
  description = "The IP Version to use, IPv6 or IPv4."
  validation {
    condition     = contains(["IPv4", "IPv6"], var.ip_version)
    error_message = "ip_version must be 'IPv4' or 'IPv6'."
  }
}

variable "public_ip_prefix_id" {
  type        = string
  default     = null
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource."
}

variable "reverse_fqdn" {
  type        = string
  default     = null
  description = "A fully qualified domain name that resolves to this public IP address."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "sku must be 'Basic' or 'Standard'."
  }
}

variable "sku_tier" {
  type        = string
  default     = "Regional"
  description = "The SKU Tier for the Public IP. Possible values are Regional and Global."
  validation {
    condition     = contains(["Regional", "Global"], var.sku_tier)
    error_message = "sku_tier must be 'Regional' or 'Global'."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}
