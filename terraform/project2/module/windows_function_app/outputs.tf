# Output.tf
output "function_app_name" {
  description = "The name of the Function App"
  value       = azurerm_windows_function_app.function_app_windows.name
}
output "function_app_id" {
  description = "The ID of the Function App"
  value       = azurerm_windows_function_app.function_app_windows.id
}
