# #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "sql-vm-ha-common-powershell-2" {
  for_each = local.replica_instances

  name               = "common-21-powershell-${each.key}"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id
  source {
    script = <<-POWERSHELL
      #Define all the required variables
      $ServerName = "${var.name[each.value]}"
      $SqlAdminUser = "sqladmin"
      $SqlServerAdminPassword = "password@123"

      $nodeName1 = "${local.replica_peers[each.key][0].name}"
      $certificateName1 = "${local.replica_peers[each.key][0].cert}"
      $nodeLoginName1 = "${local.replica_peers[each.key][0].login}"
      $nodeUserName1 = "${local.replica_peers[each.key][0].user}"
      $node1IP = "${local.replica_peers[each.key][0].ip}"

      $nodeName2 = "${local.replica_peers[each.key][1].name}"
      $certificateName2 = "${local.replica_peers[each.key][1].cert}"
      $nodeLoginName2 = "${local.replica_peers[each.key][1].login}"
      $nodeUserName2 = "${local.replica_peers[each.key][1].user}"
      $node2IP = "${local.replica_peers[each.key][1].ip}"

      $nodeName3 = "${local.replica_peers[each.key][2].name}"
      $certificateName3 = "${local.replica_peers[each.key][2].cert}"
      $nodeLoginName3 = "${local.replica_peers[each.key][2].login}"
      $nodeUserName3 = "${local.replica_peers[each.key][2].user}"
      $node3IP = "${local.replica_peers[each.key][2].ip}"

      $FolderName = "AGfolder"
      $FolderPath = "C:\$FolderName"

      #Enable AOAG from SQL Configuration manager
      Enable-SqlAlwaysOn -Path "SQLSERVER:\Sql\$ServerName\DEFAULT" -force

      New-PSDrive -Name "Z" -PSProvider "FileSystem" -Root "\\$node1IP\$FolderName" -Persist
      Copy-Item "Z:\$certificateName1.crt" -Destination "$FolderPath\"

      New-PSDrive -Name "Y" -PSProvider "FileSystem" -Root "\\$node2IP\$FolderName" -Persist
      Copy-Item "Y:\$certificateName2.crt" -Destination "$FolderPath\"
      
      New-PSDrive -Name "X" -PSProvider "FileSystem" -Root "\\$node3IP\$FolderName" -Persist
      Copy-Item "X:\$certificateName3.crt" -Destination "$FolderPath\"

      #Create logins and give permission on certificates to use that certificates to login

      $createLogin1 = @"
      USE master;   
      CREATE LOGIN $nodeLoginName1 WITH PASSWORD = 'PassWord123!';   
      GO   
      --create a user from the login 
      CREATE USER $nodeUserName1 FOR LOGIN $nodeLoginName1;   
      GO   
      --create a certificate that the login uses for authentication 
      CREATE CERTIFICATE $certificateName1   
        AUTHORIZATION $nodeUserName1   
        FROM FILE = 'C:\$FolderName\$certificateName1.crt'   
      GO  
      --grant connect for login 
      GRANT CONNECT ON ENDPOINT::hadr_endpoint TO [$nodeLoginName1];   
      GO 
      "@

      # Execute the SQL commands
      sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createLogin1

      $createLogin2 = @"
      USE master;   
      CREATE LOGIN $nodeLoginName2 WITH PASSWORD = 'PassWord123!';   
      GO   
      --create a user from the login 
      CREATE USER $nodeUserName2 FOR LOGIN $nodeLoginName2;   
      GO   
      --create a certificate that the login uses for authentication 
      CREATE CERTIFICATE $certificateName2
        AUTHORIZATION $nodeUserName2   
        FROM FILE = 'C:\$FolderName\$certificateName2.crt'   
      GO  
      --grant connect for login 
      GRANT CONNECT ON ENDPOINT::hadr_endpoint TO [$nodeLoginName2];   
      GO 
      "@

      # Execute the SQL commands
      sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createLogin2


      $createLogin3 = @"
      USE master;   
      CREATE LOGIN $nodeLoginName3 WITH PASSWORD = 'PassWord123!';   
      GO   
      --create a user from the login 
      CREATE USER $nodeUserName3 FOR LOGIN $nodeLoginName3;   
      GO   
      --create a certificate that the login uses for authentication 
      CREATE CERTIFICATE $certificateName3
        AUTHORIZATION $nodeUserName3
        FROM FILE = 'C:\$FolderName\$certificateName3.crt'   
      GO  
      --grant connect for login 
      GRANT CONNECT ON ENDPOINT::hadr_endpoint TO [$nodeLoginName3];   
      GO 
      "@

      # Execute the SQL commands
      sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createLogin3


    POWERSHELL
  }
  depends_on = [
    azurerm_virtual_machine_run_command.sql-vm-ha-primary-server-powershell-1
  ]

  tags = merge(var.vm_tags, var.tags)
}

# resource "azurerm_virtual_machine_run_command" "sql-vm-ha-common-powershell-2" {
#   for_each = local.replica_instances

#   name               = "common-2-powershell-${each.key}"
#   location           = data.azurerm_resource_group.this.location
#   virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id

#   source {
#   script = <<-POWERSHELL
#     $ServerName = "${var.name[each.value]}"
#     $SqlAdminUser = "sqladmin"
#     $SqlServerAdminPassword = "password@123"
#     $FolderName = "AGfolder"
#     $FolderPath = "C:\\$FolderName"

#     # Enable Always On
#     Enable-SqlAlwaysOn -Path "SQLSERVER:\\Sql\\$ServerName\\DEFAULT" -Force

#     ${local.sql_peer_script_blocks[each.key]}
#   POWERSHELL
# }

#   depends_on = [
#     azurerm_virtual_machine_run_command.sql-vm-ha-primary-server-powershell-1
#   ]

#   tags = merge(var.vm_tags, var.tags)
# }