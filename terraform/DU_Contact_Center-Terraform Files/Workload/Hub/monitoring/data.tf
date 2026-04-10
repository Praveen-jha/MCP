data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.monitor_rg_name
}

data "azurerm_firewall" "firewall" {
  name  = local.firwall_name
  resource_group_name = local.hub_rg_name

}

