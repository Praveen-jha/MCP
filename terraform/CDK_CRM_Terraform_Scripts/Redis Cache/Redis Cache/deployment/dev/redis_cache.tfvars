location = "centralus"
tags     = { environment = "dev" }

name_config = {
  redis_cache_resource_group_creation     = "existing"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "01"
  application                             = "redis"
}

redis_cache = {
  capacity                           = 1
  family                             = "P"
  sku_name                           = "Premium"
  access_keys_authentication_enabled = true
  non_ssl_port_enabled               = false
  redis_version                      = "6"
  minimum_tls_version                = "1.2"
}

redis_configuration = {
  authentication_enabled                  = true
  active_directory_authentication_enabled = true
}

new_redis_cache_resource_group_name = "rg-mr-crm-dev-cus-01"

public_network_access_enabled = true // flase only when sku is premium

availability_zone = false
zones             = [] //Not required if availability zones in false

existing_resource_group_redis_cache_name     = "rg-mr-crm-dev-cus-01" //Not required if deploying new Resource Group
existing_resource_group_virtual_network_name = "rg-mr-crm-dev-vnet-cus-01"
existing_virtual_network_name                = "vnet-mr-crm-dev-cus-01"
existing_private_endpoint_subnet_name        = "snet-mr-crm-dev-pep-cus-01"
existing_outbound_subnet_name                = "snet-mr-crm-dev-redis-cus-01"
redis_cache_vnet_integration_enable          = true
enable_private_dns_zone_group                = true
redis_cache_private_dns_zone_id              = [""]
