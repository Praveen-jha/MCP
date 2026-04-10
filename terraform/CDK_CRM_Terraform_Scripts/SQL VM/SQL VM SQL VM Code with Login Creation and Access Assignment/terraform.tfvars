subscription_id     = ""
tenant_id           = ""
resource_group_name = "sql-vm-rg"
prefix              = "cdkcrm"
location            = "centralus"
name                = "n"

private_ip_address_allocation = "Dynamic"
timezone_id                   = "Central Standard Time"
size                          = "Standard_D2s_v3"

subnet_id = ""

sql_admin_user     = "sqladmin"
sql_admin_password = "password@123"
sql_server_name    = "cdksqlv1aad02.products.cdk.com"

sql_groups = [
  {
    name         = ""
    server_roles = ["sysadmin"]
    databases = [
      {
        name  = "testdb"
        roles = ["db_datareader", "db_datawriter", "db_owner"]
      }
    ]
  },
  {
    name         = "test-umi"
    server_roles = ["sysadmin"]
    databases = [
      {
        name  = "testdb2"
        roles = ["db_datareader", "db_datawriter", "db_owner"]
      }
    ]
  }
]

vm_tags = {
  environment = "dev"
  owner       = "crm_team"
}

nic_tags = {
  environment = "dev"
  owner       = "crm_team"
}

availability_zone = false
vm_zone           = "1"

tags = {
  environment         = "dev"
  owner               = "crm_team"
  cdk_asset_id        = ""
  cdk_asset_name      = ""
  cdk_portfolio       = ""
  cdk_sub_portfolio   = ""
  cdk_provisioner     = ""
  cdk_environment     = ""
  cdk_app_criticality = ""
  cdk_account_type    = ""
  cdk_cluster_type    = ""
}

disk_sku             = "Standard_LRS"
disk_size_gb         = 128
caching              = "ReadWrite"
storage_account_type = "Standard_LRS"

db_log_path    = "G:\\log"
db_log_size_gb = 16

db_data_path    = "F:\\data"
db_data_size_gb = 16

db_tempdb_path    = "H:\\tempDb"
db_tempdb_size_gb = 16

collation = "Latin1_General_CI_AI"
