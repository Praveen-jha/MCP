#Terraform code defines an Azure Subnet using the azurerm_subnet resource block, which is used to carve out IP address ranges within an Azure Virtual Network (VNet).
#Terrform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "this" {
  name                                          = var.subnet_name
  resource_group_name                           = var.resource_group_name
  address_prefixes                              = var.subnet_address_prefixes
  virtual_network_name                          = var.virtual_network_name
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  service_endpoints                             = var.service_endpoints
  default_outbound_access_enabled               = var.default_outbound_access_enabled
  service_endpoint_policy_ids                   = var.service_endpoint_policy_ids

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
}

#Associates a Network Security Group with a Subnet within a Virtual Network.
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association

resource "azurerm_subnet_network_security_group_association" "this" {
  count                     = var.subnet_nsg_association == true ? 1 : 0
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = var.network_security_group_id
}