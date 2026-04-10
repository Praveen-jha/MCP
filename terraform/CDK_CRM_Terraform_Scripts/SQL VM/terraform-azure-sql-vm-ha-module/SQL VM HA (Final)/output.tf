# # Output the full virtual machine resource (sensitive due to credentials)
# output "virtual_machine" {
#   value       = azurerm_windows_virtual_machine.this
#   sensitive   = true
#   description = "The complete Azure Windows Virtual Machine resource, including sensitive details like admin credentials."
# }

# # Output the virtual machine ID
# output "virtual_machine_id" {
#   value       = azurerm_windows_virtual_machine.this.id
#   description = "The resource ID of the Azure Windows Virtual Machine."
# }

# # Output the SQL Server VM resource ID
# output "mssql_virtual_machine_id" {
#   value       = azurerm_mssql_virtual_machine.this.id
#   description = "The resource ID of the SQL Server configuration on the Azure VM."
# }

# # Output the SQL admin username (for reference)
# output "sql_admin_username" {
#   value       = "sqladmin"
#   description = "The SQL Server admin username configured for the VM."
# }

# # Output the SQL admin password (sensitive)
# output "sql_admin_password" {
#   value       = random_password.sql_password.result
#   sensitive   = true
#   description = "The randomly generated SQL Server admin password."
# }

# # Output a note about the Entra logins error log
# output "sql_entra_logins_error_log" {
#   value       = "Check 'C:\\Temp\\sql_entra_logins_error.log' on the VM for Entra login and role assignment logs."
#   description = "Path to the error log file on the VM for debugging Entra logins configuration."
# }

# Output the full virtual machine resource (sensitive due to credentials)
output "virtual_machine" {
  value       = azurerm_windows_virtual_machine.this
  sensitive   = true
  description = "A map of complete Azure Windows Virtual Machine resources, keyed by instance name. Includes sensitive details like admin credentials."
}

# Output the virtual machine IDs
output "virtual_machine_id" {
  value       = { for k, v in azurerm_windows_virtual_machine.this : k => v.id }
  description = "A map of resource IDs for each Azure Windows Virtual Machine, keyed by instance name."
}

# Output the SQL Server VM resource IDs
output "mssql_virtual_machine_id" {
  value       = { for k, v in azurerm_mssql_virtual_machine.this : k => v.id }
  description = "A map of resource IDs for the SQL Server configuration on each Azure VM, keyed by instance name."
}

# Output the SQL admin username (for reference)
output "sql_admin_username" {
  value       = "sqladmin"
  description = "The SQL Server admin username configured for the VM."
}

# Output the SQL admin passwords (sensitive)
output "sql_admin_password" {
  value       = { for k, v in random_password.sql_password : k => v.result }
  sensitive   = true
  description = "A map of randomly generated SQL Server admin passwords, keyed by instance name."
}

# Output a note about the Entra logins error log
output "sql_entra_logins_error_log" {
  value       = "Check 'C:\\Temp\\sql_entra_logins_error.log' on the VM for Entra login and role assignment logs."
  description = "Path to the error log file on the VM for debugging Entra logins configuration."
}