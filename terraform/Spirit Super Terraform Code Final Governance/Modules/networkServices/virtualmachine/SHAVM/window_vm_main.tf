resource "azurerm_network_interface" "nic" {
  name                = var.nicName
  location            = var.location
  resource_group_name = var.rgName
  tags                = var.Tag


  ip_configuration {
    name                          = var.vmConfig.NIC_ip_configuration
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.vmConfig.NIC_private_ip_address_allocation
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vmName
  resource_group_name = var.rgName
  location            = var.location
  size                = var.vmConfig.vmSize
  admin_username      = var.adminUsername
  admin_password      = var.adminPassword
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name                 = var.osdiskName
    caching              = var.vmConfig.caching
    storage_account_type = var.vmConfig.storageAccountType
  }

  source_image_reference {
    publisher = var.vmConfig.publisher
    offer     = var.vmConfig.offer
    sku       = var.vmConfig.sku
    version   = var.vmConfig.version
  }

}