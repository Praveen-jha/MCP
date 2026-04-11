resource "azurerm_subnet" "subnets" {
  name                                          = var.subnetName
  resource_group_name                           = var.rgName
  address_prefixes                              = var.subnetAddressPrefixes
  virtual_network_name                          = var.virtualNetworkName
  private_endpoint_network_policies_enabled     = var.privateEndpointNetworkPoliciesEnabled
  private_link_service_network_policies_enabled = var.privateLinkServiceNetworkPoliciesEnabled
  #service_endpoints                             = var.serviceEndpoints
  dynamic "delegation" {
    for_each = var.subnetDelegations == {} ? [] : ["delegation"]
    content {
      name = var.subnetDelegations.subnet_delegation_name
      service_delegation {
        name    = var.subnetDelegations.service_delegation_name
        actions = var.subnetDelegations.actions
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count                     = var.subnet_nsg_association == true ? 1 : 0        
  subnet_id                 = azurerm_subnet.subnets.id
  network_security_group_id = var.nsgId
  depends_on                = [azurerm_subnet.subnets]
}
         
resource "azurerm_subnet_route_table_association" "rt_association" {
  count          = var.subnet_rt_association == true ? 1 : 0  
  subnet_id      = azurerm_subnet.subnets.id
  route_table_id = var.rtId 
  depends_on     = [azurerm_subnet.subnets]
}
