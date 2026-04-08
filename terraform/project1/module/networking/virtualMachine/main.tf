resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.vm_location
  resource_group_name = var.vm_resource_group
  tags                = var.tags
  ip_configuration {
    name                          = var.nic_ip_config_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = null
  }
  lifecycle { 
    ignore_changes = [
      ip_configuration,
      tags
    ]
  }
}
resource "azurerm_windows_virtual_machine" "windowsVirtualMachine" {
  name                  = var.vm_name
  resource_group_name   = var.vm_resource_group
  location              = var.vm_location
  size                  = var.vm_size
  zone                  = var.vm_zone
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  tags                  = var.tags
  network_interface_ids = [azurerm_network_interface.nic.id]
  identity {
    type = var.identity
  }
  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_disk_size_gb

  }
  source_image_id = var.source_image_id

  lifecycle {
    ignore_changes = [
      admin_username,
      admin_password,
      # computer_name,
      # size,
      # tags,
      # zone,
      # os_disk
    ]
  }
}

