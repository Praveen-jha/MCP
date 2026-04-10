# ......................................................
# Creating New Resource Group
# ......................................................
module "rg" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.networking_rg_name
  resource_group_location = var.rg_location
}

# ......................................................
# Creating New Virtual Network
# ......................................................

module "vnet" {
  source                        = "../../../Modules/networking/virtualNetwork"
  new_virtual_network_name      = local.virtual_network_name
  virtual_network_location      = local.location
  virtual_network_address_space = local.address_space_vnet
  resource_group_name           = local.resource_group_name
  dns_server                    = var.dns_server
  virtual_network_tags          = var.vnet_tags
  depends_on                    = [module.rg]
}

# ...........................................................
# Creation of Subnet for Vnet Integration Python APP service
# ...........................................................

module "subnet_python_app_service" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet1_name
  subnet_address_prefixes                       = var.subnet_py_app_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.virtual_network_name
  subnet_delegations                            = local.subnet_delegation
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  rt_id                                         = module.route_table_python_app.route_table_id
  nsg_id     = module.nsg_py_app.nsg_id
  depends_on = [module.vnet, module.route_table_python_app, module.nsg_py_app]
}

# ......................................................
# Creation of Compute Subnet
# ......................................................

module "subnet_compute" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_compute_name
  subnet_address_prefixes                       = var.subnet_compute_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  rt_id                                         = module.route_table_compute.route_table_id
  nsg_id                = module.nsg_compute.nsg_id
  depends_on            = [module.vnet, module.nsg_compute, module.route_table_compute]
}

# ........................................................
# Creation of Subnet Vnet Integration for Node App Service
# ......................................................

module "subnet_node_app_service" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet2_name
  subnet_address_prefixes                       = var.subnet_node_app_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.virtual_network_name
  subnet_delegations                            = local.subnet_delegation
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  rt_id                                         = module.route_table_node_app.route_table_id
  nsg_id     = module.nsg_node_app.nsg_id
  depends_on = [module.vnet, module.route_table_node_app, module.nsg_node_app]
}

# ......................................................
# Creation of Private Endpoint Subnet
# ......................................................

module "subnet_pep" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_pep_name
  subnet_address_prefixes                       = var.subnet_pep_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_pep
  rt_id                                         = module.route_table_pep.route_table_id
  nsg_id                                        = module.nsg_pep.nsg_id
  depends_on                                    = [module.vnet, module.route_table_pep, module.nsg_pep]
}

# ......................................................
# Creation of Virtual network peering from HUB to Spoke
# ......................................................

module "vnet_peering" {
  source                       = "../../../Modules/networking/VNetPeering"
  peering_name_spoke_to_hub    = local.peering_name_spoke_to_hub
  peering_name_hub_to_spoke    = local.peering_name_hub_to_spoke
  spoke_rg_name                = module.rg[0].resource_group_name
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
# Creation of Network security Group for compute subnet
# ......................................................

module "nsg_compute" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.compute_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.compute_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.rg]
}

# ......................................................
# Creation of Network security Group for Pep subnet
# ......................................................

module "nsg_pep" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.pep_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.pep_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.rg]
}


# ......................................................
# Creation of Network security Group for Python APP subnet
# ......................................................

module "nsg_py_app" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.py_app_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.py_app_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.rg]
}

# ......................................................
# Creation of Network security Group for Node App subnet
# ......................................................

module "nsg_node_app" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.node_app_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.node_app_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.rg]
}

# ......................................................
# Creation of Route Table for PEP subnet
# ......................................................

module "route_table_pep" {
  source      = "../../../Modules/networking/routeTable"
  rt_name     = local.route_table_pep_name
  rt_location = local.location
  rt_rg_name  = local.resource_group_name
  rt_routes   = local.route_table_pep_routes
  rt_tags     = var.rt_tags
  depends_on  = [module.rg]
}

# ......................................................
# Creation of Route Table for Python App service subnet
# ......................................................

module "route_table_python_app" {
  source      = "../../../Modules/networking/routeTable"
  rt_name     = local.route_table_python_app_name
  rt_location = local.location
  rt_rg_name  = local.resource_group_name
  rt_routes   = local.route_table_python_app_routes
  rt_tags     = var.rt_tags
  depends_on  = [module.rg]
}

# ......................................................
# Creation of Route Table for Node App service subnet
# ......................................................

module "route_table_node_app" {
  source      = "../../../Modules/networking/routeTable"
  rt_name     = local.route_table_node_app_name
  rt_location = local.location
  rt_rg_name  = local.resource_group_name
  rt_routes   = local.route_table_node_app_routes
  rt_tags     = var.rt_tags
  depends_on  = [module.rg]
}

# ......................................................
# Creation of Route Table for Compute subnet
# ......................................................

module "route_table_compute" {
  source      = "../../../Modules/networking/routeTable"
  rt_name     = local.route_table_compute_name
  rt_location = local.location
  rt_rg_name  = local.resource_group_name
  rt_routes   = local.route_table_compute_routes
  rt_tags     = var.rt_tags
  depends_on  = [module.rg]
}
