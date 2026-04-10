# #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "sql-vm-ha-common-powershell-3" {
  for_each = local.replica_instances

  name               = "common-3-powershell-${each.key}"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id

  source {
    script = <<-POWERSHELL
      #Configuring port exclusion to prevent other system processes from being dynamically assigned the same port on the VM

      netsh int ipv4 add excludedportrange tcp startport=58888 numberofports=1 store=persistent
      netsh int ipv4 add excludedportrange tcp startport=59999 numberofports=1 store=persistent

    POWERSHELL
  }
  depends_on = [
    azurerm_virtual_machine_run_command.sql-vm-ha-primary-server-powershell-2
  ]

  tags = merge(var.vm_tags, var.tags)
}