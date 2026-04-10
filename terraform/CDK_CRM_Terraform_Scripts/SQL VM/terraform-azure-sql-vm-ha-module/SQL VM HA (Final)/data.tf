# Fetch the resource group for the VM and related resources
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# Fetch the latest or specified VM image version from the shared image gallery
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/shared_image_version
# data "azurerm_shared_image_version" "latest" {
#   provider            = azurerm.vm-image-hub
#   name                = var.image_version == "sql2022-ws2022" ? "latest" : var.image_version
#   image_name          = var.image_name
#   gallery_name        = var.gallery_name
#   resource_group_name = var.gallery_resource_group_name
# }

# Fetch the current Azure client configuration (e.g., tenant ID for Entra ID)
# Without azurerm_client_config.current, Terraform might not correctly resolve
# the tenant ID, leading to authentication errors or incorrect Entra ID operations.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "current" {}

#Fetch the storage account for Cluster
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account.html
data "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_rg_name
}
