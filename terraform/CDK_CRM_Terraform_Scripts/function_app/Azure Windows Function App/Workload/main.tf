## Azure Windows Function App Deployment using Terraform
module "storage_account" {
  source                   = "../Modules/terraform-azure-storage-account-module"
  storage_account_name     = local.storage_account_name
  resource_group_name      = data.azurerm_resource_group.existing_resource_group[0].name
  location                 = data.azurerm_resource_group.existing_resource_group[0].location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  
}

module "service_plan" {
  source                = "../Modules/terraform-azure-app-service-plan-module"
  app_service_plan_name = local.app_service_plan_name
  resource_group_name   = data.azurerm_resource_group.existing_resource_group[0].name
  location              = data.azurerm_resource_group.existing_resource_group[0].location
  os_type               = var.os_type
  sku_name              = var.sku_name
  depends_on = [ module.storage_account ]

}

module "windows_function_app" {
  source = "../Modules/terraform-azure-windows-function-app-module"
  function_app_name    = local.function_app_name         
  resource_group_name = data.azurerm_resource_group.existing_resource_group[0].name
  location = data.azurerm_resource_group.existing_resource_group[0].location
  storage_account_name = module.storage_account.storage_account_name
  storage_account_access_key = module.storage_account.primary_access_key
  service_plan_id = module.service_plan.app_service_plan_id

depends_on = [ module.storage_account,module.service_plan ]
  
}


