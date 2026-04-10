#Creation of Resource Group
module "resource_group" {
  source                  = "../../Modules/terraform-azure-resource-group-module"
  count                   = var.name_config.storage_account_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_storage_account_resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

#Creation of Storage Account
module "storage_account" {
  source                        = "../../Modules/terraform-azure-storage-account-module"
  storage_account_name          = local.storage_account_name
  resource_group_name           = local.resource_group_name
  location                      = var.location
  account_tier                  = var.storage_account.account_tier
  account_replication_type      = var.storage_account.account_replication_type
  account_kind                  = var.storage_account.account_kind
  public_network_access_enabled = var.public_network_access_enabled
  is_hns_enabled                = var.storage_account.is_hns_enabled
  tags                          = var.tags
}

#Creation of Private Endpoint of Storage Account
module "storage_account_private_endpoint" {
  source                          = "../../Modules/terraform-azure-private-endpoint-module"
  count                           = (var.public_network_access_enabled == false) ? 1 : 0
  private_endpoint_name           = local.storage_account_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = local.private_service_connection_name
  subresource_names               = local.storage_account_subresource_names
  private_connection_resource_id  = module.storage_account.storage_account_id
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_group_name     = local.private_dns_zone_group_name
  private_dns_zone_ids            = var.storage_account_private_dns_zone_ids
  depends_on                      = [module.storage_account]
}
