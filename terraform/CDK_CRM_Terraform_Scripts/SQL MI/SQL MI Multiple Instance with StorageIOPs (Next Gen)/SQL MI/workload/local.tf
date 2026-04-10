#Local Block for Resource Naming Conventions
locals {
  base_name1 = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  sql_mis_for_each = {
    for key, mi_config in var.sql_mi_mapping : key => {
      sql_mi_name   = mi_config.name
      sql_mi_base   = mi_config.sql_mi_base
      sql_mi_config = mi_config.sql_mi_config
      sku           = mi_config.sku

      sql_mi_private_endpoint_name           = "pep-${lower(mi_config.name)}-sqlmi"
      private_service_connection_name        = "psc-${lower(mi_config.name)}-sqlmi"
      sql_managed_instance_subresource_names = ["managedInstance"]
    }
  }

  sql_mi_private_endpoints_same_vnet_for_each = (var.public_network_access_enabled == true) || (var.private_endpoint_same_vnet == false) ? {} : local.sql_mis_for_each

  sql_mi_private_endpoints_diff_vnet_for_each = (var.public_network_access_enabled == true) || (var.private_endpoint_diff_vnet == false) ? {} : local.sql_mis_for_each
}
