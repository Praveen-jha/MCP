rg_creation             = "existing"
resource_group_name     = "sql-rg-01"
location                = "Central US"
ad_group_display_name   = "sqlmigroup"
sql_instance_name       = "psqlinstance01"
sql_storage_size        = 32
sql_vcores              = 4
identity_type           = "SystemAssigned"
hub_resource_group_name = "Hub-RG"
sql_mi_subnet_name      = "subnet-sql"
identity_ids            = []
azuread_principal_type  = "Group"
display_name            = "Directory Readers"

azuread_authentication_only_enabled  = true
private_endpoint_name                = "sqlmi-private-endpoint"
private_service_connection_name      = "sqlmi-private-service-connection"
is_manual_connection                 = false
private_dns_zone_group_name          = "default"
private_connection_subresource_names = ["managedInstance"]

##Same Vnet
private_endpoint_same_vnet         = false
private_dns_zone_name_same_vnet    = "privatelink.site.database.windows.net"
pep_same_vnet_subnet_name          = "subnet-pep"
pep_same_vnet_virtual_network_name = "vnet-sql"
pep_same_vnet_resource_group_name  = "sql-rg-01"

## DIFF SNET
private_endpoint_diff_vnet         = false
private_dns_zone_name_diff_vnet    = "privatelink.psqlinstance01.d9e90fe6c77a.database.windows.net"
pep_diff_vnet_subnet_name          = "default"
pep_diff_vnet_virtual_network_name = "Test-sql-vnet"
pep_diff_vnet_resource_group_name  = "sqlRg"
