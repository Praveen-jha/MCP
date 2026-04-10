// output.tf
// This file defines the output values for the azurerm_virtual_machine_extension module.

output "vm_extension" {
  description = "The entire resource object for the Azure Virtual Machine Extension."
  value       = azurerm_virtual_machine_extension.this
}
 
output "vm_extension_id" {
  description = "The ID of the Azure Virtual Machine Extension."
  value       = azurerm_virtual_machine_extension.this.id
}
 
output "vm_extension_name" {
  description = "The Name of the Azure Virtual Machine Extension."
  value       = azurerm_virtual_machine_extension.this.name
}
