#Terraform code defines an Azure App Service Plan resource using the azurerm_service_plan block. An App Service Plan determines the region, pricing tier, scaling options, and underlying compute resources for hosting Azure Web Apps, Functions, or APIs.
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/4.21.1/docs/resources/service_plan

resource "azurerm_service_plan" "this" {
  name                            = var.app_service_plan_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  os_type                         = var.os_type
  sku_name                        = var.sku_name
  app_service_environment_id      = var.app_service_environment_id
  maximum_elastic_worker_count    = var.maximum_elastic_worker_count
  worker_count                    = var.worker_count
  per_site_scaling_enabled        = var.per_site_scaling_enabled
  zone_balancing_enabled          = var.zone_balancing_enabled
  premium_plan_auto_scale_enabled = var.premium_plan_auto_scale_enabled
  tags                            = var.tags
}
