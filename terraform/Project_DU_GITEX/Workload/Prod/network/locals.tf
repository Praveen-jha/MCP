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

  peering_name_hub_to_spoke = "${var.tenant_name}-platform-hrbot-hub-vnet-peer-${var.tenant_name}-platform-${var.bu_name}-${var.environment}"
  peering_name_spoke_to_hub = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-vnet-peer-${var.tenant_name}-platform-hrbot-hub"

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
      name                       = "deny-any-to-comp-gitex-prd"
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
      name                       = "allow-bas-hr-hub-to-comp-gitex-prd"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.0.64/26"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-hr-hub-to-comp-gitex-prd"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-comp-gitex-prd-01"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cognitive-to-comp-gitex-prd"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.12.160/27"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "deny-comp-gitex-prd-to-any"
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
      name                       = "allow-comp-gitex-prd-to-pep-gitex-prd"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.15.128/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-internet"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["443","80"]
    },
    {
      name                       = "allow-comp-gitex-prd-to-comp-hr-hub"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-comp-gitex-prd-02"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-pep-cognitive"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.12.128/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-comp-cognitive"
      priority                   = 4040
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.12.160/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-spch-avatar"
      priority                   = 4030
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    }
  ]

  pep_nsg_security_rule = [
    {
      name                       = "deny-any-to-pep-gitex-prd"
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
      name                       = "allow-afw-hr-hub-to-pep-gitex-prd"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.0.0/26"
      destination_address_prefix = "172.20.15.128/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-gitex-prd-to-pep-gitex-prd"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.15.128/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-pyint-gitex-prd-to-pep-gitex-prd"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.64/26"
      destination_address_prefix = "172.20.15.128/27"
      destination_port_ranges    = null
    },
    {
      name                       = "deny-pep-gitex-prd-to-any"
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
      name                       = "deny-any-to-nodeint-gitex-prd"
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
      name                       = "deny-nodeint-gitex-prd-to-any"
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
      name                       = "allow-nodeint-gitex-prd-to-pep-gitex-prd"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.0/26"
      destination_address_prefix = "172.20.15.128/27"
      destination_port_ranges    = null
    },
    
    {
      name                       = "allow-nodeint-gitex-prd-to-comp-gitex-prd"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.15.0/26"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-nodeint-gitex-prd-to-azuremonitor"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.0/26"
      destination_address_prefix = "AzureMonitor"
      destination_port_ranges    = null
    }
   
  ]

  py_app_nsg_security_rule = [
    {
      name                       = "deny-any-to-pyint-gitex-prd"
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
      name                       = "deny-pyint-gitex-prd-to-any"
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
      name                       = "allow-pyint-gitex-prd-to-pep-gitex-prd"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.64/26"
      destination_address_prefix = "172.20.15.128/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-pyint-gitex-prd-to-internet"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.64/26"
      destination_address_prefix = "Internet"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-pyint-gitex-prd-to-azuremonitor"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.64/26"
      destination_address_prefix = "AzureMonitor"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-pyint-gitex-prd-to-pep-cognitive"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.15.64/26"
      destination_address_prefix = "172.20.12.128/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-pyint-gitex-prd-to-comp-cognitive"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.15.64/26"
      destination_address_prefix = "172.20.12.160/27"
      destination_port_ranges    = null
    }
  ]

  route_table_pep_routes = [
    {
      name                   = "pep-gitex-prd-to-wrkld-hr-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  route_table_python_app_routes = [
    {
      name                   = "pyint-gitex-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "pyint-gitex-prd-to-wrkld-hr-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
     {
      name                   = "pyint-gitex-prd-to-pep-cognitive"
      address_prefix         = "172.20.12.128/26"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  route_table_node_app_routes = [
    {
      name                   = "nodeint-gitex-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "nodeint-gitex-prd-to-wrkld-hr-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "nodeint-gitex-prd-to-pep-cognitive"
      address_prefix         = "172.20.12.128/26"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  route_table_compute_routes =[
    {
      name                   = "comp-gitex-prd-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "comp-gitex-prd-to-wrkld-hr-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "comp-gitex-prd-to-pep-cognitive"
      address_prefix         = "172.20.12.128/26"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]
}
