resource "azurerm_virtual_machine_extension" "shaVMExtension" {
  name                       = var.vmExtensionName
  virtual_machine_id         = var.virtualMachineId
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true
  
  protected_settings = <<SETTINGS
    {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(var.templateFile)}')) | Out-File -filepath ADDS.ps1\" && powershell -ExecutionPolicy Unrestricted -File ADDS.ps1 -DEVOPSURL ${var.devOpsUrl} -DEVOPSTENANTID ${var.devOpsTenantId} -DEVOPSCLIENTID ${var.devOpsClientId} -DEVOPSCLIENTSECRET ${var.devOpsClientSecret} -DEVOPSPOOL ${var.devOpsPool}" 
    }
    
    SETTINGS
}