data "azurerm_storage_account" "storage_account" {
  name = "${local.baseName1}dls2"
  resource_group_name = var.nameConfig.existingApplicationRGName
}
