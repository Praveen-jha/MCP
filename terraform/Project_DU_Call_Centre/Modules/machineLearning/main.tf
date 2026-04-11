# Defines the Azure Machine Learning workspace resource
resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                           = var.ml_workspace_name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  storage_account_id             = var.storage_account_id
  application_insights_id        = var.application_insights_id
  key_vault_id                   = var.key_vault_id
  public_network_access_enabled  = var.public_network_access_enabled_ml
  tags                           = var.tags
  primary_user_assigned_identity = var.user_assigned_identity_id
  
# Configures the managed network settings for the Machine Learning workspace
  managed_network {
    isolation_mode = var.isolation_mode_ml
  }

# Configures the identity settings for the Machine Learning workspace
  identity {
    type         = var.ml_workspace_identity_type
    identity_ids = var.ml_workspace_identity_type == "SystemAssigned" ? [] : var.ml_workspace_identity_id
  }

  lifecycle {
    ignore_changes = [ high_business_impact ]
  }
}
