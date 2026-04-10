data "azurerm_client_config" "current" {
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_user_assigned_identity" "uaid" {
  resource_group_name = var.data_resource_group_name
  name                = var.uaid_name
}