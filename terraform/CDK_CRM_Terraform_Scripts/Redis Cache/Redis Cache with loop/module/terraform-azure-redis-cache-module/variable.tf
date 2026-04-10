// variables.tf
// This file defines the input variables for the azurerm_redis_cache module.

variable "redis_cache_name" {
  description = "Name of the Azure Redis Cache instance."
  type        = string

  validation {
    condition     = length(var.redis_cache_name) >= 1 && length(var.redis_cache_name) <= 63
    error_message = "The redis_cache_name must be between 1 and 63 characters."
  }
}

variable "location" {
  description = "The Azure region where the Redis instance will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "capacity" {
  description = "The size of the Redis cache to deploy."
  type        = number
  validation {
    condition     = var.capacity >= 0 && var.capacity <= 6
    error_message = "Capacity must be between 0 and 6."
  }
}

variable "family" {
  description = "The SKU family to use. Valid values: C (Basic/Standard), P (Premium)."
  type        = string
  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "Family must be either 'C' or 'P'."
  }
}

variable "sku_name" {
  description = "The SKU of Redis to use: Basic, Standard, or Premium."
  type        = string
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "sku_name must be one of 'Basic', 'Standard', or 'Premium'."
  }
}

variable "access_keys_authentication_enabled" {
  description = "Whether access key authentication is enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "non_ssl_port_enabled" {
  description = "Enable the non-SSL port (6379). Defaults to false."
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "The minimum TLS version. Defaults to 1.0."
  type        = string
  default     = "1.0"
  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "minimum_tls_version must be one of '1.0', '1.1', or '1.2'."
  }
}

variable "private_static_ip_address" {
  description = " (Optional) The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. This argument implies the use of subnet_id."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Enable public access to Redis. Defaults to true."
  type        = bool
  default     = true
}

variable "replicas_per_master" {
  type    = number
  default = null
}

variable "replicas_per_primary" {
  description = "Replicas per primary (only for Premium)."
  type        = number
  default     = null
}

variable "redis_version" {
  description = "The Redis version. Only major version. Default: 6"
  type        = string
  default     = "6"
  validation {
    condition     = contains(["4", "6"], var.redis_version)
    error_message = "Valid values for redis_version are '4' and '6'."
  }
}

variable "tenant_settings" {
  description = "Tenant-specific settings for the Redis instance."
  type        = map(string)
  default     = {}
}

variable "shard_count" {
  description = "Number of shards (only for Premium)."
  type        = number
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID for Redis deployment in a VNet."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to assign to the Redis Cache."
  type        = map(string)
  default     = {}
}

variable "zones" {
  description = "List of Availability Zones to deploy the Redis Cache."
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for z in var.zones : contains(["1", "2", "3"], z)])
    error_message = "zones must only contain values '1', '2', or '3'."
  }
}

variable "availability_zone" {
  type        = bool
  description = "Variable to determine if we want to deploy Redis Cache in availability zone or not"
  default     = false
}

variable "identity" {
  description = "Managed Identity configuration."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "patch_schedule" {
  description = "List of patch schedule blocks."
  type = list(object({
    day_of_week        = string
    start_hour_utc     = optional(number)
    maintenance_window = optional(string)
  }))
  default = []
  validation {
    condition     = alltrue([for s in var.patch_schedule : contains(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], s.day_of_week)])
    error_message = "day_of_week in patch_schedule must be a valid weekday (Monday–Sunday)."
  }
}

variable "redis_configuration" {
  description = "Redis configuration block with all nested values."
  type = object({
    aof_backup_enabled                      = optional(bool)   //(Optional) Enable or disable AOF persistence for this Redis Cache. Defaults to false.
    aof_storage_connection_string_0         = optional(string) //(Optional) First Storage Account connection string for AOF persistence.
    aof_storage_connection_string_1         = optional(string) //Optional) Second Storage Account connection string for AOF persistence.
    authentication_enabled                  = optional(bool)   //(Optional) If set to false, the Redis instance will be accessible without authentication. Defaults to true.
    active_directory_authentication_enabled = optional(bool)   //(Optional) Enable Microsoft Entra (AAD) authentication. Defaults to false.
    maxmemory_reserved                      = optional(number) //(Optional) Value in megabytes reserved for non-cache usage e.g. failover. 
    maxmemory_delta                         = optional(number) //(Optional) The max-memory delta for this Redis instance.
    maxmemory_policy                        = optional(string) //(Optional) How Redis will select what to remove when maxmemory is reached. Defaults to volatile-lru
    data_persistence_authentication_method  = optional(string) //(Optional) Preferred auth method to communicate to storage account used for data persistence. Possible values are SAS and ManagedIdentity.
    maxfragmentationmemory_reserved         = optional(number) //(Optional) Value in megabytes reserved to accommodate for memory fragmentation. 
    rdb_backup_enabled                      = optional(bool)   //(Optional) Is Backup Enabled? Only supported on Premium SKUs. Defaults to false.
    rdb_backup_frequency                    = optional(number) //(Optional) The Backup Frequency in Minutes. Only supported on Premium SKUs. Possible values are: 15, 30, 60, 360, 720 and 1440.
    rdb_backup_max_snapshot_count           = optional(number) //(Optional) The maximum number of snapshots to create as a backup. Only supported for Premium SKUs.
    rdb_storage_connection_string           = optional(string) //(Optional) The Connection String to the Storage Account. Only supported for Premium SKUs.
    notify_keyspace_events                  = optional(string) //(Optional) Keyspace notifications allows clients to subscribe to Pub/Sub channels in order to receive events affecting the Redis data set in some way.
    storage_account_subscription_id         = optional(string) //(Optional) The ID of the Subscription containing the Storage Account.
  })
  default = null
}
