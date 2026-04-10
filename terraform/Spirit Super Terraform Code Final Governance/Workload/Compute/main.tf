# ......................................................
# Module: SHIR Virtual Machine
# ......................................................
module "shirVM" {
  source        = "../../Modules/networkServices/virtualmachine/Windows"
  vmName        = "${local.baseName1}-shir1"
  nicName       = "${local.baseName1}-shir1-nic1"
  location      = var.nameConfig.defaultLocation
  osdiskName    = "${local.baseName1}-shir1-osdisk"
  rgName        = data.azurerm_resource_group.computeRG.name
  Tag           = var.nameConfig.tags
  adminUsername = "" 
  adminPassword = ""
  subnet_id     = data.azurerm_subnet.computeSubnet.id
  vmConfig      = var.shirVM
}


# ......................................................
# Module: Synapse Self Hosted Integration Runtime
# ......................................................
module "synapseShir" {
  source = "../../Modules/synapse/synapseShir"
  synapseShirName =  "${local.baseName1}-synw-shir1"
  synapseWorkspaceId = data.azurerm_synapse_workspace.synapse.id 
  depends_on = [ module.shirVM ]
}


# ...........................................................
# Module: Virtual Machine Extension for Synapse SHIR Setup 
# ...........................................................
module "synapseShirVmExtension" {
  source = "../../Modules/networkServices/virtualmachine/vmExtention"
  vmExtensionName = "${local.baseName1}-synw-shir1"
  storageAccountName = data.azurerm_storage_account.shirStorageAccount.name 
  containerName = data.azurerm_storage_container.shirContainer.name 
  blobName = data.azurerm_storage_blob.shirBlob.name 
  virtualMachineId = module.shirVM.windowVmId
  shirKey = module.synapseShir.shirKey
  accessKey = data.azurerm_storage_account.shirStorageAccount.primary_access_key
  depends_on = [ module.synapseShir ]
}


# ......................................................
# Module: OPDG Virtual Machine
# ......................................................
module "opdgVM" {
  source        = "../../Modules/networkServices/virtualmachine/Windows"
  vmName        = "${local.baseName1}-opdg1"
  nicName       = "${local.baseName1}-opdg1-nic1"
  location      = var.nameConfig.defaultLocation
  osdiskName    = "${local.baseName1}-opdg1-osdisk"
  rgName        = data.azurerm_resource_group.computeRG.name
  Tag           = var.nameConfig.tags
  adminUsername = ""
  adminPassword = ""
  subnet_id     = data.azurerm_subnet.computeSubnet.id
  vmConfig      = var.opdgVM
}