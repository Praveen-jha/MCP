output "cosmos_db_id" {
  description = "The unique identifier of the Cosmos DB account."
  value       = azurerm_cosmosdb_account.db.id
}
