output "cosmos_db_id" {
  value = azurerm_cosmosdb_account.db.id
}

output "cosmos_db_connection_string" {
  value = azurerm_cosmosdb_account.db.primary_sql_connection_string
}

output "cosmos_db_key" {
  value = azurerm_cosmosdb_account.db.primary_key
}

output "cosmos_db_uri" {
  value = azurerm_cosmosdb_account.db.endpoint
}