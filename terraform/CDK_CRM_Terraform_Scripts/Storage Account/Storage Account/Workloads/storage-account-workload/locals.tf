locals {
  resource_group_name = var.name_config.storage_account_resource_group_creation == "new" ? var.new_storage_account_resource_group_name : data.azurerm_resource_group.existing_resource_group_storage_account[0].name
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"
  
  # Storage account naming logic (keeping your existing logic)
  raw_storage_name     = "strg${local.base_name1}${var.name_config.application}${var.name_config.region_flag}${var.name_config.instance}"
  clean_storage_name   = replace(replace(lower(local.raw_storage_name), "-", ""), "_", "")
  storage_account_name = substr(local.clean_storage_name, 0, 24)
  
  # Private endpoint naming (following Redis pattern)
  storage_account_private_endpoint_name = "pep-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_service_connection_name       = "psc-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_dns_zone_group_name           = "pdnsg-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  storage_account_subresource_names     = ["blob"]
}
