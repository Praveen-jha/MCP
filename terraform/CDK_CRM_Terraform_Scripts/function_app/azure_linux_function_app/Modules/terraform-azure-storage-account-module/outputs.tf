#output.tf
# Azure Storage Account - All Possible Outputs
output "storage_account_name" {
  description = "Output: Azure Storage Account resource object"
  value       = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "Map of all created Storage Accounts"
  value       = azurerm_storage_account.this.id
}

# Access tier for the storage account
output "access_tier" {
  value = azurerm_storage_account.this.access_tier
}

# Account kind (Storage, StorageV2, BlobStorage, etc.)
output "account_kind" {
  value = azurerm_storage_account.this.account_kind
}

# Account replication type (LRS, GRS, RAGRS, ZRS, etc.)
output "account_replication_type" {
  value = azurerm_storage_account.this.account_replication_type
}

# Account tier (Standard or Premium)
output "account_tier" {
  value = azurerm_storage_account.this.account_tier
}

# Whether nested items are allowed
output "allow_nested_items_to_be_public" {
  value = azurerm_storage_account.this.allow_nested_items_to_be_public
}

# Cross-tenant replication enabled
output "cross_tenant_replication_enabled" {
  value = azurerm_storage_account.this.cross_tenant_replication_enabled
}

# Default OAuth authentication enabled
output "default_to_oauth_authentication" {
  value = azurerm_storage_account.this.default_to_oauth_authentication
}

# DNS endpoint type
output "dns_endpoint_type" {
  value = azurerm_storage_account.this.dns_endpoint_type
}

# Edge zone
output "edge_zone" {
  value = azurerm_storage_account.this.edge_zone
}

# HTTPS traffic only enabled
output "https_traffic_only_enabled" {
  value = azurerm_storage_account.this.https_traffic_only_enabled
}

# Storage account ID
output "id" {
  value = azurerm_storage_account.this.id
}

# Infrastructure encryption enabled
output "infrastructure_encryption_enabled" {
  value = azurerm_storage_account.this.infrastructure_encryption_enabled
}

# HNS (Hierarchical Namespace) enabled
output "is_hns_enabled" {
  value = azurerm_storage_account.this.is_hns_enabled
}

# Large file share enabled
output "large_file_share_enabled" {
  value = azurerm_storage_account.this.large_file_share_enabled
}

# Local user enabled
output "local_user_enabled" {
  value = azurerm_storage_account.this.local_user_enabled
}

# Location/Region
output "location" {
  value = azurerm_storage_account.this.location
}

# Minimum TLS version
output "min_tls_version" {
  value = azurerm_storage_account.this.min_tls_version
}

# Storage account name
output "name" {
  value = azurerm_storage_account.this.name
}

# NFSv3 enabled
output "nfsv3_enabled" {
  value = azurerm_storage_account.this.nfsv3_enabled
}


## Access Keys and Connection Information


# Primary access key
output "primary_access_key" {
  value     = azurerm_storage_account.this.primary_access_key
  sensitive = true
}

# Primary blob connection string
output "primary_blob_connection_string" {
  value     = azurerm_storage_account.this.primary_blob_connection_string
  sensitive = true
}

# Primary blob endpoint
output "primary_blob_endpoint" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}

# Primary blob host
output "primary_blob_host" {
  value = azurerm_storage_account.this.primary_blob_host
}

# Primary blob internet endpoint
output "primary_blob_internet_endpoint" {
  value = azurerm_storage_account.this.primary_blob_internet_endpoint
}

# Primary blob internet host
output "primary_blob_internet_host" {
  value = azurerm_storage_account.this.primary_blob_internet_host
}

# Primary blob Microsoft endpoint
output "primary_blob_microsoft_endpoint" {
  value = azurerm_storage_account.this.primary_blob_microsoft_endpoint
}

# Primary blob Microsoft host
output "primary_blob_microsoft_host" {
  value = azurerm_storage_account.this.primary_blob_microsoft_host
}

# Primary connection string
output "primary_connection_string" {
  value     = azurerm_storage_account.this.primary_connection_string
  sensitive = true
}


## Data Lake Storage (DFS) Endpoints


# Primary DFS endpoint
output "primary_dfs_endpoint" {
  value = azurerm_storage_account.this.primary_dfs_endpoint
}

# Primary DFS host
output "primary_dfs_host" {
  value = azurerm_storage_account.this.primary_dfs_host
}

# Primary DFS internet endpoint
output "primary_dfs_internet_endpoint" {
  value = azurerm_storage_account.this.primary_dfs_internet_endpoint
}

# Primary DFS internet host
output "primary_dfs_internet_host" {
  value = azurerm_storage_account.this.primary_dfs_internet_host
}

