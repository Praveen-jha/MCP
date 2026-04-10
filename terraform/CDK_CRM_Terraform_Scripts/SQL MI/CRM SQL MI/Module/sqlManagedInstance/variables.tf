# Azure region where all resources will be deployed
variable "location" {
  type        = string
  description = "Azure region for resources"
}

# Name of the Azure Resource Group
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

# Name of the Azure SQL Managed Instance
variable "sql_instance_name" {
  type        = string
  description = "Name of the SQL managed instance"
}

# Storage size in GB for the SQL managed instance
variable "sql_storage_size" {
  type        = number
  description = "Storage size in GB"
}

# Number of vCores for the SQL managed instance
variable "sql_vcores" {
  type        = number
  description = "Number of vCores"
}

variable "subnet_id_sqlmi" {
  type = string
  description = "Subnet ID for SQL Managed Instance"
}

variable "identity_type" {
  description = "The type of managed identity"
  type        = string
}

variable "identity_ids" {
  description = "The list of identity IDs"
  type        = list(string)
}

variable "azuread_authentication_only_enabled" {
  type        = bool
  description = "Enable Azure AD authentication only for the SQL Server."
}

variable "azuread_principal_type" {
  type        = string
  description = "Principal type for Azure AD administrator (e.g., User, Group, or ServicePrincipal)."
}

variable "ad_group_display_name" {
  type        = string
  description = "Display name of the Azure AD group to set as administrator."
}

variable "ad_group_object_id" {
  type        = string
  description = "Object ID of the Azure AD group to set as administrator."
}