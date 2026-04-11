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
  spoke_rg_name                = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-${var.nameConfig.environment}01")
  spoke_virtual_network_name   = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vnet-${var.nameConfig.environment}01")
  subnet_compute_name          = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-snetcmp-${var.nameConfig.environment}01")
  subnet_private_endpoint_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-snetpe-${var.nameConfig.environment}01")
  compute_nsg_name             = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-nsgcmp-${var.nameConfig.environment}01")
  private_endpoint_nsg_name    = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-nsgpep-${var.nameConfig.environment}01")
  rt_name_compute              = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rt-${var.nameConfig.environment}01")

  virtual_network_diagnostics_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-diag-vnet-${var.nameConfig.environment}01")

  log_analytics_workspace_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-log-hub01")
  hub_shared_rg_name           = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-hub01")

  shir_vm_name                   = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmshir-${var.nameConfig.environment}01")
  shir_network_interface_name    = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmshirnic-${var.nameConfig.environment}01")
  shir_nic_ip_configuration_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmshirnic-ipc-${var.nameConfig.environment}01")
  shir_computer_name             = upper("${var.nameConfig.identity}${var.nameConfig.businessunit}shir${var.nameConfig.environment}01")

  odgw_vm_name                   = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmodgw-${var.nameConfig.environment}01")
  odgw_network_interface_name    = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmodgwnic-${var.nameConfig.environment}01")
  odgw_nic_ip_configuration_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmodgwnic-ipc-${var.nameConfig.environment}01")
  odgw_computer_name             = upper("${var.nameConfig.identity}${var.nameConfig.businessunit}odgw${var.nameConfig.environment}01")

  virtual_network_diagnostics = {
    enabled_log = {
      category        = []
      category_groups = ["allLogs"]
    },
    metric = ["AllMetrics"]
  }

  subnet_endpoints_null = null
  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_true = true
  private_endpoint_network_policies                  = "Disabled"

  private_dns_link_registration_enabled = false

  address_space_vnet = var.spoke_network.address_space_vnet

  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false
  private_endpoint_network_policies_disabled          = "Disabled"

  // subnet deligations 
  subnet_delegation_null = {}

  // service endpoints 
  service_endpoints = null

  identity_ids = [""]

  compute_nsg_security_rule = []

  private_endpoint_nsg_security_rule = []

  route_table_compute_routes = []

}

#Data block for Log Analytics Workspace
data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.hub_shared_rg_name
}

#Resource Block for Generating a random string
resource "random_uuid" "uuid" {}


# Creating New Resource Group
module "RG" {
  source                  = "../../Modules/rg"
  count                   = var.nameConfig.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.spoke_rg_name
  resource_group_location = var.nameConfig.defaultLocation
  rg_tags                 = var.nameConfig.tags
}


# Creating Spoke Virtual Network
module "vnet" {
  source                        = "../../Modules/networking/virtualNetwork"
  new_virtual_network_name      = local.spoke_virtual_network_name
  virtual_network_location      = var.nameConfig.defaultLocation
  virtual_network_address_space = local.address_space_vnet
  resource_group_name           = local.spoke_rg_name
  virtual_network_tags          = var.nameConfig.tags
  depends_on                    = [module.RG]
}


# Creating NSG For Compute Subnet
module "nsg_compute" {
  source       = "../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.compute_nsg_name
  nsg_location = var.nameConfig.defaultLocation
  nsg_rg_name  = local.spoke_rg_name
  sec_rule     = local.compute_nsg_security_rule
  nsg_tags     = var.nameConfig.tags
  depends_on   = [module.RG]
}


# Creating NSG For Private Endpoint Subnet
module "nsg_private_endpoint" {
  source       = "../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.private_endpoint_nsg_name
  nsg_location = var.nameConfig.defaultLocation
  nsg_rg_name  = local.spoke_rg_name
  sec_rule     = local.private_endpoint_nsg_security_rule
  nsg_tags     = var.nameConfig.tags
  depends_on   = [module.RG]
}


# Creation of Route table for Compute Subnet
module "route_table_compute" {
  source      = "../../Modules/networking/routeTable"
  rt_name     = local.rt_name_compute
  rt_location = var.nameConfig.defaultLocation
  rt_rg_name  = local.spoke_rg_name
  rt_routes   = local.route_table_compute_routes
  rt_tags     = var.nameConfig.tags
  depends_on  = [module.RG]
}


