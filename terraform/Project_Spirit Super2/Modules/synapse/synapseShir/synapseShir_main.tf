resource "azurerm_synapse_integration_runtime_self_hosted" "shir" {
  name                = var.synapseShirName
  synapse_workspace_id = var.synapseWorkspaceId
}