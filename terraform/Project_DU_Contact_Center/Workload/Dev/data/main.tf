# # ......................................................
# # Creating New Resource Group
# # ......................................................
# module "rg" {
#   source                  = "../../../Modules/rg"
#   count                   = var.rg_creation == "new" ? 1 : 0
#   resource_group_name     = local.dev_data_rg_name
#   resource_group_location = var.location
#   resource_group_tags     = var.resource_group_tags
# }



# # ......................................................
# # Creating diagnostic settings for storage accounts
# # # ......................................................
# # module "storage_account_ds" {
# #   source                     = "../../../Modules/monitoring/diagnosticSettings"
# #   for_each                   = local.storage_accounts
# #   diagnostic_setting_name    = "${each.value.storage_account_name}DiagToLAWorkspace"
# #   target_resource_id         = module.adls[each.key].storage_account_id
# #   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
# #   enabled_log                = local.log_category
# #   metric                     = coalesce(local.metrics, [""])
# #   depends_on                 = [module.adls]
# # }


# # ......................................................
# # Creating Key Vault
# # ......................................................

# module "keyvault" {
#   source                        = "../../../Modules/kv/keyvault"
#   key_vault_name                = local.key_vault_config.key_vault.kv_name
#   location                      = var.location
#   resource_group_name           = local.dev_data_rg_name
#   sku_name                      = var.key_vault_sku_name
#   enabled_for_disk_encryption   = local.key_vault_config.key_vault.enabled_for_disk_encryption
#   purge_protection_enabled      = local.key_vault_config.key_vault.purge_protection_enabled
#   public_network_access_enabled = local.key_vault_config.key_vault.public_network_access_enabled_kv
#   soft_delete_retention_days    = local.key_vault_config.key_vault.soft_delete_retention_days
#   tags                          = local.key_vault_config.key_vault.tags
#   depends_on                    = [module.rg]
# }

# # ......................................................
# # Creating Private Endpoint for Key Vault
# # ......................................................

# module "private_endpoint_kv" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   resource_group_name                  = local.dev_data_rg_name
#   location                             = var.location
#   private_endpoint_name                = "${local.key_vault_config.key_vault.kv_name}-pep"
#   subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet.id
#   private_service_connection_name      = "${local.key_vault_config.key_vault.kv_name}-psc"
#   private_connection_resource_id       = module.keyvault.key_vault_id
#   private_connection_subresource_names = local.key_vault_config.key_vault.key_vault_subresource_names
#   is_manual_connection                 = local.is_manual_connection
#   private_dns_zone_group_name          = local.private_dns_zone_group_name
#   private_dns_zone_ids                 = var.key_vault_private_dns_zone_id
#   depends_on                           = [module.keyvault]
# }

# # ......................................................
# # Creating Key Vault keys
# # ......................................................

# # module "kv_keys" {
# #   for_each     = local.key_names
# #   source       = "../../../Modules/kv/keys"
# #   key_name     = each.value
# #   key_opts     = var.key_opts
# #   key_size     = var.key_size
# #   key_type     = var.key_type
# #   key_vault_id = module.keyvault.key_vault_id
# #   depends_on   = [module.keyvault, module.rg, module.role_assignment_umid, module.role_assignment_user]
# # }

# # ......................................................
# # Creating Key Vault Secret
# # ......................................................

# # module "kv_secret" {
# #   for_each     = { for secret in local.secrets : secret.secret_name => secret }
# #   source       = "../../../Modules/kv/secrets"
# #   key_vault_id = module.keyvault.key_vault_id
# #   secret_name  = each.value.secret_name
# #   secret_value = each.value.secret_value
# #   depends_on   = [module.keyvault, module.adls, module.cosmos_nosql]
# # }

# # ......................................................
# # # Creating User Managed Identity
# # # ......................................................

# # module "user_managed_identity" {
# #   source              = "../../../Modules/umid"
# #   resource_group_name = local.rg_name
# #   location            = var.location
# #   umid_name           = local.umid_name
# #   depends_on          = [module.rg]
# # }

# # ......................................................
# # # Creating Role Assignment UMID
# # # ......................................................

# # module "role_assignment_umid" {
# #   source               = "../../../Modules/roleAssignment"
# #   role_definition_name = local.kv_role_definition_name
# #   scope                = module.keyvault.key_vault_id
# #   principal_id         = module.user_managed_identity.umid_principal_id
# #   depends_on           = [module.rg, module.keyvault, module.user_managed_identity]
# # }

# # # ......................................................
# # # Creating Role Assignment Service Principal
# # # ......................................................

# # module "role_assignment_user" {
# #   source               = "../../../Modules/roleAssignment"
# #   role_definition_name = local.kv_role_definition_name
# #   scope                = module.keyvault.key_vault_id
# #   principal_id         = data.azurerm_client_config.current.object_id
# #   depends_on           = [module.rg, module.keyvault]
# # }

# # # ......................................................
# # # Creating Role Assignment Service Principal
# # # ......................................................

# # module "role_assignment_user_02" {
# #   source               = "../../../Modules/roleAssignment"
# #   role_definition_name = local.kv_role_secrets_definition_name
# #   scope                = module.keyvault.key_vault_id
# #   principal_id         = data.azurerm_client_config.current.object_id
# #   depends_on           = [module.rg, module.keyvault]
# # }

