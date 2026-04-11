data "azurerm_resource_group" "computeRG" {
  name = var.nameConfig.existingComputeRGName
}

data "azurerm_resource_group" "networkRG" {
  name = var.nameConfig.existingNetworkRGName
}

data "azurerm_subnet" "computeSubnet" {
  name                 = "${local.baseName2}-vnet1-${local.baseName1}-compute-snet1"
  virtual_network_name = var.nameConfig.existingVnetName
  resource_group_name  = data.azurerm_resource_group.networkRG.name
}

data "azurerm_storage_account" "shirStorageAccount" {
  name = var.shirConfig.shirStorageAccountName 
  resource_group_name = var.shirConfig.shirRGName
}

data "azurerm_storage_container" "shirContainer" {
  name = var.shirConfig.shirContainerName
  storage_account_name = data.azurerm_storage_account.shirStorageAccount.name
}

data "azurerm_storage_blob" "shirBlob" {
  name = var.shirConfig.shirBlobName 
  storage_container_name = data.azurerm_storage_container.shirContainer.name
  storage_account_name = data.azurerm_storage_account.shirStorageAccount.name
}

data "azurerm_synapse_workspace" "synapse" {
  name = "${local.baseName1}-synw"
  resource_group_name = var.shirConfig.synapseRGName
}