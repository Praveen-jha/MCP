output "subnetName" {
  value       = azurerm_subnet.subnets.name
  description = "The name of the Azure Subnet."
}

output "subnetId" {
  value       = azurerm_subnet.subnets.id
  description = "The ID of the Azure Subnet."
}
