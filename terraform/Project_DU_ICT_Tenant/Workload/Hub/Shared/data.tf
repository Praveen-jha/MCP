data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.LA_rg_name
}

# data "azurerm_storage_account" "sa" {
#   name                 = var.storage_account_name
#   resource_group_name  = var.storage_account_resource_group
# }

# data "azurerm_subnet" "pep_subnet" {
#   name                 = var.pep_subnet_name
#   virtual_network_name = var.pep_virtual_network_name
#   resource_group_name  = var.pep_resource_group_name
# }