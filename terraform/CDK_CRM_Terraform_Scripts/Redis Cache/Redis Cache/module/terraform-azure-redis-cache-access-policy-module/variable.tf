// variables.tf
// This file defines the input variables for the azurerm_resource_group module.

variable "name" {
  description = "Name of the Redis Cache Access Policy."
  type        = string
  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 128
    error_message = "Name must be between 1 and 128 characters."
  }
}

variable "redis_cache_id" {
  description = "The ID of the Redis Cache to apply the policy to."
  type        = string
}

variable "permissions" {
  description = "A list of Redis Cache permissions to grant (e.g., \"RA\", \"R\", \"A\", \"U\", \"D\")."
  type        = list(string)
  validation {
    condition     = alltrue([for p in var.permissions : contains(["RA", "R", "A", "U", "D"], p)])
    error_message = "Each permission must be one of 'RA', 'R', 'A', 'U', or 'D'."
  }
}
