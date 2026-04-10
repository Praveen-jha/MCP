data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.ai_rg_name
}

data "azurerm_subnet" "pep_subnet" {
  name                 = var.pep_subnet_name
  virtual_network_name = var.pep_virtual_network_name
  resource_group_name  = var.pep_resource_group_name
}

data "azurerm_key_vault_key" "di_key" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = var.key_vault_key_name
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.data_resource_group_name
}

data "azurerm_user_assigned_identity" "uaid" {
  resource_group_name = var.data_resource_group_name
  name                = var.uaid_name
}
