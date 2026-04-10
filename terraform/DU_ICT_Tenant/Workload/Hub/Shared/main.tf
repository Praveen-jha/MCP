# ......................................................
# Creating New Resource Group
# ......................................................

module "RG" {
  source                  = "../../../Modules/rg"
  resource_group_name     = local.LA_rg_name
  resource_group_location = var.rg_location
}

# ......................................................
# Creating New Log Analytics workspace
# ......................................................

module "LA" {
  source                  = "../../../Modules/monitoring/logAnalyticsWorkspace"
  log_resource_group_name = local.resource_group_name
  log_workspace_name      = local.log_workspace_name
  log_location            = local.location
  log_retention_in_days   = var.log_retention_in_days
  logAnalytics_tags       = var.logAnalytics_tags
} 

# # ......................................................
# # Creating Private Endpoint for tfstate Storage Blob
# # ......................................................

# module "private_endpoint_sa_blob" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   resource_group_name                  = var.pep_resource_group_name
#   location                             = local.location
#   private_endpoint_name                = local.sa_blob_private_endpoint_name
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = local.private_service_connection_name
#   private_connection_resource_id       = data.azurerm_storage_account.sa.id
#   private_connection_subresource_names = local.sa_blob_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.sa_blob_private_dns_zone_id
# }