# ......................................................
# Creating New Resource Group _previous
# ......................................................

module "RG" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.hub_network_rg_name
  resource_group_location = var.rg_location
  resource_group_tags     = var.resource_group_tags
}

# ......................................................
# Creating Hub Virtual Network
# ......................................................

module "vnet" {
  source                        = "../../../Modules/networking/virtualNetwork"
  virtual_network_name          = local.hub_virtual_network_name
  virtual_network_location      = local.location
  virtual_network_address_space = var.address_space_vnet
  resource_group_name           = local.resource_group_name
  dns_server                    = var.custom_dns_ip
  virtual_network_tags          = var.vnet_tags
  depends_on                    = [module.RG]
}

# ......................................................
# Creation of FirewallManagement Subnet
# ......................................................

module "subnet_FirewallManagement" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_FirewallManagement_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_FirewallManagement_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  # subnet_nsg_association                        = var.subnet_nsg_association_false
  # subnet_rt_association                         = var.subnet_routetable_association_false
  # nsg_id                                        = module.network_security_group.nsg_id
  # rt_id                                         = module.route_table.route_table_id
  depends_on = [module.vnet]
}

# ......................................................
# Creation of Bastion subnet
# ......................................................

module "subnet_Bastion" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_Bastion_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_bastion_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  nsg_ids                                       = [module.nsg_bastion.nsg_id]
  # rt_id                                         = module.route_table.route_table_id
  depends_on = [module.vnet]
}

# ......................................................
# Creating Firewall Subnet
# ......................................................

module "subnet_Firewall" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_Firewall_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_firewall_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  rt_ids                                        = [module.afw_route_table.route_table_id]
  # subnet_rt_association                         = var.subnet_routetable_association_false
  # subnet_nsg_association                        = var.subnet_nsg_association_false
  depends_on = [module.vnet]
}

# ......................................................
# Creation of Private Endpoint Subnet
# ......................................................

module "subnet_pep" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_pep_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_pep_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_pep_subnet
  nsg_ids                                       = [module.nsg_pep.nsg_id]
  rt_ids                                        = [module.pep_route_table.route_table_id]
  depends_on                                    = [module.vnet]
}

# ......................................................
# Creation of ComputeSubnet
# ......................................................

module "subnet_compute" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_compute_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_compute_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  nsg_ids                                       = [module.nsg_compute.nsg_id]
  rt_ids                                        = [module.comp_route_table.route_table_id]
  depends_on                                    = [module.vnet]
}

# ......................................................
# Creation of DNS PR InboundSubnet
# ......................................................

module "subnet_dnspr_inbound" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_dnspr_inbound_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_dnspr_inbound_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  # nsg_ids                                       = [module.nsg_compute.nsg_id]
  # rt_ids                                        = [module.comp_route_table.route_table_id]
  depends_on = [module.vnet]
}

# ......................................................
# Creation of DNS PR OutboundSubnet
# ......................................................

module "subnet_dnspr_outbound" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_dnspr_outbound_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_dnspr_outbound_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  # nsg_ids                                       = [module.nsg_compute.nsg_id]
  rt_ids     = [module.dnspr_route_table.route_table_id]
  depends_on = [module.vnet]
}

# ......................................................
# Creating Private DNS Zone
# ......................................................

module "Private_Dns_Zone" {
  source                               = "../../../Modules/networking/privateDNSZone"
  count                                = length(local.private_dns_zone_name)
  private_dns_zone_name                = element(local.private_dns_zone_name, count.index)
  private_dns_zone_resource_group_name = local.resource_group_name
  private_dns_zone_tags                = var.PDZ_tags
  depends_on                           = [module.RG]
}

# ......................................................
# Creating Private DNS Zone Vnet Link
# ......................................................

