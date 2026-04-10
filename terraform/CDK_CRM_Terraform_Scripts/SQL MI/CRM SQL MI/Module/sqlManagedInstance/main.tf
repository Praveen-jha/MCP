# Azure SQL Managed Instance
resource "azurerm_mssql_managed_instance" "sql-mi" {
  name                         = var.sql_instance_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  license_type                 = "LicenseIncluded"
  sku_name                     = "GP_Gen5"
  storage_size_in_gb           = var.sql_storage_size
  subnet_id                    = var.subnet_id_sqlmi
  vcores                       = var.sql_vcores

  azure_active_directory_administrator {
    azuread_authentication_only_enabled = var.azuread_authentication_only_enabled
    login_username                      = var.ad_group_display_name
    object_id                           = var.ad_group_object_id
    principal_type                      = var.azuread_principal_type
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }

  lifecycle {
    ignore_changes = all
  }
}
