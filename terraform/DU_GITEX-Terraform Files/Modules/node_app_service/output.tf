output "node_app_id" {
  value = azurerm_windows_web_app.node_app_service.id
}

output "node_app_service_plan_id" {
  value = azurerm_service_plan.node_app_service_plan.id
}