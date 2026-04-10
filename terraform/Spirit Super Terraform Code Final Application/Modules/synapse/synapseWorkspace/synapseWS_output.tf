output "synapseWorkspaceName" {
  value = azurerm_synapse_workspace.synapse_workspace.name
  description = "Output for Synapse Workspace Name"
}

output "synapseWorkspaceId" {
  value = azurerm_synapse_workspace.synapse_workspace.id
  description = "Output for Synapse Workspace ID"
}
