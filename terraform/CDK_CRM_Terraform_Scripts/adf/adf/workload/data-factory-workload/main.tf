#Creation of Resource Group
module "resource_group" {
  source                  = "../../module/resource_group"
  count                   = var.name_config.data_factory_resource_group_creation == "new" ? 1 : 0
  resource_group_name     = var.new_data_factory_resource_group_name
  resource_group_location = var.location
  resource_group_tags     = var.tags
}

#Creation of Data Factory
module "data_factory" {
  source                          = "../../module/adf"
  data_factory_name               = var.data_factory_name
  data_factory_location           = var.location
  data_factory_rg                 = local.resource_group_name
  identity_type                   = var.identity_type
  tags                            = var.tags
  public_network_enabled          = var.public_network_access_enabled
  managed_virtual_network_enabled = var.managed_virtual_network_enabled
  depends_on                      = [module.resource_group]
}

#Creation of Private Endpoint of Data Factory
module "data_factory_private_endpoint" {
  source                          = "../../module/private_endpoint"
  count                           = var.public_network_access_enabled == false ? 1 : 0
  private_endpoint_name           = local.data_factory_private_endpoint_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = local.private_service_connection_name
  subresource_names               = local.data_factory_subresource_names
  private_connection_resource_id  = module.data_factory.data_factory_id
  enable_private_dns_zone_group   = var.enable_private_dns_zone_group
  private_dns_zone_group_name     = local.private_dns_zone_group_name
  private_dns_zone_ids            = var.data_factory_private_dns_zone_id
  depends_on                      = [module.data_factory]
}
