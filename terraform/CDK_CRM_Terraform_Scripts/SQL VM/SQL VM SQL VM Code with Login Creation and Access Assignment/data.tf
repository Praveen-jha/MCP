# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# data "azurerm_shared_image_version" "latest" {
#   provider            = azurerm.vm-image-hub
#   name                = var.image_version
#   image_name          = var.image_name
#   gallery_name        = var.gallery_name                # hard code data?
#   resource_group_name = var.gallery_resource_group_name # hard code data?
# }