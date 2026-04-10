# #Local Block for Resource Naming Conventions
# locals {
#   # resource_group_name = var.name_config.data_factory_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_data_factory[0].name
#   base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

#   data_factory_name = "adf-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
#   ssis_integration_runtime_name = "ssis-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
#   data_factory_private_endpoint_name = "pep-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
#   azurerm_data_factory_managed_private_endpoint_name = "adf-mpe-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
#   private_service_connection_name   = "psc-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
#   private_dns_zone_group_name       = "pdnsg-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
#   data_factory_subresource_names     = ["dataFactory"]

# }

# Local values to determine target resource IDs from existing resources
locals {
  target_resource_ids = {
    for k, v in var.existing_target_resources : k => (
      v.type == "storage_account" ? data.azurerm_storage_account.existing_storage[k].id :
      v.type == "key_vault"       ? data.azurerm_key_vault.existing_keyvault[k].id :
      v.type == "sql_mi"          ? data.azurerm_mssql_managed_instance.existing_sql_mi[k].id :
      null
    )
  }
}
