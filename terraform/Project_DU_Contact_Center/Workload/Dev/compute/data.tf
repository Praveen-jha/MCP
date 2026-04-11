data "azurerm_subnet" "compute_subnet" {
  name                 = var.compute_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.subnet_resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  resource_group_name = var.key_vault_rg_name
  name                = var.key_vault_name
}
