# terraform.tfvars

# General resource information
subscription_id     = ""
resource_group_name = "sql-vm-ha-rg"
prefix              = "mr"
location            = "centralus"
number_of_replicas  = 4
name                = ["sqlvmtestj1","sqlvmtestj2","sqlvmtestj3","sqlvmtestj4"]

# Virtual machine settings
size                 = "Standard_D2s_v3"
availability_zone    = true
vm_zones              = ["1","1","2","2"]
timezone_id          = "Central Standard Time"
storage_account_type = "Premium_LRS"
disk_size_gb         = 128

subnet_id            = ""


image_name           = "newimage2"
disk_sku             = "Premium_LRS"
disk_controller_type = "SCSI"

db_log_size_gb         = 16
# db_log_iops            = 3000
# db_log_throughput      = 125
db_log_number_of_disks = 1

db_data_size_gb         = 16
# db_data_iops            = 3000
# db_data_throughput      = 125
db_data_number_of_disks = 1
caching                 = "None"

db_tempdb_size_gb = 16
db_tempdb_path    = "T:\\tempdb"
db_data_path      = "M:\\Data"
db_log_path       = "L:\\Logs"

collation               = "Latin1_General_CI_AI"
sql_license_type        = "AHUB"
sql_sysadmin_group_name = "AAD-DBA-Admins-SQLVM"

cluster_name = "sqlvmtestjcls"
cluster_ip   = "10.0.0.10"
storage_account_name = "adsefv"
storage_account_rg_name = "sql-vm-ha-rg"
availability_group_name = "AG1"
listener_name = "sqlvmtestj"
listener_ip = "10.0.0.11"

# Tagging information
vm_tags = {
}

nic_tags = {
}

tags = {
}
