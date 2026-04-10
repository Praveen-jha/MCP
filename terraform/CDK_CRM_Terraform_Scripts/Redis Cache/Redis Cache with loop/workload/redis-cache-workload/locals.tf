#Local Block for Resource Naming Conventions
locals {
  resource_group_name = var.name_config.redis_cache_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_redis_cache[0].name
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  redis_cache_for_each = {
    for key, redis_cache_config in var.redis_cache_mapping : key => {
      redis_cache_name    = redis_cache_config.name
      redis_cache         = redis_cache_config.redis_cache
      redis_configuration = redis_cache_config.redis_configuration

      redis_cache_private_endpoint_name = "pep-${lower(redis_cache_config.name)}"
      private_service_connection_name   = "psc-${lower(redis_cache_config.name)}"
      private_dns_zone_group_name       = "pdnsg-${lower(redis_cache_config.name)}"
      redis_cache_subresource_names     = ["redisCache"]
    }
  }

  redis_cache_private_endpoints_for_each = (var.public_network_access_enabled == false && var.redis_cache_vnet_integration_enable == false) ? local.redis_cache_for_each : {}
}
