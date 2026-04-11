resource "azurerm_logic_app_workflow" "logic_app" {
 name                = var.logic_app_name
 location            = var.logic_app_location
 resource_group_name = var.logic_app_resource_group_name
 tags = var.logic_app_tags
}