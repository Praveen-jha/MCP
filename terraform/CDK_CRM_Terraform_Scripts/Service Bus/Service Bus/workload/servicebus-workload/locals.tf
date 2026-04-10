#Local Block for Resource Naming Conventions
locals {
  resource_group_name = var.name_config.servicebus_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_servicebus[0].name

  base_name1 = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  servicebus_name        = "service-bus-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  service_bus_private_endpoint_name = "pepsb-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_service_connection_name   = "pscsb-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_dns_zone_group_name       = "pdnsgsb-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  service_bus_subresource_names     = ["namespace"]
}
