data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.uat_data_rg_name
}

data "azurerm_subnet" "apim_subnet" {
  name                 = var.apim_config.subnet_name
  virtual_network_name = var.apim_config.virtual_network_name
  resource_group_name  = var.apim_config.resource_group_name
}

# data "azurerm_public_ip" "apim_public_ip" {
#   name                = var.apim_config.public_ip_name
#   resource_group_name = var.apim_config.resource_group_name
# }
