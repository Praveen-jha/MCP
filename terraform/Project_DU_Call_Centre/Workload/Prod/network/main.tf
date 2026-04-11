# ......................................................
# Creating New Resource Group
# ......................................................
module "rg" {
  source                  = "../../../Modules/rg"
  resource_group_name     = local.networking_rg_name
  resource_group_location = var.location
}

# ......................................................
# Creating New Virtual Network
# ......................................................
module "vnet" {
  source                        = "../../../Modules/networking/virtualNetwork"
  virtual_network_name          = local.virtual_network_name
  virtual_network_location      = var.location
  virtual_network_address_space = local.address_space_vnet
  resource_group_name           = local.networking_rg_name
  dns_server                    = var.dns_server
  virtual_network_tags          = merge(var.tags, var.vnet_tags)
  depends_on                    = [module.rg]
}

# # ........................................................
# # Creation of ML service subnet
# # ......................................................

# module "subnet_ml_service" {
#   source                                        = "../../../Modules/networking/subnet"
#   subnet_name                                   = local.subnet_ml_name
#   subnet_address_prefixes                       = var.subnet_ml_address_prefix
#   subnet_rg_name                                = local.networking_rg_name
#   virtual_network_name                          = local.virtual_network_name
#   location                                      = var.location
#   subnet_delegations                            = local.subnet_delegation_null
#   service_endpoints                             = local.subnet_endpoints_null
#   private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
#   private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
#   subnet_rt_association                         = var.subnet_routetable_association
#   rt_id                                         = module.route_table_ml.route_table_id
#   subnet_nsg_association = var.subnet_nsg_association
#   nsg_id                                        = module.nsg_ml.nsg_id
#   depends_on = [module.vnet, module.rg, module.route_table_ml]
# }

# ......................................................
# Creation of Subnet for APIM
# ......................................................
module "subnet_apim" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_apim_name
  subnet_address_prefixes                       = var.subnet_apim_address_prefix
  subnet_rg_name                                = local.networking_rg_name
  virtual_network_name                          = local.virtual_network_name
  location                                      = var.location
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  subnet_rt_association                         = var.subnet_apim_routetable_association
  # rt_id                                         = module.route_table_apim.route_table_id
  subnet_nsg_association                        = var.subnet_apim_nsg_association
  nsg_id                                        = module.nsg_apim.nsg_id
  depends_on                                    = [module.vnet, module.rg]
}

# ......................................................
# Creation of Subnet for Private Endpoint
# ......................................................
module "subnet_pep" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_pep_name
  subnet_address_prefixes                       = var.subnet_pep_address_prefix
  subnet_rg_name                                = local.networking_rg_name
  virtual_network_name                          = local.virtual_network_name
  location                                      = var.location
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_true
  private_endpoint_network_policies             = "Enabled"
  subnet_rt_association                         = var.subnet_routetable_association
  rt_id                                         = module.route_table_pep.route_table_id
  subnet_nsg_association                        = var.subnet_nsg_association
  nsg_id                                        = module.nsg_pep.nsg_id
  depends_on                                    = [module.vnet, module.rg, module.route_table_pep]
}

# ......................................................
# Creation of Compute Subnet
# ......................................................
module "subnet_compute" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_compute_name
  subnet_address_prefixes                       = var.subnet_compute_address_prefix
  subnet_rg_name                                = local.networking_rg_name
  virtual_network_name                          = local.virtual_network_name
  location                                      = var.location
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  subnet_rt_association                         = var.subnet_routetable_association
  rt_id                                         = module.route_table_compute.route_table_id
  subnet_nsg_association                        = var.subnet_nsg_association
  nsg_id                                        = module.nsg_compute.nsg_id
  depends_on                                    = [module.vnet, module.rg, module.route_table_compute]
}

# ......................................................
# Creation of Virtual network peering from Spoke to Hub
# ......................................................
module "vnet_peering" {
  source                       = "../../../Modules/networking/VNetPeering"
  peering_name_spoke_to_hub    = local.peering_name_spoke_to_hub
  peering_name_hub_to_spoke    = local.peering_name_hub_to_spoke
  spoke_rg_name                = module.rg.resource_group_name
  spoke_vnet_name              = module.vnet.virtual_network_name
  hub_vnet_id                  = var.hub_vnet_id
  hub_rg_name                  = var.hub_rg_name
  hub_vnet_name                = var.hub_vnet_name
  allow_forwarded_traffic      = local.allow_forwarded_traffic
  allow_virtual_network_access = local.allow_virtual_network_access
  hub_subscription_id          = var.hub_subscription_id
  spoke_subscription_id        = var.spoke_subscription_id
  spoke_vnet_id                = module.vnet.virtual_network_id
}

