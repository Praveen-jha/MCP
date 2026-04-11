output "shirKey" {
  value = azurerm_synapse_integration_runtime_self_hosted.shir.authorization_key_primary
  description = "Output for the SHIR Key of Synapse Analytics Workspace."
}