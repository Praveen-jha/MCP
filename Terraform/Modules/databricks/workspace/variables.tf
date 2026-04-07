variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}
variable "databricks_workspace_rg" {
  description = "Name of the Azure Resource Group for the Databricks workspace"
  type        = string
}
variable "databricks_workspace_location" {
  description = "Location of the Databricks workspace"
  type        = string
}
variable "databricks_workspace_sku" {
  description = "SKU of the Databricks workspace"
  type        = string
}
variable "tags" {
  description = "Tags for the Databricks workspace"
  type        = map(string)
}
variable "databricks_managed_rg" {
  description = "Name of the managed resource group for Databricks"
  type        = string
}
variable "public_network_enabled" {
  description = "Boolean flag indicating whether public network access is enabled for Databricks"
  type        = bool
}
variable "databricks_nsg_rules_required" {
  description = "Boolean flag indicating whether network security group rules are required for Databricks"
  type        = string
}
variable "databricks_custom_parameters" {
  description = "Custom parameters for Databricks"
  type = object({
    no_public_ip                                         = string # Indicates whether public IP is disabled for Databricks
    virtual_network_id                                   = string # ID of the virtual network for Databricks
    private_subnet_name                                  = string # Name of the private subnet for Databricks
    private_subnet_network_security_group_association_id = string # ID of the network security group associated with the private subnet for Databricks
    public_subnet_name                                   = string # Name of the public subnet for Databricks
    public_subnet_network_security_group_association_id  = string # ID of the network security group associated with the public subnet for Databricks
    # storage_account_name                                 = string # Name of the storage account for Databricks
  })
}
variable "infrastructure_encryption_enabled" {
  description = "Is the Databricks File System root file system enabled with a secondary layer of encryption with platform managed keys?"
  type = bool
  default = true
}
# variable "databricks_customer_managed_key_enabled" {
#   description = "Boolean flag indicating whether customer managed key is enabled for the Databricks workspace"
#   type        = bool
# }
# variable "key_vault_key_id" {
#   description = "Resource Id of Key vault key block"
#   type        = string
# }
# variable "databricks_infrastructure_encryption_enabled" {
#   description = "Boolean flag indicating whether infrastructure encryption is enabled for Databricks"
#   type        = bool
# }
# variable "databricks_managed_disk_cmk_key_vault_key_id" {
#   description = "ID of the key vault key used for managed disk encryption in Databricks"
#   type        = string
# }
# variable "databricks_managed_disk_cmk_rotation_to_latest_version_enabled" {
#   description = "Boolean flag indicating whether rotation to the latest version of the key vault key is enabled for managed disks in Databricks"
#   type        = bool
# }
# variable "databricks_managed_services_cmk_key_vault_key_id" {
#   description = "ID of the key vault key used for managed services encryption in Databricks"
#   type        = string
# }