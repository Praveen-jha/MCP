# Creating New Resource Group
module "resource_group" {
  source                  = "../../module/rg"
  count                   = var.nameConfig.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.new_resource_group_name
  resource_group_location = var.nameConfig.defaultLocation
  rg_tags                 = var.nameConfig.tags
}

# Creating NSG For Compute Subnet
module "nsg_compute" {
  source       = "../../module/networking/networkSecurityGroup"
  count        = var.nameConfig.nsg_creation == "new" ? 1 : 0
  nsg_name     = local.new_compute_nsg_name
  nsg_location = var.nameConfig.defaultLocation
  nsg_rg_name  = local.rg_name
  sec_rule     = var.compute_nsg_security_rule
  nsg_tags     = var.nameConfig.tags
  depends_on   = [module.resource_group]
}

# Creating Virtual Network
module "virtual_network" {
  source                        = "../../module/networking/virtualNetwork"
  count                         = var.nameConfig.vnet_creation == "new" ? 1 : 0
  new_virtual_network_name      = local.new_virtual_network_name
  virtual_network_location      = var.nameConfig.defaultLocation
  virtual_network_address_space = var.network.address_space_vnet
  resource_group_name           = local.rg_name
  virtual_network_tags          = var.nameConfig.tags
  depends_on                    = [module.resource_group, module.nsg_compute]
}


# Creation of Compute subnet
module "subnet_compute" {
  source                                        = "../../module/networking/subnet"
  count                                         = var.nameConfig.subnet_creation == "new" ? 1 : 0
  subnet_name                                   = local.new_subnet_name
  subnet_address_prefixes                       = var.network.subnet_compute_address_prefix
  subnet_rg_name                                = local.rg_name
  virtual_network_name                          = local.virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  subnet_rt_association                         = var.network.subnet_routetable_association
  nsg_id                                        = var.nameConfig.nsg_creation == "new" ? module.nsg_compute[0].nsg_id : data.azurerm_network_security_group.exisitng_network_security_group[0].id
  depends_on                                    = [module.virtual_network, module.nsg_compute]
}

# Creating SHA VM
module "virtual_machine" {
  source                        = "../../module/virtual_machine"
  resource_group_name           = local.rg_name
  location                      = var.nameConfig.defaultLocation
  windows_vm_name               = local.vm_name
  data_disks_name               = local.data_disks_name
  admin_username                = var.VM.admin_username
  password                      = var.VM.admin_password
  identity_type                 = var.VM.identity_type
  caching                       = var.VM.caching
  computer_name                 = local.computer_name
  image_version                 = var.VM.version
  private_ip_address_allocation = var.VM.private_ip_address_allocation
  nic_name                      = local.network_interface_name
  size                          = var.VM.vmSize
  storage_account_type          = var.VM.storage_account_type
  subnet_id                     = var.nameConfig.subnet_creation == "new" ? module.subnet_compute[0].subnet_id : data.azurerm_subnet.existing_subnet[0].id
  windows_offer                 = var.VM.offer
  windows_publisher             = var.VM.publisher
  windows_sku                   = var.VM.sku
  disk_size_gb                  = var.VM.disk_size_gb
  nic_ip_configuration_name     = local.nic_ip_configuration_name
  nic_tags                      = var.nameConfig.tags
  vm_tags                       = var.nameConfig.tags
  dataDiskResources             = var.dataDiskResources
  depends_on                    = [module.resource_group, module.subnet_compute]
}

# # Creating SHA VM
# module "virtual_machine" {
#   source                        = "../../module/virtual_machine"
#   resource_group_name           = local.rg_name
#   location                      = var.nameConfig.defaultLocation
#   windows_vm_name               = local.vm_name
#   data_disks_name               = local.data_disks_name
#   admin_username                = var.VM.admin_username
#   password                      = var.VM.admin_password
#   identity_type                 = var.VM.identity_type
#   caching                       = var.VM.caching
#   computer_name                 = local.computer_name
#   image_version                 = var.VM.version
#   private_ip_address_allocation = var.VM.private_ip_address_allocation
#   nic_name                      = local.network_interface_name
#   size                          = var.VM.vmSize
#   storage_account_type          = var.VM.storage_account_type
#   subnet_id                     = var.nameConfig.subnet_creation == "new" ? module.subnet_compute[0].subnet_id : data.azurerm_subnet.existing_subnet[0].id
#   windows_offer                 = var.VM.offer
#   windows_publisher             = var.VM.publisher
#   windows_sku                   = var.VM.sku
#   disk_size_gb                  = var.VM.disk_size_gb
#   nic_ip_configuration_name     = local.nic_ip_configuration_name
#   nic_tags                      = var.nameConfig.tags
#   vm_tags                       = var.nameConfig.tags
#   dataDiskResources             = var.dataDiskResources
#   depends_on                    = [module.resource_group, module.subnet_compute]
# }

# module "sql_virtual_machine" {
#   source                    = "../../module/sql_vm"
#   virtual_machine_id        = module.virtual_machine.virtual_machine_id
#   sql_license_type          = var.sqlVM.sql_license_type
#   sqlAuthenticationLogin    = var.sqlVM.sqlAuthenticationLogin
#   sqlAuthenticationPassword = var.sqlVM.sqlAuthenticationPassword
#   sqlConnectivityType       = var.sqlVM.sqlConnectivityType
#   sqlPortNumber             = var.sqlVM.sqlPortNumber
#   storage_configuration     = var.sql_vm_storage_configuration
#   key_vault_credential      = var.key_vault_credential
#   auto_patching             = var.auto_patching
#   auto_backup               = var.auto_backup
#   sql_instance              = var.sql_instance   
#   depends_on                = [module.virtual_machine]
# }
