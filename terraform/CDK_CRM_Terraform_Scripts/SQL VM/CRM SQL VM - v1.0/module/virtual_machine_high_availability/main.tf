data "azurerm_virtual_network" "existing_vnet" {
  name                = var.existing_virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnets" {
  for_each             = { for subnet in var.subnet_names : subnet => subnet }
  name                 = each.value
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = var.resource_group_name
}

# --- Network Interfaces (NICs) ---
resource "azurerm_network_interface" "nic" {
  for_each            = var.vm_subnet_map
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = data.azurerm_subnet.existing_subnets[each.value.subnet_name].id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

resource "azurerm_managed_disk" "data_disks" {
  count                = length(var.dataDiskResources)
  name                 = var.dataDiskResources[count.index].name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.dataDiskResources[count.index].sku
  create_option        = var.dataDiskResources[count.index].properties.createOption
  disk_size_gb         = var.dataDiskResources[count.index].properties.diskSizeGB
  zone                 = strcontains(lower(var.dataDiskResources[count.index].sku), "_zrs") ? null : var.availability_zones[count.index % length(var.availability_zones)]
}


# --- Windows Virtual Machines ---
resource "azurerm_windows_virtual_machine" "vm" {
  count               = length(var.vm_names)
  name                = var.vm_names[count.index]
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.password
  tags                = var.vm_tags
  network_interface_ids = [
    azurerm_network_interface.nic[var.vm_names[count.index]].id
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

  zone = var.availability_zones[count.index % length(var.availability_zones)]
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  count              = length(azurerm_managed_disk.data_disks)
  managed_disk_id    = azurerm_managed_disk.data_disks[count.index].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm[count.index % length(var.vm_names)].id
  lun                = count.index
  caching            = "ReadWrite"
  depends_on         = [azurerm_windows_virtual_machine.vm]
}

resource "azurerm_virtual_machine_extension" "domain_join" {
  count                      = length(var.vm_names)
  name                       = "${var.vm_names[count.index]}-joindomain"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    Name    = var.domain_fqdn
    User    = var.domain_user_name
    Restart = "false"
    Options = 3
  })
  protected_settings = jsonencode({
    Password = var.domain_user_password
  })
  depends_on = [
    azurerm_windows_virtual_machine.vm,
    azurerm_virtual_machine_data_disk_attachment.disk_attachment
  ]
}
