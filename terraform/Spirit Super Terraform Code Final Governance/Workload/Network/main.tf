# ......................................................
# Module: Private Endpoint Subnet
# ......................................................
module "peSnet" {
  source                = "../../Modules/networkServices/Subnet"
  rgName                = data.azurerm_resource_group.networkRG.name
  subnetName            = "${local.baseName2}-vnet1-${local.baseName1}-pe-snet1"
  virtualNetworkName    = data.azurerm_virtual_network.existingVnet.name
  subnetAddressPrefixes = var.vnet.privateEndpointSnetAddressPrefixes
  subnet_nsg_association= false
  subnet_rt_association = false
  nsgId                 = null
  rtId                  = null
  subnetDelegations     = local.subnetDelegationNull
}


# ......................................................
# Module: Compute Subnet
# ......................................................
module "computeSnet" {
  source                = "../../Modules/networkServices/Subnet"
  rgName                = data.azurerm_resource_group.networkRG.name
  subnetName            = "${local.baseName2}-vnet1-${local.baseName1}-compute-snet1"
  virtualNetworkName    = data.azurerm_virtual_network.existingVnet.name
  subnetAddressPrefixes = var.vnet.computeSnetAddressPrefixes
  subnet_nsg_association= true
  subnet_rt_association = true
  rtId                  = module.computeRt.routeTableId
  nsgId                 = module.computeNsg.nsgId
  subnetDelegations     = local.subnetDelegationNull
  depends_on            = [module.peSnet,module.computeNsg]
}


# ......................................................
# Module: Host Subnet
# ......................................................
module "hostSnet" {
  source                = "../../Modules/networkServices/Subnet"
  rgName                = data.azurerm_resource_group.networkRG.name
  subnetName            = "${local.baseName2}-vnet1-${local.baseName1}-host-snet1"
  virtualNetworkName    = data.azurerm_virtual_network.existingVnet.name
  subnetAddressPrefixes = var.vnet.hostSnetAddressPrefixes
  subnet_nsg_association= true
  subnet_rt_association = true
  rtId                  = module.hostRt.routeTableId
  nsgId                 = module.hostNsg.nsgId
  subnetDelegations     = local.databricksSubnetDelegation
  depends_on            = [module.computeSnet,module.hostNsg,module.hostRt]
}


# ......................................................
# Module: Container Subnet
# ......................................................
module "containerSnet" {
  source                = "../../Modules/networkServices/Subnet"
  rgName                = data.azurerm_resource_group.networkRG.name
  subnetName            = "${local.baseName2}-vnet1-${local.baseName1}-container-snet1"
  virtualNetworkName    = data.azurerm_virtual_network.existingVnet.name
  subnetAddressPrefixes = var.vnet.contianerSnetAddressPrefixes
  subnet_nsg_association= true
  subnet_rt_association = true
  rtId                  = module.containerRt.routeTableId
  nsgId                 = module.containerNsg.nsgId
  subnetDelegations     = local.databricksSubnetDelegation
  depends_on            = [module.hostSnet,module.containerNsg,module.containerRt]
}

# module "hostTwoSnet" {
#   source                = "../../Modules/networkServices/Subnet"
#   rgName                = data.azurerm_resource_group.networkRG.name
#   subnetName            = "snet-host-02"
#   virtualNetworkName    = data.azurerm_virtual_network.existingVnet.name
#   subnetAddressPrefixes = var.vnet.hostTwoSnetAddressPrefixes
#   subnet_nsg_association= true
#   subnet_rt_association = true
#   rtId                  = module.hostTwoRt.routeTableId
#   nsgId                 = module.hostTwoNsg.nsgId
#   subnetDelegations     = local.databricksSubnetDelegation
#   depends_on            = [module.containerOneSnet, module.hostTwoNsg,module.hostTwoRt]
# }

# module "containerTwoSnet" {
#   source                = "../../Modules/networkServices/Subnet"
#   rgName                = data.azurerm_resource_group.networkRG.name
#   subnetName            = "snet-container-02"
#   virtualNetworkName    = data.azurerm_virtual_network.existingVnet.name
#   subnetAddressPrefixes = var.vnet.containerTwoSnetAddressPrefixes
#   subnet_nsg_association= true
#   subnet_rt_association = true
#   rtId                  = module.containerTwoRt.routeTableId
#   nsgId                 = module.containerTwoNsg.nsgId
#   subnetDelegations     = local.databricksSubnetDelegation
#   depends_on            = [module.hostTwoSnet, module.containerTwoNsg,module.containerOneRt]
# }


