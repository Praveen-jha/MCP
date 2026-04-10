data "azurerm_firewall_policy" "firewall_policy_id" {
  resource_group_name = var.hub_network_rg_name
  name                = var.firewall_policy_name
}
