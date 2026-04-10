output "linuxVirtualMachine" {
  description = "The name of the linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.linuxVirtualMachine.name
}
output "linuxVirtualMachineId" {
  description = "The ID of the linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.linuxVirtualMachine.id
}

# output "linuxVirtualMachineSystemAssignedIdentity" {
#   value = azurerm_linux_virtual_machine.linuxVirtualMachine.identity[0].principal_id
# }
 