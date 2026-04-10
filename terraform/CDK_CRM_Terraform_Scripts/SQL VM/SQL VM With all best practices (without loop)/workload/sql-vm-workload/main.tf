#Creation of Data Disks
module "data_disks" {
  source                         = "../../module/terraform-azure-data-disk-module"
  for_each                       = local.data_disk_for_each
  data_disk_name                 = each.value.data_disk_name
  data_disk_location             = var.location
  data_disk_rg_name              = data.azurerm_resource_group.existing_resource_group_sql_vm[0].name
  data_disk_storage_account_type = each.value.data_disk_sku
  data_disk_create_option        = each.value.data_disk_create_option
  data_disk_size_gb              = each.value.data_disk_size_gb
  data_disk_tags                 = var.tags
}

#Creation of Windows Virtual Machine
module "virtual_machine" {
  source = "../../module/terraform-azure-vritual-machine-module"
  // Virtual Machine Configuration
  windows_vm_name                    = var.virtual_machine_config.name
  windows_vm_rg_name                 = data.azurerm_resource_group.existing_resource_group_sql_vm[0].name
  windows_vm_location                = var.location
  windows_vm_size                    = var.virtual_machine_config.vm_size
  windows_vm_admin_username          = var.virtual_machine_config.admin_username
  windows_vm_admin_password          = var.virtual_machine_config.admin_password
  windows_vm_computer_name           = var.virtual_machine_config.computer_name
  windows_vm_tags                    = var.tags
  windows_vm_os_caching              = var.virtual_machine_config.caching
  windows_vm_os_storage_account_type = var.virtual_machine_config.storage_account_type
  windows_vm_os_disk_size_gb         = var.virtual_machine_config.disk_size_gb
  windows_vm_publisher               = var.virtual_machine_config.publisher
  windows_vm_offer                   = var.virtual_machine_config.offer
  windows_vm_sku                     = var.virtual_machine_config.sku
  windows_vm_image_version           = var.virtual_machine_config.version
  windows_vm_identity_type           = var.virtual_machine_config.identity_type

  // NIC Configuration
  network_interface_card_name                          = local.network_interface_name
  network_interface_card_location                      = var.location
  network_interface_card_rg_name                       = data.azurerm_resource_group.existing_resource_group_sql_vm[0].name
  network_interface_card_ip_configuration_name         = local.nic_ip_configuration_name
  network_interface_card_tags                          = var.tags
  network_interface_card_private_ip_address_allocation = var.virtual_machine_config.private_ip_address_allocation
  network_interface_card_subnet_id                     = data.azurerm_subnet.existing_compute_subnet[0].id

  depends_on = [module.data_disks]
}

#Creation of Data Disk Attachment
module "data_disk_attachment" {
  source                            = "../../module/terraform-azure-data-disk-attachment-module"
  for_each                          = local.data_disk_for_each
  virtual_machine_id                = module.virtual_machine.windows_vm_id
  managed_disk_id                   = module.data_disks[each.key].managed_disk_id
  virtual_machine_data_disk_lun     = each.value.data_disk_lun
  virtual_machine_data_disk_caching = each.value.data_disk_caching
  depends_on                        = [module.data_disks, module.virtual_machine]
}

#Creation of Virtual Machine Extension
module "virtual_machine_extension" {
  source                                         = "../../module/terraform-azure-virtual-machine-extension-module"
  virtual_machine_extension_name                 = var.virtual_machine_extension.vm_extension_name
  virtual_machine_id                             = module.virtual_machine.windows_vm_id
  virtual_machine_extension_publisher            = var.virtual_machine_extension.vm_extension_publisher
  virtual_machine_extension_type                 = var.virtual_machine_extension.vm_extension_type
  virtual_machine_extension_type_handler_version = var.virtual_machine_extension.vm_extension_type_handler_version
  virtual_machine_extension_settings             = local.virtual_machine_extension_settings
  virtual_machine_extension_tags                 = var.tags
  depends_on                                     = [module.virtual_machine, module.data_disk_attachment]
}

#Creation of SQL Virtual Machine
module "sql_virtual_machine" {
  source                             = "../../module/terraform-azure-mssql_virtual-machine-module"
  mssql_vm_virtual_machine_id        = module.virtual_machine.windows_vm_id
  mssql_vm_sql_license_type          = var.sql_vm_config.sql_license_type
  mssql_vm_sqlAuthenticationLogin    = var.sql_vm_config.sql_authentication_login
  mssql_vm_sqlAuthenticationPassword = var.sql_vm_config.sql_authentication_password
  mssql_vm_sqlConnectivityType       = var.sql_vm_config.sql_connectivity_type
  mssql_vm_sqlPortNumber             = var.sql_vm_config.sql_port_number
  mssql_vm_storage_configuration     = var.sql_vm_storage_configuration
  mssql_vm_tags                      = var.tags
  depends_on                         = [module.virtual_machine, module.data_disk_attachment, module.virtual_machine_extension]
}
