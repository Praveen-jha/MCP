variable "location" {
  description = "Azure region where the resource will be deployed."
  type        = string
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}

variable "name_config" {
  type = object({
    redis_cache_resource_group_creation         = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_resource_group_creation = string //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    virtual_network_creation                = string //"Flag to indicate whether a new Virtual Network should be created or existing Virtual Network is used."
    subnet_creation                         = string //"Flag to indicate whether a new Subnet should be created or existing Subnet is used."
    environment                             = string //Deployment Environment (for example UAT or Prod).
    short_name                              = string //Global Hosting Services=ghs, Data Services = ds, DMS=dms, CorpApps=corpapps, modern retailing = mr, Automotive Commerce Exchange Platform=fortellis, Dealer IT = dit
    product_name                            = string //Asset Name / Product Name - crm, titan, coefficient, drivecredit, servicenxt, clouddefence, cloudconnect, etc.
    region_flag                             = string //Central US (cus), East US 2 (eus2)
    instance                                = string //The instance counts for a specific resource, to differentiate it from other resources that have the same naming convention and naming components. Examples, 01, 001
    application                             = string //web, app, data, logs, mgmt, appvm, appserv, sqlvm, sqlmi
  })
}

variable "redis_cache" {
  type = object({
    capacity                           = number //(Required) The size of the Redis cache to deploy. Valid values depend on the SKU.
    family                             = string //(Required) SKU family name: C for Basic/Standard, P for Premium.
    sku_name                           = string //(Required) SKU name of the Redis Cache (Basic, Standard, Premium).
    access_keys_authentication_enabled = bool   //(Required) Enable or disable access key authentication
    non_ssl_port_enabled               = bool   // (Required) Enable non-SSL port access.
    redis_version                      = string // (Optional)  Version of Redis to deploy.
    minimum_tls_version                = string //Minimum TLS version allowed.
  })
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access."
  type        = bool
}

variable "new_redis_cache_resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the redis cache should exist."
}

variable "availability_zone" {
  type        = bool
  description = "Variable to determine if we want to deploy Redis Cache in availability zone or not"
  default     = false
}

variable "zones" {
  description = "Availability zones."
  type        = list(string)
  default     = []
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

variable "redis_cache_vnet_integration_enable" {
  type        = bool
  description = "To determine whether VNet integration is enabled for Web Apps. If false, virtual_network_subnet_id will be null."
}

variable "existing_resource_group_redis_cache_name" {
  type        = string
  description = "Name of the Existing Resource Group in which Web App is to be created."
}

variable "existing_resource_group_virtual_network_name" {
  type        = string
  description = "Name of the Existing Resource Group in which Virtual Network is created."
}

variable "existing_virtual_network_name" {
  type        = string
  description = "Name of the Existing Virtual Network"
}

variable "existing_private_endpoint_subnet_name" {
  type        = string
  description = "Name of the Existing Inbound Subnet for App Service"
}

variable "existing_outbound_subnet_name" {
  type        = string
  description = "Name of the Existing Outbound Subnet for App Service"
}

variable "enable_private_dns_zone_group" {
  description = "Whether to enable the private DNS zone group."
  type        = bool
}

variable "redis_cache_private_dns_zone_id" {
  description = "A list of private DNS zone IDs for Web App."
  type        = list(string)
  default     = null
}

