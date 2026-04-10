# locals.tf
# Generates dynamic names and configuration for each Key Vault based on mapping
locals {
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"
  resource_group_name = var.name_config.kv_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_kv[0].name

  keyvault_for_each = {
    for key, keyVault_config in var.keyvault_mapping : key => {
      key_vault_name                  = keyVault_config.name
      key_vault_config                = keyVault_config.key_vault_config
      key_vault_private_endpoint_name = "pep-${lower(keyVault_config.name)}"
      private_service_connection_name = "psckv-${lower(keyVault_config.name)}"
      private_dns_zone_group_name     = "pdnsgkv-${lower(keyVault_config.name)}"
      key_vault_subresource_names     = ["vault"]
    }
  }

  keyvault_private_endpoints_for_each = (var.public_network_access_enabled == false  ? local.keyvault_for_each : {})
}
