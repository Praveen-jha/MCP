# #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "sql-vm-ha-primary-server-powershell-1" {
  name               = "sql-vm-ha-primary-server-powershell-1"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this["instance-0"].id
  source {
    script = <<-POWERSHELL
      #Define all the required variables
      $SqlAdminUser = "sqladmin"
      $SqlServerAdminPassword = "password@123"
      $ServerName = "${var.name[0]}"
      $FolderName = "AGfolder"

      $ClusterName = "${var.cluster_name}"
      $Nodes =  @(${join(",", [for ip in local.replica_ips : "\"${ip}\""])})
      $ClusterStaticAddress = "${var.cluster_ip}"
      $StorageAccountName = ${var.storage_account_name}
      $StorageAccountAccessKey = "${data.azurerm_storage_account.this.primary_access_key}"

      #Create Failover Cluster
      New-Cluster -Name $ClusterName -Node $Nodes -StaticAddress $ClusterStaticAddress -NoStorage -AdministrativeAccessPoint DNS -ManagementPointNetworkType Singleton

      #Set Cluster Quorum
      Set-ClusterQuorum -CloudWitness -Cluster "${var.cluster_name}.products.cdk.com" -AccountName $StorageAccountName -AccessKey $StorageAccountAccessKey

      #Create a Database
      $createDatabase = @"
      CREATE DATABASE db;
      GO
      USE db;
      GO
      CREATE TABLE dbo.emp 
      ( 
          ID int IDENTITY(1,1) NOT NULL, 
          FirstName varchar(50), 
          LastName varchar(50) 
      );
      GO
      INSERT INTO emp (FirstName, LastName) VALUES ('John', 'Doe');
      INSERT INTO emp (FirstName, LastName) VALUES ('Jane', 'Doe');
      GO
      "@

      # Execute the SQL commands
      sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createDatabase

      # Create backup of the Database
      sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q "BACKUP DATABASE [db] TO DISK='C:\$FolderName\db.bak' WITH FORMAT"

    POWERSHELL
  }
  depends_on = [
    azurerm_virtual_machine_run_command.sql-vm-ha-common-powershell-1
  ]

  tags = merge(var.vm_tags, var.tags)
}

# resource "azurerm_virtual_machine_run_command" "sql-vm-ha-primary-server-powershell-test1" {
#   name               = "sql-vm-ha-primary-server-powershell-4"
#   location           = data.azurerm_resource_group.this.location
#   virtual_machine_id = azurerm_windows_virtual_machine.this["instance-0"].id
#   run_as_user        = "test"
#   run_as_password    = "password@123"
#   source {
#     script = <<-POWERSHELL
#       #Define all the required variables
#       $SqlAdminUser = "sqladmin"
#       $SqlServerAdminPassword = "password@123"
#       $ServerName = "${var.name[0]}"
#       $FolderName = "AGfolder"

#       $ClusterName = "${var.cluster_name}"
#       $Nodes =  @(${join(",", [for ip in local.replica_ips : "\"${ip}\""])})
#       $ClusterStaticAddress = "${var.cluster_ip}"
#       $StorageAccountName = ${var.storage_account_name}
#       $StorageAccountAccessKey = "${data.azurerm_storage_account.this.primary_access_key}"

#       #Create Failover Cluster
#       New-Cluster -Name $ClusterName -Node $Nodes -StaticAddress $ClusterStaticAddress -NoStorage -AdministrativeAccessPoint DNS -ManagementPointNetworkType Singleton

#       #Set Cluster Quorum
#       Set-ClusterQuorum -CloudWitness -Cluster "${var.cluster_name}.products.cdk.com" -AccountName $StorageAccountName -AccessKey $StorageAccountAccessKey

#       #Create a Database
#       $createDatabase = @"
#       CREATE DATABASE db;
#       GO
#       USE db;
#       GO
#       CREATE TABLE dbo.emp 
#       ( 
#           ID int IDENTITY(1,1) NOT NULL, 
#           FirstName varchar(50), 
#           LastName varchar(50) 
#       );
#       GO
#       INSERT INTO emp (FirstName, LastName) VALUES ('John', 'Doe');
#       INSERT INTO emp (FirstName, LastName) VALUES ('Jane', 'Doe');
#       GO
#       "@

#       # Execute the SQL commands
#       sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createDatabase

#       # Create backup of the Database
#       sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q "BACKUP DATABASE [db] TO DISK='C:\$FolderName\db.bak' WITH FORMAT"

#     POWERSHELL
#   }
#   depends_on = [
#     azurerm_virtual_machine_run_command.sql-vm-ha-common-powershell-1
#   ]

#   tags = merge(var.vm_tags, var.tags)
# }

# resource "azurerm_virtual_machine_run_command" "sql-vm-ha-primary-server-powershell-test2" {
#   name               = "sql-vm-ha-primary-server-powershell-6"
#   location           = data.azurerm_resource_group.this.location
#   virtual_machine_id = azurerm_windows_virtual_machine.this["instance-0"].id
#   run_as_user        = "test"
#   run_as_password    = "password@123"
#   source {
#     script = <<-POWERSHELL
#       $ClusterName = "${var.cluster_name}"
#       $Nodes =  @("10.0.0.5", "10.0.0.7", "10.0.0.6", "10.0.0.4")
#       $ClusterStaticAddress = "${var.cluster_ip}"
#       #Create Failover Cluster
#       New-Cluster -Name $ClusterName -Node $Nodes -StaticAddress $ClusterStaticAddress -NoStorage -AdministrativeAccessPoint DNS -ManagementPointNetworkType Singleton

#     POWERSHELL
#   }
#   depends_on = [
#     azurerm_virtual_machine_run_command.sql-vm-ha-common-powershell-1
#   ]

#   tags = merge(var.vm_tags, var.tags)
# }