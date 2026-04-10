locals {
  networking_rg_name   = "${var.tenant_name}-platform-${var.bu_name}-prd-network-rg-${var.location_shortname}-01"
  virtual_network_name = "${var.tenant_name}-platform-${var.bu_name}-prd-vnet-${var.location_shortname}-01"
  address_space_vnet   = var.address_space_vnet
  subnet_apim_name     = "${var.tenant_name}-platform-${var.bu_name}-prd-apim-snet-${var.location_shortname}-01"
  subnet_pep_name      = "${var.tenant_name}-platform-${var.bu_name}-prd-pep-snet-${var.location_shortname}-01"
  subnet_compute_name  = "${var.tenant_name}-platform-${var.bu_name}-prd-comp-snet-${var.location_shortname}-01"

  route_table_pep_name     = "${var.tenant_name}-platform-${var.bu_name}-prd-pep-rt-${var.location_shortname}-01"
  route_table_compute_name = "${var.tenant_name}-platform-${var.bu_name}-prd-comp-rt-${var.location_shortname}-01"
  route_table_apim_name    = "${var.tenant_name}-platform-${var.bu_name}-prd-apim-rt-${var.location_shortname}-01"

  compute_nsg_name = "${var.tenant_name}-platform-${var.bu_name}-prd-comp-nsg-${var.location_shortname}-01"
  pep_nsg_name     = "${var.tenant_name}-platform-${var.bu_name}-prd-pep-nsg-${var.location_shortname}-01"
  apim_nsg_name    = "${var.tenant_name}-platform-${var.bu_name}-prd-apim-nsg-${var.location_shortname}-01"

  apim_public_ip_name = "${var.tenant_name}-platform-${var.bu_name}-prd-apim-pip-${var.location_shortname}-01"

  // subnet delegations
  subnet_delegation_null = {}
  subnet_endpoints_null  = null

  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_true  = true
  private_link_service_network_policies_enabled_false = false

  # private_endpoint_network_policies_pep      = "Enabled"
  private_endpoint_network_policies_disabled = "Disabled"

  peering_name_hub_to_spoke = "${var.tenant_name}-platform-shrd-hub-vnet-peer-${var.tenant_name}-platform-${var.bu_name}-prd-vnet"
  peering_name_spoke_to_hub = "${var.tenant_name}-platform-${var.bu_name}-prd-vnet-peer-${var.tenant_name}-platform-shrd-hub-vnet"

  //disable bgp route propagation
  disable_bgp_route_propagation = true
  enable_bgp_route_propagation  = false

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true

  compute_nsg_security_rule = [
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
      name                       = "allow-comp-cog-prd-to-comp-cog-prd-02"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-cog-prd-01"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-bas-shrd-hub-to-comp-cog-prd"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.128/26"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-cog-prd-02"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-cog-prd-01"
      priority                   = 4050
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-gitex-prd-to-comp-cog-prd-02"
      priority                   = 4040
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-comp-cog-prd-01"
      priority                   = 4030
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-onprem-to-comp-cog-prd-02"
      priority                   = 4020
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.141.97.0/24"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = ["443", "80"]
    },
    {
      name                       = "allow-comp-onprem-to-comp-cog-prd-01"
      priority                   = 4010
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.141.97.0/24"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-eitc-hub-to-comp-cog-prd-02"
      priority                   = 4000
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.24.0/24"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = ["443", "80"]
    },
    {
      name                       = "allow-comp-eitc-hub-to-comp-cog-prd-01"
      priority                   = 3990
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.24.0/24"
      destination_address_prefix = "10.81.54.32/27"
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
      name                       = "allow-comp-cog-prd-to-comp-cog-prd-04"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-cog-prd-03"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-hr-hub-02"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-hr-hub-01"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-cog-prd-to-pep-cog-prd"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-internet"
      priority                   = 4040
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["9141", "9142", "9143", "443", "80"]
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-shrd-hub-01"
      priority                   = 4030
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = ["80", "443", "22", "3389"]
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-shrd-hub-02"
      priority                   = 4020
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-pep-shrd-hub"
      priority                   = 4010
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-pep-ccai-dev"
      priority                   = 4000
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.50.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-onprem-02"
      priority                   = 3990
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.141.97.0/24"
      destination_port_ranges    = ["443", "80", "9141", "9142", "9143"]
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-onprem-01"
      priority                   = 3980
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.141.97.0/24"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-eitc-hub-02"
      priority                   = 3970
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.24.0/24"
      destination_port_ranges    = ["443", "80"]
    },
    {
      name                       = "allow-comp-cog-prd-to-comp-eitc-hub-01"
      priority                   = 3960
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.24.0/24"
      destination_port_ranges    = null
    }
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
      name                       = "allow-comp-cog-prd-to-pep-cog-prd"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-cog-prd"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-afw-shrd-hub-to-pep-cog-prd"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.0/26"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-afw-hr-hub-to-pep-cog-prd"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.0.0/20"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-apim-cog-prd-to-pep-cog-prd"
      priority                   = 4050
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.64/26"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-apim-ccai-uat-to-pep-cog-prd"
      priority                   = 4040
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.51.64/26"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-onprem-to-pep-cog-prd"
      priority                   = 4030
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.141.97.0/24"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-eitc-hub-to-pep-cog-prd"
      priority                   = 4020
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.24.0/24"
      destination_address_prefix = "10.81.54.0/27"
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

  apim_nsg_security_rule = [
    # {
    #   name                       = "deny-any-to-any-inbound"
    #   priority                   = 4096
    #   direction                  = "Inbound"
    #   access                     = "Deny"
    #   protocol                   = "*"
    #   source_port_range          = "*"
    #   source_address_prefix      = "*"
    #   destination_port_range     = "*"
    #   destination_address_prefix = "*"
    #   destination_port_ranges    = null
    # },
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
    # {
    #   name                       = "deny-any-to-any-outbound"
    #   priority                   = 4096
    #   direction                  = "Outbound"
    #   access                     = "Deny"
    #   protocol                   = "*"
    #   source_port_range          = "*"
    #   source_address_prefix      = "*"
    #   destination_port_range     = "*"
    #   destination_address_prefix = "*"
    #   destination_port_ranges    = null
    # },
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

  # Route Tables.
  route_table_apim_routes = [
    {
      name                   = "apim-cog-prd-to-comp-shrd-hub"
      address_prefix         = "10.81.48.192/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "apim-cog-prd-to-pep-shrd-hub"
      address_prefix         = "10.81.48.224/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "apim-cog-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "apim-cog-prd-to-apimanagement"
      address_prefix         = "ApiManagement"
      next_hop_type          = "Internet"
      next_hop_in_ip_address = null
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

  route_table_pep_routes = [
    {
      name                   = "pep-cog-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-cog-prd-to-comp-shrd-hub"
      address_prefix         = "10.81.48.192/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-cog-prd-to-pep-shrd-hub"
      address_prefix         = "10.81.48.224/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-cog-prd-to-apim-ccai-uat"
      address_prefix         = "10.81.51.64/26"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-cog-prd-to-comp-eitc"
      address_prefix         = "10.81.24.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-cog-prd-to-comp-onprem"
      address_prefix         = "10.141.97.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
  ]

  route_table_compute_routes = [
    {
      name                   = "comp-cog-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-cog-prd-to-comp-shrd-hub"
      address_prefix         = "10.81.48.192/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-cog-prd-to-pep-shrd-hub"
      address_prefix         = "10.81.48.224/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-cog-prd-to-pep-ccai-dev"
      address_prefix         = "10.81.50.0/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-cog-prd-to-apim-ccai-uat"
      address_prefix         = "10.81.51.64/26"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-cog-prd-to-comp-eitc"
      address_prefix         = "10.81.24.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-cog-prd-to-comp-onprem"
      address_prefix         = "10.141.97.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
  ]
}
