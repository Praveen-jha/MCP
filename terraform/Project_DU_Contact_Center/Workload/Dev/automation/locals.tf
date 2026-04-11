locals {

  rg_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-automation-rg"

  automation_account_name = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-aa"

  runbook_name_start = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-aa-rb-vm-start" # If Start runbook name get change then update in PowerShell scirpt file name StartVMs.ps1
  runbook_name_stop  = "${var.tenant_name}-platform-${var.bu_name}-${var.environment}-aa-rb-vm-stop"  # If Stop runbokk name get change then update in PowerShell scirpt file name StopVMs.ps1

  vm_role_definition_name = "Virtual Machine Contributor"

  frequency = "Day"
  interval  = 1
  timezone  = "UTC"


  automationRunbookVmStart = {
    runbookType = "PowerShellWorkflow"
    content     = "psScript/StartVMs.ps1"
  }

  automationRunbookVmStop = {
    runbookType = "PowerShellWorkflow"
    content     = "psScript/StopVMs.ps1"
  }

  vms = {
    ict-platform-ccai-dev-devopssha01-vm = { #VM Name
      vm_resource_group = "ict-platform-ccai-dev-workload-rg"
      start_schedule    = "ict-platform-ccai-dev-aa-schd-sha-vm-start"
      stop_schedule     = "ict-platform-ccai-dev-aa-schd-sha-vm-stop"
      start_time        = "2025-02-05T04:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
      stop_time         = "2025-02-05T14:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    }
    ict-platform-ccai-dev-jumpbox01-vm = { #VM Name
      vm_resource_group = "ict-platform-ccai-dev-workload-rg"
      start_schedule    = "ict-platform-ccai-dev-aa-schd-jumpbox01-vm-start"
      stop_schedule     = "ict-platform-ccai-dev-aa-schd-jumpbox01-vm-stop"
      start_time        = "2025-02-05T04:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
      stop_time         = "2025-02-05T14:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    }
    # ict-platform-ccai-dev-jumpbox02-vm = { #VM Name
    #   vm_resource_group = "ict-platform-ccai-dev-workload-rg"
    #   start_schedule    = "ict-platform-ccai-dev-aa-schd-jumpbox02-vm-start"
    #   stop_schedule     = "ict-platform-ccai-dev-aa-schd-jumpbox02-vm-stop"
    #   start_time        = "2025-02-05T04:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    #   stop_time         = "2025-02-05T14:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    # }
    # ict-platform-ccai-dev-jumpbox03-vm = { #VM Name
    #   vm_resource_group = "ict-platform-ccai-dev-workload-rg"
    #   start_schedule    = "ict-platform-ccai-dev-aa-schd-jumpbox03-vm-start"
    #   stop_schedule     = "ict-platform-ccai-dev-aa-schd-jumpbox01-vm-stop"
    #   start_time        = "2025-02-05T04:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    #   stop_time         = "2025-02-05T14:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    # }
    # ict-platform-ccai-dev-adfshir01-vm = { #VM Name
    #   vm_resource_group = "ict-platform-ccai-dev-workload-rg"
    #   start_schedule    = "ict-platform-ccai-dev-aa-schd-adfshir01-vm-start"
    #   stop_schedule     = "ict-platform-ccai-dev-aa-schd-adfshir01-vm-stop"
    #   start_time        = "2025-02-05T04:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    #   stop_time         = "2025-02-05T14:30:00Z" # YYYY-MM-DDTHH:MM:SSZ || HH(24Format)
    # }
  }
}

