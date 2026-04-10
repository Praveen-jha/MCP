data_factory_name = "cdkadftest01ac"

location = "CentralUS"

tags = {
  environment = "dev"
}

name_config = {
  data_factory_resource_group_creation    = "new"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "01"
  application                             = "adf"
}

new_data_factory_resource_group_name = "rg-mr-crm-dev-cus-01"

public_network_access_enabled   = false
managed_virtual_network_enabled = false

identity_type = "SystemAssigned"

enable_private_dns_zone_group    = true
data_factory_private_dns_zone_id = ["/subscriptions/1edb4cd6-7b49-44f9-87e3-e6add4be7774/resourceGroups/CDK-POC-RG/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net"]

existing_resource_group_data_factory_name    = "rg-mr-crm-dev-cus-01"
existing_resource_group_virtual_network_name = "CDK-POC-RG"
existing_virtual_network_name                = "CDK-Vnet"
existing_private_endpoint_subnet_name        = "PEP-Subnet"