# Primary DFS Microsoft endpoint
output "primary_dfs_microsoft_endpoint" {
  value = azurerm_storage_account.this.primary_dfs_microsoft_endpoint
}

# Primary DFS Microsoft host
output "primary_dfs_microsoft_host" {
  value = azurerm_storage_account.this.primary_dfs_microsoft_host
}


## File Share Endpoints


# Primary file endpoint
output "primary_file_endpoint" {
  value = azurerm_storage_account.this.primary_file_endpoint
}

# Primary file host
output "primary_file_host" {
  value = azurerm_storage_account.this.primary_file_host
}

# Primary file internet endpoint
output "primary_file_internet_endpoint" {
  value = azurerm_storage_account.this.primary_file_internet_endpoint
}

# Primary file internet host
output "primary_file_internet_host" {
  value = azurerm_storage_account.this.primary_file_internet_host
}

# Primary file Microsoft endpoint
output "primary_file_microsoft_endpoint" {
  value = azurerm_storage_account.this.primary_file_microsoft_endpoint
}

# Primary file Microsoft host
output "primary_file_microsoft_host" {
  value = azurerm_storage_account.this.primary_file_microsoft_host
}

# Primary location
output "primary_location" {
  value = azurerm_storage_account.this.primary_location
}


## Network Access Configuration


# Public network access enabled
output "public_network_access_enabled" {
  value = azurerm_storage_account.this.public_network_access_enabled
}


## Queue Storage Endpoints


# Queue encryption key type
output "queue_encryption_key_type" {
  value = azurerm_storage_account.this.queue_encryption_key_type
}

# Primary queue endpoint
output "primary_queue_endpoint" {
  value = azurerm_storage_account.this.primary_queue_endpoint
}

# Primary queue host
output "primary_queue_host" {
  value = azurerm_storage_account.this.primary_queue_host
}

# Primary queue Microsoft endpoint
output "primary_queue_microsoft_endpoint" {
  value = azurerm_storage_account.this.primary_queue_microsoft_endpoint
}

# Primary queue Microsoft host
output "primary_queue_microsoft_host" {
  value = azurerm_storage_account.this.primary_queue_microsoft_host
}


## Table Storage Endpoints


# Table encryption key type
output "table_encryption_key_type" {
  value = azurerm_storage_account.this.table_encryption_key_type
}

# Primary table endpoint
output "primary_table_endpoint" {
  value = azurerm_storage_account.this.primary_table_endpoint
}

# Primary table host
output "primary_table_host" {
  value = azurerm_storage_account.this.primary_table_host
}

# Primary table Microsoft endpoint
output "primary_table_microsoft_endpoint" {
  value = azurerm_storage_account.this.primary_table_microsoft_endpoint
}

# Primary table Microsoft host
output "primary_table_microsoft_host" {
  value = azurerm_storage_account.this.primary_table_microsoft_host
}


## Web Storage Endpoints


# Primary web endpoint
output "primary_web_endpoint" {
  value = azurerm_storage_account.this.primary_web_endpoint
}

# Primary web host
output "primary_web_host" {
  value = azurerm_storage_account.this.primary_web_host
}

# Primary web internet endpoint
output "primary_web_internet_endpoint" {
  value = azurerm_storage_account.this.primary_web_internet_endpoint
}

# Primary web internet host
output "primary_web_internet_host" {
  value = azurerm_storage_account.this.primary_web_internet_host
}

# Primary web Microsoft endpoint
output "primary_web_microsoft_endpoint" {
  value = azurerm_storage_account.this.primary_web_microsoft_endpoint
}

# Primary web Microsoft host
output "primary_web_microsoft_host" {
  value = azurerm_storage_account.this.primary_web_microsoft_host
}


## Secondary Access Information (For GRS/RAGRS accounts)


# Secondary access key
output "secondary_access_key" {
  value     = azurerm_storage_account.this.secondary_access_key
  sensitive = true
}

# Secondary blob connection string
output "secondary_blob_connection_string" {
  value     = azurerm_storage_account.this.secondary_blob_connection_string
  sensitive = true
}

# Secondary blob endpoint
output "secondary_blob_endpoint" {
  value = azurerm_storage_account.this.secondary_blob_endpoint
}

# Secondary blob host
output "secondary_blob_host" {
  value = azurerm_storage_account.this.secondary_blob_host
}

# Secondary blob internet endpoint
output "secondary_blob_internet_endpoint" {
  value = azurerm_storage_account.this.secondary_blob_internet_endpoint
}

# Secondary blob internet host
output "secondary_blob_internet_host" {
  value = azurerm_storage_account.this.secondary_blob_internet_host
}

