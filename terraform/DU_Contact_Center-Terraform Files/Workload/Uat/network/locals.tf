locals {
  resource_group_name = var.rg_creation == "new" ? module.RG[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.RG[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  uat_network_rg_name      = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01" //ict-platform-ccai-uat-network-rg-uaen-01
  uat_virtual_network_name = "${var.tenant_name}-platform-${var.environment}-vnet-${var.location_shortname}-01"                    //ict-platform-ccai-uat-vnet-uaen-01
  apim_subnet_name         = "${var.tenant_name}-platform-${var.environment}-apim-snet-${var.location_shortname}-01"               //ict-platform-ccai-uat-apim-snet-uaen-01
  apim_nsg_name            = "${var.tenant_name}-platform-${var.environment}-apim-nsg-${var.location_shortname}-01"                //ict-platform-ccai-uat-apim-nsg-uaen-01

  subnet_endpoints_null = null

  private_link_service_network_policies_enabled_false = false
  private_endpoint_network_policies_pep_subnet        = "Enabled"
  subnet_delegation_null                              = {}
  service_endpoints                                   = null

  rt_apim_name          = "${var.tenant_name}-platform-${var.environment}-apim-rt-${var.location_shortname}-01" //ict-platform-ccai-uat-apim-rt-uaen-01
  bgp_route_propagation = false

  rt_apim_routes = [
    {
      name                   = "apim-ccai-uat-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "apim-ccai-uat-to-apimanagement"
      address_prefix         = "ApiManagement"
      next_hop_type          = "Internet"
      next_hop_in_ip_address = null
    },
    {
      name                   = "apim-ccai-uat-to-comp-shrd-hub"
      address_prefix         = "10.81.48.192/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "apim-ccai-uat-to-pep-shrd-hub"
      address_prefix         = "10.81.48.224/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "apim-cog-prd-to-comp-eitc"
      address_prefix         = "10.81.24.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "apim-cog-prd-to-comp-onprem"
      address_prefix         = "10.141.97.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
  ]

  apim_nsg_security_rule = [
    {
      name                       = "allow-azuretrafficmanager-to-virtualnetwork"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      source_address_prefix      = "AzureTrafficManager"
      destination_port_range     = "443"
      destination_address_prefix = "VirtualNetwork"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-internet-to-virtualnetwork"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "Internet"
      destination_port_ranges    = ["80", "443"]
      destination_address_prefix = "VirtualNetwork"
      destination_port_range     = null
    },
    {
      name                       = "allow-azureloadbalancer-to-virtualnetwork"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_port_range     = "6390"
      destination_address_prefix = "VirtualNetwork"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-apimanagement-to-virtualnetwork"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "ApiManagement"
      destination_port_range     = "3443"
      destination_address_prefix = "VirtualNetwork"
      destination_port_ranges    = null
    },
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
    },
    {
      name                       = "allow-virtualnetwork-to-azuremonitor"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_port_ranges    = ["1886", "443"]
      destination_address_prefix = "AzureMonitor"
      destination_port_range     = null
    },
    {
      name                       = "allow-virtualnetwork-to-azurekeyvault"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_port_range     = "443"
      destination_address_prefix = "AzureKeyVault"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-virtualnetwork-to-sql"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_port_range     = "1433"
      destination_address_prefix = "Sql"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-virtualnetwork-to-storage"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_port_range     = "443"
      destination_address_prefix = "Storage"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-virtualnetwork-to-internet"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_port_range     = null
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["80", "443"]
    },
  ]
}
