variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the ACR will be deployed"
  type        = string
}

variable "acr_sku" {
  description = "SKU for the Azure Container Registry (Basic, Standard, Premium)"
  type        = string
  default     = "Premium"
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access"
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "Network rule bypass option (AzureServices or None)"
  type        = string
  default     = "AzureServices"
}

variable "default_action" {
  description = "Default network rule action (Allow or Deny)"
  type        = string
  default     = "Deny"
}

variable "zone_redundancy_enabled" {
  description = "Enable zone redundancy for ACR"
  type        = bool
  default     = true
}

variable "data_endpoint_enabled" {
  description = "Enable dedicated data endpoints"
  type        = bool
  default     = true
}

variable "geo_replication_location" {
  description = "Location for ACR geo-replication"
  type        = string
  default     = "West Europe"
}

variable "geo_replication_enabled" {
  description = "Enable geo-replication for ACR"
  type        = bool
  default     = true
}

variable "regional_endpoint_enabled" {
  description = "Enable regional endpoint for geo-replication"
  type        = bool
  default     = true
}

variable "geo_zone_redundancy_enabled" {
  description = "Enable zone redundancy for geo-replicated ACR"
  type        = bool
  default     = true
}

variable "acr_tags" {
  description = "Tags for the Azure Container Registry"
  type        = map(string)
  default     = {}
}

variable "trust_policy_enabled" {
  description = "Enable trust policy for signed images to ensure that only signed/trusted images are used."
  type        = bool
}

variable "retention_policy_in_days" {
  description = "Number of days to retain untagged manifests before automatic cleanup."
  type        = number
}

variable "quarantine_policy_enabled" {
  type        = bool
  description = "Enable or disable the quarantine policy for container images in Azure Container Registry (ACR). When enabled, newly pushed images are quarantined until approved."
}
