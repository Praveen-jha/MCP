#Terraform code defines an Azure Resource Group using the azurerm_resource_group resource block.
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "this" {
  location = var.resource_group_location
  name     = var.resource_group_name
  tags     = var.tags
}
