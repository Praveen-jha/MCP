# This terraform resource block attaches a managed data disk to an existing Azure Virtual Machine.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  virtual_machine_id        = var.virtual_machine_id
  managed_disk_id           = var.managed_disk_id
  lun                       = var.virtual_machine_data_disk_lun
  caching                   = var.virtual_machine_data_disk_caching
  create_option             = var.virtual_machine_data_disk_create_option
  write_accelerator_enabled = var.write_accelerator_enabled
}