# ......................................................
# Module: Compute Network Security Group
# ......................................................
module "computeNsg" {
  source     = "../../Modules/networkServices/Nsg"
  nsgName    = "${local.baseName2}-vnet1-${local.baseName1}-compute-nsg1"
  location   = var.nameConfig.defaultLocation
  rgName     = data.azurerm_resource_group.networkRG.name
  nsgTags    = var.nameConfig.tags
  secRule    = [
    local.computeNsgRule.rdprule
   ]
}


# ......................................................
# Module: Databricks Host Network Security Group
# ......................................................
module "hostNsg" {
  source     = "../../Modules/networkServices/Nsg"
  nsgName    = "${local.baseName2}-vnet1-${local.baseName1}-host-nsg1"
  location   = var.nameConfig.defaultLocation
  rgName     = data.azurerm_resource_group.networkRG.name
  nsgTags    = var.nameConfig.tags
  secRule    = [ ]
}


# ......................................................
# Module: Databricks Container Network Security Group
# ......................................................
module "containerNsg" {
  source     = "../../Modules/networkServices/Nsg"
  nsgName    = "${local.baseName2}-vnet1-${local.baseName1}-container-nsg1"
  location   = var.nameConfig.defaultLocation
  rgName     = data.azurerm_resource_group.networkRG.name
  nsgTags    = var.nameConfig.tags
  secRule    = [ ]
}

# module "hostTwoNsg" {
#   source     = "../../Modules/networkServices/Nsg"
#   nsgName    = "nsg-host-02"
#   location   = var.nameConfig.defaultLocation
#   rgName     = data.azurerm_resource_group.networkRG.name
#   nsgTags    = var.nameConfig.tags
#   secRule    = [ ]
# }

# module "containerTwoNsg" {
#   source     = "../../Modules/networkServices/Nsg"
#   nsgName    = "nsg-container-02"
#   location   = var.nameConfig.defaultLocation
#   rgName     = data.azurerm_resource_group.networkRG.name
#   nsgTags    = var.nameConfig.tags
#   secRule    = [ ]
# }


# ......................................................
# Module: Compute Route Table
# ......................................................
module "computeRt" {
  source     = "../../Modules/networkServices/routeTable"
  rtName     = "${local.baseName2}-vnet1-${local.baseName1}-compute-rt1"
  location   = var.nameConfig.defaultLocation
  rgName     = data.azurerm_resource_group.networkRG.name
  rtTags     = var.nameConfig.tags
  rtRoutes   = var.vnet.routes
}


# ......................................................
# Module: Databricks Host Route Table
# ......................................................
module "hostRt" {
  source     = "../../Modules/networkServices/routeTable"
  rtName     = "${local.baseName2}-vnet1-${local.baseName1}-host-rt1"
  location   = var.nameConfig.defaultLocation
  rgName     = data.azurerm_resource_group.networkRG.name
  rtTags     = var.nameConfig.tags
  rtRoutes   = var.vnet.routes
}


# ......................................................
# Module: Databricks Container Route Table
# ......................................................
module "containerRt" {
  source     = "../../Modules/networkServices/routeTable"
  rtName     = "${local.baseName2}-vnet1-${local.baseName1}-container-rt1"
  location   = var.nameConfig.defaultLocation
  rgName     = data.azurerm_resource_group.networkRG.name
  rtTags     = var.nameConfig.tags
  rtRoutes   = var.vnet.routes
}

# module "hostTwoRt" {
#   source     = "../../Modules/networkServices/routeTable"
#   rtName     = "rt-host-02"
#   location   = var.nameConfig.defaultLocation
#   rgName     = data.azurerm_resource_group.networkRG.name
#   rtTags     = var.nameConfig.tags
#   rtRoutes   = var.vnet.routes
# }

# module "containerTwoRt" {
#   source     = "../../Modules/networkServices/routeTable"
#   rtName     = "rt-container-02"
#   location   = var.nameConfig.defaultLocation
#   rgName     = data.azurerm_resource_group.networkRG.name
#   rtTags     = var.nameConfig.tags
#   rtRoutes   = var.vnet.routes
# }
