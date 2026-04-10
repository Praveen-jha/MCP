// output.tf
// This file defines the output values for the azurerm_virtual_machine_data_disk_attachment module.
 
output "virtual_machine_data_disk_attachment" {
  description = "The entire resource object for the Azure Virtual Machine Data Disk Attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this
}
 
output "virtual_machine_data_disk_attachment_id" {
  description = "The Id of the Azure Virtual Machine Data Disk Attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.id
}
 
output "virtual_machine_data_disk_attachment_caching" {
  description = "Returns the caching of the Azure Virtual Machine Data Disk Attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.caching
}
 
output "virtual_machine_data_disk_attachment_create_option" {
  description = "Returns the Create Option of the Azure Virtual Machine Data Disk Attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.create_option
}
 
output "virtual_machine_data_disk_attachment_lun" {
  description = "Returns the lun value of the Azure Virtual Machine Data Disk Attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.lun
}
 
output "virtual_machine_data_disk_attachment_managed_disk_id" {
  description = "Returns the Id of the Managed Disk inside the Azure Virtual Machine Data Disk Attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.managed_disk_id
}
 
output "virtual_machine_data_disk_attachment_virtual_machine_id" {
  description = "Returns the Id of the Virtual Machine inside the Azure Virtual Machine Data Disk Attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.virtual_machine_id
}
 
output "virtual_machine_data_disk_attachment_write_accelerator_enabled" {
  description = "Returns whether Write Accelerator is Enabled or not."
  value       = azurerm_virtual_machine_data_disk_attachment.this.write_accelerator_enabled
}

output "lun" {
  description = "The Logical Unit Number of the attached data disk."
  value       = var.virtual_machine_data_disk_lun
}