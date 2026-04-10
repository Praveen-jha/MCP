locals {

  baseName1 = "${var.nameConfig.identity}${var.nameConfig.index}${var.nameConfig.deploymentEnvironment}"
  baseName2 = "${var.nameConfig.identity2}${var.nameConfig.index}-${substr(var.nameConfig.defaultLocation, 0, 2)}${substr(var.nameConfig.defaultLocation, 10, 1)}"

  databricksSubnetDelegation = {
    subnet_delegation_name  = "sub-del-001"
    service_delegation_name = "Microsoft.Databricks/workspaces"
    actions                 = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  }
  subnetDelegationNull = {}

  computeNsgRule = {
    rdprule = {
      name                         = "Allow_RDP"
      priority                     = 101
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_range            = "*"
      destination_port_range       = "3389"
      source_address_prefix        = "*"
      destination_address_prefix   = ""
      source_address_prefixes      = []
      destination_address_prefixes = var.vnet.computeSnetAddressPrefixes
    }
  }
}

