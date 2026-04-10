variable "search_service_name" {
  description = "The name of the Azure Search Service resource."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure Search Service resource."
  type        = string
}

variable "location" {
  description = "The Azure location where the resource group is located."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Search Service resource."
  type        = string
}

variable "identity_type" {
  description = "The identity type for the Azure Search Service."
  type        = string
}

variable "local_authentication_enabled" {
  description = "Indicates if local authentication is enabled for the Azure Search Service."
  type        = bool
}

variable "authentication_failure_mode" {
  description = "Specifies the behavior when authentication fails for the Azure Search Service."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Specifies if public network access is enabled for the Azure Search Service."
  type        = bool
}

variable "tags" {
  description = "Tags for AI Search resource block."
  type = map(string)
}

# variable "identity_ids" {
#   description = "The list of identity IDs"
#   type        = list(string)
# }

variable "customer_managed_key_enforcement_enabled" {
  description = "Specifies if customer managed key enforcement is enabled for the Azure Search Service."
  type        = bool
}

variable "semantic_search_sku" {
  description = "The SKU name for the semantic search capability. Accepted values are 'Standard', 'Free', or leave empty to disable."
  type        = string
}