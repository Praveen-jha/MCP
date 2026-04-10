#Terraform code defines an Azure Resource Group using the azurerm_resource_group resource block.
#A resource group is a collection of resources such as virtual machines, storage accounts, and more, that are deployed and managed together in Azure
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "this" {
  location   = var.resource_group_location
  name       = var.resource_group_name
  managed_by = var.resource_group_managed_by
  tags       = var.resource_group_tags
}