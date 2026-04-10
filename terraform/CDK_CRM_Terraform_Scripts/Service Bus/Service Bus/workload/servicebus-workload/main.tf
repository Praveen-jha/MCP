#Creation of Resource Group
module "resource_group" {
  source                  = "../../module/terraform-azure-resource-group-module"
  count                   = var.name_config.servicebus_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_servicebus_resource_group_name
  resource_group_location = var.location
  resource_group_tags     = var.tags
}

# This module deploys multiple Azure Service Bus Namespace.
module "servicebus_namespace" {
  source                        = "../../module/terraform-azure-servicebus-namespace-module"
  servicebus_name               = local.servicebus_name
  location                      = var.location
  resource_group_name           = local.resource_group_name
  sku                           = var.servicebus_config.sku
  capacity                      = var.servicebus_config.capacity
  premium_messaging_partitions  = var.servicebus_config.premium_messaging_partitions
  local_auth_enabled            = var.servicebus_config.local_auth_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.servicebus_config.minimum_tls_version
  tags                          = var.tags
}

# This module creates Private Endpoints for Service Bus Namespace.
module "servicebus_private_endpoint" {
  source                          = "../../module/terraform-azure-private-endpoint-module"
  count                           = var.public_network_access_enabled ? 0 : 1
  private_endpoint_name           = local.service_bus_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = local.private_service_connection_name
  subresource_names               = local.service_bus_subresource_names
  private_connection_resource_id  = module.servicebus_namespace.namespace_id
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_group_name     = local.private_dns_zone_group_name
  private_dns_zone_ids            = var.service_bus_private_dns_zone_id
  depends_on                      = [module.servicebus_namespace]
}
