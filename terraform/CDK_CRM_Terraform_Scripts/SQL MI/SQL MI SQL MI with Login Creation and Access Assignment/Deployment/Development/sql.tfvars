rg_creation           = "existing"
resource_group_name   = "cdk-crm-sqlmi-rg-03"
location              = "centralus"
ad_group_display_name = "adf-test"
tags = {
  "Workload Category" = "Internal Workloads"
  "Tier"              = "Networking"
}
sql_instance_name       = "crmsqlinstance09a"

sql_admin_user     = "sqladmin"
sql_admin_password = "password@123"
sql_server_name    = "sql-mi-6094188.43bc68f41483.database.windows.net,3342"

sql_groups = [
  {
    name         = ""
    server_roles = ["sysadmin"]
    databases = [
      {
        name  = "tempdb"
        roles = ["db_datareader", "db_datawriter", "db_owner"]
      }
    ]
  },
  {
    name         = "test-umi"
    server_roles = ["sysadmin"]
    databases = [
      {
        name  = "tempdb"
        roles = ["db_datareader", "db_datawriter", "db_owner"]
      }
    ]
  },
  {
    name         = "test-umi2"
    server_roles = ["sysadmin"]
    databases = [
      {
        name  = "tempdb"
        roles = ["db_datareader", "db_datawriter", "db_owner"]
      }
    ]
  }
]


sql_mi_sku_name         = "GP_Gen5"
sql_storage_size        = 32
sql_vcores              = 4
identity_type           = "SystemAssigned"
hub_resource_group_name = ""
sql_mi_subnet_name      = "sql-mi-subnet-01"
identity_ids            = [""]
azuread_principal_type  = "Group"
display_name            = "Directory Readers"
dns_zone_creation       = "new"

azuread_authentication_only_enabled  = false
private_endpoint_name                = "sqlmi-private-endpoint"
private_service_connection_name      = "sqlmi-private-service-connection"
is_manual_connection                 = false
private_dns_zone_group_name          = "default"
private_connection_subresource_names = ["managedInstance"]

##Same Vnet
private_endpoint_same_vnet         = false
private_dns_zone_name_same_vnet    = "privatelink.site.database.windows.net"
pep_same_vnet_subnet_name          = "subnet-pep"
pep_same_vnet_virtual_network_name = "cdk-crm-vnet"
pep_same_vnet_resource_group_name  = "cdk-crm-sqlmi-rg-03"
pdz_id_same_vnet                   = ""                               ## Only if we are using existing Private DNS Zone

## Diff Vnet
private_endpoint_diff_vnet         = false
private_dns_zone_name_diff_vnet    = "privatelink.psqlinstance01.d9e90fe6c77a.database.windows.net"
pep_diff_vnet_subnet_name          = "default"
pep_diff_vnet_virtual_network_name = ""
pep_diff_vnet_resource_group_name  = ""
pdz_id_diff_vnet                   = ""                              ## Only if we are using existing Private DNS Zone
