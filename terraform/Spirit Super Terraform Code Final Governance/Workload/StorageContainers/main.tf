# ......................................................
# Module: Storage Account Container
# ......................................................
module "aldsgen2_file_system_one" {
  source = "../../Modules/storageServices/adlsGen2FileSystem"
  fileSystemName =  var.cotainers.containerOneName
  storageAccountId = data.azurerm_storage_account.storage_account.id
  depends_on = [ module.sa_network ]
}

# ......................................................
# Module: Storage Account Container
# ......................................................
module "aldsgen2_file_system_two" {
  source = "../../Modules/storageServices/adlsGen2FileSystem"
  fileSystemName =  var.cotainers.containerTwoName
  storageAccountId = data.azurerm_storage_account.storage_account.id
  depends_on = [ module.aldsgen2_file_system_one ]
}

# ......................................................
# Module: Storage Account Container
# ......................................................
module "aldsgen2_file_system_three" {
  source = "../../Modules/storageServices/adlsGen2FileSystem"
  fileSystemName =  var.cotainers.containerThreeName
  storageAccountId = data.azurerm_storage_account.storage_account.id
  depends_on = [ module.aldsgen2_file_system_two ]
}
