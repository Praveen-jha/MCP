# ......................................................
# Module: DSHA Virtual Machine
# ......................................................
module "dshaVM" {
  source        = "../../Modules/networkServices/virtualmachine/SHAVM"
  vmName        = "${local.baseName1}-dshai"
  nicName       = "${local.baseName1}-dshai-nic1"
  location      = var.nameConfig.defaultLocation
  osdiskName    = "${local.baseName1}-dshai-osdisk"
  rgName        = data.azurerm_resource_group.computeRG.name
  Tag           = var.nameConfig.tags
  adminUsername = "adminuser"
  adminPassword = "password@123"
  subnet_id     = data.azurerm_subnet.computeSubnet.id
  vmConfig      = var.dshaVM
}

resource "azurerm_virtual_machine_extension" "shaVMExtension" {
  name                       = "SHA"
  virtual_machine_id         = module.dshaVM.windowVmId
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true
  
  protected_settings = <<SETTINGS
    {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.install_devops_agent_win.rendered)}')) | Out-File -filepath ADDS.ps1\" && powershell -ExecutionPolicy Unrestricted -File ADDS.ps1 -DEVOPSURL ${data.template_file.install_devops_agent_win.vars.DEVOPSURL} -DEVOPSTENANTID ${data.template_file.install_devops_agent_win.vars.DEVOPSTENANTID} -DEVOPSCLIENTID ${data.template_file.install_devops_agent_win.vars.DEVOPSCLIENTID} -DEVOPSCLIENTSECRET ${data.template_file.install_devops_agent_win.vars.DEVOPSCLIENTSECRET} -DEVOPSPOOL ${data.template_file.install_devops_agent_win.vars.DEVOPSPOOL}" 
    }
    
    SETTINGS

  depends_on = [ module.dshaVM ]
}