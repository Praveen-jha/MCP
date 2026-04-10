// variables.tf
// This file defines the input variables for the azurerm_redis_linked_server module.

variable "target_redis_cache_name" {
  description = "Name of the primary Redis Cache instance."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the Redis caches."
  type        = string
}

variable "linked_redis_cache_id" {
  description = "Resource ID of the secondary Redis Cache instance."
  type        = string
}

variable "linked_redis_cache_location" {
  description = "Azure location/region of the linked Redis Cache."
  type        = string
}

variable "server_role" {
  description = "The role of the linked server. Valid values: 'Primary', 'Secondary'."
  type        = string
  validation {
    condition     = contains(["Primary", "Secondary"], var.server_role)
    error_message = "server_role must be either 'Primary' or 'Secondary'."
  }
}
