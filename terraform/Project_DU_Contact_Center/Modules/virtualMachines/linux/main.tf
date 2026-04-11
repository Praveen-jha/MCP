resource "azurerm_network_interface" "nic" {
  name                           = var.nic_name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  tags                           = var.nic_tags
  accelerated_networking_enabled = var.nic_accelerated_networking_enabled

  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

resource "azurerm_linux_virtual_machine" "linuxVirtualMachine" {
  name                  = var.linux_vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.password
  computer_name         = var.computer_name
  tags                  = var.vm_tags
  network_interface_ids = [azurerm_network_interface.nic.id]
  identity {
    type = var.vm_identity_type
  }
  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  disable_password_authentication = var.disable_password_authentication

  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.image_version
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "auto_shutdown" {
  location              = var.location
  daily_recurrence_time = var.daily_recurrence_time
  enabled               = var.auto_shutdown_enable
  timezone              = var.shutdown_timezone
  virtual_machine_id    = azurerm_linux_virtual_machine.linuxVirtualMachine.id
  notification_settings {
    enabled = var.shutdown_notification_enabled
    email   = var.auto_shutdown_notification_email
  }



}


 
