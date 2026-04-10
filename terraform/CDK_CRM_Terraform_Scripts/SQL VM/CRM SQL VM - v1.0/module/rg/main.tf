resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
  tags     = var.rg_tags
  # lifecycle {
  #   ignore_changes = [
  #     tags
  #   ]
  #   prevent_destroy = true
  # }
}
