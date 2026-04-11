output "route_table_name" {
  value       = azurerm_route_table.route_table.name
  description = "The name of the Azure Route Table."
}

output "route_table_id" {
  value       = azurerm_route_table.route_table.id
  description = "The ID of the Azure Route Table."
}
