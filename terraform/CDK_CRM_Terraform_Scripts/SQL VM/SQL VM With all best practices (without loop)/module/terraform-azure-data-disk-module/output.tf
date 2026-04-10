// output.tf
// This file defines the output values for the azurerm_managed_disk module.

output "managed_disk" {
  description = "The entire resource object for the Azure Managed Disk."
  value       = azurerm_managed_disk.this
}

output "managed_disk_id" {
  description = "The ID of the Azure Managed Disk."
  value       = azurerm_managed_disk.this.id
}

output "managed_disk_create_option" {
  description = "Returns the create option of the Azure Managed Disk."
  value       = azurerm_managed_disk.this.create_option
}

output "managed_disk_access_id" {
  description = "Returns the Disk Access Id of the Azure Managed Disk."
  value       = azurerm_managed_disk.this.disk_access_id
}

output "managed_disk_encryption_set_id" {
  description = "Returns the Disk Encryption Set Id of the Azure Managed Disk."
  value       = azurerm_managed_disk.this.disk_encryption_set_id
}

output "managed_disk_iops_read_only" {
  description = "Returns the Disk Read-only IOPS value."
  value       = azurerm_managed_disk.this.disk_iops_read_only
}

output "managed_disk_iops_read_write" {
  description = "Returns the Disk Read-write IOPS value."
  value       = azurerm_managed_disk.this.disk_iops_read_write
}

output "managed_disk_mbps_read_only" {
  description = "Returns the Disk Read-only mbps value."
  value       = azurerm_managed_disk.this.disk_mbps_read_only
}

output "managed_disk_mbps_read_write" {
  description = "Returns the Disk Read-write mbps value."
  value       = azurerm_managed_disk.this.disk_mbps_read_write
}

output "managed_disk_size_gb" {
  description = "Returns the Disk Size (in GB) value."
  value       = azurerm_managed_disk.this.disk_size_gb
}

output "managed_disk_edge_zone" {
  description = "Returns the Edge Zone of the Azure Managed Disk."
  value       = azurerm_managed_disk.this.edge_zone
}

output "managed_disk_gallery_image_reference_id" {
  description = "Returns the Disk Gallery Image Reference ID."
  value       = azurerm_managed_disk.this.gallery_image_reference_id
}

output "managed_disk_hyper_v_generation" {
  description = "Returns the Hyper-V generation of the managed disk (e.g., V1 or V2)."
  value       = azurerm_managed_disk.this.hyper_v_generation
}

output "managed_disk_image_reference_id" {
  description = "Returns the Disk Image Reference ID."
  value       = azurerm_managed_disk.this.image_reference_id
}

output "managed_disk_location" {
  description = "The Azure region where the Azure Managed Disk is deployed."
  value       = azurerm_managed_disk.this.location
}

output "managed_disk_logical_sector_size" {
  description = "Returns the Logical Sector Size."
  value       = azurerm_managed_disk.this.logical_sector_size
}




