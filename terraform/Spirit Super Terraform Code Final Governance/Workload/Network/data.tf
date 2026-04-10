# data "azurerm_resource_group" "networkRG" {
#   name = var.nameConfig.existingNetworkRGName
# }

# data "azurerm_virtual_network" "existingVnet" {
#   name = var.vnet.existingVnetName
#   resource_group_name = data.azurerm_resource_group.networkRG.name
# }


data "azurerm_resource_group" "networkRG" {
  name = var.nameConfig.existingNetworkRGName
}

data "azurerm_virtual_network" "existingVnet" {
  name = var.vnet.existingVnetName
  resource_group_name = data.azurerm_resource_group.networkRG.name
}