#Creation of Resource Group
module "resource_group" {
  source                  = "../../module/terraform-azure-resource-group-module"
  count                   = var.name_config.servicebus_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_servicebus_resource_group_name
  resource_group_location = var.location
  resource_group_tags     = var.tags
}

# This module deploys multiple Azure Service Bus Namespaces using a for_each loop.
module "service_bus_namespace" {
  source                        = "../../module/terraform-azure-servicebus-namespace-module"
  for_each                      = local.service_bus_for_each
  servicebus_name               = each.value.servicebus_name
  location                      = var.location
  resource_group_name           = local.resource_group_name
  sku                           = each.value.servicebus_namespace.sku
  capacity                      = each.value.servicebus_namespace.capacity
  premium_messaging_partitions  = each.value.servicebus_namespace.premium_messaging_partitions
  local_auth_enabled            = each.value.servicebus_namespace.local_auth_enabled
  minimum_tls_version           = each.value.servicebus_namespace.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}

# This module creates Private Endpoints for each Service Bus Namespace defined in the local.servicebus_for_each map.
module "service_bus_private_endpoint" {
  source                          = "../../module/terraform-azure-private-endpoint-module"
  for_each                        = local.service_bus_private_endpoints_for_each
  private_endpoint_name           = each.value.service_bus_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = each.value.private_service_connection_name
  subresource_names               = each.value.service_bus_subresource_name
  private_connection_resource_id  = module.service_bus_namespace[each.key].namespace_id
  private_dns_zone_group_name     = each.value.private_dns_zone_group_name
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_ids            = var.service_bus_private_dns_zone_id
  depends_on                      = [module.service_bus_namespace]
}
