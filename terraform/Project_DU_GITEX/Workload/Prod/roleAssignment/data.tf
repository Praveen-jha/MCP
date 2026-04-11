data "azurerm_client_config" "current" {
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_user_assigned_identity" "umid" {
  name                = var.umi_id_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_windows_web_app" "node_app" {
  name = var.node_app_service_name
  resource_group_name = var.app_service_resource_group_name
}

data "azurerm_windows_web_app" "python_app" {
  name = var.python_app_service_name
  resource_group_name = var.app_service_resource_group_name
}

data "azurerm_storage_account" "tfstate_stoarge" {
  name=var.tfstate_stoarge_name
  resource_group_name = var.tfstate_stoarge_resource_group_name
}
