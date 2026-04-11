output "sql_server_id" {
  description = "The ID of the Azure SQL Server."
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_principle_id" {
  description = "The Principal ID of the managed identity associated with the Azure SQL Server."
  value       = azurerm_mssql_server.sql_server.identity[0].principal_id
}
