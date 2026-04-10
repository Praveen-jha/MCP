#Local Block for Resource Naming Conventions
locals {
  # resource_group_name  = var.name_config.resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group[0].name
  # virtual_network_name = var.name_config.virtual_network_creation == "new" ? module.virtual_network[0].virtual_network_name : data.azurerm_virtual_network.existing_vnet[0].name

  base_name1 = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  new_resource_group_name          = "rg-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  new_virtual_network_name         = "vnet-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  new_private_endpoint_subnet_name = "snet-${local.base_name1}-${var.network.private_endpoint_subnet_application}-${var.name_config.region_flag}-${var.name_config.instance}"
  new_outbound_subnet_name         = "snet-${local.base_name1}-${var.network.outbound_subnet_application}-${var.name_config.region_flag}-${var.name_config.instance}"

  app_service_plan_name = "asp-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}"
  windows_web_app_name  = "webapp-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}av"
}
