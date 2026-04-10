# Creation of SQL Managed Instance
module "sql_managed_instance" {
  source                              = "../modules/terraform-azure-sql-managed-instance-module"
  for_each                            = local.sql_mis_for_each
  sql_mi_name                         = each.value.sql_mi_name
  sql_mi_location                     = data.azurerm_resource_group.existing_resource_group_sql_mi[0].location
  parent_id                           = data.azurerm_resource_group.existing_resource_group_sql_mi[0].id
  sql_mi_resource_type                = each.value.sql_mi_base.sql_mi_resource_type
  sql_mi_identity_type                = each.value.sql_mi_base.sql_mi_identity_type
  sql_mi_admin_login                  = each.value.sql_mi_base.sql_mi_admin_login
  sql_mi_admin_password               = each.value.sql_mi_base.sql_mi_admin_password
  ad_group_display_name               = each.value.sql_mi_base.ad_group_display_name
  ad_group_object_id                  = each.value.sql_mi_base.ad_group_object_id
  administrator_type                  = each.value.sql_mi_base.administrator_type
  azuread_authentication_only_enabled = each.value.sql_mi_base.azuread_authentication_only_enabled
  azuread_principal_type              = each.value.sql_mi_base.azuread_principal_type
  tenant_id                           = each.value.sql_mi_base.tenant_id
  sql_mi_subnet_id                    = data.azurerm_subnet.existing_outbound_subnet[0].id
  sql_mi_vcores                       = each.value.sql_mi_config.sql_mi_vcores
  sql_mi_storage_size                 = each.value.sql_mi_config.sql_mi_storage_size
  sql_mi_storage_iops                 = each.value.sql_mi_config.sql_mi_storage_iops
  timezone_id                         = lookup(each.value.sql_mi_config, "sql_mi_timezone_id", null)
  sql_mi_zone_redundant               = lookup(each.value.sql_mi_config, "sql_mi_zone_redundant", false)
  sql_mi_collation                    = lookup(each.value.sql_mi_config, "sql_mi_collation", null)
  sql_mi_database_format              = lookup(each.value.sql_mi_config, "sql_mi_database_format", null)
  sql_mi_is_general_purpose_v2        = lookup(each.value.sql_mi_config, "sql_mi_is_general_purpose_v2", null)
  sql_mi_license_type                 = lookup(each.value.sql_mi_config, "sql_mi_license_type", null)
  sql_mi_minimal_tls_version          = lookup(each.value.sql_mi_config, "sql_mi_minimal_tls_version", null)
  sql_mi_pricing_model                = lookup(each.value.sql_mi_config, "sql_mi_pricing_model", null)
  sql_mi_proxy_override               = lookup(each.value.sql_mi_config, "sql_mi_proxy_override", null)
  sql_mi_public_data_endpoint_enabled = lookup(each.value.sql_mi_config, "sql_mi_public_data_endpoint_enabled", false)
  sql_mi_backup_storage_redundancy    = lookup(each.value.sql_mi_config, "sql_mi_backup_storage_redundancy", null)
  sql_mi_sku_capacity                 = each.value.sku.sql_mi_sku_capacity
  sql_mi_sku_family                   = each.value.sku.sql_mi_sku_family
  sql_mi_sku_name                     = each.value.sku.sql_mi_sku_name
  sql_mi_sku_tier                     = each.value.sku.sql_mi_sku_tier
  tags                                = var.tags
}

# Creation of Private Endpoint for SQL Managed Instance in Same Virtual Network
module "sql_mi_private_endpoint_same_vnet" {
  source                          = "../modules/terraform-azure-private-endpoint-module"
  for_each                        = local.sql_mi_private_endpoints_same_vnet_for_each
  private_endpoint_name           = each.value.sql_mi_private_endpoint_name
  location                        = var.location
  resource_group_name             = data.azurerm_resource_group.existing_resource_group_sql_mi[0].name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet_same_vnet[0].id
  private_service_connection_name = each.value.private_service_connection_name
  subresource_names               = each.value.sql_managed_instance_subresource_names
  private_connection_resource_id  = module.sql_managed_instance[each.key].sql_mi_id
  tags                            = var.tags
}

# Creation of Private DNS A Record for SQL Managed Instance in Same Virtual Network
module "pdz_a_record_same_vnet" {
  source                               = "../modules/terraform-azure-private-dns-arecord-module"
  for_each                             = local.sql_mi_private_endpoints_same_vnet_for_each
  private_dns_record_name              = each.value.sql_mi_name
  private_dns_zone_name                = var.private_dns_zone_name_same_vnet
  private_dns_zone_resource_group_name = var.private_dns_zone_resource_group_name
  records                              = module.sql_mi_private_endpoint_same_vnet[each.key].private_endpoint_ip_config
}

# Creation of Private Endpoint for SQL Managed Instance in Different Virtual Network
module "sql_mi_private_endpoint_diff_vnet" {
  source                          = "../modules/terraform-azure-private-endpoint-module"
  for_each                        = local.sql_mi_private_endpoints_diff_vnet_for_each
  private_endpoint_name           = each.value.sql_mi_private_endpoint_name
  location                        = var.location
  resource_group_name             = data.azurerm_resource_group.existing_resource_group_sql_mi[0].name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet_diff_vnet[0].id
  private_service_connection_name = each.value.private_service_connection_name
  subresource_names               = each.value.sql_managed_instance_subresource_names
  private_connection_resource_id  = module.sql_managed_instance[each.key].sql_mi_id
  tags                            = var.tags
}

# Creation of Private DNS A Record for SQL Managed Instance in Different Virtual Network
module "pdz_a_record_diff_vnet" {
  source                               = "../modules/terraform-azure-private-dns-arecord-module"
  for_each                             = local.sql_mi_private_endpoints_diff_vnet_for_each
  private_dns_record_name              = each.value.sql_mi_name
  private_dns_zone_name                = var.private_dns_zone_name_diff_vnet
  private_dns_zone_resource_group_name = var.private_dns_zone_resource_group_name
  records                              = module.sql_mi_private_endpoint_diff_vnet[each.key].private_endpoint_ip_config
}
