# Define required providers - Azure.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

# Configure Azure provider for Azure Authentication.
provider "azurerm" {
  features {}
}

#Local Block for Resource Naming Conventions
locals {
  hub_network_rg_name      = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-${var.nameConfig.environment}01")
  hub_virtual_network_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vnet-${var.nameConfig.environment}01")
  vpngw_name               = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vng-${var.nameConfig.environment}01")
  vpngw_pip_name           = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vng-pip-${var.nameConfig.environment}01")
  ip_configuration_name    = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vng-pipconfig-${var.nameConfig.environment}01")
  lng_name                 = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-lng-${var.nameConfig.environment}01")
  subnet_vpngw_name        = "GatewaySubnet"
}


#Data block for Hub Network Resource Group
data "azurerm_resource_group" "hub_network_resource_group" {
  count = var.nameConfig.rg_creation == "existing" ? 1 : 0
  name  = local.hub_network_rg_name
}


#Data block for Hub Virtual Network
data "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_virtual_network_name
  resource_group_name = data.azurerm_resource_group.hub_network_resource_group[0].name
}


#Data block for Virtual Network Gateway Subnet
data "azurerm_subnet" "vpngw_subnet" {
  name                 = local.subnet_vpngw_name
  virtual_network_name = data.azurerm_virtual_network.hub_vnet.name
  resource_group_name  = data.azurerm_resource_group.hub_network_resource_group[0].name
}


#Create VPN Gateway
module "vpngw" {
  source                        = "../../Modules/networking/VPNGateway"
  resource_group_name           = data.azurerm_resource_group.hub_network_resource_group[0].name
  virtual_network_gateway_name  = local.vpngw_name
  vpn_type                      = var.vpnGateway.vpn_type
  enable_bgp                    = var.vpnGateway.enable_bgp
  active_active                 = var.vpnGateway.enable_active_active
  ip_configuration_name         = local.ip_configuration_name
  gateway_subnet_id             = data.azurerm_subnet.vpngw_subnet.id
  gateway_public_ip_id          = module.pip_vpn.public_ip_id
  gateway_sku                   = var.vpnGateway.gateway_sku
  gateway_type                  = var.vpnGateway.vpn_gw_type
  private_ip_address_allocation = var.vpnGateway.private_ip_address_allocation
  location                      = var.nameConfig.defaultLocation
  tags                          = var.nameConfig.tags
  depends_on                    = [module.pip_vpn]
}


# Creation of VPN Gateway PIP
module "pip_vpn" {
  source                = "../../Modules/networking/publicIP"
  pip_name              = local.vpngw_pip_name
  pip_allocation_method = var.publicIP.private_ip_address_allocation
  pip_sku               = var.publicIP.pip_sku
  resource_group_name   = data.azurerm_resource_group.hub_network_resource_group[0].name
  location              = var.nameConfig.defaultLocation
  pip_tags              = var.nameConfig.tags
}


# Creation of local network gateway
module "lng" {
  source                  = "../../Modules/networking/localNetworkGateway"
  lng_name                = local.lng_name
  lng_resource_group_name = data.azurerm_resource_group.hub_network_resource_group[0].name
  lng_location            = var.nameConfig.defaultLocation
  lng_address             = var.lng.lng_address
  lng_address_space       = var.lng.lng_address_space
}
