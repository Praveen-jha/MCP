output "logic_app_storage_account" {
  description = "Output: Logic App Storage Account"
  value       = azurerm_storage_account.logic_app_storage_account
}
output "app_service_plan" {
  description = "Output: App Service Plan"
  value       = azurerm_service_plan.logic_app_plan
}
output "logic_app" {
  description = "Output: Logic App"
  value       = azurerm_logic_app_standard.logic_app
}
