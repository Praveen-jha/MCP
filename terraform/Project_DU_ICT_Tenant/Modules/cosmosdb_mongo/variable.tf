# Location where the Cosmos DB account and MongoDB database will be deployed (e.g., UAE North)
variable "location" {
  type        = string
  description = "Location of the resource. This specifies the Azure region where the resources will be deployed."
}

# Name of the resource group where the Cosmos DB resources will be created
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group. This is the container in Azure Resource Manager that holds the related resources."
}

# Name of the Cosmos DB account to be created
# This name must be globally unique and will be used to identify the Cosmos DB account within Azure.
variable "cosmosdb_account_name" {
  type        = string
  description = "The name of the CosmosDB account to be created."
}

# Offer type for Cosmos DB account
variable "cosmosdb_account_offer_type" {
  type        = string
  description = "The offer type for the CosmosDB account. Typical values are 'Standard' or 'Premium'."
}

# Kind of Cosmos DB account
variable "cosmosdb_account_kind" {
  type        = string
  description = "The kind of CosmosDB account to be created. Examples include 'GlobalDocumentDB', 'MongoDB', etc."
}

# Capabilities of the Cosmos DB account
variable "cosmosdb_account_capabilities" {
  type        = string
  description = "The capabilities of the CosmosDB account. For example, 'EnableMongo' enables MongoDB API support."
}

# Public network access setting
variable "public_network_access_enabled" {
  type        = bool
  description = "Indicates whether public network access is enabled for the CosmosDB account. Set to 'false' to disable public access."
}

# Consistency level for the Cosmos DB account
variable "cosmosdb_account_consistency_level" {
  type        = string
  description = "The consistency level of the CosmosDB account. Options include 'Strong', 'BoundedStaleness', 'Session', 'Eventual', and 'ConsistentPrefix'."
}

# Geographic location for Cosmos DB geo-replication
variable "cosmosdb_account_geo_location_primary" {
  type        = string
  description = "The geographic location for CosmosDB geo-replication. This specifies the region where the secondary replica will be located."
}

# Failover priority setting for Cosmos DB account
variable "cosmosdb_account_failover_priority_primary" {
  type        = number
  description = "The failover priority of the CosmosDB account. Lower values indicate higher priority for failover."
}

# Managed Identity Type for the Cosmos DB account
variable "cosmosdb_identity_type" {
  type        = string
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this CosmosDB account. Possible values are 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned' to enable both."
}

# List of user-assigned identities
# If 'UserAssigned' or both types of identities are used, specify the identity IDs here.
variable "cosmosdb_identity_id" {
  type        = list(string)
  description = "The list of identity IDs to be used if 'cosmosdb_identity_type' is set to 'UserAssigned' or 'SystemAssigned, UserAssigned'."
}

# Virtual network filter setting
# Enables or disables virtual network filtering, allowing access control through Azure Virtual Network.
variable "is_virtual_network_filter_enabled" {
  type        = bool
  description = "Specifies whether the virtual network filter is enabled. Set to 'true' to enable virtual network filtering."
}

# Name of the MongoDB database to be created within the Cosmos DB account
variable "mongo_database_name" {
  description = "Name of the MongoDB database to be created within the Cosmos DB account."
  type        = string
}

# Provisioned throughput for the MongoDB database (in RU/s)
variable "throughput" {
  description = "Provisioned throughput for the MongoDB database, specified in request units per second (RU/s). Choose an appropriate value based on the expected workload."
  type        = number
}

variable "cosmos_mongodb_tags" {
  description = "A map of tags to assign to the resource. Tags are key-value pairs used for organizing and managing resources."
  type        = map(string)
}

# variable "key_vault_key_id" {
#   type        = string
#   description = "The fully qualified ID of the key in Azure Key Vault to be used for encryption, including the version."
# }
