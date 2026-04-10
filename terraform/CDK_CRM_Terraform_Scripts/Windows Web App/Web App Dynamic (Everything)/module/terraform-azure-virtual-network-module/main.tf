#Terraform code defines an Azure Virtual Network (VNet) using the azurerm_virtual_network resource block.
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/4.30.0/docs/resources/virtual_network

resource "azurerm_virtual_network" "this" {
  name                           = var.virtual_network_name
  location                       = var.virtual_network_location
  resource_group_name            = var.resource_group_name
  address_space                  = var.virtual_network_address_space
  tags                           = var.tags
  dns_servers                    = var.dns_servers
  bgp_community                  = var.bgp_community
  edge_zone                      = var.edge_zone
  flow_timeout_in_minutes        = var.flow_timeout_in_minutes
  private_endpoint_vnet_policies = var.private_endpoint_vnet_policies

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_id != null && var.ddos_protection_plan_id != "" ? [1] : []
    content {
      enable = var.enable_ddos_protection_plan
      id     = var.ddos_protection_plan_id
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_enforcement != null && var.encryption_enforcement != "" ? [1] : []
    content {
      enforcement = var.encryption_enforcement
    }
  }
}