module "Vnet_Link" {
  source                                = "../../../Modules/networking/virtualNetworkLink"
  count                                 = length(local.private_dns_zone_name)
  private_dns_link_name                 = local.Virtual_Network_Link_Name
  private_dns_link_registration_enabled = local.private_dns_link_registration_enabled
  private_dns_link_resource_group_name  = local.resource_group_name
  private_dns_link_virtual_network_id   = module.vnet.virtual_network_id
  private_dns_link_zone_name            = element(local.private_dns_zone_name, count.index)
  virtual_network_link_tags             = var.vnet_link_tags
  depends_on                            = [module.RG, module.Private_Dns_Zone]
}

# .......................................................
# Route Table
# .......................................................

module "comp_route_table" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.rt_comp_name
  rt_location                   = local.location
  rt_rg_name                    = local.resource_group_name
  rt_routes                     = local.rt_comp_routes
  rt_tags                       = var.rt_tags
  depends_on                    = [module.RG]
  bgp_route_propagation_enabled = local.bgp_route_propagation
}

module "afw_route_table" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.rt_afw_name
  rt_location                   = local.location
  rt_rg_name                    = local.resource_group_name
  rt_routes                     = local.rt_afw_routes
  rt_tags                       = var.rt_tags
  depends_on                    = [module.RG]
  bgp_route_propagation_enabled = local.bgp_route_propagation
}

module "pep_route_table" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.rt_pep_name
  rt_location                   = local.location
  rt_rg_name                    = local.resource_group_name
  rt_routes                     = local.rt_pep_routes
  rt_tags                       = var.rt_tags
  depends_on                    = [module.RG]
  bgp_route_propagation_enabled = local.bgp_route_propagation
}

module "dnspr_route_table" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.rt_dnspr_name
  rt_location                   = local.location
  rt_rg_name                    = local.resource_group_name
  rt_routes                     = local.rt_dnspr_routes
  rt_tags                       = var.rt_tags
  depends_on                    = [module.RG]
  bgp_route_propagation_enabled = local.bgp_route_propagation
}
module "nsg_bastion" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.bastion_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.bastion_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.RG]
}

module "nsg_compute" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.comp_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.comp_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.RG]
}

module "nsg_pep" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.pep_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.pep_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.RG]
}

# ......................................................
# Setting Custom DNS on Virtual Network for Firewall
# ......................................................

# module "custom_dns" {
#   source             = "../../../Modules/networking/virtualNetworkDNSServer"
#   virtual_network_id = module.vnet.virtual_network_id
#   custom_dns_ip      = var.custom_dns_ip
# }


# ......................................................
# Creating Bastion
# ......................................................

module "bastion" {
  source                = "../../../Modules/networking/bastion"
  resource_group_name   = local.resource_group_name
  location              = local.location
  bastion_name          = local.bastion_name
  ip_configuration_name = local.bastion_ip_configuration_name
  subnet_id             = module.subnet_Bastion.subnet_id
  public_ip_name        = local.bastion_public_ip_name
  ip_allocation_method  = local.IP_allocation_method
  bastion_tags          = var.bastion_tags
  PIP_tags              = var.PIP_tags
  ip_sku                = var.ip_sku
  depends_on            = [module.subnet_Bastion]
}

# ......................................................
# Creating Pribate DNS Resolver
# ......................................................
module "private_resolver" {
  source              = "../../../Modules/networking/privateDNSResolver/dnsResolver"
  dns_resolver_name   = local.private_dns_resolver_name
  resource_group_name = local.resource_group_name
  location            = local.location
  virtual_network_id  = module.vnet.virtual_network_id
  tags                = var.dnspr_tags
  depends_on          = [module.subnet_dnspr_inbound, module.subnet_dnspr_outbound, module.vnet]
}

module "outbound_endpoint" {
  source                  = "../../../Modules/networking/privateDNSResolver/dnsResolverOutboundEndpoint"
  name                    = local.private_dns_resolver_outbound_endpoint_name
  private_dns_resolver_id = module.private_resolver.id
  location                = local.location
  subnet_id               = module.subnet_dnspr_outbound.subnet_id
  tags                    = var.dnspr_tags
  depends_on              = [module.private_resolver]
}

