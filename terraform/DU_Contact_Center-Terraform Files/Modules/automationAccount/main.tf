resource "azurerm_automation_account" "automationAccount" {
  name                = var.automationAccountName
  location            = var.location
  resource_group_name = var.rgName
  sku_name            = var.sku
  tags = var.tags
  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [ identity ]
  }
}