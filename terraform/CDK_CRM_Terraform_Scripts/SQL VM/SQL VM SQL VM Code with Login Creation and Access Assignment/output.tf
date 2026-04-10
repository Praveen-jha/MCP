output "virtual_machine" {
  value     = azurerm_windows_virtual_machine.this
  sensitive = true
}

output "virtual_machine_id" {
  value = azurerm_windows_virtual_machine.this.id
}

output "vm_password" {
  value     = azurerm_mssql_virtual_machine.this.sql_connectivity_update_password
  sensitive = true
}

# output "password" {
#   value = random_password.password.result
# }