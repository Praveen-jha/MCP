# Fetch details of the current Azure client (used for authentication and identity)
data "azurerm_client_config" "current" {}

# Fetch details of an existing Resource Group
data "azurerm_resource_group" "data_rg" {
  name = var.resource_config.resource_group_name
}

# Fetch details of an existing private Subnet
data "azurerm_subnet" "private_subnet" {
  name                 = var.resource_config.private_subnet_name
  virtual_network_name = var.resource_config.virtual_network_name
  resource_group_name  = var.resource_config.network_resource_group_name
}

# Retrieves the AKS subnet details within the specified Virtual Network
data "azurerm_subnet" "aks_subnet" {
  name                 = var.resource_config.aks_subnet_name
  virtual_network_name = var.resource_config.virtual_network_name
  resource_group_name  = var.resource_config.network_resource_group_name
}

# Fetch details of an existing integration Subnet
data "azurerm_subnet" "integration_subnet" {
  name                 = var.resource_config.integration_subnet_name
  virtual_network_name = var.resource_config.virtual_network_name
  resource_group_name  = var.resource_config.network_resource_group_name
}

# Fetch details of an existing Azure Key Vault
data "azurerm_key_vault" "kv" {
  name                = var.resource_config.kv_name
  resource_group_name = var.resource_config.key_vault_rg_name
}

# Fetch details of a specific Key Vault encryption key
data "azurerm_key_vault_key" "kv_key" {
  name         = var.resource_config.key_vault_key_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Fetch secrets from the Key Vault
data "azurerm_key_vault_secret" "kv_secrets" {
  name         = var.resource_config.sql_password_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}
