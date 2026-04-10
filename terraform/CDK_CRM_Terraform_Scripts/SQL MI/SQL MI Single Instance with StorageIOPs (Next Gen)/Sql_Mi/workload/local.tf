#Local Block for Resource Naming Conventions
locals {
  base_name1                    = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"
  new_sql_managed_instance_name = "sqlmi-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}hn2"

  sql_mi_private_endpoint_name           = "pep-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_service_connection_name        = "psc-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  sql_managed_instance_subresource_names = ["managedInstance"]
}
