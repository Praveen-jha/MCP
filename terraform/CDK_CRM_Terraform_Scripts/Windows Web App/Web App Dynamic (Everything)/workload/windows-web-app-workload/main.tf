#Creation of App Service Plan
module "app_service_plan" {
  source                = "../../module/terraform-azure-app-service-plan-module"
  app_service_plan_name = local.app_service_plan_name
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.existing_resource_group[0].name
  sku_name              = var.app_service_plan_sku_name
  os_type               = var.app_service_plan_os_type
  tags                  = var.tags
}

#Creation of Windows Web App
module "windows_web_app" {
  source                        = "../../module/terraform-azure-windows-web-app-module"
  windows_web_app_name          = local.windows_web_app_name
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.existing_resource_group[0].name
  service_plan_id               = module.app_service_plan.app_service_plan_id
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = data.azurerm_subnet.existing_outbound_subnet[0].id
  site_config                   = var.windows_web_app_site_config
  client_affinity_enabled       = true
  https_only                    = true
}
