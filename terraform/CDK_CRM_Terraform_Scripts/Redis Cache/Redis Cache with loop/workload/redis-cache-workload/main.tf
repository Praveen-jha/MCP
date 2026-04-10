#Creation of Resource Group
module "resource_group" {
  source                  = "../../module/terraform-azure-resource-group-module"
  count                   = var.name_config.redis_cache_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_redis_cache_resource_group_name
  resource_group_location = var.location
  resource_group_tags     = var.tags
}

#Creation of Redis Cache
module "redis_cache" {
  source                             = "../../module/terraform-azure-redis-cache-module"
  for_each                           = local.redis_cache_for_each
  redis_cache_name                   = each.value.redis_cache_name
  location                           = var.location
  resource_group_name                = local.resource_group_name
  capacity                           = each.value.redis_cache.capacity
  family                             = each.value.redis_cache.family
  sku_name                           = each.value.redis_cache.sku_name
  access_keys_authentication_enabled = each.value.redis_cache.access_keys_authentication_enabled
  non_ssl_port_enabled               = each.value.redis_cache.non_ssl_port_enabled
  redis_version                      = each.value.redis_cache.redis_version
  minimum_tls_version                = each.value.redis_cache.minimum_tls_version
  public_network_access_enabled      = var.public_network_access_enabled
  subnet_id                          = var.redis_cache_vnet_integration_enable ? data.azurerm_subnet.existing_outbound_subnet[0].id : null
  zones                              = var.availability_zone ? var.zones : []
  redis_configuration                = each.value.redis_configuration
  tags                               = var.tags
}

#Creation of Private Endpoint of Redis Cache
module "redis_cache_private_endpoint" {
  source                          = "../../module/terraform-azure-private-endpoint-module"
  for_each                        = local.redis_cache_private_endpoints_for_each
  private_endpoint_name           = each.value.redis_cache_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = each.value.private_service_connection_name
  subresource_names               = each.value.redis_cache_subresource_names
  private_connection_resource_id  = module.redis_cache[each.key].redis_cache_id
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_group_name     = each.value.private_dns_zone_group_name
  private_dns_zone_ids            = var.redis_cache_private_dns_zone_id
  depends_on                      = [module.redis_cache]
}
