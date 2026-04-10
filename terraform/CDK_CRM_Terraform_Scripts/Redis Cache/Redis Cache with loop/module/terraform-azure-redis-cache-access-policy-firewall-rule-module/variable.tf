// variables.tf
// This file defines the input variables for the azurerm_redis_firewall_rule module.

variable "name" {
  description = "The name of the Redis Firewall Rule."
  type        = string
  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 80
    error_message = "Name must be between 1 and 80 characters."
  }
}

variable "redis_cache_name" {
  description = "The name of the Redis Cache."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which this Redis Cache exists."
  type        = string
}

variable "start_ip" {
  description = "The lowest IP address included in the range."
  type        = string
}

variable "end_ip" {
  description = "The highest IP address included in the range."
  type        = string
}

variable "timeouts" {
  description = "Timeout settings for create, read, update, and delete operations."
  type = object({
    create = optional(string, "30m")
    read   = optional(string, "5m")
    update = optional(string, "30m")
    delete = optional(string, "30m")
  })
  default = {}
}
