# Local Block for Resource Naming Conventions
#Local Block for Resource Naming Conventions
locals {
  resource_group_name = var.name_config.storage_account_resource_group_creation == "new" ? var.new_storage_account_resource_group_name : data.azurerm_resource_group.existing_resource_group_storage_account[0].name
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  # Keep your existing storage account name logic unchanged
  raw_storage_name     = "strg${local.base_name1}${var.name_config.application}${var.name_config.region_flag}${var.name_config.instance}30"
  clean_storage_name   = replace(replace(lower(local.raw_storage_name), "-", ""), "_", "")
  storage_account_name = substr(local.clean_storage_name, 0, 24)

  storage_account_for_each = {
    for key, storage_config in var.storage_account_mapping : key => {
      storage_account_name = storage_config.name != null ? storage_config.name : local.storage_account_name
      storage_account      = storage_config.storage_account
    
      
      storage_account_private_endpoint_name = "pep-${lower(storage_config.name)}"
      private_service_connection_name       = "psc-${lower(storage_config.name)}"
      private_dns_zone_group_name           = "pdnsg-${lower(storage_config.name)}"
      storage_account_subresource_names     =  ["blob"]
    }
  }

  storage_account_private_endpoints_for_each = var.public_network_access_enabled == false ? local.storage_account_for_each : {}
}