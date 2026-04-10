resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.nic_tags

  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id = "/subscriptions/a746bef1-0f80-4ee5-888c-d0ff7d17f254/resourceGroups/testrg1/providers/Microsoft.Network/publicIPAddresses/new-ip"
  }
  lifecycle {
    prevent_destroy = true
  }
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

}

