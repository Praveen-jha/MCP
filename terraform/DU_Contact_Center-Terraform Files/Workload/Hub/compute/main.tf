# ......................................................
# Creating New Resource Group
# ......................................................
module "rg" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.hub_comp_rg_name
  resource_group_location = var.rg_location
  resource_group_tags     = var.resource_group_tags
}

# ......................................................
# Creating windows VMs
# ......................................................

module "windows_vm" {
  source                        = "../../../Modules/virtualMachines/windows"
  for_each                      = local.windows_vm_name
  resource_group_name           = local.hub_comp_rg_name
  windows_vm_name               = each.value
  size                          = var.windows_vm_configs[each.key].size
  windows_sku                   = var.windows_vm_configs[each.key].windows_sku
  windows_offer                 = var.windows_vm_configs[each.key].windows_offer
  windows_publisher             = var.windows_vm_configs[each.key].windows_publisher
  admin_username                = var.windows_vm_configs[each.key].admin_username
  password                      = var.windows_vm_configs[each.key].password
  computer_name                 = var.windows_vm_configs[each.key].computer_name
  location                      = var.location
  private_ip_address_allocation = var.windows_vm_configs[each.key].private_ip_address_allocation
  caching                       = var.windows_vm_configs[each.key].caching
  image_version                 = var.windows_vm_configs[each.key].image_version
  storage_account_type          = var.windows_vm_configs[each.key].storage_account_type
  IP_allocation_method          = var.windows_vm_configs[each.key].private_ip_address_allocation
  subnet_id                     = data.azurerm_subnet.subnet.id

  nic_name                           = "${each.value}-nic"
  nic_ip_configuration_name          = "${each.value}-nic-ipc"
  nic_accelerated_networking_enabled = var.windows_vm_configs[each.key].nic_accelerated_networking_enabled
  auto_shutdown_enable               = var.windows_vm_configs[each.key].auto_shutdown_enable
  auto_shutdown_notification_email   = var.auto_shutdown_notification_email
  daily_recurrence_time              = var.daily_recurrence_time
  shutdown_notification_enabled      = var.shutdown_notification_enabled
  shutdown_timezone                  = var.shutdown_timezone
  vm_identity_type                   = var.windows_vm_configs[each.key].vm_identity_type
  nic_tags                           = var.windows_vm_configs[each.key].nic_tags
  vm_tags                            = var.windows_vm_configs[each.key].vm_tags
  #   depends_on                         = [module.rg, module.random_password]
}

# ...........................................................
# Creating Random Password for VMs and Store it in key Vault
# ............................................................

# module "random_password" {
#   source       = "../../../Modules/randomPassword"
#   for_each     = local.windows_vm_name
#   secret_name  = "${each.value}-password"
#   key_vault_id = data.azurerm_key_vault.key_vault.id
# }


# ......................................................
# Creating linux VMs
# ......................................................

module "linux_vm" {
  source                             = "../../../Modules/virtualMachines/linux"
  for_each                           = local.linux_vm_name
  resource_group_name                = local.resource_group_name
  linux_vm_name                      = each.value
  size                               = var.linux_vm_configs[each.key].size
  linux_sku                          = var.linux_vm_configs[each.key].linux_sku
  linux_offer                        = var.linux_vm_configs[each.key].linux_offer
  linux_publisher                    = var.linux_vm_configs[each.key].linux_publisher
  admin_username                     = var.linux_vm_configs[each.key].admin_username
  password                           = "Anupam@123"
  computer_name                      = var.linux_vm_configs[each.key].computer_name
  location                           = var.location
  private_ip_address_allocation      = var.linux_vm_configs[each.key].private_ip_address_allocation
  caching                            = var.linux_vm_configs[each.key].caching
  image_version                      = var.linux_vm_configs[each.key].image_version
  storage_account_type               = var.linux_vm_configs[each.key].storage_account_type
  disk_size_gb                       = var.linux_vm_configs[each.key].disk_size_gb
  IP_allocation_method               = var.linux_vm_configs[each.key].private_ip_address_allocation
  subnet_id                          = data.azurerm_subnet.subnet.id
  nic_name                           = "${each.value}-nic"
  nic_ip_configuration_name          = "${each.value}-nic-ipc"
  nic_accelerated_networking_enabled = var.linux_vm_configs[each.key].nic_accelerated_networking_enabled
  auto_shutdown_enable               = var.linux_vm_configs[each.key].auto_shutdown_enable
  auto_shutdown_notification_email   = var.auto_shutdown_notification_email
  daily_recurrence_time              = var.daily_recurrence_time
  disable_password_authentication    = var.linux_vm_configs[each.key].disable_password_authentication
  shutdown_notification_enabled      = var.shutdown_notification_enabled
  shutdown_timezone                  = var.shutdown_timezone
  vm_identity_type                   = var.linux_vm_configs[each.key].vm_identity_type
  nic_tags                           = var.linux_vm_configs[each.key].nic_tags
  vm_tags                            = var.linux_vm_configs[each.key].vm_tags
  depends_on                         = [module.rg]
}

module "managed_disk" {
  source              = "../../../Modules/virtualMachines/managedDisk"
  data_disks_name     = local.data_disks_name
  location            = var.location
  resource_group_name = local.resource_group_name
  dataDiskResources   = var.dataDiskResources
  vm_id               = module.linux_vm["development-vm"].linuxVirtualMachineId

}
