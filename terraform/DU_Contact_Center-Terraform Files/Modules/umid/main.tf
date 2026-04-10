# Creates a user-assigned managed identity with the specified location, name, and resource group.
resource "azurerm_user_assigned_identity" "umid" {
  location            = var.location
  name                = var.umid_name
  resource_group_name = var.resource_group_name
  lifecycle {
    ignore_changes = all
  }
}