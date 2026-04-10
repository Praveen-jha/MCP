data "azurerm_synapse_workspace" "synapse_workspace" {
  name                = "${local.baseName1}-synw"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_storage_account" "storage_account_one" {
  name                = "${local.baseName1}dls"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_storage_account" "storage_account_two" {
  name                = "${local.baseName1}dls2"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.baseName1}-kv01"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_databricks_workspace" "databricks_workspace" {
  name                = "${local.baseName1}-dbw"
  resource_group_name = var.nameConfig.existingApplicationRGName
}

data "azurerm_key_vault_secret" "pat_token" {
  name         = "ngdp1t-dbw-pat"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
