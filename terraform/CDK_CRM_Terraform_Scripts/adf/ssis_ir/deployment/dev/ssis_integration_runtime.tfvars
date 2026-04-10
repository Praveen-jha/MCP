data_factory_name             = "ssis-test-adf01"
ssis_integration_runtime_name = "ssis-ir3"

location = "CentralUS"

tags = {
  environment = "dev"
}

name_config = {
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "04"
  application                             = "adf"
}

node_size       = "Standard_D4_v3"
number_of_nodes = 1

catalog_info = {
  server_endpoint = "ssis-sql-server01.database.windows.net"
  pricing_tier    = "S1"
}

license_type                     = "LicenseIncluded"
enable_vnet_integration          = true
data_factory_credential_umi_name = "credentials01" //Not required, if Identity Type is "SystemAssigned"

identity_type = "UserAssigned"

existing_data_factory_rg_name           = "ssis-test-rg"
existing_vnet_rg_name                   = "ssis-test-rg"
existing_virtual_network_name           = "ssis-test-vnet"
existing_private_ssis_subnet_name       = "ssis-subnet"
existing_user_assigned_identity_name    = "umi"    //Not required, if Identity Type is "SystemAssigned"
existing_user_assigned_identity_rg_name = "testrg" //Not required, if Identity Type is "SystemAssigned"