# ......................................................
# Creation of Network security Group for ML subnet
# ......................................................

# module "nsg_ml" {
#   source       = "../../../Modules/networking/networkSecurityGroup"
#   nsg_name     = local.ml_nsg_name
#   nsg_location = var.location
#   nsg_rg_name  = local.networking_rg_name
#   sec_rule     = local.ml_nsg_security_rule
#   nsg_tags     = merge(var.tags, var.nsg_tags)
#   depends_on   = [module.rg]
# }

# ......................................................
# Creation of Network security Group for compute subnet
# ......................................................

module "nsg_compute" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.compute_nsg_name
  nsg_location = var.location
  nsg_rg_name  = local.networking_rg_name
  sec_rule     = local.compute_nsg_security_rule
  nsg_tags     = merge(var.tags, var.nsg_tags)
  depends_on   = [module.rg]
}

# ......................................................
# Creation of Network security Group for private endpoint subnet
# ......................................................
module "nsg_pep" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.pep_nsg_name
  nsg_location = var.location
  nsg_rg_name  = local.networking_rg_name
  sec_rule     = local.pep_nsg_security_rule
  nsg_tags     = merge(var.tags, var.nsg_tags)
  depends_on   = [module.rg]
}

# ......................................................
# Creation of Network security Group for APIM subnet
# ......................................................
module "nsg_apim" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.apim_nsg_name
  nsg_location = var.location
  nsg_rg_name  = local.networking_rg_name
  sec_rule     = local.apim_nsg_security_rule
  nsg_tags     = merge(var.tags, var.nsg_tags)
  depends_on   = [module.rg]
}

# ......................................................
# Creation of Route Table for ML service subnet
# ......................................................

# module "route_table_ml" {
#   source                        = "../../../Modules/networking/routeTable"
#   rt_name                       = local.route_table_ml_name
#   rt_location                   = var.location
#   rt_rg_name                    = local.networking_rg_name
#   disable_bgp_route_propagation = local.disable_bgp_route_propagation
#   rt_routes                     = local.route_table_ml_routes
#   rt_tags                       = merge(var.tags, var.rt_tags)
#   depends_on                    = [module.rg]
# }

# ......................................................
# Creation of Route Table for APIM subnet
# ......................................................
module "route_table_apim" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.route_table_apim_name
  rt_location                   = var.location
  rt_rg_name                    = local.networking_rg_name
  disable_bgp_route_propagation = local.disable_bgp_route_propagation
  rt_routes                     = local.route_table_apim_routes
  rt_tags                       = merge(var.tags, var.rt_tags)
  depends_on                    = [module.rg]
}

# ......................................................
# Creation of Route Table for PEP subnet
# ......................................................
module "route_table_pep" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.route_table_pep_name
  rt_location                   = var.location
  rt_rg_name                    = local.networking_rg_name
  disable_bgp_route_propagation = local.disable_bgp_route_propagation
  rt_routes                     = local.route_table_pep_routes
  rt_tags                       = merge(var.tags, var.rt_tags)
  depends_on                    = [module.rg]
}

# ......................................................
# Creation of Route Table for Compute subnet
# ......................................................
module "route_table_compute" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.route_table_compute_name
  rt_location                   = var.location
  rt_rg_name                    = local.networking_rg_name
  disable_bgp_route_propagation = local.disable_bgp_route_propagation
  rt_routes                     = local.route_table_compute_routes
  rt_tags                       = merge(var.tags, var.rt_tags)
  depends_on                    = [module.rg]
}

# ......................................................
# Creating Extenal APIM Public IP
# ......................................................
module "public_ip_apim" {
  source              = "../../../Modules/networking/publicIp" # adjust this path to where your module is
  public_ip_name      = local.apim_public_ip_name
  resource_group_name = local.networking_rg_name
  location            = var.location
  allocation_method   = var.apim_public_ip.allocation_method
  sku                 = var.apim_public_ip.sku
  domain_name_label   = var.apim_public_ip.domain_name_label
  tags                = merge(var.tags, var.apim_public_ip.tags)
}