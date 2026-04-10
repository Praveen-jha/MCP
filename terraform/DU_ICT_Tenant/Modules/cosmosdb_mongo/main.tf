# Resource block Azure Cosmos DB
resource "azurerm_cosmosdb_account" "db" {
  name                          = var.cosmosdb_account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  offer_type                    = var.cosmosdb_account_offer_type
  kind                          = var.cosmosdb_account_kind
  public_network_access_enabled = var.public_network_access_enabled
  # key_vault_key_id              = var.key_vault_key_id

  capabilities {
    name = var.cosmosdb_account_capabilities
  }

  consistency_policy {
    consistency_level = var.cosmosdb_account_consistency_level
  }

  geo_location {
    location          = var.cosmosdb_account_geo_location_primary # Primary region
    failover_priority = var.cosmosdb_account_failover_priority_primary
  }

  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled

  identity {
    type         = var.cosmosdb_identity_type
    identity_ids = var.cosmosdb_identity_type == "SystemAssigned" ? [] : var.cosmosdb_identity_id
  }

  lifecycle {
    ignore_changes = all # Ignores all changes to this resource
  }

  timeouts {
    create = "30m" # Timeout for creating the resource
    update = "30m" # Timeout for updating the resource
    delete = "30m" # Timeout for deleting the resource
  }

  tags = var.cosmos_mongodb_tags
}

resource "azurerm_cosmosdb_mongo_database" "mongo_database" {
  name                = var.mongo_database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  throughput          = var.throughput
  lifecycle {
    ignore_changes = all # Ignores all changes to this resource
  }
}
