# # ......................................................
# # Creating New Resource Group
# # ......................................................
# module "rg" {
#   source                  = "../../../Modules/rg"
#   resource_group_name     = local.application_rg_name
#   resource_group_location = var.location
# }

# # ......................................................
# # Creating logic app
# # ......................................................
# module "logic_app" {
#   source                        = "../../../Modules/logicApp"
#   logic_app_name                = local.logic_app_name
#   logic_app_location            = var.location
#   logic_app_resource_group_name = local.application_rg_name
#   logic_app_tags                = var.tags
#   depends_on                    = [module.rg]
# }

# # ......................................................
# # Creating diagnostic settings for logic app
# # ......................................................
# module "logic_app_ds" {
#   source                     = "../../../Modules/monitoring/diagnosticSettings"
#   diagnostic_setting_name    = local.diagnostic_setting_name
#   target_resource_id         = module.logic_app.logic_app_id
#   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
#   enabled_log                = local.log_category
#   metric                     = coalesce(local.metrics, [""])
#   depends_on                 = [module.logic_app]
# }

# # ......................................................
# # Creating API Management service
# # ......................................................
# # module "apim" {
# #   source = "../../../Modules/API Management"
# #   apim_name = var.apim_name
# #   apim_location = var.location
# #   apim_resource_group_name = local.application_rg_name
# #   apim_publisher_name = var.apim_publisher_name
# #   apim_publisher_email = var.apim_publisher_email
# #   apim_sku = var.apim_sku
# #   apim_virtual_network_type = var.apim_virtual_network_type
# #   apim_public_network_access_enabled = var.apim_public_network_enabled
# #   apim_subnet_id = data.azurerm_subnet.apim_subnet.id
# #   apim_tags = var.apim_tags
# # }
