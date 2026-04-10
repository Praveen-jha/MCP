output "routeTableName" {
  value       = azurerm_route_table.route_table.name
  description = "The name of the Azure Route Table."
}

output "routeTableId" {
  value       = azurerm_route_table.route_table.id
  description = "The ID of the Azure Route Table."
}
