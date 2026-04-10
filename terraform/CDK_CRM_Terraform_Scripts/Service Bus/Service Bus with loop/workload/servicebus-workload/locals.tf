#Local Block for Resource Naming Conventions
locals {
  resource_group_name = var.name_config.servicebus_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_servicebus[0].name
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  service_bus_for_each = {
    for key, servicebus_config in var.servicebus_mapping : key => {
      servicebus_name      = servicebus_config.name
      servicebus_namespace = servicebus_config.servicebus_namespace

      service_bus_private_endpoint_name = "pep-${lower(servicebus_config.name)}"
      private_service_connection_name   = "psc-${lower(servicebus_config.name)}"
      private_dns_zone_group_name       = "pdnsg-${lower(servicebus_config.name)}"
      service_bus_subresource_name      = ["namespace"]
    }
  }

  service_bus_private_endpoints_for_each = var.public_network_access_enabled == false ? local.service_bus_for_each : {}
}
