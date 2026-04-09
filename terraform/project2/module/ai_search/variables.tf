# REQUIRED VARIABLES (variables which are needed to be passed)
variable "ai_search_name" {
  description = "The Name given to this Search Service"
  type        = string
}
variable "ai_search_rg_name" {
  description = "The name of the Resource Group where the Search Service should exist"
  type        = string
}
variable "ai_search_rg_location" {
  description = "The Azure Region where the Search Service should exist"
  type        = string
}
variable "ai_search_sku" {
  description = "The SKU which should be used for this Search Service"
  type        = string
}

# OPTIONAL VARIABLES (variables which are not necessary to be passed)
variable "ai_search_tag" {
  description = "Specifies a mapping of tags which should be assigned to this Search Service"
  type        = map(string)
}
variable "public_network_access_enabled" {
  description = "Defines Public Network Access. This variable accepts a bool value for ai search service"
  type        = bool
  default     = false
}
variable "ai_service_hosting_mode" {
  description = "ai search service hosting mode. This variable accepts string for hosting mode"
  type        = string
}
variable "ai_partition_count" {
  description = "ai partition count for ai search service accepts number"
  type        = number
}
variable "ai_replica_count" {
  description = "ai replica count for ai search service accepts number"
  type        = number
}
variable "ai_search_identity" {
  description = "It specifies the type of Managed Service Identity that should be configured"
  type        = string
}
