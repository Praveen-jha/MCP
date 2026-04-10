output "synapseWorkspaceName" {
  value = azurerm_synapse_workspace.synapseWorkspace.name
  description = "Output for Synapse Workspace Name"
}

output "synapseWorkspaceId" {
  value = azurerm_synapse_workspace.synapseWorkspace.id
  description = "Output for Synapse Workspace ID"
}