# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Variable for defining the storage account tier
variable "storage_account_tier" {
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid."
  type        = string
}

# Variable for defining the replication type of the storage account
variable "account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS, and RAGRS are changed to ZRS, GZRS, or RAGZRS and vice versa."
  type        = string
}

# Variable for specifying the type of Managed Service Identity for the storage account
variable "storage_identity_type" {
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  type        = string
}

# Variable for defining the offer type for the CosmosDB account
variable "cosmosdb_account_offer_type" {
  type        = string
  description = "The offer type for the CosmosDB account. Typical values are 'Standard' or 'Premium'."
}

# Variable for specifying the kind of CosmosDB account
variable "cosmos_mongodb_account_kind" {
  type        = string
  description = "The kind of CosmosDB account to be created. Examples include 'GlobalDocumentDB', 'MongoDB', etc."
}

# Variable for specifying the capabilities of the CosmosDB account
variable "cosmosdb_account_capabilities" {
  type        = string
  description = "The capabilities of the CosmosDB account. For example, 'EnableMongo' enables MongoDB API support."
}

# Variable for defining the consistency level of the CosmosDB account
variable "cosmosdb_account_consistency_level" {
  type        = string
  description = "The consistency level of the CosmosDB account. Options include 'Strong', 'BoundedStaleness', 'Session', 'Eventual', and 'ConsistentPrefix'."
}

# Variable for specifying the geographic location for CosmosDB geo-replication
variable "cosmosdb_account_geo_location_primary" {
  type        = string
  description = "The geographic location for CosmosDB geo-replication. This specifies the region where the secondary replica will be located."
}

# Variable for defining the failover priority of the CosmosDB account
variable "cosmosdb_account_failover_priority_primary" {
  type        = number
  description = "The failover priority of the CosmosDB account. Lower values indicate higher priority for failover."
}

# Variable for specifying the type of Managed Service Identity for the CosmosDB account
variable "cosmosdb_identity_type" {
  type        = string
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this CosmosDB account. Possible values are 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned' to enable both."
}

# Provisioned throughput for the MongoDB database (in RU/s)
variable "throughput" {
  description = "Provisioned throughput for the MongoDB database, specified in request units per second (RU/s). Choose an appropriate value based on the expected workload."
  type        = number
}

# Variable for the Tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the Tenant."
}

# Variable for the business unit name
variable "bu_name" {
  type        = string
  description = "The name of the business unit."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

# Specifies the SKU (pricing tier) of the Azure Key Vault instance.
# Common values are 'standard' for general use or 'premium' for advanced features, such as HSM-backed keys.
variable "key_vault_sku_name" {
  type        = string
  description = "The SKU (pricing tier) name for the Azure Key Vault. Options are 'standard' or 'premium'."
}

# The name of the subnet to retrieve information for.
variable "pep_subnet_name" {
  type        = string
  description = "The name of the subnet."
}

# The name of the virtual network containing the subnet.
variable "pep_virtual_network_name" {
  type        = string
  description = "The name of the virtual network containing the subnet."
}

# The name of the resource group where the virtual network and subnet reside.
variable "pep_resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual network and subnet are located."
}

# Specifies a list of Private DNS Zone IDs to associate with the Azure Key Vault.
# Used to configure private DNS settings for accessing the Key Vault within a private network.
variable "key_vault_private_dns_zone_id" {
  type        = list(string)
  description = "A list of Private DNS Zone IDs to associate with the Key Vault for private network access."
}

# List of Private DNS Zone IDs for Azure Data Lake Storage (ADLS) Blob access.
# This is used to configure private DNS settings for blob storage endpoints within a private network.
variable "adls_blob_private_dns_zone_id" {
  type        = list(string)
  description = "List of Private DNS Zone IDs associated with ADLS Blob endpoints for private network access."
}

# List of Private DNS Zone IDs for Azure Data Lake Storage (ADLS) Data File System (DFS) access.
# This is used to set up private DNS for DFS endpoints within a private network.
variable "adls_dfs_private_dns_zone_id" {
  type        = list(string)
  description = "List of Private DNS Zone IDs associated with ADLS DFS endpoints for private network access."
}

# List of Private DNS Zone IDs for Cosmos DB.
# Configures private DNS settings for accessing Cosmos DB within a private network.
variable "cosmos_mongodb_private_dns_zone_id" {
  type        = list(string)
  description = "List of Private DNS Zone IDs associated with Cosmos DB for private network access."
}

# The kind of CosmosDB account to be created. Examples include 'GlobalDocumentDB', 'MongoDB', etc.
variable "cosmos_nosql_account_kind" {
  type        = string
  description = "The kind of CosmosDB account to be created. Examples include 'GlobalDocumentDB', 'MongoDB', etc."
}

# List of Private DNS Zone IDs for Cosmos DB.
# Configures private DNS settings for accessing Cosmos DB within a private network.
variable "cosmos_nosql_private_dns_zone_id" {
  type        = list(string)
  description = "List of Private DNS Zone IDs associated with Cosmos DB for private network access."
}

# Tags for the Cosmos DB MongoDB instance
variable "cosmos_mongodb_tags" {
  description = "A map of tags to assign to the Cosmos DB MongoDB instance."
  type        = map(string)
}

# Tags for the Cosmos DB NoSQL instance
variable "cosmos_nosql_tags" {
  description = "A map of tags to assign to the Cosmos DB NoSQL instance."
  type        = map(string)
}

# Tags for the Azure Data Lake Storage (ADLS) resource
variable "adls_tags" {
  description = "A map of tags to assign to the Azure Data Lake Storage (ADLS) resource."
  type        = map(string)
}

# Tags for the Azure Key Vault instance
variable "keyvault_tags" {
  description = "A map of tags to assign to the Azure Key Vault instance."
  type        = map(string)
}

# Options for creating the key
variable "key_opts" {
  description = "The options for the key."
  type        = list(string)
}

# Type of key to create (e.g., RSA, EC)
variable "key_type" {
  description = "The type of key to create."
  type        = string
}

# Size of the key in bits (e.g., 2048, 4096)
variable "key_size" {
  description = "The size of the key in bits."
  type        = number
}

# Resource group name for the Application Insights instance
variable "application_insights_resource_group_name" {
  description = "The name of the resource group containing the Application Insights resource."
  type        = string
}

# Name of the Application Insights resource
variable "application_insights_name" {
  description = "The name of the Application Insights resource."
  type        = string
}

# Name of the Cognitive Services account (OpenAI)
variable "openai_account_name" {
  description = "The name of the Cognitive Services account."
  type        = string
}

# Resource group name containing the Cognitive Services account
variable "openai_resource_group_name" {
  description = "The name of the resource group containing the Cognitive Services account."
  type        = string
}

# Shared resource group name for Cognitive Services and Search Service
variable "ai_resource_group_name" {
  description = "The name of the shared resource group containing the Cognitive Services account and Search Service."
  type        = string
}

# Name of the Cognitive Services account (Data Intelligence)
variable "di_account_name" {
  description = "The name of the Cognitive Services account."
  type        = string
}

# Name of the Search Service resource
variable "search_service_name" {
  description = "The name of the Search Service."
  type        = string
}
