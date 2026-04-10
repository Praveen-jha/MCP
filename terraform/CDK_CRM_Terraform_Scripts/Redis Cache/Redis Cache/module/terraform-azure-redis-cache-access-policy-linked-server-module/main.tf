# Terraform code defines an Azure Redis Linked Server using the azurerm_redis_linked_server resource block.
#This configuration sets up a geo-replication link between a primary and secondary Redis cache instance by referencing the target Redis cache and its associated properties. 
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/redis_linked_server.html

resource "azurerm_redis_linked_server" "this" {
  name                        = "${var.target_redis_cache_name}-link-${var.server_role}"
  target_redis_cache_name     = var.target_redis_cache_name
  resource_group_name         = var.resource_group_name
  linked_redis_cache_id       = var.linked_redis_cache_id
  linked_redis_cache_location = var.linked_redis_cache_location
  server_role                 = var.server_role
}
