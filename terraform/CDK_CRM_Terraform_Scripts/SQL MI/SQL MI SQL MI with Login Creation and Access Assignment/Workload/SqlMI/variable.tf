# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Name of the Azure Resource Group
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "tags" {
  description = "Tags for OpenAI resource block."
  type        = map(string)
}

# The geographical location where the resource group will be deployed.
variable "location" {
  type        = string
  description = "Location of the resource group."
}

variable "identity_type" {
  description = "The type of managed identity"
  type        = string
}

variable "identity_ids" {
  description = "The list of identity IDs"
  type        = list(string)
}

variable "sql_mi_sku_name" {
  type        = string
  description = "The SKU name for the Azure SQL Managed Instance. For example, 'GP_Gen5' for General Purpose or 'BC_Gen5' for Business Critical tier."
}

variable "ad_group_display_name" {
  type        = string
  description = "The display name of the Azure AD group to be assigned as SQL Server admin."
}

variable "sql_instance_name" {
  type        = string
  description = "Name of the SQL managed instance."
}

variable "sql_admin_user" {
  type        = string
  description = "SQL admin username"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL admin password"
  sensitive   = true
}

variable "sql_server_name" {
  type        = string
  description = "SQL server name"
}

variable "sql_groups" {
  description = "List of groups with server and database roles"
  type = list(object({
    name         = string
    server_roles = list(string)
    databases = list(object({
      name  = string
      roles = list(string)
    }))
  }))
}

variable "sql_storage_size" {
  type        = number
  description = "Storage size in GB for the SQL managed instance."
}

variable "sql_vcores" {
  type        = number
  description = "Number of vCores for the SQL managed instance."
}

variable "azuread_principal_type" {
  type        = string
  description = "Principal type (User, Group, ServicePrincipal)."
}

variable "azuread_authentication_only_enabled" {
  type        = bool
  description = "Enable Azure AD authentication only."
}

variable "sql_mi_subnet_name" {
  type        = string
  description = "Name of the subnet for the SQL managed instance."
}

variable "private_endpoint_name" {
  description = "Name of the Private Endpoint"
  type        = string
}

variable "hub_resource_group_name" {
  type        = string
  description = "Name of the HUB Resource group"
}

variable "private_service_connection_name" {
  description = "Name of the Private Service Connection"
  type        = string
}

variable "is_manual_connection" {
  description = "Flag to determine if the private endpoint connection is manual"
  type        = bool
}

variable "private_dns_zone_group_name" {
  description = "Name of the Private DNS Zone Group"
  type        = string
}

variable "private_connection_subresource_names" {
  description = "List of subresource names for the private connection"
  type        = list(string)
}

variable "dns_zone_creation" {
  type        = string
  description = "Whether to create a new private DNS zone or use an existing one. Allowed values: 'new', 'existing'"
}


## Same Vnet

variable "private_endpoint_same_vnet" {
  description = "Boolean flag to determine if the private endpoint is in the same VNet as the resource"
  type        = bool
}

variable "private_dns_zone_name_same_vnet" {
  description = "Private DNS Zone name to use when the private endpoint is in the same VNet"
  type        = string
}

variable "pep_same_vnet_subnet_name" {
  description = "Name of the subnet for the private endpoint in the same VNet"
  type        = string
}

variable "pep_same_vnet_virtual_network_name" {
  description = "Name of the virtual network for the private endpoint in the same VNet"
  type        = string
}

variable "pep_same_vnet_resource_group_name" {
  description = "Name of the resource group containing the subnet and VNet for the private endpoint"
  type        = string
}

variable "pdz_id_same_vnet" {
  type        = string
  description = "ID Of private DNS Zone in the same VNet"
}

## Diff Vnet

variable "private_endpoint_diff_vnet" {
  description = "Boolean flag to determine if the private endpoint is in a different VNet"
  type        = bool
}

variable "private_dns_zone_name_diff_vnet" {
  description = "Private DNS Zone name to use when the private endpoint is in a different VNet"
  type        = string
}


variable "pep_diff_vnet_subnet_name" {
  description = "Name of the subnet for the private endpoint in a different VNet"
  type        = string
}

variable "pep_diff_vnet_virtual_network_name" {
  description = "Name of the virtual network for the private endpoint in a different VNet"
  type        = string
}

variable "pep_diff_vnet_resource_group_name" {
  description = "Name of the resource group containing the different VNet"
  type        = string
}

variable "display_name" {
  type        = string
  description = "The display name of the Entra ID (Azure AD) directory role to be assigned to the managed identity. For example: 'Directory Readers'."
}

variable "pdz_id_diff_vnet" {
  type        = string
  description = "ID Of private DNS Zone in the same VNet"
}
