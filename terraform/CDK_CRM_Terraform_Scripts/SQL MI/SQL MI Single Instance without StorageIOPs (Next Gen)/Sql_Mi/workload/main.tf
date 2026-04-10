#Creation of SQL Managed Instance
module "sql_managed_instance" {
  source                              = "../modules/terraform-azure-sql-managed-instance-module"
  sql_mi_resource_type                = var.sql_mi_base.sql_mi_resource_type
  sql_mi_name                         = local.new_sql_managed_instance_name
  sql_mi_location                     = data.azurerm_resource_group.existing_resource_group[0].location
  parent_id                           = data.azurerm_resource_group.existing_resource_group[0].id
  sql_mi_identity_type                = var.sql_mi_base.sql_mi_identity_type
  sql_mi_admin_login                  = var.sql_mi_base.sql_mi_admin_login
  sql_mi_admin_password               = var.sql_mi_base.sql_mi_admin_password
  ad_group_display_name               = var.sql_mi_base.ad_group_display_name
  ad_group_object_id                  = var.sql_mi_base.ad_group_object_id
  administrator_type                  = var.sql_mi_base.administrator_type
  azuread_authentication_only_enabled = var.sql_mi_base.azuread_authentication_only_enabled
  azuread_principal_type              = var.sql_mi_base.azuread_principal_type
  tenant_id                           = var.sql_mi_base.tenant_id
  sql_mi_subnet_id                    = data.azurerm_subnet.existing_outbound_subnet[0].id
  sql_mi_vcores                       = var.sql_mi_config.sql_mi_vcores
  sql_mi_storage_size                 = var.sql_mi_config.sql_mi_storage_size
  timezone_id                         = var.sql_mi_config.sql_mi_timezone_id
  sql_mi_zone_redundant               = var.sql_mi_config.sql_mi_zone_redundant
  sql_mi_collation                    = var.sql_mi_config.sql_mi_collation
  sql_mi_database_format              = var.sql_mi_config.sql_mi_database_format
  sql_mi_is_general_purpose_v2        = var.sql_mi_config.sql_mi_is_general_purpose_v2
  sql_mi_license_type                 = var.sql_mi_config.sql_mi_license_type
  sql_mi_minimal_tls_version          = var.sql_mi_config.sql_mi_minimal_tls_version
  sql_mi_pricing_model                = var.sql_mi_config.sql_mi_pricing_model
  sql_mi_proxy_override               = var.sql_mi_config.sql_mi_proxy_override
  sql_mi_public_data_endpoint_enabled = var.sql_mi_config.sql_mi_public_data_endpoint_enabled
  sql_mi_backup_storage_redundancy    = var.sql_mi_config.sql_mi_backup_storage_redundancy
  sql_mi_sku_capacity                 = var.sku.sql_mi_sku_capacity
  sql_mi_sku_family                   = var.sku.sql_mi_sku_family
  sql_mi_sku_name                     = var.sku.sql_mi_sku_name
  sql_mi_sku_tier                     = var.sku.sql_mi_sku_tier
}

#Creation of Private Endpoint for SQL Managed Instance
module "sql_mi_private_endpoint" {
  source                          = "../modules/terraform-azure-private-endpoint-module"
  count                           = var.public_network_access_enabled ? 0 : 1
  private_endpoint_name           = local.sql_mi_private_endpoint_name
  location                        = var.location
  resource_group_name             = data.azurerm_resource_group.existing_resource_group[0].name
  subnet_id                       = data.azurerm_subnet.existing_private_endpoint_subnet[0].id
  private_service_connection_name = local.private_service_connection_name
  subresource_names               = local.sql_managed_instance_subresource_names
  private_connection_resource_id  = module.sql_managed_instance.sql_mi_id
}

#Creation of A record in Private DNS Zone
module "private_dns_zone_a_record" {
  source                               = "../modules/terraform-azure-private-dns-arecord-module"
  count                                = var.public_network_access_enabled ? 0 : 1
  private_dns_record_name              = local.new_sql_managed_instance_name
  private_dns_zone_name                = var.private_dns_zone_name
  private_dns_zone_resource_group_name = var.private_dns_zone_resource_group_name
  records                              = module.sql_mi_private_endpoint[0].private_endpoint_ip_config
}
