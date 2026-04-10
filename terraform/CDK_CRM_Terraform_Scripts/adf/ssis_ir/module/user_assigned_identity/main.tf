#main.tf
# This file defines the User Assigned Identity resource for Azure Data Factory credentials.
resource "azurerm_data_factory_credential_user_managed_identity" "this" {
  name            = var.name
  data_factory_id = var.data_factory_id
  identity_id     = var.user_assigned_identity_id

  # Optional
  description = var.description
}
