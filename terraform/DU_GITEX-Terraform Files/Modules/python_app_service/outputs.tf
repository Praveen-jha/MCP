output "app_service_id" {
  value = azurerm_linux_web_app.python_app_service.id
}

output "python_app_service_plan_id" {
  value = azurerm_service_plan.python_app_service_plan.id
}