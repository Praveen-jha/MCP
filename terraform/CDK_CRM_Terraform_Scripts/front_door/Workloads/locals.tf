locals {
  name_config               = "${var.name_config.identity}-${var.name_config.businessunit}-${var.name_config.environment}-${var.name_config.locationflag}"
  build_resource_group_name = "rg-${local.name_config}-01"
  resource_group_name       = var.resource_group_name == "" ? local.build_resource_group_name : var.resource_group_name
}
