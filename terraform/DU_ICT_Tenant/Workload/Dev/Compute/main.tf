# ......................................................
# Creating New Resource Group
# ......................................................

module "rg" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.compute_rg_name
  resource_group_location = var.rg_location
}

# ......................................................
# Creating PBI VM
# ......................................................

module "pbi_vm" {
  source                        = "../../../Modules/virtualMachines"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  windows_vm_name               = local.pbi_vm_name
  admin_username                = var.admin_username
  password                      = var.password
  caching                       = local.caching
  computer_name                 = local.pbi_computer_name
  image_version                 = local.image_version
  private_ip_address_allocation = local.private_ip_address_allocation
  nic_name                      = local.pbi_network_interface_name
  size                          = var.size
  storage_account_type          = local.storage_account_type
  subnet_id                     = data.azurerm_subnet.compute_subnet.id
  windows_offer                 = var.windows_offer_pbi_vm
  windows_publisher             = var.windows_publisher_pbi_vm
  windows_sku                   = var.windows_sku_pbi_vm
  nic_ip_configuration_name     = local.pbi_nic_ip_configuration_name
  depends_on                    = [module.rg]
  nic_tags                      = var.nic_tags
  identity_type                 = var.identity_type
  identity_ids                  = [data.azurerm_user_assigned_identity.uaid.id]
  vm_tags                       = var.vm_tags
}

# ......................................................
# Creating Development VM
# ......................................................

module "development_vm" {
  source                        = "../../../Modules/virtualMachines"
  count                         = length(local.development_vm_names)
  resource_group_name           = local.resource_group_name
  location                      = local.location
  windows_vm_name               = element(local.development_vm_names, count.index)
  admin_username                = var.admin_username
  password                      = var.password
  caching                       = local.caching
  computer_name                 = element(local.development_vm_computer_names, count.index)
  image_version                 = local.image_version
  private_ip_address_allocation = local.private_ip_address_allocation
  nic_name                      = element(local.development_vm_network_interface_names, count.index)
  size                          = element(var.dev_vm_size, count.index)
  storage_account_type          = local.storage_account_type
  subnet_id                     = data.azurerm_subnet.compute_subnet.id
  windows_offer                 = var.windows_offer
  windows_publisher             = var.windows_publisher
  windows_sku                   = var.windows_sku
  nic_ip_configuration_name     = element(local.development_vm_nic_ip_configuration_names, count.index)
  nic_tags                      = var.nic_tags
  vm_tags                       = var.vm_tags
  identity_type                 = var.identity_type
  identity_ids                  = [data.azurerm_user_assigned_identity.uaid.id]
  depends_on                    = [module.rg]
}
