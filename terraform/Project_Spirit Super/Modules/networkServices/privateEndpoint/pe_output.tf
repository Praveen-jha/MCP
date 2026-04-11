output "pepName" {
  value = azurerm_private_endpoint.private_endpoint.name
  description = "name of the private end point"
}

output "pepId" {
  value = azurerm_private_endpoint.private_endpoint.id
  description = "id of the private end point"
}
