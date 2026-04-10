locals {
  resource_group_name = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  networking_rg_name   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-network-rg"
  virtual_network_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-vnet-${var.location_shortname}"
  subnet1_name         = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pyint-snet-${var.location_shortname}"
  subnet2_name         = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-nodeint-snet-${var.location_shortname}"
  subnet_compute_name  = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-compute-snet-${var.location_shortname}"
  subnet_pep_name      = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pep-snet-${var.location_shortname}"

  compute_nsg_name  = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-compute-nsg"
  pep_nsg_name      = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pep-nsg"
  py_app_nsg_name   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pyint-nsg"
  node_app_nsg_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-nodeint-nsg"

  address_space_vnet = var.address_space_vnet

  route_table_pep_name          = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pep-rt"
  route_table_python_app_name   = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-pyint-rt"
  route_table_node_app_name     = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-nodeint-rt"
  route_table_compute_name      = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-compute-rt"

  peering_name_hub_to_spoke = "${var.tenant_name}-platform-${var.bu_name}-hub-vnet-peer-${var.tenant_name}-platform-${var.bu_name}-${var.environment}"
  peering_name_spoke_to_hub = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-vnet-peer-${var.tenant_name}-platform-${var.bu_name}-hub"

  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false

  private_endpoint_network_policies_pep      = "Enabled"
  private_endpoint_network_policies_disabled = "Disabled"

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true

  // subnet deligations 
  subnet_delegation = {
    subnet_delegation_name  = "appServiceDelegation"
    service_delegation_name = "Microsoft.Web/serverFarms"
    actions                 = ["Microsoft.Network/virtualNetworks/subnets/action"]
  }
  subnet_delegation_null = {}

  subnet_endpoints_null = null

  compute_nsg_security_rule = [
    {
      name                       = "allow-bas-shrd-to-wrkld-prd"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.0.64/26"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = ["3389", "22"]
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-prd-01"
      priority                   = 4050
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-afw-shrd-to-wrkld-prd"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.0.0/26"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-prd-01"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.6.0/24"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-prd-02"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-dev-to-wrkld-prd-01"
      priority                   = 4030
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.4.160/28"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-dev-to-wrkld-prd-02"
      priority                   = 4040
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.4.160/28"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "deny-any-to-wrkld-prd"
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
      name                       = "allow-wrkld-prd-to-pep-prd"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-wrkld-prd-to-internet"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["443", "80", "9102", "9141", "9143", "9144", "9142"]
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-shrd-01"
      priority                   = 4040
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-prd-02"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-shrd-02"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-prd-to-afw-shrd"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.0.0/26"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-dev-02"
      priority                   = 4030
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.4.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-dev-01"
      priority                   = 4020
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.4.160/28"
      destination_port_ranges    = null
    }
    # {
    #   name                       = "deny-wrkld-prd-to-any"
    #   priority                   = 4096
    #   direction                  = "Outbound"
    #   access                     = "Deny"
    #   protocol                   = "*"
    #   source_port_range          = "*"
    #   destination_port_range     = "*"
    #   source_address_prefix      = "*"
    #   destination_address_prefix = "*"
    #   destination_port_ranges    = null
    # }
  ]

  pep_nsg_security_rule = [
    {
      name                       = "allow-py-app-dev-to-pep-prd"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.4.0/26"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-py-app-prd-to-pep-prd"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-afw-shrd-to-pep-prd"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.0.0/26"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-wrkld-prd-to-pep-prd"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-wrkld-dev-to-pep-prd"
      priority                   = 4050
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.4.160/28"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    # {
    #   name                       = "deny-any-to-pep-prd"
    #   priority                   = 4096
    #   direction                  = "Inbound"
    #   access                     = "Deny"
    #   protocol                   = "*"
    #   source_port_range          = "*"
    #   destination_port_range     = "*"
    #   source_address_prefix      = "*"
    #   destination_address_prefix = "*"
    #   destination_port_ranges    = null
    # },
    {
      name                       = "deny-pep-prd-to-any"
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

  node_app_nsg_security_rule = [
    {
      name                       = "deny-any-to-node-app-prd"
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
      name                       = "allow-node-app-prd-to-pep-prd"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.0/26"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-node-app-prd-to-afw"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.6.0/26"
      destination_address_prefix = "172.20.0.0/26"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-node-app-prd-to-wrkld-prd"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.0/26"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = ["443", "3389"]
    },
    {
      name                       = "allow-node-app-prd-to-azuremonitor"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.6.0/26"
      destination_address_prefix = "AzureMonitor"
      destination_port_ranges    = null
    },
    {
      name                       = "deny-node-app-prd-to-any"
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

  py_app_nsg_security_rule = [
    {
      name                       = "deny-any-to-py-app-prd"
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
      name                       = "allow-py-app-prd-to-pep-prd"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-py-app-prd-to-afw"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "172.20.0.0/26"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-py-app-prd-to-api"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "8000"
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "0.0.0.0"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-py-app-prd-to-wrkld-prd"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = ["443", "3389"]
    },
    {
      name                       = "allow-py-app-prd-to-internet"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["9102", "443", "9141", "9143", "9144", "9142"]
    },
    {
      name                       = "allow-py-app-prd-to-azuremonitor"
      priority                   = 4040
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "AzureMonitor"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-py-app-prd-to-wrkld-dev" ##test
      priority                   = 4030
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "172.20.4.160/28"
      destination_port_ranges    = ["443", "3389"]
    },
    {
      name                       = "allow-py-app-prd-to-pep-dev"
      priority                   = 4020
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.64/26"
      destination_address_prefix = "172.20.4.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "deny-py-app-prd-to-any"
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

  route_table_pep_routes = [
    {
      name                   = "pep-prod-to-wrkld-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "pep-prod-to-wrkld-dev"
      address_prefix         = "172.20.4.160/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "pep-prod-to-pep-dev"
      address_prefix         = "172.20.4.128/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  route_table_python_app_routes = [
    {
      name                   = "vnetint-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "vnetint-prd-to-wrkld-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  route_table_node_app_routes = [
    {
      name                   = "vnetint-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "vnetint-prd-to-wrkld-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  route_table_compute_routes = [
    {
      name                   = "wrkld-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-prd-to-wrkld-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-prd-to-wrkld-dev"
      address_prefix         = "172.20.4.160/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-prd-to-pep-dev"
      address_prefix         = "172.20.4.128/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]
}
