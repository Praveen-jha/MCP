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
  hub_network_rg_name           = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-rg-${var.nameConfig.environment}01")
  hub_virtual_network_name      = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vnet-${var.nameConfig.environment}01")
  sha_vm_name                   = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmsha-${var.nameConfig.environment}01")
  sha_network_interface_name    = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmshanic-${var.nameConfig.environment}01")
  sha_nic_ip_configuration_name = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-vmshanic-ipc-${var.nameConfig.environment}01")
  sha_computer_name             = upper("${var.nameConfig.identity}${var.nameConfig.businessunit}sha${var.nameConfig.environment}01")
  subnet_compute_name           = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-snetcmp-${var.nameConfig.environment}01")
  compute_nsg_name              = upper("${var.nameConfig.identity}-${var.nameConfig.businessunit}-nsgcmp-${var.nameConfig.environment}01")

  identity_ids = [""]

  // subnet deligations 
  subnet_delegation_null = {}

  // service endpoints 
  service_endpoints = null

  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false

  private_endpoint_network_policies = "Disabled"

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

#Data block for Compute Subnet
data "azurerm_subnet" "compute_subnet" {
  name                 = local.subnet_compute_name
  virtual_network_name = data.azurerm_virtual_network.hub_vnet.name
  resource_group_name  = data.azurerm_resource_group.hub_network_resource_group[0].name
}

#Resource Block for Generating a random string
resource "random_uuid" "uuid" {}

# Creating SHA VM
module "self_hosted_agent_virtual_machine" {
  source                        = "../../Modules/virtualMachines"
  resource_group_name           = local.hub_network_rg_name
  location                      = var.nameConfig.defaultLocation
  windows_vm_name               = local.sha_vm_name
  admin_username                = var.shaVM.admin_username
  password                      = random_uuid.uuid.result
  identity_type                 = var.shaVM.identity_type
  identity_ids                  = local.identity_ids
  caching                       = var.shaVM.caching
  computer_name                 = local.sha_computer_name
  image_version                 = var.shaVM.version
  private_ip_address_allocation = var.shaVM.private_ip_address_allocation
  nic_name                      = local.sha_network_interface_name
  size                          = var.shaVM.vmSize
  storage_account_type          = var.shaVM.storage_account_type
  subnet_id                     = data.azurerm_subnet.compute_subnet.id
  windows_offer                 = var.shaVM.offer
  windows_publisher             = var.shaVM.publisher
  windows_sku                   = var.shaVM.sku
  disk_size_gb                  = var.shaVM.disk_size_gb
  nic_ip_configuration_name     = local.sha_nic_ip_configuration_name
  nic_tags                      = var.nameConfig.tags
  vm_tags                       = var.nameConfig.tags
}
