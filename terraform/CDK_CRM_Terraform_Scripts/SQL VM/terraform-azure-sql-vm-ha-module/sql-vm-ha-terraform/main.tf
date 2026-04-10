# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "this" {
  for_each = local.replica_instances

  name                = "vnic-${var.prefix}-${var.name[each.value]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = merge(
    var.tags,
    var.nic_tags
  )
  ip_configuration {
    name                          = "private"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  lifecycle {
    ignore_changes = all
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
resource "azurerm_windows_virtual_machine" "this" {
  for_each = local.replica_instances

  name = var.name[each.value]
  // timezone            = var.timezone_id
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = "adminuser"
  admin_password      = "password@123"
  computer_name       = var.name[each.value]

  network_interface_ids = [
    azurerm_network_interface.this[each.key].id,
  ]

  os_disk {
    caching              = "ReadOnly"
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb

    dynamic "diff_disk_settings" {
      for_each = var.disk_controller_type == "NVMe" ? [1] : []
      content {
        option    = "Local"
        placement = "NvmeDisk"
      }
    }
  }


  dynamic "source_image_reference" {
    for_each = var.image_version == "sql2022-ws2022" ? [1] : []
    content {
      publisher = "microsoftsqlserver"
      offer     = "sql2022-ws2022"
      sku       = "enterprise-gen2"
      version   = "latest"
    }
  }

  //source_image_id      = var.image_version != "sql2022-ws2022" ? data.azurerm_shared_image_version.latest.id : null
  disk_controller_type = var.disk_controller_type
  identity {
    type = "SystemAssigned"
  }

  zone         = var.availability_zone ? var.vm_zones[each.value] : null
  license_type = "Windows_Server"

  tags = merge(
    var.vm_tags,
    var.tags
  )

  lifecycle {
    ignore_changes = all
  }
}
