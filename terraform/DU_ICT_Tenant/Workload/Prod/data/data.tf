data "azurerm_resource_group" "resource_group" {
  count = var.rg_creation == "existing" ? 1 : 0
  name  = local.data_rg_name
}

data "azurerm_subnet" "pep_subnet" {
  name                 = var.pep_subnet_name
  virtual_network_name = var.pep_virtual_network_name
  resource_group_name  = var.pep_resource_group_name
}

data "azurerm_client_config" "current" {
}

data "azurerm_application_insights" "appi" {
  resource_group_name = var.application_insights_resource_group_name
  name                = var.application_insights_name
}

data "azurerm_cognitive_account" "openai" {
  name                = var.openai_account_name
  resource_group_name = var.openai_resource_group_name
}

data "azurerm_cognitive_account" "di" {
  name                = var.di_account_name
  resource_group_name = var.ai_resource_group_name
}

data "azurerm_search_service" "srch" {
  name                = var.search_service_name
  resource_group_name = var.ai_resource_group_name
}
