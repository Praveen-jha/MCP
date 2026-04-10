output "id" {
  description = "The Container Registry ID"
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "The Container Registry Name."
  value       = azurerm_container_registry.this.name
}
