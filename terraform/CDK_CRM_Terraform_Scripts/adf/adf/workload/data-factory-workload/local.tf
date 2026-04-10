#Local Block for Resource Naming Conventions
locals {
  resource_group_name = var.name_config.data_factory_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_data_factory[0].name
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  data_factory_name = "adf-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"

  data_factory_private_endpoint_name = "pep-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_service_connection_name   = "psc-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_dns_zone_group_name       = "pdnsg-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  data_factory_subresource_names     = ["dataFactory"]

}
