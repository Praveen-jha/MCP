#Creation of Resource Group
module "resource_group" {
  source                  = "../../Modules/terraform-azure-resource-group-module"
  count                   = var.name_config.kv_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_kv_resource_group_name
  resource_group_location = var.location
  resource_group_tags     = var.tags
}

#Creation of Key Vault This module creates
module "key_vault" {
  source                        = "../../Modules/terraform-azure-key-vault-module"
  for_each                      = local.keyvault_for_each
  create_kv                     = each.value.key_vault_config.create_kv
  location                      = var.location
  resource_group_name           = local.resource_group_name
  key_vault_name                = each.value.key_vault_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = each.value.key_vault_config.sku_name
  enable_rbac_authorization     = each.value.key_vault_config.enable_rbac_authorization
  enabled_for_disk_encryption   = each.value.key_vault_config.enabled_for_disk_encryption
  purge_protection_enabled      = each.value.key_vault_config.purge_protection_enabled
  soft_delete_retention_days    = each.value.key_vault_config.soft_delete_retention_days
  public_network_access_enabled = var.public_network_access_enabled
  key_vault_roles               = var.key_vault_roles
  principal_id                  = data.azurerm_client_config.current.object_id
  tags                          = var.tags
  depends_on                    = [module.resource_group]
}

# This module creates Private Endpoints for Key Vault.
module "kv_private_endpoint" {
  source                          = "../../Modules/terraform-azure-private-endpoint-module"
  for_each                        = local.keyvault_private_endpoints_for_each
  private_endpoint_name           = each.value.key_vault_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = each.value.private_service_connection_name
  subresource_names               = each.value.key_vault_subresource_names
  private_connection_resource_id  = module.key_vault[each.key].key_vault_id
  enable_private_dns_zone_group   = var.keyvault_private_endpoint_config.enable_private_dns_zone_group
  private_dns_zone_group_name     = each.value.private_dns_zone_group_name
  private_dns_zone_ids            = var.keyvault_private_endpoint_config.private_dns_zone_ids
  tags                            = var.tags
  depends_on                      = [module.key_vault]
}


