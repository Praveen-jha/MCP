variable "cosmos_db_name" {
  description = "The name of the Cosmos DB account."
  type        = string
}

variable "location" {
  description = "The Azure region where the Cosmos DB will be deployed."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "cosmos_offer_type" {
  description = "The offer type for Cosmos DB (e.g., Standard)."
  type        = string
}

variable "cosmos_kind" {
  description = "The kind of Cosmos DB account (e.g., GlobalDocumentDB)."
  type        = string
}

variable "cosmos_automatic_failover_enabled" {
  description = "Enable automatic failover for high availability."
  type        = bool
  default     = false
}

variable "cosmos_min_tls_version" {
  description = "The minimum TLS version for Cosmos DB (e.g., TLS1_2)."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Cosmos DB account."
  type        = map(string)
  default     = {}
}

variable "cosmos_consistency_policy" {
  description = "Consistency policy configuration for Cosmos DB."
  type = object({
    consistency_level       = string
    max_interval_in_seconds = number
    max_staleness_prefix    = number
  })
}

variable "cosmos_geo_location" {
  description = "Geo-location configuration for Cosmos DB."
  type = object({
    location          = string
    failover_priority = number
  })
}

variable "cosmos_identity" {
  description = "Identity configuration for Cosmos DB."
  type = object({
    type         = string
    identity_ids = list(string)
  })
}

variable "key_vault_key_id" {
  description = "The key vault key ID for customer-managed encryption keys."
  type        = string
}

variable "local_authentication_disabled" {
  description = "Flag to disable local authentication."
  type        = bool
  default     = true
}

variable "access_key_metadata_writes_enabled" {
  description = "Specifies whether metadata writes using access keys are enabled."
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Determines if public network access is enabled for the resource."
  type        = bool
  default     = false
}

variable "default_identity_type" {
  description = "Specifies the default identity type to be used (e.g., 'SystemAssigned', 'UserAssigned')."
  type        = string
}

variable "cosmos_backup_type" {
  description = "Backup type of the Cosmos DB"
  type        = string
}

variable "cosmos_interval_in_minutes" {
  description = "Cosmos Backup Interval In Minutes"
  type        = number
}

variable "cosmos_retention_in_hours" {
  description = "Cosmos Backup Retention In Hours"
  type        = number
}

variable "cosmos_backup_tier" {
  description = "Backup Tier of the Cosmos DB"
  type        = string
  nullable    = true
}
