resource "azurerm_managed_disk" "data_disks" {
  count                = length(var.dataDiskResources)
  name                 = var.data_disks_name[count.index]
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.dataDiskResources[count.index].sku
  create_option        = var.dataDiskResources[count.index].properties.createOption
  disk_size_gb         = var.dataDiskResources[count.index].properties.diskSizeGB
}


resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  count              = length(azurerm_managed_disk.data_disks)
  managed_disk_id    = azurerm_managed_disk.data_disks[count.index].id
  virtual_machine_id = var.vm_id
  lun                = count.index
  caching            = "ReadWrite"
}