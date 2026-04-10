#Local Block for Resource Naming Conventions
locals {
  hub_network_rg_name              = "rg34"
  hub_virtual_network_name         = "vnet34"
  subnet_compute_name              = "compute-subnet"
  compute_nsg_name                 = "compute-nsg34"
  sha_vm_name                      = "vm-sql-terraform"
  sha_network_interface_name       = "vm-sql-terraform-nic"
  sha_nic_ip_configuration_name    = "vm-sql-terraform-ipconfig"
  sha_computer_name                = "vmsqltf"
  failover_cluster_name            = "overfail13"
  listener_name                    = "listner13"
  vm_names                         = ["vm-sqlc", "vm-sqlb"]
  storage_account_name             = "failoverstr1313"
  storage_account_replication_type = "LRS"
  storage_account_tier             = "Standard"
  //subnet private link service network policies enabled or disabled
  private_link_service_network_policies_enabled_false = false

  private_endpoint_network_policies = "Disabled"

  private_dns_link_registration_enabled = false

  // subnet deligations 
  subnet_delegation_null = {}

  // service endpoints 
  service_endpoints = null

  compute_nsg_security_rule = [
    {
      name                       = "Allow_RDP"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_ranges    = null
    }
  ]

  route_table_vpn_routes = []
}

# Creating New Resource Group
module "RG" {
  source                  = "../../module/rg"
  count                   = var.nameConfig.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.hub_network_rg_name
  resource_group_location = var.nameConfig.defaultLocation
  rg_tags                 = var.nameConfig.tags
}

# Creating NSG For Compute Subnet
module "nsg_compute" {
  source       = "../../module/networking/networkSecurityGroup"
  nsg_name     = local.compute_nsg_name
  nsg_location = var.nameConfig.defaultLocation
  nsg_rg_name  = local.hub_network_rg_name
  sec_rule     = local.compute_nsg_security_rule
  nsg_tags     = var.nameConfig.tags
  depends_on   = [module.RG]
}

# Creating Hub Virtual Network
module "vnet" {
  source                        = "../../module/networking/virtualNetwork"
  new_virtual_network_name      = local.hub_virtual_network_name
  virtual_network_location      = var.nameConfig.defaultLocation
  virtual_network_address_space = var.hub_network.address_space_vnet
  resource_group_name           = local.hub_network_rg_name
  virtual_network_tags          = var.nameConfig.tags
  depends_on                    = [module.RG]
}


# Creation of Compute subnet
module "subnet_compute" {
  source                                        = "../../module/networking/subnet"
  count                                         = var.enable_high_availability == false ? 1 : 0
  subnet_name                                   = local.subnet_compute_name
  subnet_address_prefixes                       = var.hub_network.subnet_compute_address_prefix
  subnet_rg_name                                = local.hub_network_rg_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  subnet_rt_association                         = var.hub_network.subnet_routetable_association
  nsg_id                                        = module.nsg_compute.nsg_id
  depends_on                                    = [module.vnet]
}

# Creating SHA VM
module "virtual_machine" {
  source                        = "../../module/virtual_machine"
  count                         = var.enable_high_availability == false ? 1 : 0
  resource_group_name           = local.hub_network_rg_name
  location                      = var.nameConfig.defaultLocation
  windows_vm_name               = local.sha_vm_name
  admin_username                = var.shaVM.admin_username
  password                      = var.shaVM.admin_password
  identity_type                 = var.shaVM.identity_type
  caching                       = var.shaVM.caching
  computer_name                 = local.sha_computer_name
  image_version                 = var.shaVM.version
  private_ip_address_allocation = var.shaVM.private_ip_address_allocation
  nic_name                      = local.sha_network_interface_name
  size                          = var.shaVM.vmSize
  storage_account_type          = var.shaVM.storage_account_type
  subnet_id                     = module.subnet_compute[0].subnet_id
  windows_offer                 = var.shaVM.offer
  windows_publisher             = var.shaVM.publisher
  windows_sku                   = var.shaVM.sku
  disk_size_gb                  = var.shaVM.disk_size_gb
  nic_ip_configuration_name     = local.sha_nic_ip_configuration_name
  nic_tags                      = var.nameConfig.tags
  vm_tags                       = var.nameConfig.tags
  dataDiskResources             = var.dataDiskResources
  depends_on                    = [module.RG]
}

resource "azurerm_virtual_machine_extension" "aad_login" {
  count                      = var.enable_high_availability == false ? 1 : 0
  name                       = "${local.sha_vm_name}-AADLogin"
  virtual_machine_id         = module.virtual_machine[0].virtual_machine_id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  #   settings = jsonencode({
  #     mdmId = ""
  #   })
}

module "sql_virtual_machine" {
  source                    = "../../module/sql_vm"
  count                     = var.enable_high_availability == false ? 1 : 0
  virtual_machine_id        = module.virtual_machine[0].virtual_machine_id
  sql_license_type          = var.sqlVM.sql_license_type
  sqlAuthenticationLogin    = var.sqlVM.sqlAuthenticationLogin
  sqlAuthenticationPassword = var.sqlVM.sqlAuthenticationPassword
  sqlConnectivityType       = var.sqlVM.sqlConnectivityType
  sqlPortNumber             = var.sqlVM.sqlPortNumber
}
