output "app_service_plan_id" {
  description = "The ID of the created App Service Plan."
  value       = azurerm_service_plan.asp.id
}

output "app_service_plan_name" {
  description = "The name of the created App Service Plan."
  value       = azurerm_service_plan.asp.name
}
