# Inside the workload main use for_each for the following module to create multiple datadisk for the same vm
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk

resource "azurerm_managed_disk" "this" {
  name                             = var.data_disk_name
  location                         = var.data_disk_location
  resource_group_name              = var.data_disk_rg_name
  storage_account_type             = var.data_disk_storage_account_type
  create_option                    = var.data_disk_create_option
  tags                             = var.data_disk_tags
  disk_size_gb                     = var.data_disk_size_gb
  zone                             = try(var.data_disk_zone, null)
  os_type                          = contains(["Import", "ImportSecure", "Copy"], var.data_disk_create_option) ? try(var.data_disk_os_type, null) : null
  disk_encryption_set_id           = var.data_disk_security_type != "ConfidentialVM_DiskEncryptedWithCustomerKey" && var.data_disk_secure_vm_disk_encryption_set_id == null ? try(var.data_disk_disk_encryption_set_id, null) : null
  secure_vm_disk_encryption_set_id = var.data_disk_security_type == "ConfidentialVM_DiskEncryptedWithCustomerKey" && var.data_disk_disk_encryption_set_id == null ? var.data_disk_secure_vm_disk_encryption_set_id : null


  disk_iops_read_write              = try(var.data_disk_iops_read_write, null)
  disk_mbps_read_write              = try(var.data_disk_mbps_read_write, null)
  disk_iops_read_only               = try(var.data_disk_iops_read_only, null)
  disk_mbps_read_only               = try(var.data_disk_mbps_read_only, null)
  upload_size_bytes                 = var.data_disk_create_option == "Upload" ? var.data_disk_upload_size_bytes : null
  edge_zone                         = try(var.data_disk_edge_zone, null)
  hyper_v_generation                = contains(["Import", "Copy", "ImportSecure"], var.data_disk_create_option) ? (contains(["ImportSecure"], var.data_disk_create_option) ? "V2" : try(var.data_disk_hyper_v_generation, null)) : null
  image_reference_id                = var.data_disk_create_option == "FromImage" && var.data_disk_gallery_image_reference_id == null ? try(var.data_disk_image_reference_id, null) : null
  gallery_image_reference_id        = var.data_disk_create_option == "FromImage" && var.data_disk_image_reference_id == null ? try(var.data_disk_gallery_image_reference_id, null) : null
  logical_sector_size               = contains(["UltraSSD_LRS", "PremiumV2_LRS"], var.data_disk_storage_account_type) ? try(var.data_disk_logical_sector_size, null) : null
  optimized_frequent_attach_enabled = var.data_disk_optimized_frequent_attach_enabled
  performance_plus_enabled          = var.data_disk_performance_plus_enabled
  source_resource_id                = contains(["Copy", "Restore"], var.data_disk_create_option) ? try(var.data_disk_source_resource_id, null) : null
  source_uri                        = contains(["Import", "ImportSecure"], var.data_disk_create_option) ? try(var.data_disk_source_uri, null) : null
  storage_account_id                = contains(["Import", "ImportSecure"], var.data_disk_create_option) ? try(var.data_disk_storage_account_id, null) : null
  tier                              = try(var.data_disk_tier, null)
  max_shares                        = try(var.data_disk_max_shares, null)
  trusted_launch_enabled            = contains(["FromImage", "Import"], var.data_disk_create_option) ? try(var.data_disk_trusted_launch_enabled, null) : null
  security_type                     = contains(["FromImage", "ImportSecure"], var.data_disk_create_option) && var.data_disk_trusted_launch_enabled == false ? "ConfidentialVM_DiskEncryptedWithCustomerKey" : (var.data_disk_trusted_launch_enabled == false ? try(var.data_disk_security_type, null) : null)
  on_demand_bursting_enabled        = try(var.data_disk_on_demand_bursting_enabled, null)
  network_access_policy             = try(var.data_disk_network_access_policy, null)
  disk_access_id                    = var.data_disk_network_access_policy == "AllowPrivate" ? try(var.data_disk_access_id, null) : null
  public_network_access_enabled     = try(var.data_disk_public_network_access_enabled, null)

  dynamic "encryption_settings" {
    for_each = var.data_disk_encryption_settings == null ? [] : ["encryption_settings"]
    content {
      disk_encryption_key {
        secret_url      = try(var.data_disk_encryption_settings.disk_encryption_key.secret_url, null)
        source_vault_id = try(var.data_disk_encryption_settings.disk_encryption_key.source_vault_id, null)
      }

      key_encryption_key {
        key_url         = try(var.data_disk_encryption_settings.key_encryption_key.key_url, null)
        source_vault_id = try(var.data_disk_encryption_settings.key_encryption_key.source_vault_id, null)
      }
    }
  }
}
