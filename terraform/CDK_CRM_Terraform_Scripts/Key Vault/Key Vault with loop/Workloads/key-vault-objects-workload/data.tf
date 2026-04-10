# data.tf
# Data blocks for multiple existing Key Vaults using for_each loop

# Data source to fetch multiple existing Key Vaults
data "azurerm_key_vault" "keyvault_existing" {
  for_each = var.kv_objects
  
  name                = each.value.kv_name
  resource_group_name = each.value.kv_rg_name
}

