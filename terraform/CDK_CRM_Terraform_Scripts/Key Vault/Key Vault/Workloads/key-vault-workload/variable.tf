#variables.tf
# This file defines all input variables required for configuring Azure Key Vault and related networking resources.

variable "location" {
  description = "Azure region where the resource will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the  Namespace."
  type        = map(string)
  default     = {}
}

variable "name_config" {
  type = object({
    environment                             = string //Deployment Environment (for example UAT or Prod).
    short_name                              = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name                            = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag                             = string //Central US (cus), East US 2 (eus2)
    instance                                = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    kv_resource_group_creation              = string // "new" or "existing" to indicate whether Key Vault RG should be created.
    virtual_network_resource_group_creation = string // "new" or "existing" for the virtual network's resource group.
    virtual_network_creation                = string // "new" or "existing" to control virtual network creation.
    subnet_creation                         = string // "new" or "existing" to control subnet creation.
  })
}

variable "new_kv_resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the servicebus should exist."
}

variable "keyvault_config" {
  description = "Configuration object for Azure Key Vault."
  type = object({
    sku_name                    = optional(string, null) // The SKU name of the Key Vault (e.g., "standard" or "premium").
    enabled_for_disk_encryption = bool                   // Whether disk encryption is enabled for the Key Vault.
    create_kv                   = bool                   // Flag to indicate whether to create a new Key Vault.
    soft_delete_retention_days  = number                 // Number of days to retain deleted Key Vault before permanent deletion.
    enable_rbac_authorization   = bool                   // Whether to enable Azure RBAC for access control.
    purge_protection_enabled    = bool                   //Specifies whether purge protection is enabled to prevent the permanent deletion of Key Vault and its contents.
  })
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
}

variable "keyvault_private_endpoint_config" {
  description = "Configuration object for the  private endpoint"
  type = object({
    enable_private_dns_zone_group = bool         // Flag to enable or disable the Private DNS Zone Group for the private endpoint.
    private_dns_zone_ids          = list(string) // List of Private DNS Zone resource IDs to link with the private endpoint.
  })
}

#Declaring variables for existing resources
variable "existing_resource_group_kv_name" {
  description = "Name of the existing resource group where the service bus will deploy."
  type        = string
}
variable "existing_resource_group_virtual_network_name" {
  description = "Name of the existing resource group where the virtual network and subnet are located."
  type        = string
}
variable "existing_virtual_network_name" {
  description = "The name of the existing Virtual Network to reference when 'virtual_network_creation' is set to 'existing'."
  type        = string
}

variable "existing_private_endpoint_subnet_name" {
  description = "The name of the existing Subnet to reference when 'subnet_creation' is set to 'existing'."
  type        = string
}

variable "key_vault_roles" {
  type        = set(string)
  description = "List of Key Vault Roles to be assigned."
}