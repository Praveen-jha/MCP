resource "azurerm_automation_runbook" "automationRunbook" {
  name                    = var.runbookName
  location                = var.location
  resource_group_name     = var.rgName
  automation_account_name = var.automationAccountName
  log_verbose             = var.logVerbose
  log_progress            = var.logProgress
  tags                    = var.tags
  runbook_type            = var.runbookType
  content                 = var.content
}