data "azurerm_resource_group" "applicationRG" {
  name = var.nameConfig.existingApplicationRGName
}

data "azurerm_resource_group" "networkRG" {
  name = var.nameConfig.existingNetworkRGName
}

data "azurerm_virtual_network" "existingVnet" {
  name                = var.nameConfig.existingVnetName
  resource_group_name = data.azurerm_resource_group.networkRG.name
}

data "azurerm_subnet" "peSubnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-pe-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_resource_group.networkRG.name
}

data "azurerm_subnet" "databricksHostSubnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-host-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_resource_group.networkRG.name
}

data "azurerm_subnet" "databricksContainerSubnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-container-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_resource_group.networkRG.name
}

data "azurerm_network_security_group" "hostNsg" {
  name                = "${local.baseName2}-vnet1-${local.baseName1}-host-nsg1"
  resource_group_name = data.azurerm_resource_group.networkRG.name
}

data "azurerm_network_security_group" "containerNsg" {
  name                = "${local.baseName2}-vnet1-${local.baseName1}-container-nsg1"
  resource_group_name = data.azurerm_resource_group.networkRG.name
}

# data "azurerm_resource_group" "applicationRG" {
#   name = "fmz-e-v-ailz-rgp-dbw-01"
# }

# data "azurerm_resource_group" "networkRG" {
#   name = "fmz-e-n-rgp-ailz-net-01"
# }

# data "azurerm_virtual_network" "existingVnet" {
#   name                = "fmz-e-n-ailz-vnet-01"
#   resource_group_name = data.azurerm_resource_group.networkRG.name
# }

# data "azurerm_subnet" "peSubnet" {
#   name                 = "fmz-e-n-ailz-end-snt-01"
#   virtual_network_name = "fmz-e-n-ailz-vnet-01"
#   resource_group_name  = data.azurerm_resource_group.networkRG.name
# }

# data "azurerm_subnet" "databricksHostSubnet" {
#   name                 = "fmz-e-n-ailz-dbw-pub-snt-01"
#   virtual_network_name = "fmz-e-n-ailz-vnet-01"
#   resource_group_name  = data.azurerm_resource_group.networkRG.name
# }

# data "azurerm_subnet" "databricksContainerSubnet" {
#   name                 = "fmz-e-n-ailz-dbw-pvt-snt-01"
#   virtual_network_name = "fmz-e-n-ailz-vnet-01"
#   resource_group_name  = data.azurerm_resource_group.networkRG.name
# }

# data "azurerm_network_security_group" "hostNsg" {
#   name                = "databricks-nsg"
#   resource_group_name = data.azurerm_resource_group.networkRG.name
# }

# data "azurerm_network_security_group" "containerNsg" {
#   name                = "databricks-nsg"
#   resource_group_name = data.azurerm_resource_group.networkRG.name
# }