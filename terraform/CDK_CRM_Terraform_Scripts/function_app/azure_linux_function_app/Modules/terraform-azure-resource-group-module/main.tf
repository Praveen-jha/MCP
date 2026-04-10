#creation of a resource group in Azure
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "this" {
  location = var.resource_group_location
  name     = var.resource_group_name
  tags     = var.tags
}