module "inbound_endpoint" {
  source                  = "../../../Modules/networking/privateDNSResolver/dnsResolverInboundEndpoint"
  name                    = local.private_dns_resolver_inbound_endpoint_name
  private_dns_resolver_id = module.private_resolver.id
  location                = local.location
  tags                    = var.dnspr_tags
  ip_configurations       = local.ip_configurations
  depends_on              = [module.private_resolver]
}

module "dns_forwarding_ruleset" {
  source                                     = "../../../Modules/networking/privateDNSResolver/dnsResolverDnsForwardingRuleset"
  name                                       = local.dns_forwarding_ruleset_ruleset_name
  resource_group_name                        = local.resource_group_name
  location                                   = local.location
  private_dns_resolver_outbound_endpoint_ids = [module.outbound_endpoint.id]
  tags                                       = var.dnspr_tags
  depends_on                                 = [module.outbound_endpoint]
}

module "dns_resolver_ruleset_vnet_linking" {
  source                    = "../../../Modules/networking/privateDNSResolver/dnsResolverVirtualNetworkLink"
  name                      = local.virtual_network_link_name
  dns_forwarding_ruleset_id = module.dns_forwarding_ruleset.id
  virtual_network_id        = module.vnet.virtual_network_id
  depends_on                = [module.dns_forwarding_ruleset, module.vnet]
}

module "dns_forwarding_rules" {
  source                    = "../../../Modules/networking/privateDNSResolver/dnsResolverForwardingRules"
  for_each                  = var.dns_resolver_forwarding_rules_config
  name                      = each.value.rule_name
  dns_forwarding_ruleset_id = module.dns_forwarding_ruleset.id
  domain_name               = each.value.domain_name
  enabled                   = each.value.enabled
  target_dns_servers        = each.value.target_dns_servers
  depends_on                = [module.dns_forwarding_ruleset]
}

# #......................................................
# # Module: Private Endpoint for Open AI
# #......................................................
# module "private_endpoint_open_ai" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = module.subnet_pep.subnet_id
#   private_connection_resource_id       = local.open_ai_private_endpoint_config.private_connection_resource_id
#   private_endpoint_name                = local.open_ai_private_endpoint_config.private_endpoint_name
#   private_service_connection_name      = local.open_ai_private_endpoint_config.private_service_connection_name
#   private_dns_zone_group_name          = local.open_ai_private_endpoint_config.private_dns_zone_group_name
#   private_dns_zone_ids                 = local.open_ai_private_endpoint_config.private_dns_zone_ids
#   private_connection_subresource_names = local.open_ai_private_endpoint_config.private_connection_subresource_names
#   is_manual_connection                 = local.open_ai_private_endpoint_config.is_manual_connection
#   depends_on                           = [module.RG]
# }

# #......................................................
# # Module: Private Endpoint for AI Search.
# #......................................................
# module "private_endpoint_ai_search" {
#   source                               = "../../../Modules/networking/privateEndpoint"
#   location                             = local.location
#   resource_group_name                  = local.resource_group_name
#   subnet_endpoint_id                   = module.subnet_pep.subnet_id
#   private_connection_resource_id       = local.ai_search_private_endpoint_config.private_connection_resource_id
#   private_endpoint_name                = local.ai_search_private_endpoint_config.private_endpoint_name
#   private_service_connection_name      = local.ai_search_private_endpoint_config.private_service_connection_name
#   private_dns_zone_group_name          = local.ai_search_private_endpoint_config.private_dns_zone_group_name
#   private_dns_zone_ids                 = local.ai_search_private_endpoint_config.private_dns_zone_ids
#   private_connection_subresource_names = local.ai_search_private_endpoint_config.private_connection_subresource_names
#   is_manual_connection                 = local.ai_search_private_endpoint_config.is_manual_connection
#   depends_on                           = [module.RG]
# }
