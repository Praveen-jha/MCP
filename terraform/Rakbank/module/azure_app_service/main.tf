resource "azurerm_service_plan" "asp" {
  name                         = var.app_service_plan_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku_name
  os_type                      = var.os_type
  zone_balancing_enabled       = var.zone_balancing_enabled
  tags                         = var.tags
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
}
