# SQL Server Resource
resource "azurerm_mssql_server" "sql_server" {
  name                          = var.sql_server_name
  resource_group_name           = var.rg_name
  location                      = var.location
  version                       = var.sql_server_version
  administrator_login           = var.sql_server_admin_login
  administrator_login_password  = var.sql_server_admin_password
  minimum_tls_version           = var.sql_server_min_tls_version
  public_network_access_enabled = var.sql_public_network_access_enabled

  identity {
    type         = var.sql_server_identity.type
    identity_ids = var.sql_server_identity.identity_ids
  }

  azuread_administrator {
    login_username = var.sql_server_azure_ad_administrator.login_username
    object_id      = var.sql_server_azure_ad_administrator.object_id
  }

  lifecycle {
    ignore_changes = [transparent_data_encryption_key_vault_key_id]
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "auditing_policy_role" {
  count                = var.auditing_policy_enabled == true ? 1 : 0
  depends_on           = [azurerm_mssql_server.sql_server]
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_mssql_server.sql_server.identity[0].principal_id
}

resource "azurerm_mssql_server_extended_auditing_policy" "auditing_policy" {
  count                                   = var.auditing_policy_enabled == true ? 1 : 0
  depends_on                              = [azurerm_role_assignment.auditing_policy_role]
  enabled                                 = var.auditing_policy_enabled
  server_id                               = azurerm_mssql_server.sql_server.id
  storage_endpoint                        = var.storage_account_primary_blob_endpoint
  storage_account_access_key              = var.storage_account_primary_access_key
  storage_account_access_key_is_secondary = true
  retention_in_days                       = 90
}

# SQL Databases - Using for_each to create multiple databases
resource "azurerm_mssql_database" "sql_database" {
  for_each     = var.sql_databases
  name         = each.value.database_name
  server_id    = azurerm_mssql_server.sql_server.id
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type
  tags         = var.tags

  # Enable Ledger Feature
  ledger_enabled = each.value.ledger_enabled

  # Ensure Zone Redundancy
  zone_redundant = each.value.zone_redundant
  secondary_type = each.value.secondary_type

  long_term_retention_policy {
    weekly_retention = each.value.long_term_weekly_retention
  }
}

resource "azurerm_role_assignment" "cmk_role" {
  depends_on           = [azurerm_mssql_server.sql_server]
  scope                = var.key_scope_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_mssql_server.sql_server.identity[0].principal_id
}

# Transparent Data Encryption for SQL Server
resource "azurerm_mssql_server_transparent_data_encryption" "encryption" {
  depends_on = [azurerm_role_assignment.cmk_role]

  server_id        = azurerm_mssql_server.sql_server.id
  key_vault_key_id = var.key_vault_key_id
}
