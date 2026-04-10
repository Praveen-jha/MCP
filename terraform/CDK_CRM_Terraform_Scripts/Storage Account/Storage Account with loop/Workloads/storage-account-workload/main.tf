#Creation of Resource Group
module "resource_group" {
  source                  = "../../Modules/terraform-azure-resource-group-module"
  count                   = var.name_config.storage_account_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_storage_account_resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

#Module for Storage Account Creation
module "storage_account" {
  source                        = "../../Modules/terraform-azure-storage-account-module"
  for_each                      = local.storage_account_for_each
  storage_account_name          = each.value.storage_account_name
  resource_group_name           = local.resource_group_name
  location                      = var.location
  account_tier                  = each.value.storage_account.account_tier
  account_replication_type      = each.value.storage_account.account_replication_type
  account_kind                  = each.value.storage_account.account_kind
  public_network_access_enabled = var.public_network_access_enabled
  is_hns_enabled                = each.value.storage_account.is_hns_enabled
  tags                          = var.tags
}

#Module for Private Endpoint Creation for Storage Account
# This module creates private endpoints for storage accounts if public network access is disabled.
module "storage_account_private_endpoint" {
  source                          = "../../Modules/terraform-azure-private-endpoint-module"
  for_each                        = local.storage_account_private_endpoints_for_each
  private_endpoint_name           = each.value.storage_account_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = each.value.private_service_connection_name
  subresource_names               = each.value.storage_account_subresource_names
  private_connection_resource_id  = module.storage_account[each.key].storage_account_id
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_group_name     = each.value.private_dns_zone_group_name
  private_dns_zone_ids            = var.storage_account_private_dns_zone_ids
  depends_on                      = [module.storage_account]
}

