locals {
  resource_group_name = var.rg_creation == "new" ? module.RG[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location            = var.rg_creation == "new" ? module.RG[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location

  hub_network_rg_name           = "${var.tenant_name}-platform-hrbot-${var.environment}-${var.workload_type}-rg"
  hub_virtual_network_name      = "${var.tenant_name}-platform-hrbot-${var.environment}-vnet-${var.location_shortname}"
  vm_name                       = "${var.tenant_name}-platform-hrbot-shared-dsha-vm"
  network_interface_name        = "${var.tenant_name}-platform-hrbot-shared-dsha-vm-nic"
  nic_ip_configuration_name     = "${var.tenant_name}-platform-hrbot-shared-dsha-nic-ipc"
  workload_nsg_name             = "${var.tenant_name}-platform-hrbot-${var.environment}-workload-nsg"
  bastion_name                  = "${var.tenant_name}-platform-hrbot-shared-bas"
  bastion_public_ip_name        = "${var.tenant_name}-platform-hrbot-shared-bas-pip"
  computer_name                 = "ictplthrbdsha"
  subnet_Bastion_name           = "AzureBastionSubnet"
  bastion_ip_configuration_name = "${var.tenant_name}-platform-hrbot-shared-bas-ipc"
  Virtual_Network_Link_Name     = "${var.tenant_name}-platform_hrbot-${var.environment}-vnet_link"
  bastion_nsg_name              = "${var.tenant_name}-platform-hrbot-shared-bas-nsg"

  Firewall_Name         = "${var.tenant_name}-platform-hrbot-${var.environment}-afw"
  firewall_policy_name  = "${var.tenant_name}-platform-hrbot-${var.environment}-afw-policy"
  PIP_Name              = "${var.tenant_name}-platform-hrbot-${var.environment}-afw-pip"
  rt_name               = "${var.tenant_name}-platform-hrbot-${var.environment}-workload-rt"
  rt_name_vpn           = "${var.tenant_name}-platform-hrbot-${var.environment}-vpn-rt"
  Ip_Configuration_name = "${var.tenant_name}-platform-hrbot-${var.environment}-afw-pip-ipc"

  subnet_Firewall_name    = "AzureFirewallSubnet"
  subnet_pep_name         = "${var.tenant_name}-platform-hrbot-${var.environment}-pep-snet-${var.location_shortname}"
  diagnostic_setting_Name = "${var.tenant_name}-platform-hrbot-${var.environment}-afw-diagnostics"
  subnet_vpngw_name       = "GatewaySubnet"

  subnet_endpoints_null = null
  //subnet private link service network policies enabled or disabled
  # private_link_service_network_policies_enabled_true  = true
  private_endpoint_network_policies_disabled = "Disabled"

  sonarqube_vm_name                   = "${var.tenant_name}-platform-hrbot-shared-sonarqube-vm"
  sonarqube_computer_name             = "icthrbpltdsqvm"
  sonarqube_network_interface_name    = "${var.tenant_name}-platform-hrbot-shared-sonarqube-vm-nic"
  sonarqube_nic_ip_configuration_name = "${var.tenant_name}-platform-hrbot-shared-sonarqube-nic-ipc"

  address_space_vnet = var.address_space_vnet

  identity_ids = [""]

  proxy_enabled = true

  subnet_Workload_name1 = "${var.tenant_name}-platform-hrbot-${var.environment}-workload-snet-${var.location_shortname}"

  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false

  private_endpoint_network_policies = "Disabled"

  private_dns_link_registration_enabled = false

  // subnet deligations 
  subnet_delegation_null = {}

  // service endpoints 
  service_endpoints = null

  caching                       = "ReadWrite"
  storage_account_type          = "StandardSSD_LRS"
  image_version                 = "latest"
  IP_allocation_method          = "Static"
  private_ip_address_allocation = "Dynamic"

  private_dns_zone_name = [
    "privatelink.vaultcore.azure.net",
    "privatelink.blob.core.windows.net",
    "privatelink.dfs.core.windows.net",
    "privatelink.documents.azure.com",
    "privatelink.mongo.cosmos.azure.com",
    "privatelink.cognitiveservices.azure.com",
    "privatelink.openai.azure.com",
    "privatelink.azurewebsites.net",
    "privatelink.search.windows.net",
    "privatelink.notebooks.azure.net",
    "privatelink.api.azureml.ms",
    "privatelink.file.core.windows.net"
  ]

  nsg_security_rule = [
    {
      name                       = "allow-bas-shrd-to-wrkld-shrd"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.0.64/26"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-dev-to-wrkld-shrd-01"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.4.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-afw-shrd-to-wrkld-shrd"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.0/26"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-dev-to-wrkld-shrd-02"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.20.4.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-shrd-01"
      priority                   = 4030
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-shrd-02"
      priority                   = 4020
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = ["3389", "9000", "443"]
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-shrd-01"
      priority                   = 4050
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = ["3389"]
    },
    {
      name                       = "allow-wrkld-prd-to-wrkld-shrd-02"
      priority                   = 4040
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.6.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-gitex-prd-to-wrkld-hr-hub"
      priority                   = 4010
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.15.160/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "deny-any-to-wrkld-shrd"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-shrd-to-dev"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.4.0/24"
      destination_port_ranges    = ["443", "10255", "3389"]
    },
    {
      name                       = "allow-wrkld-shrd-to-pep-prd"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.6.128/27"
      destination_port_ranges    = ["443", "10255"]
    },
    {
      name                       = "allow-wrkld-shrd-to-hub"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.0.0/22"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-shrd-to-internet"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["443", "80", "9102", "9141", "9143", "9144", "9142"]
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-shrd-03"
      priority                   = 4040
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.0.144/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-dev"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.4.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-prd-01"
      priority                   = 4020
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = ["443", "3389"]
    },
    {
      name                       = "allow-wrkld-shrd-to-wrkld-prd-02"
      priority                   = 4030
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.6.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-hr-hub-to-wrkld-gitex-prd-02"
      priority                   = 4010
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-hr-hub-to-wrkld-gitex-prd-01"
      priority                   = 4000
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     ="3389"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.15.160/28"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-wrkld-hr-hub-to-pep-gitex-prd"
      priority                   = 3990
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "172.20.0.144/28"
      destination_address_prefix = "172.20.15.128/27"
      destination_port_ranges    = null
    },
    
    {
      name                       = "deny-wrkld-shrd-to-any"
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

  bastion_nsg_security_rule = [
    {
      name                       = "AllowHTTPSInternetInbound"
      priority                   = 300
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    },
    {
      name                       = "AllowGatewayManagerInbound"
      priority                   = 320
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "GatewayManager"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    },
    {
      name                       = "AllowAzureLoadBalancerInbound"
      priority                   = 340
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    },
    {
      name                       = "AllowBastionHostCommunication"
      priority                   = 360
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
      destination_port_ranges    = ["8080", "5701"]
    },
    {
      name                       = "DenyAllInbound"
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
      name                       = "AllowSshRdpOutbound"
      priority                   = 300
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "AllowAzureCloudOutbound"
      priority                   = 320
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "AzureCloud"
      destination_port_ranges    = null
    },
    {
      name                       = "AllowBastionCommunication"
      priority                   = 340
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
      destination_port_ranges    = ["8080", "5701"]
    },
    {
      name                       = "AllowHttpOutbound"
      priority                   = 360
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
      destination_port_ranges    = null
    },
    {
      name                       = "DenyAllOutbound"
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

  rt_routes = [
    {
      name                   = "wrkld-hub-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hub-to-pep-dev"
      address_prefix         = "172.20.4.128/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hub-to-comp-dev"
      address_prefix         = "172.20.4.160/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hub-to-pep-prd"
      address_prefix         = "172.20.6.128/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hub-to-comp-prd"
      address_prefix         = "172.20.6.160/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hr-hub-to-ccai-dev"
      address_prefix         = "172.20.8.0/23"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hr-hub-to-cognitive"
      address_prefix         = "172.20.12.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hr-hub-to-pep-gitex-prd"
      address_prefix         = "172.20.15.128/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "wrkld-hr-hub-to-comp-gitex-prd"
      address_prefix         = "172.20.15.160/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  route_table_vpn_routes = [
    {
      name                   = "tanzu-onprem-to-ccai-dev"
      address_prefix         = "172.20.8.0/23"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "tanzu-onprem-to-cognitive"
      address_prefix         = "172.20.12.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    },
    {
      name                   = "tanzu-onprem-to-wrkld-hr-hub"
      address_prefix         = "172.20.0.144/28"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "172.20.0.4"
    }
  ]

  enabled_logs = {
    category        = []
    category_groups = ["allLogs"]
  }
  metrics = ["AllMetrics"]
}
