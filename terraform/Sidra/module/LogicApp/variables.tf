variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
}

variable "storage_accoun_content_share_name" {
  description = "Name of the File Share"
  type        = string
}

variable "service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "logic_app_name" {
  description = "Name of the Logic App Standard"
  type        = string
}

variable "os_type" {
  description = "Operating system type for the App Service Plan"
  type        = string
  default     = "Windows"
}

variable "sku_name" {
  description = "SKU for the App Service Plan"
  type        = string
  default     = "WS1"
}
variable "account_tier" {
  description = "The performance tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the storage account"
  type        = string
  default     = "LRS"
}

variable "logic_app_subnet_id" {
  description = "subnet ID of the subnet with which the logic app needs to be VNET integrated"
  type        = string
}

variable "logic_app_identity_type" {
  description = "logic app identity type"
  type        = string
  default     = "SystemAssigned"
}

variable "logic_app_public_access_enabled" {
  description = "public network access for logic app"
  type        = string
  default     = "Disabled"
}

variable "storage_pe_subnet_id" {
  type        = string
  description = "Subnet ID where all the Private endpoint will be deployed"
}
variable "private_dns_zone_ids" {
  type        = list(string)
  description = "private dns zone ids"
}
variable "functions_worker_runtime" {
  type        = string
  description = "function workder runtime for logic aap setting"
}

variable "website_dns_server" {
  type        = string
  description = "dns server for runtime"
  default     = "168.63.129.16"
}
variable "website_node_default_version" {
  type        = string
  description = "version of node"
  default     = "~20"
}

