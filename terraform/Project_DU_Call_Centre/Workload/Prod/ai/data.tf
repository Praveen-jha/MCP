data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.ai_rg_name
}

data "azurerm_client_config" "current" {
}

data "azurerm_subnet" "pep_subnet" {
  name                 = var.pep_subnet_name
  virtual_network_name = var.pep_virtual_network_name
  resource_group_name  = var.pep_resource_group_name
}

data "azurerm_subnet" "apim_subnet" {
  name                 = var.apim_subnet_name
  virtual_network_name = var.pep_virtual_network_name
  resource_group_name  = var.pep_resource_group_name
}

data "azurerm_storage_account" "tfstate" {
  name                = local.hub_sa_private_endpoint_config.tfstate_sa_name
  resource_group_name = local.hub_sa_private_endpoint_config.tfstate_sa_rg_name
}

# data "azurerm_subnet" "ml_compute_instance_subnet" {
#   name                 = var.ml_compute_instance_subnet_name
#   virtual_network_name = var.ml_compute_instance_vnet_name
#   resource_group_name  = var.ml_compute_instance_network_rg 
# }

data "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  resource_group_name = var.law_rg_name
}

data "azurerm_public_ip" "apim_public_ip" {
  name                = var.apim_public_ip_name
  resource_group_name = var.pep_resource_group_name
}

