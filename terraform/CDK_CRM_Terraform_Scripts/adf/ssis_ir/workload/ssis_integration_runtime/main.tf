#Creation of Data Factory Credential for User Assigned Identity
module "data_factory_credential_umi" {
  source                    = "../../module/user_assigned_identity"
  count                     = var.identity_type == "UserAssigned" ? 1 : 0
  name                      = var.data_factory_credential_umi_name
  data_factory_id           = data.azurerm_data_factory.existing_data_factory.id
  user_assigned_identity_id = data.azurerm_user_assigned_identity.existing_user_assigned_identity[0].id
}

#Creation of SSIS Integration Runtime
module "ssis_integration_runtime" {
  source          = "../../module/ssis_integration_runtime"
  name            = var.ssis_integration_runtime_name
  data_factory_id = data.azurerm_data_factory.existing_data_factory.id
  location        = var.location
  credential_name = var.identity_type == "UserAssigned" ? module.data_factory_credential_umi[0].name : null
  node_size       = var.node_size
  number_of_nodes = var.number_of_nodes
  license_type    = var.license_type
  catalog_info    = var.catalog_info
  vnet_integration = var.enable_vnet_integration ? {
    vnet_id     = data.azurerm_virtual_network.existing_vnet[0].id
    subnet_name = data.azurerm_subnet.existing_ssis_subnet[0].name
  } : null

  depends_on = [ data.azurerm_data_factory.existing_data_factory ]
}
