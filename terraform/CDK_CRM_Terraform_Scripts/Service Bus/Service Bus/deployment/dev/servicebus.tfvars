location = "Central US"
tags     = { environment = "dev" }

name_config = {
  servicebus_resource_group_creation      = "existing"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "01"
  application                             = "web"
}

new_servicebus_resource_group_name = "rg-mr-crm-dev-cus-01"

existing_resource_group_servicebus_name      = "rg-mr-crm-dev-cus-01" //Not required if deploying new Resource Group
existing_resource_group_virtual_network_name = "rg-mr-crm-dev-vnet-cus-01"
existing_virtual_network_name                = "vnet-mr-crm-dev-cus-01"
existing_private_endpoint_subnet_name        = "snet-mr-crm-dev-pep-cus-01"

servicebus_config = {
  sku                          = "Premium"
  capacity                     = 1
  premium_messaging_partitions = 1
  local_auth_enabled           = true
  minimum_tls_version          = "1.2"
}

public_network_access_enabled = true
enable_private_dns_zone_group = true

service_bus_private_dns_zone_id = [""]
