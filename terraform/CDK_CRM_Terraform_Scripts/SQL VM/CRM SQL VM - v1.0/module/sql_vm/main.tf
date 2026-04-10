resource "azurerm_mssql_virtual_machine" "main" {
  virtual_machine_id = var.virtual_machine_id

  sql_connectivity_port            = var.sqlPortNumber
  sql_connectivity_type            = var.sqlConnectivityType
  sql_connectivity_update_username = var.sqlAuthenticationLogin
  sql_connectivity_update_password = var.sqlAuthenticationPassword
  sql_license_type                 = var.sql_license_type
}
