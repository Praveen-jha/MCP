#locals.tf
# Determines the appropriate resource group name based on Key Vault creation mode
locals {
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"
  resource_group_name = var.name_config.kv_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_kv[0].name


  key_vault_name                  = "kv-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}kp1"
  key_vault_private_endpoint_name = "pepkv-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_service_connection_name = "psckv-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_dns_zone_group_name     = "pdnsgkv-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  key_vault_subresource_names     = ["vault"]
}
