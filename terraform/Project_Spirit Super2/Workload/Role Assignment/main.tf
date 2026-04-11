resource "azurerm_role_assignment" "synapse_contributor" {
  scope                = data.azurerm_synapse_workspace.synapse_workspace.id
  role_definition_name = "Contributor"
  principal_id         = var.principal_id
}