resource "azurerm_virtual_machine_extension" "vmextension-0000" {
  name                       = var.vmExtensionName
  virtual_machine_id         = var.virtualMachineId
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  protected_settings = <<PROTECTED_SETTINGS
      {
          "fileUris": ["${format("https://%s.blob.core.windows.net/%s/%s", var.storageAccountName, var.containerName, var.blobName)}"],
          "commandToExecute": "${join(" ", ["powershell.exe -ExecutionPolicy Unrestricted -File",var.blobName,"-gatewayKey ${var.shirKey} "])}",
          "storageAccountName": "${var.storageAccountName}",
          "storageAccountKey": "${var.accessKey}"
      }
  PROTECTED_SETTINGS
}