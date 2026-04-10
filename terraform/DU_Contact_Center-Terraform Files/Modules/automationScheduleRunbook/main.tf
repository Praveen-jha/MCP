resource "azurerm_automation_schedule" "schedule" {
  name                    = var.scheduleName
  resource_group_name     = var.rgName
  automation_account_name = var.automationAccountName
  frequency               = var.frequency
  timezone                = var.timezone
  start_time              = var.startTime
  interval = var.interval
}

resource "azurerm_automation_job_schedule" "JobScheduler" {
  resource_group_name     = var.rgName
  automation_account_name = var.automationAccountName
  schedule_name           = var.scheduleName
  runbook_name            = var.runbookName
  parameters = {
    resourcegroupname = var.rgNameVM
    vmnames = var.vmnames
  }
}