# Creation of Compute subnet
module "subnet_compute" {
  source                                        = "../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_compute_name
  subnet_address_prefixes                       = var.spoke_network.subnet_compute_address_prefix
  subnet_rg_name                                = local.spoke_rg_name
  virtual_network_name                          = local.spoke_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  rt_id                                         = module.route_table_compute.route_table_id
  nsg_id                                        = module.nsg_compute.nsg_id
  depends_on                                    = [module.vnet, module.nsg_compute]
}


# Creating Private Endpoint Subnet
module "subnet_private_endpoint" {
  source                                        = "../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_private_endpoint_name
  subnet_address_prefixes                       = var.spoke_network.subnet_private_endpoint_address_prefix
  subnet_rg_name                                = local.spoke_rg_name
  virtual_network_name                          = local.spoke_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  subnet_rt_association                         = var.spoke_network.subnet_routetable_association
  nsg_id                                        = module.nsg_private_endpoint.nsg_id
  depends_on                                    = [module.vnet, module.nsg_private_endpoint]
}

# Creating SHIR VM
module "shir_virtual_machine" {
  source                        = "../../Modules/virtualMachines"
  resource_group_name           = local.spoke_rg_name
  location                      = var.nameConfig.defaultLocation
  windows_vm_name               = local.shir_vm_name
  admin_username                = var.shirVM.admin_username
  password                      = random_uuid.uuid.result
  identity_type                 = var.shirVM.identity_type
  identity_ids                  = local.identity_ids
  caching                       = var.shirVM.caching
  computer_name                 = local.shir_computer_name
  image_version                 = var.shirVM.version
  private_ip_address_allocation = var.shirVM.private_ip_address_allocation
  nic_name                      = local.shir_network_interface_name
  size                          = var.shirVM.vmSize
  storage_account_type          = var.shirVM.storage_account_type
  subnet_id                     = module.subnet_compute.subnet_id
  windows_offer                 = var.shirVM.offer
  windows_publisher             = var.shirVM.publisher
  windows_sku                   = var.shirVM.sku
  disk_size_gb                  = var.shirVM.disk_size_gb
  nic_ip_configuration_name     = local.shir_nic_ip_configuration_name
  nic_tags                      = var.nameConfig.tags
  vm_tags                       = var.nameConfig.tags
}

# Creating ODGW VM
module "odgw_virtual_machine" {
  source                        = "../../Modules/virtualMachines"
  resource_group_name           = local.spoke_rg_name
  location                      = var.nameConfig.defaultLocation
  windows_vm_name               = local.odgw_vm_name
  admin_username                = var.odgwVM.admin_username
  password                      = random_uuid.uuid.result
  identity_type                 = var.odgwVM.identity_type
  identity_ids                  = local.identity_ids
  caching                       = var.odgwVM.caching
  computer_name                 = local.odgw_computer_name
  image_version                 = var.odgwVM.version
  private_ip_address_allocation = var.odgwVM.private_ip_address_allocation
  nic_name                      = local.odgw_network_interface_name
  size                          = var.odgwVM.vmSize
  storage_account_type          = var.odgwVM.storage_account_type
  subnet_id                     = module.subnet_compute.subnet_id
  windows_offer                 = var.odgwVM.offer
  windows_publisher             = var.odgwVM.publisher
  windows_sku                   = var.odgwVM.sku
  disk_size_gb                  = var.odgwVM.disk_size_gb
  nic_ip_configuration_name     = local.odgw_nic_ip_configuration_name
  nic_tags                      = var.nameConfig.tags
  vm_tags                       = var.nameConfig.tags
}

#Creating Diagnostics Settings for Spoke Virtual Network
module "virtual_network_diagnostics_settings" {
  source                     = "../../Modules/diagnosticsSettings"
  diagnostic_setting_name    = local.virtual_network_diagnostics_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  target_resource_id         = module.vnet.virtual_network_id
  enabled_log                = local.virtual_network_diagnostics.enabled_log
  metric                     = local.virtual_network_diagnostics.metric
}
