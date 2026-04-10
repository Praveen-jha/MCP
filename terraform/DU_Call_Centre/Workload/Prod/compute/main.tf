# ......................................................
# Creating New Resource Group
# ......................................................
module "rg" {
  source                  = "../../../Modules/rg"
  resource_group_name     = local.rg_name
  resource_group_location = var.location
}

# # ...........................................................
# # Creating Random Password for VMs and Store it in key Vault
# # ............................................................
# module "random_password" {
#   source       = "../../../Modules/randomPassword"
#   for_each     = local.windows_vm_name
#   secret_name  = "${each.value}-Password"
#   key_vault_id = data.azurerm_key_vault.key_vault.id
# }

# ......................................................
# Creating windows VMs
# ......................................................
module "windows_vm" {
  source                             = "../../../Modules/virtualMachines"
  for_each                           = local.windows_vm_name
  resource_group_name                = local.rg_name
  windows_vm_name                    = each.value
  size                               = var.windows_vm_configs[each.key].size
  windows_sku                        = var.windows_vm_configs[each.key].windows_sku
  windows_offer                      = var.windows_vm_configs[each.key].windows_offer
  windows_publisher                  = var.windows_vm_configs[each.key].windows_publisher
  admin_username                     = var.windows_vm_configs[each.key].admin_username
  password                           = var.windows_vm_configs[each.key].password
  computer_name                      = var.windows_vm_configs[each.key].computer_name
  location                           = var.location
  private_ip_address_allocation      = var.windows_vm_configs[each.key].private_ip_address_allocation
  caching                            = var.windows_vm_configs[each.key].caching
  image_version                      = var.windows_vm_configs[each.key].image_version
  storage_account_type               = var.windows_vm_configs[each.key].storage_account_type
  IP_allocation_method               = var.windows_vm_configs[each.key].private_ip_address_allocation
  subnet_id                          = data.azurerm_subnet.compute_subnet.id
  nic_name                           = "${each.value}-nic"
  nic_ip_configuration_name          = "${each.value}-nic-ipc"
  nic_accelerated_networking_enabled = var.windows_vm_configs[each.key].nic_accelerated_networking_enabled
  auto_shutdown_enable               = var.windows_vm_configs[each.key].auto_shutdown_enable
  auto_shutdown_notification_email   = var.auto_shutdown_notification_email
  daily_recurrence_time              = var.daily_recurrence_time
  shutdown_notification_enabled      = var.shutdown_notification_enabled
  shutdown_timezone                  = var.shutdown_timezone
  nic_tags                           = merge(var.windows_vm_configs[each.key].nic_tags, var.tags)
  vm_tags                            = merge(var.windows_vm_configs[each.key].vm_tags, var.tags)
  identity_type                      = var.windows_vm_configs[each.key].identity_type
  depends_on                         = [module.rg]
}
