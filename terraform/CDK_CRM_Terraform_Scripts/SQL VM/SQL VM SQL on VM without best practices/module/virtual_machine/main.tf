resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.nic_tags

  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "azurerm_managed_disk" "data_disks" {
  count                = length(var.dataDiskResources)
  name                 = var.data_disks_name[count.index]
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.dataDiskResources[count.index].sku
  create_option        = var.dataDiskResources[count.index].properties.createOption
  disk_size_gb         = var.dataDiskResources[count.index].properties.diskSizeGB
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.windows_vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.password
  computer_name       = var.computer_name
  tags                = var.vm_tags
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  source_image_reference {
    publisher = var.windows_publisher
    offer     = var.windows_offer
    sku       = var.windows_sku
    version   = var.image_version
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }

  zone = var.availability_zone ? var.vm_zone : null
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  count              = length(azurerm_managed_disk.data_disks)
  managed_disk_id    = azurerm_managed_disk.data_disks[count.index].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = count.index
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_extension" "aad_login" {
  name                       = "${var.windows_vm_name}-AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  settings = jsonencode({
    mdmId = ""
  })
  depends_on = [azurerm_managed_disk.data_disks, azurerm_virtual_machine_data_disk_attachment.example]
}
