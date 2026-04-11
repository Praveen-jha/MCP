locals {
  # resource_group_name      = var.rg_creation == "new" ? module.rg[0].resource_group_name : data.azurerm_resource_group.resource_group[0].name
  # location                 = var.rg_creation == "new" ? module.rg[0].resource_group_location : data.azurerm_resource_group.resource_group[0].location
  dev_data_rg_name         = "${var.tenant_name}-platform-${var.environment}-${var.workload_type}-rg-${var.location_shortname}-01"
  pep_subnet_name          = "ict-platform-ccai-dev-pep-snet-uaen-01"
  dev_network_rg_name      = "ict-platform-ccai-dev-network-rg-uaen-01"
  dev_virtual_network_name = "${var.tenant_name}-platform-${var.environment}-vnet-${var.location_shortname}-01"
  #   umid_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-data-uaid"
  private_dns_zone_group_name = "default"
  is_manual_connection        = false
  #   kv_role_definition_name         = "Key Vault Crypto Officer"
  #   kv_role_secrets_definition_name = "key vault secrets officer"
  key_vault_config = {
    key_vault = {
      kv_name                          = "${var.tenant_name}-platform-${var.environment}-kv"
      key_vault_subresource_names      = ["vault"]
      public_network_access_enabled_kv = false
      enabled_for_disk_encryption      = false
      purge_protection_enabled         = true
      soft_delete_retention_days       = 7
      tags                             = merge(var.tags, { "Workload Name" : "Key Vault" })
    }
  }

  #   secrets = [
  #     {
  #       secret_name  = "dusaccaidevblobpostcall"
  #       secret_value = "${module.adls["postCall_storage"].primary_access_key}"
  #     },
  #     
  #   key_names = {
  #     postCall_storage     = "dusa-ccai-dev-blob-postcall-cmk"  # used this key for postCall_storage
  #     # dataIngestion_storage = "dusa-ccai-dev-adls-ingesting-cmk" # used this key for dataIngestion_storage
  #   }
}

 
