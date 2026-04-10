# Output the SQL Managed Instance name and ID
output "sql_managed_instance_name" {
  description = "Name of the SQL Managed Instance"
  value       = azurerm_mssql_managed_instance.sql-mi.name
}

output "sql_managed_instance_id" {
  description = "ID of the SQL Managed Instance"
  value       = azurerm_mssql_managed_instance.sql-mi.id
}

output "sql_managed_instance_identity" {
  description = "ID of the SQL Managed Instance"
  value       = azurerm_mssql_managed_instance.sql-mi.identity
}

output "sql_mi_public_endpoint" {
  value = azurerm_mssql_managed_instance.sql-mi.fqdn
}