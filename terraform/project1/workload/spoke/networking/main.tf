
resource "random_uuid" "uuid" {}
module "virtual_machine" {
  source                        = "../../../Modules/networking/virtualMachine"
  for_each                      = local.virtual_machine
  nic_name                      = each.value.nic_name
  vm_location                   = local.location_primary
  vm_resource_group             = var.networking.spoke_rg_name
  tags                          = var.common_tags
  nic_ip_config_name            = each.value.nic_ip_config_name
  subnet_id                     = data.azurerm_subnet.compute_subnet.id
  private_ip_address_allocation = each.value.private_ip_address_allocation
  vm_name                       = each.value.vm_name
  vm_size                       = each.value.vm_size
  vm_zone                       = each.value.vm_zone
  admin_username                = each.value.admin_username
  admin_password                = random_uuid.uuid.result
  os_disk_name                  = each.value.os_disk_name
  os_disk_caching               = each.value.os_disk_caching
  os_disk_storage_account_type  = each.value.os_disk_storage_account_type
  os_disk_disk_size_gb          = each.value.os_disk_disk_size_gb
  source_image_id               = each.value.source_image_id
}
