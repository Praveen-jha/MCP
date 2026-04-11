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

resource "azurerm_windows_virtual_machine" "windowsVirtualMachine" {
  name                  = var.windows_vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.password
  computer_name         = var.computer_name
  tags                  = var.vm_tags
  network_interface_ids = [azurerm_network_interface.nic.id]
  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }
  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.windows_publisher
    offer     = var.windows_offer
    sku       = var.windows_sku
    version   = var.image_version
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "auto_shutdown" {
  location              = var.location
  daily_recurrence_time = var.daily_recurrence_time
  enabled               = var.auto_shutdown_enable
  timezone              = var.shutdown_timezone
  virtual_machine_id    = azurerm_windows_virtual_machine.windowsVirtualMachine.id
  notification_settings {
    enabled = var.shutdown_notification_enabled
    email   = var.auto_shutdown_notification_email
  }
}


