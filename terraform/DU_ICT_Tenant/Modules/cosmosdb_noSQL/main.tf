# Resource block Azure Cosmos DB
resource "azurerm_cosmosdb_account" "db" {
  name                          = var.cosmosdb_account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  offer_type                    = var.cosmosdb_account_offer_type
  kind                          = var.cosmosdb_account_kind
  public_network_access_enabled = var.public_network_access_enabled
  # key_vault_key_id              = var.key_vault_key_id

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

  timeouts {
    create = "30m" # Timeout for creating the resource
    update = "30m" # Timeout for updating the resource
    delete = "30m" # Timeout for deleting the resource
  }

  lifecycle {
    ignore_changes = all # Ignores all changes to this resource
  }

  tags = var.cosmos_nosql_tags

}

# Define the Cosmos DB database
resource "azurerm_cosmosdb_sql_database" "cosmosdb_sql_database" {
  name                = var.nosql_database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  lifecycle {
    ignore_changes = all
  }
}
