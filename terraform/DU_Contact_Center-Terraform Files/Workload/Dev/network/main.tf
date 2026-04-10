# ......................................................
# Creating New Resource Group _previous
# ......................................................
module "RG" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.dev_network_rg_name
  resource_group_location = var.rg_location
  resource_group_tags     = var.resource_group_tags
}

# ......................................................
#  Creating dev Virtual Network
#  ......................................................
module "vnet" {
  source                        = "../../../Modules/networking/virtualNetwork"
  virtual_network_name          = local.dev_virtual_network_name
  virtual_network_location      = local.location
  virtual_network_address_space = var.address_space_vnet
  resource_group_name           = local.resource_group_name
  dns_server                    = var.custom_dns_ip
  virtual_network_tags          = var.vnet_tags
  depends_on                    = [module.RG]
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
  virtual_network_name                          = local.dev_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_pep_subnet
  nsg_ids                                       = [module.nsg_pep.nsg_id]
  rt_ids                                        = [module.pep_route_table.route_table_id]
  depends_on                                    = [module.vnet]
}

# .......................................................
# Route Table
# .......................................................
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

module "nsg_pep" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.pep_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.pep_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.RG]
}

# # ......................................................
# # Creation of Virtual network peering from Hub to Spoke
# # ......................................................
module "vnet_peering" {
  source                       = "../../../Modules/networking/VNetPeering"
  peering_name_spoke_to_hub    = local.peering_name_spoke_to_hub
  peering_name_hub_to_spoke    = local.peering_name_hub_to_spoke
  spoke_rg_name                = module.RG[0].resource_group_name
  spoke_vnet_name              = module.vnet.virtual_network_name
  spoke_vnet_id                = module.vnet.virtual_network_id
  hub_subscription_id          = var.hub_subscription_id
  allow_forwarded_traffic      = local.allow_forwarded_traffic
  allow_virtual_network_access = local.allow_virtual_network_access
  spoke_subscription_id        = var.dev_subscription_id
  hub_vnet_id                  = var.hub_vnet_id
  hub_rg_name                  = var.hub_rg_name
  hub_vnet_name                = var.hub_vnet_name
}
