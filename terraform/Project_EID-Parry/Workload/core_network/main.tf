# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
}

#Local Block for Resource Naming Conventions
locals {
  hub_network_rg_name          = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-${var.nameConfig.environment}01")
  hub_virtual_network_name     = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vnet-${var.nameConfig.environment}01")
  subnet_compute_name          = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-snetcmp-${var.nameConfig.environment}01")
  compute_nsg_name             = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-nsgcmp-${var.nameConfig.environment}01")
  private_endpoint_nsg_name    = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-nsgpe-${var.nameConfig.environment}01")
  subnet_private_endpoint_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-snetpe-${var.nameConfig.environment}01")
  subnet_Firewall_name         = "AzureFirewallSubnet"
  subnet_vpngw_name            = "GatewaySubnet"
  rt_name_vpn                  = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rt-${var.nameConfig.environment}01")
  rt_name_compute              = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rtcmp-${var.nameConfig.environment}01")

  subnet_endpoints_null = null
  //subnet private link service network policies enabled or disabled
  # private_link_service_network_policies_enabled_true  = true
  private_endpoint_network_policies_disabled = "Disabled"

  address_space_vnet = var.hub_network.address_space_vnet

  identity_ids = [""]

  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false

  private_endpoint_network_policies = "Disabled"

  private_dns_link_registration_enabled = false

  // subnet deligations 
  subnet_delegation_null = {}

  // service endpoints 
  service_endpoints = null

  compute_nsg_security_rule = []

  private_endpoint_nsg_security_rule = []

  route_table_vpn_routes = []
}


#Data block for Hub Network Resource Group
data "azurerm_resource_group" "hub_network_rg" {
  count = var.nameConfig.rg_creation == "existing" ? 1 : 0
  name  = local.hub_network_rg_name
}


# Creating NSG For Compute Subnet
module "nsg_compute" {
  source       = "../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.compute_nsg_name
  nsg_location = var.nameConfig.defaultLocation
  nsg_rg_name  = local.hub_network_rg_name
  sec_rule     = local.compute_nsg_security_rule
  nsg_tags     = var.nameConfig.tags
}

# Creating NSG For Private Endpoint Subnet
module "nsg_private_endpoint" {
  source       = "../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.private_endpoint_nsg_name
  nsg_location = var.nameConfig.defaultLocation
  nsg_rg_name  = local.hub_network_rg_name
  sec_rule     = local.private_endpoint_nsg_security_rule
  nsg_tags     = var.nameConfig.tags
}


# Creation of Route table for VPN Gateway Subnet
module "route_table_vpn" {
  source      = "../../Modules/networking/routeTable"
  rt_name     = local.rt_name_vpn
  rt_location = var.nameConfig.defaultLocation
  rt_rg_name  = local.hub_network_rg_name
  rt_routes   = local.route_table_vpn_routes
  rt_tags     = var.nameConfig.tags
}

# Creation of Route table for Compute Subnet
module "route_table_compute" {
  source      = "../../Modules/networking/routeTable"
  rt_name     = local.rt_name_compute
  rt_location = var.nameConfig.defaultLocation
  rt_rg_name  = local.hub_network_rg_name
  rt_routes   = local.route_table_vpn_routes
  rt_tags     = var.nameConfig.tags
}


# Creating Hub Virtual Network
module "vnet" {
  source                        = "../../Modules/networking/virtualNetwork"
  new_virtual_network_name      = local.hub_virtual_network_name
  virtual_network_location      = var.nameConfig.defaultLocation
  virtual_network_address_space = local.address_space_vnet
  resource_group_name           = local.hub_network_rg_name
  virtual_network_tags          = var.nameConfig.tags
}


# Creation of Compute subnet
module "subnet_compute" {
  source                                        = "../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_compute_name
  subnet_address_prefixes                       = var.hub_network.subnet_compute_address_prefix
  subnet_rg_name                                = local.hub_network_rg_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  rt_id                                         = module.route_table_compute.route_table_id
  nsg_id                                        = module.nsg_compute.nsg_id
  depends_on                                    = [module.vnet]
}


# Creation of VPN Gateway Subnet
module "subnet_vpn" {
  source                                        = "../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_vpngw_name
  subnet_address_prefixes                       = var.hub_network.subnet_vpn_address_prefix
  subnet_rg_name                                = local.hub_network_rg_name
  virtual_network_name                          = local.hub_virtual_network_name
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  subnet_nsg_association                        = var.hub_network.subnet_nsg_association
  rt_id                                         = module.route_table_vpn.route_table_id
  depends_on                                    = [module.vnet]
}


# Creation of Private Endpoint Subnet
module "subnet_private_endpoint" {
  source                                        = "../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_private_endpoint_name
  subnet_address_prefixes                       = var.hub_network.subnet_private_endpoint_address_prefix
  subnet_rg_name                                = local.hub_network_rg_name
  virtual_network_name                          = local.hub_virtual_network_name
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  nsg_id                                        = module.nsg_private_endpoint.nsg_id
  subnet_rt_association                         = var.hub_network.subnet_routetable_association
  depends_on                                    = [module.vnet]
}
