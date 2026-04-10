locals {
  resource_group_name       = var.rg_creation == "new" ? module.RG[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  location                  = var.rg_creation == "new" ? module.RG[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location
  hub_network_rg_name       = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
  hub_virtual_network_name  = "${var.tenant_name}-platform-${var.environment}-vnet-${var.location_shortname}-01"
  subnet_Bastion_name       = "AzureBastionSubnet"
  Virtual_Network_Link_Name = "${var.tenant_name}-platform-${var.environment}-vnet_link"

  subnet_Firewall_name       = "AzureFirewallSubnet"
  subnet_pep_name            = "${var.tenant_name}-platform-${var.environment}-pep-snet-${var.location_shortname}-01"
  subnet_compute_name        = "${var.tenant_name}-platform-${var.environment}-comp-snet-${var.location_shortname}-01"
  subnet_dnspr_inbound_name  = "${var.tenant_name}-platform-${var.environment}-dnsprin-snet-${var.location_shortname}-01"
  subnet_dnspr_outbound_name = "${var.tenant_name}-platform-${var.environment}-dnsprout-snet-${var.location_shortname}-01"
  subnet_endpoints_null      = null
  //subnet private link service network policies enabled or disabled

  private_endpoint_network_policies_disabled = "Disabled"
  proxy_enabled                              = true

  subnet_FirewallManagement_name = "AzureFirewallManagementSubnet"

  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false

  private_endpoint_network_policies            = "Disabled"
  private_endpoint_network_policies_pep_subnet = "Enabled"

  private_dns_link_registration_enabled = false

  // subnet deligations
  subnet_delegation_null = {}

  // service endpoints
  service_endpoints = null


  private_dns_zone_name = [
    "privatelink.vaultcore.azure.net",
    "privatelink.blob.core.windows.net",
    "privatelink.dfs.core.windows.net",
    "privatelink.documents.azure.com",
    # "privatelink.mongo.cosmos.azure.com",
    "privatelink.cognitiveservices.azure.com",
    "privatelink.openai.azure.com",
    "privatelink.azurewebsites.net",
    "privatelink.search.windows.net",
    # "privatelink.notebooks.azure.net",
    # "privatelink.api.azureml.ms",
    "privatelink.file.core.windows.net",
    "privatelink.azurecr.io"
  ]

  rt_comp_name          = "${var.tenant_name}-platform-${var.environment}-comp-rt-${var.location_shortname}-01"
  rt_afw_name           = "${var.tenant_name}-platform-${var.environment}-afw-rt-${var.location_shortname}-01"
  rt_pep_name           = "${var.tenant_name}-platform-${var.environment}-pep-rt-${var.location_shortname}-01"
  rt_dnspr_name         = "${var.tenant_name}-platform-${var.environment}-dnsprout-rt-${var.location_shortname}-01"
  bgp_route_propagation = false

  bastion_nsg_name = "${var.tenant_name}-platform-${var.environment}-bas-nsg-${var.location_shortname}-01"
  comp_nsg_name    = "${var.tenant_name}-platform-${var.environment}-comp-nsg-${var.location_shortname}-01"
  pep_nsg_name     = "${var.tenant_name}-platform-${var.environment}-pep-nsg-${var.location_shortname}-01"

  bastion_name                  = "${var.tenant_name}-platform-${var.environment}-bas-${var.location_shortname}-01"
  bastion_public_ip_name        = "${var.tenant_name}-platform-${var.environment}-bas-pip-${var.location_shortname}-01"
  bastion_ip_configuration_name = "${var.tenant_name}-platform-${var.environment}-bas-nic-ipc-${var.location_shortname}-01"
  IP_allocation_method          = "Static"

  private_dns_resolver_name                   = "${var.tenant_name}-platform-${var.environment}-dnspr-${var.location_shortname}-01"
  private_dns_resolver_outbound_endpoint_name = "${var.tenant_name}-platform-${var.environment}-dnspr-outep-${var.location_shortname}-01"
  private_dns_resolver_inbound_endpoint_name  = "${var.tenant_name}-platform-${var.environment}-dnspr-inep-${var.location_shortname}-01"
  dns_forwarding_ruleset_ruleset_name         = "${var.tenant_name}-platform-${var.environment}-dnsfrs-${var.location_shortname}-01"
  virtual_network_link_name                   = "${var.tenant_name}-platform-${var.environment}-vnetlink-${local.dns_forwarding_ruleset_ruleset_name}"

  ip_configurations = [{
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = module.subnet_dnspr_inbound.subnet_id
  }]

  open_ai_private_endpoint_config = {
    private_connection_resource_id       = "/subscriptions/b092ed20-9480-45e1-a96c-8b307bfa9eab/resourceGroups/ict-platform-ccai-ai-rg/providers/Microsoft.CognitiveServices/accounts/ict-platform-ccai-oai"
    private_endpoint_name                = "${var.tenant_name}-platform-${var.environment}-oai-pep-uaen-01" # ict-platform-shrd-hub-oai-pep-uaen-01
    private_service_connection_name      = "ict-platform-ccai-oai-account-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com"]
    private_connection_subresource_names = ["account"]
    is_manual_connection                 = false
  }
  ai_search_private_endpoint_config = {
    private_connection_resource_id       = "/subscriptions/b092ed20-9480-45e1-a96c-8b307bfa9eab/resourceGroups/ict-platform-ccai-ai-rg/providers/Microsoft.Search/searchServices/ict-platform-ccai-srch"
    private_endpoint_name                = "${var.tenant_name}-platform-${var.environment}-srch-pep-uaen-01" # ict-platform-shrd-hub-srch-pep-uaen-01
    private_service_connection_name      = "ict-platform-ccai-srch-searchService-psc"
    private_dns_zone_group_name          = "default"
    private_dns_zone_ids                 = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"]
    private_connection_subresource_names = ["searchService"]
    is_manual_connection                 = false
  }

  # rt_comp_routes = [
  #   {
  #     name                   = "compute-shrd-hub-to-any"
  #     address_prefix         = "0.0.0.0/0"
  #     next_hop_type          = "VirtualAppliance"
  #     next_hop_in_ip_address = "10.81.48.4"
  #   },
  #   {
  #     name                   = "compute-shrd-hub-to-ccai-prd"
  #     address_prefix         = "10.81.52.0/24"
  #     next_hop_type          = "VirtualAppliance"
  #     next_hop_in_ip_address = "10.81.48.4"
  #   },
  #   {
  #     name                   = "compute-shrd-hub-to-ccai-dev"
  #     address_prefix         = "10.81.50.0/24"
  #     next_hop_type          = "VirtualAppliance"
  #     next_hop_in_ip_address = "10.81.48.4"
  #   },
  #   {
  #     name                   = "compute-shrd-hub-to-ccai-uat"
  #     address_prefix         = "10.81.51.0/24"
  #     next_hop_type          = "VirtualAppliance"
  #     next_hop_in_ip_address = "10.81.48.4"
  #   },
  #   {
  #     name                   = "compute-shrd-hub-to-ccai-dr"
  #     address_prefix         = "10.81.53.0/24"
  #     next_hop_type          = "VirtualAppliance"
  #     next_hop_in_ip_address = "10.81.48.4"
  #   },
  #   {
  #     name                   = "compute-shrd-hub-to-cognitive"
  #     address_prefix         = "10.81.54.0/24"
  #     next_hop_type          = "VirtualAppliance"
  #     next_hop_in_ip_address = "10.81.48.4"
  #   }
  # ]

  rt_comp_routes = [
    {
      name                   = "comp-shrd-hub-to-any"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-shrd-hub-to-ccai-dev"
      address_prefix         = "10.81.50.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-shrd-hub-to-ccai-uat"
      address_prefix         = "10.81.51.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-shrd-hub-to-ccai-prd"
      address_prefix         = "10.81.52.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-shrd-hub-to-ccai-dr"
      address_prefix         = "10.81.53.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-shrd-hub-to-cog-prd"
      address_prefix         = "10.81.54.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-01"
      address_prefix         = "10.81.0.0/19"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-02"
      address_prefix         = "10.81.32.0/20"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-03"
      address_prefix         = "10.128.0.0/9"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-04"
      address_prefix         = "100.64.24.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-05"
      address_prefix         = "100.64.43.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-06"
      address_prefix         = "100.93.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-07"
      address_prefix         = "172.16.0.0/14"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-08"
      address_prefix         = "172.20.16.0/20"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-09"
      address_prefix         = "172.20.32.0/19"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-10"
      address_prefix         = "172.20.64.0/18"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-11"
      address_prefix         = "172.20.128.0/17"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-12"
      address_prefix         = "172.21.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-13"
      address_prefix         = "172.22.0.0/15"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "comp-shrd-hub-to-ip-block-14"
      address_prefix         = "172.24.0.0/13"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    }
  ]

  rt_afw_routes = [
    {
      name                   = "ict-shrd-hub-to-ip-block-01"
      address_prefix         = "10.0.0.0/10"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-02"
      address_prefix         = "10.64.0.0/12"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-03"
      address_prefix         = "10.80.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-04"
      address_prefix         = "10.81.0.0/19"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-05"
      address_prefix         = "10.81.32.0/20"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-06"
      address_prefix         = "10.81.64.0/18"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-07"
      address_prefix         = "10.81.128.0/17"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-08"
      address_prefix         = "10.82.0.0/15"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-09"
      address_prefix         = "10.84.0.0/14"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-10"
      address_prefix         = "10.88.0.0/13"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-11"
      address_prefix         = "10.96.0.0/11"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-12"
      address_prefix         = "10.128.0.0/9"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-13"
      address_prefix         = "100.64.24.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-14"
      address_prefix         = "100.64.43.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-15"
      address_prefix         = "100.93.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-16"
      address_prefix         = "172.16.0.0/14"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-17"
      address_prefix         = "172.20.16.0/20"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-18"
      address_prefix         = "172.20.32.0/19"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-19"
      address_prefix         = "172.20.64.0/18"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-20"
      address_prefix         = "172.20.128.0/17"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-21"
      address_prefix         = "172.21.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-22"
      address_prefix         = "172.22.0.0/15"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "ict-shrd-hub-to-ip-block-23"
      address_prefix         = "172.24.0.0/13"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    }
  ]

  rt_dnspr_routes = [
    {
      name                   = "dnspr-shrd-hub-to-dnspr-eitc-hub"
      address_prefix         = "10.81.28.4/31"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
  ]

  rt_pep_routes = [
    {
      name                   = "pep-shrd-hub-to-comp-ccai-dev"
      address_prefix         = "10.81.50.32/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-shrd-hub-to-comp-ccai-uat"
      address_prefix         = "10.81.51.32/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-shrd-hub-to-comp-ccai-prd"
      address_prefix         = "10.81.52.32/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-shrd-hub-to-comp-ccai-dr"
      address_prefix         = "10.81.53.32/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-shrd-hub-to-comp-cog-prd"
      address_prefix         = "10.81.54.160/27"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.48.4"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-01"
      address_prefix         = "10.81.0.0/19"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-02"
      address_prefix         = "10.81.32.0/20"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-03"
      address_prefix         = "10.128.0.0/9"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-04"
      address_prefix         = "100.64.24.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-05"
      address_prefix         = "100.64.43.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-06"
      address_prefix         = "100.93.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-07"
      address_prefix         = "172.16.0.0/14"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-08"
      address_prefix         = "172.20.16.0/20"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-09"
      address_prefix         = "172.20.32.0/19"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-10"
      address_prefix         = "172.20.64.0/18"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-11"
      address_prefix         = "172.20.128.0/17"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-12"
      address_prefix         = "172.21.0.0/16"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-13"
      address_prefix         = "172.22.0.0/15"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    },
    {
      name                   = "pep-shrd-hub-to-ip-block-14"
      address_prefix         = "172.24.0.0/13"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.81.24.70"
    }
  ]

  comp_nsg_security_rule = [
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
      name                       = "allow-bas-shrd-hub-to-comp-shrd-hub"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.128/26"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-shrd-hub-01"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-shrd-hub-02"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = ["9000", "3389", "443", "5000"]
    },
    {
      name                       = "allow-comp-ccai-dev-to-comp-shrd-hub-01"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.50.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-ccai-dev-to-comp-shrd-hub-02"
      priority                   = 4050
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.50.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-ccai-prd-to-comp-shrd-hub-01"
      priority                   = 4040
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.52.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = ["22", "3389"]
    },
    {
      name                       = "allow-comp-ccai-prd-to-comp-shrd-hub-02"
      priority                   = 4030
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.52.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-linux-comp-shrd-hub-01"
      priority                   = 4020
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.202/32"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-ccai-uat-to-comp-shrd-hub"
      priority                   = 4010
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.51.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-ccai-dr-to-comp-shrd-hub"
      priority                   = 4000
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.53.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cogitive-to-comp-shrd-hub"
      priority                   = 3990
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-onprem-to-comp-shrd-hub-01"
      priority                   = 3980
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.141.97.0/24"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = ["443", "80", "3389", "22"]
    },
    {
      name                       = "allow-comp-onprem-to-comp-shrd-hub-02"
      priority                   = 3970
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.141.97.0/24"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-eitc-to-comp-shrd-hub-01"
      priority                   = 3960
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.24.0/24"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = ["443", "80", "3389", "22"]
    },
    {
      name                       = "allow-comp-eitc-to-comp-shrd-hub-02"
      priority                   = 3950
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.24.0/24"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-any-to-jbx5-shrd-hub-01"
      priority                   = 3940
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "10.81.48.203/27"
      destination_port_ranges    = null
    },
    {
      name                       = "deny-shrd-hub-comp-to-any"
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
      name                       = "allow-comp-shrd-hub-to-ccai-dev"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.50.0/24"
      destination_port_ranges    = ["10255", "3389", "443"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-ccai-prd"
      priority                   = 4080
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.52.0/27"
      destination_port_ranges    = ["10255", "443"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-shrd-hub"
      priority                   = 4070
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.0/23"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-internet-02"
      priority                   = 4060
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "Internet"
      destination_port_ranges    = ["9141", "80", "9143", "9102", "9144", "443", "9142", "5000", "27018", "27017", "27019"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-linux-comp-shrd-hub-02"
      priority                   = 4055
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.202/32"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-ccai-dev"
      priority                   = 4050
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.50.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-shrd-hub-03"
      priority                   = 4040
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-shrd-hub-04"
      priority                   = 4030
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.192/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-ccai-prd-01"
      priority                   = 4020
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.52.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-ccai-prd-02"
      priority                   = 4010
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.52.32/27"
      destination_port_ranges    = ["3389", "443"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-ccai-uat"
      priority                   = 4000
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.51.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-ccai-dr"
      priority                   = 3990
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.53.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-cog-prd"
      priority                   = 3980
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.54.32/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-internet-01"
      priority                   = 3970
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.202/31"
      destination_address_prefix = "Internet"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-shrd-hub"
      priority                   = 3960
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-ccai-dev"
      priority                   = 3950
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.50.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-ccai-uat"
      priority                   = 3940
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.51.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-ccai-prd"
      priority                   = 3930
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.52.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-ccai-dr"
      priority                   = 3920
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.53.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-pep-cog-prd"
      priority                   = 3910
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.54.0/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-onprem-01"
      priority                   = 3900
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.141.97.0/24"
      destination_port_ranges    = ["443", "80", "9141", "9142", "9143"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-onprem-02"
      priority                   = 3890
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.141.97.0/24"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-eitc-01"
      priority                   = 3880
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = null
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.24.0/24"
      destination_port_ranges    = ["443", "80"]
    },
    {
      name                       = "allow-comp-shrd-hub-to-comp-eitc-02"
      priority                   = 3870
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.24.0/24"
      destination_port_ranges    = null
    },
  ]

  bastion_nsg_security_rule = [
    {
      name                       = "allow-internet-to-bas-shrd-hub"
      priority                   = 4090
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
      name                       = "allow-gatewaymanager-to-bas-shrd-hub"
      priority                   = 4080
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
      name                       = "allow-azureloadbalancer-to-bas-shrd-hub"
      priority                   = 4070
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
      name                       = "allow-virtualnetwork-to-bas-shrd-hub"
      priority                   = 4060
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
      name                       = "deny-any-to-bas-shrd-hub"
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
      name                       = "allow-bas-shrd-hub-to-virtualnetwork"
      priority                   = 4090
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
      name                       = "allow-bas-shrd-hub-to-controlplane"
      priority                   = 4080
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
      name                       = "allow-bas-shrd-hub-to-shrd-hub"
      priority                   = 4070
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
      name                       = "allow-bas-shrd-hub-to-internet"
      priority                   = 4060
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
      name                       = "deny-bas-shrd-hub-to-any"
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

  pep_nsg_security_rule = [
    # {
    #   name                       = "deny-any-to-any-inbound"
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
      name                       = "allow-comp-shrd-hub-to-pep-shrd-hub"
      priority                   = 4090
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.48.192/27"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-ccai-dev-to-pep-shrd-hub"
      priority                   = 4080
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.50.32/27"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-apim-ccai-uat-to-pep-shrd-hub"
      priority                   = 4070
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.51.64/26"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-apim-cog-prd-to-pep-shrd-hub"
      priority                   = 4060
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.64/26"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-ccai-prd-to-pep-shrd-hub"
      priority                   = 4050
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.52.32/27"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-ccai-dr-to-pep-shrd-hub"
      priority                   = 4040
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.53.32/27"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-cog-prd-to-pep-shrd-hub"
      priority                   = 4030
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.54.32/27"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-onprem-to-pep-shrd-hub"
      priority                   = 4020
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.141.97.0/24"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    {
      name                       = "allow-comp-eitc-to-pep-shrd-hub"
      priority                   = 4010
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.81.24.0/24"
      destination_address_prefix = "10.81.48.224/27"
      destination_port_ranges    = null
    },
    # {
    #   name                       = "deny-any-to-any-outbound"
    #   priority                   = 4096
    #   direction                  = "Outbound"
    #   access                     = "Deny"
    #   protocol                   = "*"
    #   source_port_range          = "*"
    #   destination_port_range     = "*"
    #   source_address_prefix      = "*"
    #   destination_address_prefix = "*"
    #   destination_port_ranges    = null
    # },
  ]
}
