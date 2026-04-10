// output.tf
// This file defines the output values for the azurerm_mssql_virtual_machine module.

output "mssql_vm" {
  description = "The entire resource object for the Azure MSSQL Virtual Machine."
  value       = azurerm_mssql_virtual_machine.this
}

output "mssql_vm_id" {
  description = "The ID of the MSSQL Virtual Machine."
  value       = azurerm_mssql_virtual_machine.this.id
}

output "mssql_vm_r_services_enabled" {
  description = "Defines whether R Service is enabled or not."
  value       = azurerm_mssql_virtual_machine.this.r_services_enabled
}

output "mssql_vm_sql_connectivity_port" {
  description = "Defines the SQL Connectivity Port of the MSSQL Virtual Machine."
  value       = azurerm_mssql_virtual_machine.this.sql_connectivity_port
}

output "mssql_vm_sql_connectivity_type" {
  description = "Defines the SQL Connectivity Type of the MSSQL Virtual Machine."
  value       = azurerm_mssql_virtual_machine.this.sql_connectivity_type
}

output "mssql_vm_sql_connectivity_update_password" {
  description = "Defines the SQL connectivity update password."
  value       = azurerm_mssql_virtual_machine.this.sql_connectivity_update_password
  sensitive = true
}

output "mssql_vm_sql_connectivity_update_username" {
  description = "Defines the SQL Connectivity Updated Username."
  value       = azurerm_mssql_virtual_machine.this.sql_connectivity_update_username
}

output "mssql_vm_sql_license_type" {
  description = "Defines the SQL License Type."
  value       = azurerm_mssql_virtual_machine.this.sql_license_type
}

output "mssql_vm_sql_virtual_machine_group_id" {
  description = "Defines the SQL Virtual Machine Group Id."
  value       = azurerm_mssql_virtual_machine.this.sql_virtual_machine_group_id
}

output "mssql_vm_virtual_machine_id" {
  description = "Defines the  SQL Virtual Machine Id."
  value       = azurerm_mssql_virtual_machine.this.virtual_machine_id
}