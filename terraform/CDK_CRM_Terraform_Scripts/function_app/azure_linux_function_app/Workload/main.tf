## Azure Linux Function App Deployment using Terraform
module "storage_account" {
  source                   = "../Modules/terraform-azure-storage-account-module"
  storage_account_name     = local.storage_account_name
  resource_group_name      = data.azurerm_resource_group.existing_resource_group[0].name
  location                 = data.azurerm_resource_group.existing_resource_group[0].location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type

}

module "app_service_plan" {
  source                = "../Modules/terraform-azure-app-service-plan-module"
  app_service_plan_name = local.app_service_plan_name
  resource_group_name   = data.azurerm_resource_group.existing_resource_group[0].name
  location              = data.azurerm_resource_group.existing_resource_group[0].location
  os_type               = var.os_type
  sku_name              = var.sku_name
  depends_on            = [ module.storage_account]

}

module "linux_function_app" {
  source                        = "../Modules/terraform-azure-linux-function-app-module"
  name                          = local.function_app_name
  resource_group_name           = data.azurerm_resource_group.existing_resource_group[0].name
  location                      = data.azurerm_resource_group.existing_resource_group[0].location
  storage_account_name          = module.storage_account.storage_account_name
  storage_account_access_key    = module.storage_account.primary_access_key
  service_plan_id               = module.app_service_plan.app_service_plan_id
  public_network_access_enabled = var.public_network_access_enabled
  # VNet Integration
  virtual_network_subnet_id = var.web_app_vnet_integration_enable ? data.azurerm_subnet.existing_outbound_subnet[0].id : null
  #Add Subnet delegation "Microsoft.Web/serverFarms" to subnet for vnet integration of functions app

  depends_on = [ module.storage_account, module.app_service_plan]

}

module "azurerm_private_endpoint" {
  source                          = "../Modules/terraform-azure-private-endpoint-module"
  private_endpoint_name           = local.function_app_private_endpoint_name
  location                        = data.azurerm_resource_group.existing_resource_group[0].location
  resource_group_name             = data.azurerm_resource_group.existing_resource_group[0].name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = local.private_service_connection_name
  private_connection_resource_id  = module.linux_function_app.id
  subresource_names               = local.subresource_names
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_group_name     = local.private_dns_zone_group_name
  private_dns_zone_ids            = var.private_dns_zone_id
  depends_on                      = [module.linux_function_app, module.app_service_plan]
}

