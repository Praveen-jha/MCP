output "containerName" {
  value = azurerm_storage_container.new_container.name
  description = "Output of container name"
}
