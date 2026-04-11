resource "azurerm_synapse_workspace" "synapse_workspace" {
  name                                 = var.synapseWorkspaceName
  resource_group_name                  = var.rgName
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.fileSystemId
  sql_administrator_login              = var.sqlAdminUserName
  sql_administrator_login_password     = var.sqlAdminPassword
  managed_virtual_network_enabled      = var.managedVirtualNetworkEnabled
  public_network_access_enabled        = var.publicNetworkAccessEnabled
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
