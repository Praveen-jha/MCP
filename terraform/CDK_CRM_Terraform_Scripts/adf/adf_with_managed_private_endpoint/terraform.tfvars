
name_config = {
  data_factory_resource_group_creation    = "existing"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  data_factory_creation                  = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "05"
  application                             = "adf"
}

existing_resource_group_data_factory_name = "test-cdk-rg"
existing_resource_group_virtual_network_name = "test-cdk-rg"
existing_virtual_network_name             = "test-vnet"
existing_private_endpoint_subnet_name     = "test-subnet"


# Existing target resources for managed private endpoints
existing_target_resources = {
#   storage1-blob = {
#     type               = "storage_account"
#     name               = "testcdkstrg01"
#     resource_group     = "test-cdk-rg"
#     subresource_name   = "blob"
#   }
#   storage2-file = {
#     type               = "storage_account"
#     name               = "testcdkstrg02"
#     resource_group     = "test-cdk-rg"
#     subresource_name   = "file"
#   }
#   keyvault1 = {
#     type               = "key_vault"
#     name               = "test-kv3050"
#     resource_group     = "test-cdk-rg"
#     subresource_name   = "vault"
#   }
#   sql_mi1 = {
#   type               = "sql_mi"
#   name               = "test-cdk3060"      # your Managed Instance name
#   resource_group     = "test-cdk-rg"
#   subresource_name   = "managedInstance"     # ✅ correct for MI
# }

}

# identity_type = "SystemAssigned"

tags = {
  Project     = "DataPlatform"
  Owner       = "DataTeam"
  CostCenter  = "IT-001"
  Environment = "Production"
}

# location = "Central US"

data_factory_name = "test-adf-3045"