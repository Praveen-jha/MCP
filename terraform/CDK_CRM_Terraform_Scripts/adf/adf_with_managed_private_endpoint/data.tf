#Data block for Existing Resource Group for Data Factory
data "azurerm_resource_group" "existing_resource_group_data_factory" {
  count = var.name_config.data_factory_resource_group_creation == "existing" ? 1 : 0
  name  = var.existing_resource_group_data_factory_name
}

#Data block for Existing Virtual Network
data "azurerm_virtual_network" "existing_vnet" {
  count               = (var.name_config.virtual_network_creation == "existing" ) ? 1 : 0
  name                = var.existing_virtual_network_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group_data_factory[0].name
}

#Data block for Exsiting Inbound Subnet
data "azurerm_subnet" "existing_private_endpoint_subnet" {
  count                = (var.name_config.subnet_creation == "existing") ? 1 : 0
  name                 = var.existing_private_endpoint_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
  resource_group_name  = data.azurerm_resource_group.existing_resource_group_data_factory[0].name
}

data "azurerm_client_config" "current" {}

# Data block for Data Factories
data "azurerm_data_factory" "existing_data_factory" {
  count = (var.name_config.data_factory_creation == "existing" ) ? 1 : 0
  name  = var.data_factory_name
  resource_group_name = data.azurerm_resource_group.existing_resource_group_data_factory[0].name
  
}

# Data blocks to reference existing storage accounts
data "azurerm_storage_account" "existing_storage" {
  for_each = {
    for k, v in var.existing_target_resources : k => v
    if v.type == "storage_account"
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
}

# Data blocks to reference existing key vaults
data "azurerm_key_vault" "existing_keyvault" {
  for_each = {
    for k, v in var.existing_target_resources : k => v
    if v.type == "key_vault"
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
}
# Data blocks to reference existing SQL MI
data "azurerm_mssql_managed_instance" "existing_sql_mi" {
  for_each = {
    for k, v in var.existing_target_resources : k => v
    if v.type == "sql_mi"
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
}