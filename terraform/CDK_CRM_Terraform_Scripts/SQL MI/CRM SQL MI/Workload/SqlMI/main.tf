# ......................................................
# Creating New Resource Group
# ......................................................

module "rg" {
  source                  = "../../Module/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
}

module "sql_managed_instance" {
  source                              = "../../Module/sqlManagedInstance"
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  sql_instance_name                   = var.sql_instance_name
  sql_storage_size                    = var.sql_storage_size
  sql_vcores                          = var.sql_vcores
  subnet_id_sqlmi                     = data.azurerm_subnet.subnet_sqlmi.id
  ad_group_display_name               = data.azuread_group.mi_admin.display_name
  ad_group_object_id                  = data.azuread_group.mi_admin.object_id
  azuread_principal_type              = var.azuread_principal_type
  azuread_authentication_only_enabled = var.azuread_authentication_only_enabled
  identity_type                       = var.identity_type
  identity_ids                        = var.identity_ids

  depends_on = [module.rg]
}

# ......................................................
# Creating Private Same Vnet
# ......................................................

module "Private_Dns_Zone_same_vnet" {
  source = "../../Module/privateDNSZone"
  count  = var.private_endpoint_same_vnet ? 1 : 0
  providers = {
    azurerm = azurerm.hub
  }
  private_dns_zone_name                = var.private_dns_zone_name_same_vnet
  private_dns_zone_resource_group_name = var.hub_resource_group_name
  depends_on                           = [module.rg]
}

module "private_endpoint_same_vnet" {
  source                               = "../../Module/privateEndpoint"
  count                                = var.private_endpoint_same_vnet ? 1 : 0
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  private_endpoint_name                = var.private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet_same_vnet[0].id
  private_service_connection_name      = var.private_service_connection_name
  private_connection_resource_id       = module.sql_managed_instance.sql_managed_instance_id
  private_connection_subresource_names = var.private_connection_subresource_names
  is_manual_connection                 = var.is_manual_connection
  private_dns_zone_group_name          = var.private_dns_zone_group_name
  private_dns_zone_ids                 = [module.Private_Dns_Zone_same_vnet[0].private_dns_zone_id]
  depends_on                           = [module.sql_managed_instance]
}


# ......................................................
# Creating Private Different Vnet
# ......................................................

module "Private_Dns_Zone_diff_vnet" {
  source = "../../Module/privateDNSZone"
  count  = var.private_endpoint_diff_vnet ? 1 : 0
  providers = {
    azurerm = azurerm.hub
  }
  private_dns_zone_name                = var.private_dns_zone_name_diff_vnet
  private_dns_zone_resource_group_name = var.hub_resource_group_name
  depends_on                           = [module.rg]
}

module "private_endpoint_diff_vnet" {
  source                               = "../../Module/privateEndpoint"
  count                                = var.private_endpoint_diff_vnet ? 1 : 0
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  private_endpoint_name                = var.private_endpoint_name
  subnet_endpoint_id                   = data.azurerm_subnet.pep_subnet_diff_vnet[0].id
  private_service_connection_name      = var.private_service_connection_name
  private_connection_resource_id       = module.sql_managed_instance.sql_managed_instance_id
  private_connection_subresource_names = var.private_connection_subresource_names
  is_manual_connection                 = var.is_manual_connection
  private_dns_zone_group_name          = var.private_dns_zone_group_name
  private_dns_zone_ids                 = [module.Private_Dns_Zone_diff_vnet[0].private_dns_zone_id]
  depends_on                           = [module.sql_managed_instance]
}


module "role_assignment" {
  source                                     = "../../Module/roleAssignment"
  display_name                               = var.display_name
  sql_managed_instance_identity_principal_id = module.sql_managed_instance.sql_managed_instance_identity
  depends_on = [ module.sql_managed_instance ]
}
