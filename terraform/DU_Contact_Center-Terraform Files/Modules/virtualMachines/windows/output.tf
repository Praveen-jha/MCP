output "windowsVirtualMachine" {
  description = "The name of the Windows Virtual Machine"
  value       = azurerm_windows_virtual_machine.windowsVirtualMachine.name
}
output "windowsVirtualMachineId" {
  description = "The ID of the Windows Virtual Machine"
  value       = azurerm_windows_virtual_machine.windowsVirtualMachine.id
}

# output "windowsVirtualMachineSystemAssignedIdentity" {
#   value = azurerm_windows_virtual_machine.windowsVirtualMachine.identity[0].principal_id
# }
 