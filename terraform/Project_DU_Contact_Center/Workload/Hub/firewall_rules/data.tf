# data "azurerm_firewall_policy" "firewall_policy_id" {
#   resource_group_name = local.hub_network_rg_name
#   name                = var.firewall_policy_name
# }

data "azurerm_resource_group" "resource_group" {
  name  = local.hub_network_rg_name
}

data "azurerm_subnet" "subnet" {
  name  = local.firewall_subnet_name
  virtual_network_name = local.hub_virtual_network_name
  resource_group_name = local.hub_network_rg_name
}

data "azurerm_subnet" "mgnt_subnet" {
  name  = local.management_subnet_name
  virtual_network_name = local.hub_virtual_network_name
  resource_group_name = local.hub_network_rg_name
}

 