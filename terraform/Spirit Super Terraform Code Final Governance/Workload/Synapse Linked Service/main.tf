resource "azurerm_synapse_linked_service" "azurerm_adlsgen2_linkedservice1" {
  name                 = data.azurerm_storage_account.storage_account_one.name
  synapse_workspace_id = data.azurerm_synapse_workspace.synapse_workspace.id

  type                 = "AzureBlobFS"
  type_properties_json = jsonencode({
    url = format("https://%s.dfs.core.windows.net", data.azurerm_storage_account.storage_account_one.name)
  })
  integration_runtime {
    name = var.nameConfig.shirName
  }
}

resource "azurerm_synapse_linked_service" "azurerm_adlsgen2_linkedservice2" {
  name                 = data.azurerm_storage_account.storage_account_two.name
  synapse_workspace_id = data.azurerm_synapse_workspace.synapse_workspace.id

  type                 = "AzureBlobFS"
  type_properties_json = jsonencode({
    url = format("https://%s.dfs.core.windows.net", data.azurerm_storage_account.storage_account_two.name)
  })
  integration_runtime {
    name = var.nameConfig.shirName
  }
}

resource "azurerm_synapse_linked_service" "azurerm_key_vault_linkedservice" {
  name                 = data.azurerm_key_vault.key_vault.name
  synapse_workspace_id = data.azurerm_synapse_workspace.synapse_workspace.id

  type                 = "AzureKeyVault"
  type_properties_json = jsonencode({
    baseUrl = data.azurerm_key_vault.key_vault.vault_uri
  })
  integration_runtime {
    name = var.nameConfig.shirName
  }
}

resource "azurerm_synapse_linked_service" "azurerm_databricks_linkedservice" {
  name                 = data.azurerm_databricks_workspace.databricks_workspace.name
  synapse_workspace_id = data.azurerm_synapse_workspace.synapse_workspace.id

  type                 = "AzureDatabricks"
  type_properties_json = jsonencode({
    domain  = data.azurerm_databricks_workspace.databricks_workspace.workspace_url,
    accessToken = {
      type      = "AzureKeyVaultSecret"
      secretName = data.azurerm_key_vault_secret.pat_token.name
      store     = {
        referenceName = azurerm_synapse_linked_service.azurerm_key_vault_linkedservice.name
        type          = "LinkedServiceReference"
      }
    }
  })
  integration_runtime {
    name = var.nameConfig.shirName
  }
}

resource "azurerm_synapse_linked_service" "azurerm_databricks_deltalake_linkedservice" {
  name                 = "${data.azurerm_databricks_workspace.databricks_workspace.name}-deltalake"
  synapse_workspace_id = data.azurerm_synapse_workspace.synapse_workspace.id

  type                 = "AzureDatabricksDeltaLake"
  type_properties_json = jsonencode({
    domain  = data.azurerm_databricks_workspace.databricks_workspace.workspace_url,
    accessToken = {
      type      = "AzureKeyVaultSecret"
      secretName = data.azurerm_key_vault_secret.pat_token.name
      store     = {
        referenceName = azurerm_synapse_linked_service.azurerm_key_vault_linkedservice.name
        type          = "LinkedServiceReference"
      }
    }
  })
  integration_runtime {
    name = var.nameConfig.shirName
  }
}
