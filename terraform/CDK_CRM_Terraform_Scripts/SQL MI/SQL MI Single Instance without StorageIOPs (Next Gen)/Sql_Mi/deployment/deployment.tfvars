location = "centralus"

name_config = {
  resource_group_creation  = "existing"
  virtual_network_creation = "existing"
  subnet_creation          = "existing"
  environment              = "dev"
  short_name               = "mr"
  product_name             = "crm"
  region_flag              = "cus"
  instance                 = "01"
  application              = "sqlmi"
}

sql_mi_base = {
  sql_mi_resource_type                = "Microsoft.Sql/managedInstances@2023-05-01-preview"
  sql_mi_identity_type                = "SystemAssigned"
  sql_mi_admin_login                  = "sqladmin"
  sql_mi_admin_password               = "password@123"
  ad_group_display_name               = ""
  ad_group_object_id                  = ""
  administrator_type                  = "ActiveDirectory"
  azuread_authentication_only_enabled = true
  azuread_principal_type              = "User"
  tenant_id                           = ""
}

sql_mi_config = {
  sql_mi_vcores                       = 4
  sql_mi_storage_size                 = 64
  sql_mi_timezone_id                  = "UTC"
  sql_mi_zone_redundant               = false
  sql_mi_collation                    = "SQL_Latin1_General_CP1_CI_AS"
  sql_mi_database_format              = "SQLServer2022"
  sql_mi_is_general_purpose_v2        = true
  sql_mi_license_type                 = "LicenseIncluded"
  sql_mi_minimal_tls_version          = "1.2"
  sql_mi_pricing_model                = "Regular"
  sql_mi_proxy_override               = "Default"
  sql_mi_public_data_endpoint_enabled = false
  sql_mi_backup_storage_redundancy    = "Geo"
}

sku = {
  sql_mi_sku_capacity = 4
  sql_mi_sku_family   = "Gen5"
  sql_mi_sku_name     = "GP_Gen5"
  sql_mi_sku_tier     = "GeneralPurpose"
}

existing_resource_group_name          = "rg-mr-crm-dev-cus-01"
existing_virtual_network_name         = "vnet-mr-crm-dev-cus-01"
existing_sqlmi_subnet_name            = "snet-mr-crm-dev-sqlmi-cus-01"
existing_private_endpoint_subnet_name = "snet-mr-crm-dev-pep-cus-01"

public_network_access_enabled        = true
private_dns_zone_name                = "privatelink.database.windows.net"
private_dns_zone_resource_group_name = "rg-mr-crm-dev-cus-01"
