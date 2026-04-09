variable "storage_account_name" {
  description = "The name of the Azure Storage Account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account will be created"
  type        = string
}

variable "storage_account_tier" {
  description = "The tier of the storage account (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type for the storage account (LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS)"
  type        = string
  default     = "LRS"
}

variable "is_hns_enabled" {
  description = "Whether to enable hierarchical namespace for Data Lake Storage"
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "Enables infrastructure encryption for the storage account"
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = "Determines whether shared access keys are enabled"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enables or disables public network access to the storage account"
  type        = bool
  default     = false
}

variable "network_rules_ip_rules" {
  description = "List of allowed IPs for accessing the storage account"
  type        = list(string)
  default     = []
}

variable "network_rules_virtual_network_subnet_ids" {
  description = "List of subnet IDs that are allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "delete_retention_policy_days" {
  description = "Number of days to retain deleted blobs and containers"
  type        = number
  default     = 7
}

variable "min_tls_version" {
  description = "The minimum TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}

variable "tags" {
  description = "A map of tags to apply to the storage account"
  type        = map(string)
  default     = {}
}

variable "local_user_enabled" {
  description = "Are local users enabled on the storage account ?"
  type        = string
}

variable "identity" {
  description = "Type of Managed Service Identity that should be configured on the SQL Server"
  type = object({
    type         = string
    identity_ids = list(string)
  })
}

variable "storage_account_containers" {
  type = map(object({
    container_name = string
    access_type    = string
  }))
  description = "A map of storage account containers with their access type."
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Azure Key Vault storing the customer-managed key."
}

variable "key_name" {
  type        = string
  description = "The name of the customer-managed key in the Key Vault. If empty, no CMK will be created."
}

variable "key_scope_id" {
  type        = string
  description = "The versionless ID of the customer-managed key in the Key Vault."
}
