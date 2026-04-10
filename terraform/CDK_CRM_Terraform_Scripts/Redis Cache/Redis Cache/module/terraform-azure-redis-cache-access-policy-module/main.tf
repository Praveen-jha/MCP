// Module: terraform-azure-redis-cache-access-policy-module
// Description: Creates an Azure Redis Cache Access Policy
// Registry Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache_access_policy

resource "azurerm_redis_cache_access_policy" "this" {
  name                = var.name
  redis_cache_id      = var.redis_cache_id
  permissions         = var.permissions
}

