locals {
  resource_group_name      = var.rg_creation == "new" ? module.RG[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location                 = var.rg_creation == "new" ? module.RG[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location
  dev_network_rg_name      = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
  dev_virtual_network_name = "${var.tenant_name}-platform-${var.environment}-vnet-${var.location_shortname}-01"
  subnet_pep_name          = "${var.tenant_name}-platform-${var.environment}-pep-snet-${var.location_shortname}-01"
  subnet_endpoints_null    = null


  //subnet private link service network policies enabled or disabled
  private_endpoint_network_policies_disabled = "Disabled"
  proxy_enabled                              = true
  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false
  private_endpoint_network_policies                   = "Disabled"
  private_endpoint_network_policies_pep_subnet        = "Enabled"
  // subnet deligations
  subnet_delegation_null = {}
  // service endpoints
  service_endpoints = null


  peering_name_spoke_to_hub    = "${var.tenant_name}-platform-${var.environment}-vnet-peer-${var.tenant_name}-platform-shrd-hub-vnet"
  peering_name_hub_to_spoke    = "${var.tenant_name}-platform-shrd-hub-vnet-peer-${var.tenant_name}-platform-${var.environment}-vnet" //ict-platform-shrd-hub-vnet-peer-ict-platform-ccai-dev-vnet
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true


  rt_pep_name           = "${var.tenant_name}-platform-${var.environment}-pep-rt-${var.location_shortname}-01"
  bgp_route_propagation = true

  pep_nsg_name         = "${var.tenant_name}-platform-${var.environment}-pep-nsg-${var.location_shortname}-01"
  IP_allocation_method = "Static"

  rt_pep_routes = [
    {
      name                   = "pep-ccai-dev-to-comp-ccai-hub"
      address_prefix         = "10.81.48.192/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-ccai-dev-to-comp-cog-prd"
      address_prefix         = "10.81.54.32/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-ccai-dev-to-comp-onprem"
      address_prefix         = "10.141.97.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-ccai-dev-to-comp-eitc-hub"
      address_prefix         = "10.81.24.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
  ]

  pep_nsg_security_rule = [
    {
      name                       = "deny-any-to-any-inbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-ccai-dev"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.50.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-pep-ccai-dev"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.50.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "deny-any-to-any-outbound"
      priority                   = 4096
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    }
  ]
}
