# # terraform.tfvars

# # General resource information
# subscription_id     = ""
# resource_group_name = "sql-rg"
# prefix              = "mr"
# location            = "centralus"
# name                = "sql-vm-01"

# # Virtual machine settings
# size                        = "Standard_D8s_v3"
# availability_zone           = true
# vm_zone                     = "1"
# timezone_id                 = ""
# storage_account_type        = "Premium_LRS"
# disk_size_gb                = 128
# subnet_id                   = ""
# image_name                  = ""
# disk_sku                    = "Premium_LRS"


# #Data and log disk configuration
# data_log_disks_config = {
#   data = {
#     total_size_gb   = 50684
#     number_of_disks = 2
#     iops            = 44490
#     throughput      = 727
#     caching         = "None"
#     disk_type       = "PremiumV2_LRS"
#     zone            = "1"
#   }
#   log = {
#     total_size_gb   = 21101
#     number_of_disks = 1
#     iops            = 3000
#     throughput      = 125
#     caching         = "None"
#     disk_type       = "PremiumV2_LRS"
#     zone            = "1"
#   }
# }

# db_tempdb_size_gb = 128
# db_tempdb_path    = "T:\\tempdb"
# db_data_path      = "M:\\Data"
# db_log_path       = "L:\\Logs"

# collation               = "Latin1_General_CI_AI"
# sql_license_type        = "AHUB"
# sql_sysadmin_group_name = "AAD-DBA-Admins-SQLVM"

# # Tagging information
# vm_tags = {
# }

# nic_tags = {
# }

# tags = {
# }
