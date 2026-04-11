output "function_app_name" {
  description = "The name of the Function App"
  value       = azurerm_linux_function_app.function_app_linux.name
}
output "function_app_id" {
  description = "The ID of the Function App"
  value       = azurerm_linux_function_app.function_app_linux.id
}
