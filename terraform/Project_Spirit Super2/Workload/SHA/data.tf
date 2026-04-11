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

data "template_file" "install_devops_agent_win" {
    # for_each    = local.scripts_to_execute
    template    = "${file("windows-agent-install.ps1")}"
    vars = {
        DEVOPSURL          = "https://dev.azure.com/arinsharma0181/"   
        DEVOPSTENANTID     = "d18895cc-999c-43f0-acda-6b008393110a"
        DEVOPSCLIENTID     = data.azurerm_key_vault_secret.client_id.value
        DEVOPSCLIENTSECRET = data.azurerm_key_vault_secret.client_secret.value
        DEVOPSPOOL         = "pool1"   
        DEVOPSAGENT        = "myagent"
        }
}

data "azurerm_key_vault" "devOpsKeyVault" {
  name = "spirit-super-poc-kv01"
  resource_group_name = "testRG-01"
}

data "azurerm_key_vault_secret" "client_id" {
  name = "clientid"
  key_vault_id =  data.azurerm_key_vault.devOpsKeyVault.id 
}

data "azurerm_key_vault_secret" "client_secret" {
  name =  "clientSecret"
  key_vault_id = data.azurerm_key_vault.devOpsKeyVault.id
}