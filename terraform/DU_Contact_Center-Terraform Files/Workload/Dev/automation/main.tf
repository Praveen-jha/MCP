# ......................................................
# Creating New Resource Group
# ......................................................

module "rg" {
  source                  = "../../../Modules/rg"
  resource_group_name     = local.rg_name
  resource_group_location = var.location
  resource_group_tags     = {}
}

# ......................................................
# Module: Automation Account
# ......................................................

module "automationAccount" {
  source                = "../../../Modules/automationAccount"
  automationAccountName = local.automation_account_name
  rgName                = local.rg_name
  location              = var.location
  tags                  = merge(var.tags, { "Workload Name" : "Automation Account" })
  depends_on            = [module.rg]
}

# ......................................................
# Module: Automation Account Start Runbook
# ......................................................

module "automationRunbookVmStart" {
  source                = "../../../Modules/automationRunbook"
  automationAccountName = module.automationAccount.automationAccountName
  runbookName           = local.runbook_name_start
  rgName                = local.rg_name
  location              = var.location
  runbookType           = local.automationRunbookVmStart.runbookType
  content               = file(local.automationRunbookVmStart.content)
  tags                  = merge(var.tags, { "Workload Name" : "Start-VM-RunBook" })
  depends_on            = [module.rg, module.automationAccount]
}

# ......................................................
# Module: Automation Account Stop Runbook
# ......................................................

module "automationRunbookVmStop" {
  source                = "../../../Modules/automationRunbook"
  automationAccountName = module.automationAccount.automationAccountName
  runbookName           = local.runbook_name_stop
  rgName                = local.rg_name
  location              = var.location
  runbookType           = local.automationRunbookVmStop.runbookType
  content               = file(local.automationRunbookVmStop.content)
  tags                  = merge(var.tags, { "Workload Name" : "stop-VM-RunBook" })
  depends_on            = [module.rg, module.automationAccount]
}

# ......................................................
# Module: Automation Account Schedules VM Start
# ......................................................

# module "scheduleVmStart" {
#   source                = "../../../Modules/automationScheduleRunbook"
#   for_each              = local.vms
#   rgName                = local.rg_name
#   scheduleName          = each.value.start_schedule
#   frequency             = local.frequency
#   timezone              = local.timezone
#   interval              = local.interval
#   startTime             = each.value.start_time
#   rgNameVM              = each.value.vm_resource_group
#   runbookName           = module.automationRunbookVmStart.automationRunbookName
#   automationAccountName = module.automationAccount.automationAccountName
#   vmnames               = each.key
#   depends_on            = [module.rg, module.automationAccount, module.automationRunbookVmStart]
# }

# ......................................................
# Module: Automation Account Schedules VM Stop
# ......................................................

# module "scheduleVmStop" {
#   source                = "../../../Modules/automationScheduleRunbook"
#   for_each              = local.vms
#   rgName                = local.rg_name
#   scheduleName          = each.value.stop_schedule
#   frequency             = local.frequency
#   timezone              = local.timezone
#   interval              = local.interval
#   startTime             = each.value.stop_time
#   rgNameVM              = each.value.vm_resource_group
#   runbookName           = module.automationRunbookVmStop.automationRunbookName
#   automationAccountName = module.automationAccount.automationAccountName
#   vmnames               = each.key
#   depends_on            = [module.rg, module.automationAccount, module.automationRunbookVmStop]
# }

# ......................................................
# Creating Role Assignment SMID 
# ......................................................

module "role_assignment_smid" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.vm_role_definition_name
  principal_id         = module.automationAccount.automationAccountSystemAssignedIdentity
  scope                = data.azurerm_resource_group.computeworkload_rg.id
  depends_on           = [module.rg, module.automationAccount]
}
