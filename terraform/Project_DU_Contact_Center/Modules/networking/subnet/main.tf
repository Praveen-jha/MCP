resource "azurerm_subnet" "subnets" {
  name                                          = var.subnet_name
  resource_group_name                           = var.subnet_rg_name
  address_prefixes                              = var.subnet_address_prefixes
  virtual_network_name                          = var.virtual_network_name
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  service_endpoints                             = var.service_endpoints
  dynamic "delegation" {
    for_each = var.subnet_delegations == {} ? [] : ["delegation"]
    content {
      name = var.subnet_delegations.subnet_delegation_name
      service_delegation {
        name    = var.subnet_delegations.service_delegation_name
        actions = var.subnet_delegations.actions
      }
    }
  }
  lifecycle {
    ignore_changes = all
  }
}
 
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count                     = length(var.nsg_ids)
  subnet_id                 = azurerm_subnet.subnets.id
  network_security_group_id = element(var.nsg_ids, count.index)
  depends_on                = [azurerm_subnet.subnets]
  lifecycle {
    ignore_changes = all
  }
}
 
resource "azurerm_subnet_route_table_association" "rt_association" {
  count          = length(var.rt_ids)
  subnet_id      = azurerm_subnet.subnets.id
  route_table_id = element(var.rt_ids, count.index)
  depends_on     = [azurerm_subnet.subnets]
  lifecycle {
    ignore_changes = all
  }
}