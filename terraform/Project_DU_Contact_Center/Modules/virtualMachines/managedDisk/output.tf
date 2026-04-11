output "data_disk_id" {
  value = azurerm_managed_disk.data_disks.*.id
}

output "data_disk_name" {
  value = azurerm_managed_disk.data_disks.*.name
}
