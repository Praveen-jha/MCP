data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                            = var.keyVaultName
  location                        = var.location
  resource_group_name             = var.rgName
  enabled_for_disk_encryption     = var.kvEnabledForDiskEncryption
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = var.kvSoftDeleteRetentionDays
  purge_protection_enabled        = var.kvPurgeProtectionEnabled
  sku_name                        = var.kvSkuName
  enabled_for_template_deployment = var.enabledForTemplateDeployment
  enabled_for_deployment          = var.enabledForDeployment
  enable_rbac_authorization       = var.enableRbacAuthorization
  public_network_access_enabled   = var.publicNetworkAccessEnabled
  tags                            = var.kvTags

  network_acls {
    default_action = var.defaultAction
    bypass         = var.bypass
    ip_rules       = var.kvIpRules
  }

}