# Secondary blob Microsoft endpoint
output "secondary_blob_microsoft_endpoint" {
  value = azurerm_storage_account.this.secondary_blob_microsoft_endpoint
}

# Secondary blob Microsoft host
output "secondary_blob_microsoft_host" {
  value = azurerm_storage_account.this.secondary_blob_microsoft_host
}

# Secondary connection string
output "secondary_connection_string" {
  value     = azurerm_storage_account.this.secondary_connection_string
  sensitive = true
}

# Secondary DFS endpoint
output "secondary_dfs_endpoint" {
  value = azurerm_storage_account.this.secondary_dfs_endpoint
}

# Secondary DFS host
output "secondary_dfs_host" {
  value = azurerm_storage_account.this.secondary_dfs_host
}

# Secondary DFS internet endpoint
output "secondary_dfs_internet_endpoint" {
  value = azurerm_storage_account.this.secondary_dfs_internet_endpoint
}

# Secondary DFS internet host
output "secondary_dfs_internet_host" {
  value = azurerm_storage_account.this.secondary_dfs_internet_host
}

# Secondary DFS Microsoft endpoint
output "secondary_dfs_microsoft_endpoint" {
  value = azurerm_storage_account.this.secondary_dfs_microsoft_endpoint
}

# Secondary DFS Microsoft host
output "secondary_dfs_microsoft_host" {
  value = azurerm_storage_account.this.secondary_dfs_microsoft_host
}

# Secondary file endpoint
output "secondary_file_endpoint" {
  value = azurerm_storage_account.this.secondary_file_endpoint
}

# Secondary file host
output "secondary_file_host" {
  value = azurerm_storage_account.this.secondary_file_host
}

# Secondary file internet endpoint
output "secondary_file_internet_endpoint" {
  value = azurerm_storage_account.this.secondary_file_internet_endpoint
}

# Secondary file internet host
output "secondary_file_internet_host" {
  value = azurerm_storage_account.this.secondary_file_internet_host
}

# Secondary file Microsoft endpoint
output "secondary_file_microsoft_endpoint" {
  value = azurerm_storage_account.this.secondary_file_microsoft_endpoint
}

# Secondary file Microsoft host
output "secondary_file_microsoft_host" {
  value = azurerm_storage_account.this.secondary_file_microsoft_host
}

# Secondary location
output "secondary_location" {
  value = azurerm_storage_account.this.secondary_location
}

# Secondary queue endpoint
output "secondary_queue_endpoint" {
  value = azurerm_storage_account.this.secondary_queue_endpoint
}

# Secondary queue host
output "secondary_queue_host" {
  value = azurerm_storage_account.this.secondary_queue_host
}

# Secondary queue Microsoft endpoint
output "secondary_queue_microsoft_endpoint" {
  value = azurerm_storage_account.this.secondary_queue_microsoft_endpoint
}

# Secondary queue Microsoft host
output "secondary_queue_microsoft_host" {
  value = azurerm_storage_account.this.secondary_queue_microsoft_host
}

# Secondary table endpoint
output "secondary_table_endpoint" {
  value = azurerm_storage_account.this.secondary_table_endpoint
}

# Secondary table host
output "secondary_table_host" {
  value = azurerm_storage_account.this.secondary_table_host
}

# Secondary table Microsoft endpoint
output "secondary_table_microsoft_endpoint" {
  value = azurerm_storage_account.this.secondary_table_microsoft_endpoint
}

# Secondary table Microsoft host
output "secondary_table_microsoft_host" {
  value = azurerm_storage_account.this.secondary_table_microsoft_host
}

# Secondary web endpoint
output "secondary_web_endpoint" {
  value = azurerm_storage_account.this.secondary_web_endpoint
}

# Secondary web host
output "secondary_web_host" {
  value = azurerm_storage_account.this.secondary_web_host
}

# Secondary web internet endpoint
output "secondary_web_internet_endpoint" {
  value = azurerm_storage_account.this.secondary_web_internet_endpoint
}

# Secondary web internet host
output "secondary_web_internet_host" {
  value = azurerm_storage_account.this.secondary_web_internet_host
}

# Secondary web Microsoft endpoint
output "secondary_web_microsoft_endpoint" {
  value = azurerm_storage_account.this.secondary_web_microsoft_endpoint
}

# Secondary web Microsoft host
output "secondary_web_microsoft_host" {
  value = azurerm_storage_account.this.secondary_web_microsoft_host
}


## Additional Configuration
# Shared access key enabled
output "shared_access_key_enabled" {
  value = azurerm_storage_account.this.shared_access_key_enabled
}

# Resource group name
output "resource_group_name" {
  value = azurerm_storage_account.this.resource_group_name
}

# Tags
output "tags" {
  value = azurerm_storage_account.this.tags
}

