// variables.tf
// This file defines the input variables for the azurerm_redis_cache_access_policy_assignment module.

variable "name" {
  description = "Name of the Redis Cache Access Policy Assignment."
  type        = string
  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 128
    error_message = "Name must be between 1 and 128 characters."
  }
}

variable "redis_cache_id" {
  description = "The ID of the Redis Cache."
  type        = string
}

variable "access_policy_name" {
  description = "The name of the Access Policy to be assigned."
  type        = string
  validation {
    condition     = length(var.access_policy_name) > 0
    error_message = "Access policy name cannot be empty."
  }
}

variable "object_id" {
  description = "The object ID to assign the access policy."
  type        = string
}

variable "object_id_alias" {
  description = "User-friendly alias for the object ID."
  type        = string
  validation {
    condition     = length(var.object_id_alias) > 0
    error_message = "Object ID alias cannot be empty."
  }
}
