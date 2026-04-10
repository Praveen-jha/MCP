#Local Block for Resource Naming Conventions
locals {
  resource_group_name = var.name_config.redis_cache_resource_group_creation == "new" ? module.resource_group[0].resource_group_name : data.azurerm_resource_group.existing_resource_group_redis_cache[0].name
  base_name1          = "${var.name_config.short_name}-${var.name_config.product_name}-${var.name_config.environment}"

  redis_cache_name = "redis-${local.base_name1}-${var.name_config.region_flag}-${var.name_config.instance}ab"

  redis_cache_private_endpoint_name = "pep-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_service_connection_name   = "psc-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  private_dns_zone_group_name       = "pdnsg-${local.base_name1}-${var.name_config.application}-${var.name_config.region_flag}-${var.name_config.instance}"
  redis_cache_subresource_names     = ["redisCache"]
}
