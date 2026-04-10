// Module: terraform_azure_redis_firewall_rule_module
// Description: Creates an Azure Redis Firewall Rule
// Registry Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule

resource "azurerm_redis_firewall_rule" "this" {
  name                = var.name
  redis_cache_name    = var.redis_cache_name
  resource_group_name = var.resource_group_name
  start_ip            = var.start_ip
  end_ip              = var.end_ip

}
