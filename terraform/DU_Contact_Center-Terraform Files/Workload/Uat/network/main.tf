# ......................................................
# Creating New Resource Group _previous
# ......................................................
module "RG" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.uat_network_rg_name
  resource_group_location = var.rg_location
  resource_group_tags     = var.resource_group_tags
}

# ......................................................
#  Creating uat Virtual Network
# ......................................................
module "vnet" {
  source                        = "../../../Modules/networking/virtualNetwork"
  virtual_network_name          = local.uat_virtual_network_name
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
module "subnet_apim" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.apim_subnet_name
  location                                      = local.location
  subnet_address_prefixes                       = var.subnet_apim_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.uat_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_pep_subnet
  nsg_ids                                       = [module.nsg_apim.nsg_id]
  rt_ids                                        = [module.apim_route_table.route_table_id]
  depends_on                                    = [module.vnet]
}

# ......................................................
# Creation of APIM Network Security Group
# ......................................................
module "nsg_apim" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.apim_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.apim_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.RG]
}

module "apim_route_table" {
  source                        = "../../../Modules/networking/routeTable"
  rt_name                       = local.rt_apim_name
  rt_location                   = local.location
  rt_rg_name                    = local.resource_group_name
  rt_routes                     = local.rt_apim_routes
  rt_tags                       = var.rt_tags
  depends_on                    = [module.RG]
  bgp_route_propagation_enabled = local.bgp_route_propagation
}
