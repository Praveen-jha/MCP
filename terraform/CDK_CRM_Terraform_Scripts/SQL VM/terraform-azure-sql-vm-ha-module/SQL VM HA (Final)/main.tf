# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "this" {
  for_each = local.replica_instances

  name                = "vnic-${var.prefix}-${var.name[each.value]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = merge(
    var.tags,
    var.nic_tags
  )
  ip_configuration {
    name                          = "private"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  lifecycle {
    ignore_changes = all
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "data_log_disks" {
  for_each             = local.dynamic_disks_config
  name                 = each.value.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.disk_type
  create_option        = "Empty"
  disk_size_gb         = each.value.size_gb
  zone                 = local.replica_zones_map[each.value.vm_key]
  disk_iops_read_write = each.value.iops
  disk_mbps_read_write = each.value.throughput
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "data_log_disk_attachment" {
  for_each           = local.dynamic_disks_config
  managed_disk_id    = azurerm_managed_disk.data_log_disks[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.value.vm_key].id
  lun                = each.value.lun
  caching            = each.value.caching
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "tempdb_disk" {
  for_each = local.replica_instances

  name                 = "vmd-${var.prefix}-${var.name[each.value]}-tempdb-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  zone                 = var.vm_zones[each.value]
  disk_size_gb         = var.db_tempdb_size_gb
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "tempdb_disk_attachment" {
  for_each = local.replica_instances

  managed_disk_id    = azurerm_managed_disk.tempdb_disk[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id
  lun                = var.db_data_number_of_disks + var.db_log_number_of_disks + 1
  caching            = var.db_tempdb_disk_caching
}

## 1) Firstly Windows Virtual Machine will be created 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
resource "azurerm_windows_virtual_machine" "this" {
  for_each = local.replica_instances

  name = var.name[each.value]
  // timezone            = var.timezone_id
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = "adminuser"
  admin_password      = "password@123"
  computer_name       = var.name[each.value]

  network_interface_ids = [
    azurerm_network_interface.this[each.key].id,
  ]

  os_disk {
    caching              = "ReadOnly"
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb

    dynamic "diff_disk_settings" {
      for_each = var.disk_controller_type == "NVMe" ? [1] : []
      content {
        option    = "Local"
        placement = "NvmeDisk"
      }
    }
  }


  dynamic "source_image_reference" {
    for_each = var.image_version == "sql2022-ws2022" ? [1] : []
    content {
      publisher = "microsoftsqlserver"
      offer     = "sql2022-ws2022"
      sku       = "enterprise-gen2"
      version   = "latest"
    }
  }

  //source_image_id      = var.image_version != "sql2022-ws2022" ? data.azurerm_shared_image_version.latest.id : null
  disk_controller_type = var.disk_controller_type
  identity {
    type = "SystemAssigned"
  }

  zone         = var.availability_zone ? var.vm_zones[each.value] : null
  license_type = "Windows_Server"

  tags = merge(
    var.vm_tags,
    var.tags
  )

  lifecycle {
    ignore_changes = all
  }
}

# Time delay to ensure VM is fully ready
resource "time_sleep" "wait_for_vm_boot" {
  for_each = local.replica_instances
  depends_on = [
    azurerm_windows_virtual_machine.this
  ]
  create_duration = "120s"
}

## 2) then SQL on VM will get created, which will install the IaaS extension (Microsoft.SqlServer.Management.SqlIaaSAgent) on Windows VM by itself.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine
resource "azurerm_mssql_virtual_machine" "this" {
  for_each = local.replica_instances

  virtual_machine_id               = azurerm_windows_virtual_machine.this[each.key].id
  sql_license_type                 = var.sql_license_type
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = "password@123"
  sql_connectivity_update_username = "sqladmin"

  storage_configuration {
    disk_type             = "NEW"
    storage_workload_type = "GENERAL"
    data_settings {
      default_file_path = var.db_data_path
      luns              = local.dynamic_disk_luns[each.key].data
    }
    log_settings {
      default_file_path = var.db_log_path
      luns              = local.dynamic_disk_luns[each.key].log
    }

    temp_db_settings {
      default_file_path = var.db_tempdb_path
      luns              = [azurerm_virtual_machine_data_disk_attachment.tempdb_disk_attachment[each.key].lun]
    }
  }

  sql_instance {
    adhoc_workloads_optimization_enabled = true
    collation                            = var.collation
    instant_file_initialization_enabled  = true
    lock_pages_in_memory_enabled         = true
  }

  depends_on = [
    azurerm_windows_virtual_machine.this,
    azurerm_virtual_machine_data_disk_attachment.data_log_disk_attachment,
    azurerm_virtual_machine_data_disk_attachment.tempdb_disk_attachment,
  ]

  lifecycle {
    ignore_changes = all
  }

  tags = var.tags
}

## 3) then Role Assignment to Windows VM for Directory Readers will get created.
resource "azuread_directory_role" "directory_reader_role" {
  display_name = "Directory Readers"
  depends_on = [
    azurerm_mssql_virtual_machine.this
  ]
}

resource "azuread_directory_role_assignment" "directory_reader_role_assignment" {
  for_each = local.replica_instances

  role_id             = azuread_directory_role.directory_reader_role.template_id
  principal_object_id = azurerm_windows_virtual_machine.this[each.key].identity[0].principal_id

  depends_on = [
    azuread_directory_role.directory_reader_role
  ]
}

# Wait for Managed Identity Permissions to complete
resource "time_sleep" "wait_for_managed_identity_permissions" {
  for_each = local.replica_instances

  depends_on = [
    azuread_directory_role_assignment.directory_reader_role_assignment
  ]
  create_duration = "60s"
}

## 4) then Entra Authentication will get enabled for SQL VM.
resource "azapi_update_resource" "enable_sql_entra_authentication" {
  for_each = local.replica_instances

  type        = "Microsoft.SqlVirtualMachine/sqlVirtualMachines@2023-10-01"
  resource_id = azurerm_mssql_virtual_machine.this[each.key].id
  body = {
    properties = {
      serverConfigurationsManagementSettings = {
        azureAdAuthenticationSettings = {
          clientId = ""
        }
      }
    }
  }
  depends_on = [
    azurerm_mssql_virtual_machine.this,
    time_sleep.wait_for_managed_identity_permissions,
    azuread_directory_role_assignment.directory_reader_role_assignment
  ]
}

## 5) then the tcpip_domain extension (Microsoft.Compute) will get created to set DNS suffix to "products.cdk.com".
resource "azurerm_virtual_machine_extension" "tcpip_domain" {
  for_each = local.replica_instances

  name                 = "set-dns-suffix-${each.key}"
  virtual_machine_id   = azurerm_windows_virtual_machine.this[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = jsonencode({
    commandToExecute = "powershell.exe -ExecutionPolicy Unrestricted -Command \"reg.exe add HKLM\\SYSTEM\\CurrentControlSet\\services\\Tcpip\\Parameters /v 'Domain' /t REG_SZ /d 'products.cdk.com' /f\""
  })

  depends_on = [
    //azapi_update_resource.enable_sql_entra_authentication
    azuread_directory_role.directory_reader_role
  ]
}

## 6) then AAD Login will be created using VM Extension
resource "azurerm_virtual_machine_extension" "aad_login" {
  for_each = local.replica_instances

  name                       = "vm-${var.prefix}-${var.name[each.value]}-AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[each.key].id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = false
  settings = jsonencode({
    mdmId = ""
  })
  depends_on = [
    azurerm_virtual_machine_extension.tcpip_domain
  ]
}

# Wait for AAD login to complete
resource "time_sleep" "wait_for_aad" {
  for_each = local.replica_instances

  depends_on = [
    azurerm_virtual_machine_extension.aad_login
  ]
  create_duration = "60s"
}

# 7) Create Entra login and assign sysadmin server role for SQL Server (PCI-7487) - Added by Marabut
resource "azurerm_virtual_machine_run_command" "sql_entra_logins" {
  for_each = local.replica_instances

  name               = "configure-sql-entra-logins-${each.key}"
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id
  location           = var.location

  source {
    script = <<-EOT
      $sqlAdminUser = 'sqladmin';
      $sqlAdminPassword = '${random_password.sql_password[each.key].result}';
      $sqlServer = 'localhost';
      $errorLog = 'C:\\Temp\\sql_entra_logins_error.log';
      New-Item -ItemType Directory -Force -Path 'C:\\Temp' | Out-Null;
      $maxRetries = 3;
      $retryDelay = 10;
      $groupName = '${var.sql_sysadmin_group_name}';

      if ($groupName -ne '' -and $groupName -ne $null) {
        try {
          $loginCmd = "IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = N'$groupName') BEGIN CREATE LOGIN [$groupName] FROM EXTERNAL PROVIDER; END";
          $retryCount = 0;
          do {
            $loginResult = sqlcmd -U $sqlAdminUser -P $sqlAdminPassword -S $sqlServer -Q $loginCmd 2>&1 | Out-String;
            if ($LASTEXITCODE -eq 0) { break }
            Add-Content -Path $errorLog -Value "Retry $($retryCount + 1) for login $groupName : $loginResult";
            Start-Sleep -Seconds $retryDelay;
            $retryCount++;
          } while ($retryCount -lt $maxRetries);
          if ($LASTEXITCODE -ne 0) { Add-Content -Path $errorLog -Value "Failed to create login for $groupName after $maxRetries retries : $loginResult" };

          $roleCmd = "ALTER SERVER ROLE [sysadmin] ADD MEMBER [$groupName];";
          $retryCount = 0;
          do {
            $roleResult = sqlcmd -U $sqlAdminUser -P $sqlAdminPassword -S $sqlServer -Q $roleCmd 2>&1 | Out-String;
            if ($LASTEXITCODE -eq 0) { break }
            Add-Content -Path $errorLog -Value "Retry $($retryCount + 1) for sysadmin role on $groupName : $roleResult";
            Start-Sleep -Seconds $retryDelay;
            $retryCount++;
          } while ($retryCount -lt $maxRetries);
          if ($LASTEXITCODE -ne 0) { Add-Content -Path $errorLog -Value "Failed to assign sysadmin role to $groupName after $maxRetries retries : $roleResult" };

          Add-Content -Path $errorLog -Value 'Script completed successfully';
        } catch {
          Add-Content -Path $errorLog -Value "Unexpected error : $_";
          exit 1;
        }
      } else {
        Add-Content -Path $errorLog -Value 'No sysadmin group name provided; skipping configuration.';
      }
EOT
  }

  depends_on = [
    azurerm_mssql_virtual_machine.this,
    azurerm_virtual_machine_extension.aad_login,
    azapi_update_resource.enable_sql_entra_authentication,
    time_sleep.wait_for_aad
  ]
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "config_for_secure_winrm" {
  for_each = local.replica_instances

  name               = "config-for-secure-winrm-${each.key}"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id

  source {
    script = <<-POWERSHELL
      Start-Transcript
      #Remove the Reg key we added for TCPIP to make AAD Extenstion working
      Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name Domain -Value ""

      # Create cert with domain name
      $cert = New-SelfSignedCertificate -DnsName "*.products.cdk.com" -CertStoreLocation Cert:\LocalMachine\My

      # Remove old HTTPS listener
      Get-ChildItem WSMan:\localhost\Listener  | ? {$_.keys -like "*https*" } |  remove-item -Confirm:$false -Force -Recurse

      # Prep for new listener
      $valueset = @{
          Hostname = "*.products.cdk.com"
          CertificateThumbprint = $cert.thumbprint
      }
      $selectorset = @{
          Transport = "HTTPS"
          Address = "*"
      }

      # Create new listener
      New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset

      # Set Registry Key
      $token_path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
      $token_prop_name = "LocalAccountTokenFilterPolicy"
      $token_key = Get-Item -Path $token_path
      $token_value = $token_key.GetValue($token_prop_name, $null)
      if ($token_value -ne 1) {
          Write-Verbose "Setting LocalAccountTOkenFilterPolicy to 1"
          if ($null -ne $token_value) {
              Remove-ItemProperty -Path $token_path -Name $token_prop_name
          }
          New-ItemProperty -Path $token_path -Name $token_prop_name -Value 1 -PropertyType DWORD > $null
      }

      # Enable Cred SSP
      $credsspAuthSetting = Get-ChildItem WSMan:\localhost\Service\Auth | Where-Object { $_.Name -eq "CredSSP" }
      If (($credsspAuthSetting.Value) -eq $false) {
        Enable-WSManCredSSP -role server -Force
      }
      Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name Domain -Value "products.cdk.com"
      Stop-Transcript
    POWERSHELL
  }
  depends_on = [
    azurerm_mssql_virtual_machine.this,
    azurerm_virtual_machine_extension.aad_login,
    # azapi_update_resource.enable_sql_entra_authentication,
    time_sleep.wait_for_aad
  ]

  tags = merge(var.vm_tags, var.tags)
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "restart_host" {
  for_each = local.replica_instances

  name               = "restart-host-${each.key}"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id

  source {
    script = <<-POWERSHELL
      Restart-Computer
    POWERSHELL
  }
  depends_on = [
    azurerm_virtual_machine_run_command.config_for_secure_winrm
  ]

  lifecycle {
    ignore_changes = all
  }

  tags = merge(var.vm_tags, var.tags)
}

# Wait for AAD login to complete
resource "time_sleep" "wait_for_restart_host" {
  for_each = local.replica_instances

  depends_on = [
    azurerm_virtual_machine_run_command.restart_host
  ]
  create_duration = "60s"
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "sql-vm-ha-common-powershell-1" {
  for_each = local.replica_instances

  name               = "common-1-powershell-${each.key}"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this[each.key].id

  source {
    script = <<-POWERSHELL
      #Define all the required variables
      $SqlAdminUser = "sqladmin"
      $SqlServerAdminPassword = "password@123"
      $ServerName = "${var.name[each.value]}"

      $FolderName = "AGfolder"
      $FolderPath = "C:\$FolderName"
      $accountName = 'NT Service\MSSQLSERVER'

      $Username = "test"
      $UserPassword = "password@123"
      $nodeName = "AGNode${each.value + 1}"
      $certificateName = "AGNode${each.value + 1}Cert"

      # Create Folder and Give permission to service account on folders
      New-Item -ItemType Directory -Path "C:\$FolderName"

      $acl = Get-Acl -Path $folderPath

      $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
          $accountName,
          "FullControl",
          "ContainerInherit,ObjectInherit",
          "None",
          "Allow"
      )

      $acl.AddAccessRule($accessRule)
      Set-Acl -Path $folderPath -AclObject $acl

      #Share the folder
      New-SmbShare -Name $FolderName -Path $FolderPath -FullAccess "Everyone"


      # Create Test User and Add user in Administrator Group

      $Password = ConvertTo-SecureString $UserPassword -AsPlainText -Force

      # Create local user
      New-LocalUser -Name $Username -Password $Password -FullName "Test User" -Description "AG Admin User"

      Add-LocalGroupMember -Group "Administrators" -Member $Username


      # Add 5022, 1433 port on VM's internal firewall & VM NSG
      New-NetFirewallRule -DisplayName "SQL-Port1-Inbound" -Name "SQL-Port1-Inbound" -Protocol TCP -LocalPort 1433 -Direction Inbound -Action Allow
      New-NetFirewallRule -DisplayName "SQL-Port2-Inbound" -Name "SQL-Port2-Inbound" -Protocol TCP -LocalPort 5022 -Direction Inbound -Action Allow
      New-NetFirewallRule -DisplayName "SQL-Port3-Inbound" -Name "SQL-Port3-Inbound" -Protocol TCP -LocalPort 59999 -Direction Inbound -Action Allow
      New-NetFirewallRule -DisplayName "SQL-Port4-Inbound" -Name "SQL-Port4-Inbound" -Protocol TCP -LocalPort 58888 -Direction Inbound -Action Allow

      New-NetFirewallRule -DisplayName "SQL-Port1-Outbound" -Name "SQL-Port1-Outbound" -Protocol TCP -LocalPort 1433 -Direction Outbound -Action Allow
      New-NetFirewallRule -DisplayName "SQL-Port2-Outbound" -Name "SQL-Port2-Outbound" -Protocol TCP -LocalPort 5022 -Direction Outbound -Action Allow
      New-NetFirewallRule -DisplayName "SQL-Port3-Outbound" -Name "SQL-Port3-Outbound" -Protocol TCP -LocalPort 59999 -Direction Outbound -Action Allow
      New-NetFirewallRule -DisplayName "SQL-Port4-Outbound" -Name "SQL-Port4-Outbound" -Protocol TCP -LocalPort 58888 -Direction Outbound -Action Allow

      # Install Failover Cluster Features and Tools
      Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools

      #Create certificate
      $createCertificate = @"
      USE master;   
      CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'PassWOrd123!';   
      GO 
      --create a cert from the master key 
      USE master;   
      CREATE CERTIFICATE $certificateName    
        WITH SUBJECT = '$nodeName Certificate';   
      GO   
      --Backup the cert and transfer it to AGNode2 
      BACKUP CERTIFICATE $certificateName TO FILE = 'C:\$FolderName\$certificateName.crt';   
      GO 
      "@

      # Execute the SQL commands
      sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createCertificate 

      #Create mirroring endpoint
      $createMirroringEndpoint = @"
      CREATE ENDPOINT hadr_endpoint   
        STATE = STARTED   
        AS TCP (   
            LISTENER_PORT=5022   
            , LISTENER_IP = ALL   
        )    
        FOR DATABASE_MIRRORING (    
            AUTHENTICATION = CERTIFICATE $certificateName   
            , ENCRYPTION = REQUIRED ALGORITHM AES   
            , ROLE = ALL   
        );   
      GO 
      "@

      sqlcmd -U $SqlAdminUser -P $SqlServerAdminPassword -S $ServerName -Q $createMirroringEndpoint

    POWERSHELL
  }
  depends_on = [
    time_sleep.wait_for_restart_host
  ]

  tags = merge(var.vm_tags, var.tags)
}

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

# #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_run_command
resource "azurerm_virtual_machine_run_command" "sql-vm-ha-primary-server-powershell-2" {
  name               = "sql-vm-ha-primary-server-powershell-2"
  location           = data.azurerm_resource_group.this.location
  virtual_machine_id = azurerm_windows_virtual_machine.this["instance-0"].id

  source {
    script = <<-POWERSHELL
      #Define all the required variables
      $availabilityGroupName = "${var.availability_group_name}"
      $listenerName = "${var.listener_name}"
      $listenerIP = "${var.listener_ip}"
      $listenerIPName = "listener-IP"
      $clusterIP = "${var.cluster_ip}"

      $SqlAdminUser = "sqladmin"
      $SqlPrimaryServerAdminPassword = "password@123"
      $SqlSecondaryServer1AdminPassword = "password@123"
      $SqlSecondaryServer2AdminPassword = "password@123"
      $SqlSecondaryServer3AdminPassword = "password@123"

      $primaryServerName = "${var.name[0]}"
      $secondaryServer1Name = "${var.name[1]}"
      $secondaryServer2Name = "${var.name[2]}"
      $secondaryServer3Name = "${var.name[3]}"

      # Create Availability Group
      $createAvailabilityGroup = @"
      CREATE AVAILABILITY GROUP [$availabilityGroupName]
      WITH (AUTOMATED_BACKUP_PREFERENCE = SECONDARY,
      DB_FAILOVER = OFF,
      DTC_SUPPORT = NONE,
      REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT = 0)
      FOR DATABASE [db]
      REPLICA ON N'$primaryServerName' WITH (ENDPOINT_URL = N'TCP://$primaryServerName.products.cdk.com:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
        N'$secondaryServer1Name' WITH (ENDPOINT_URL = N'TCP://$secondaryServer1Name.products.cdk.com:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
        N'$secondaryServer2Name' WITH (ENDPOINT_URL = N'TCP://$secondaryServer2Name.products.cdk.com:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
        N'$secondaryServer3Name' WITH (ENDPOINT_URL = N'TCP://$secondaryServer3Name.products.cdk.com:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));

      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlPrimaryServerAdminPassword -S $primaryServerName -Q $createAvailabilityGroup

      $joinAvailabilityGroupinSecondaryServer1 = @"
      ALTER AVAILABILITY GROUP [$availabilityGroupName] JOIN;
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName] GRANT CREATE ANY DATABASE;
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlSecondaryServer1AdminPassword -S $secondaryServer1Name -Q $joinAvailabilityGroupinSecondaryServer1

      $joinAvailabilityGroupinSecondaryServer2 = @"
      ALTER AVAILABILITY GROUP [$availabilityGroupName] JOIN;
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName] GRANT CREATE ANY DATABASE;
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlSecondaryServer2AdminPassword -S $secondaryServer2Name -Q $joinAvailabilityGroupinSecondaryServer2


      $joinAvailabilityGroupinSecondaryServer3 = @"
      ALTER AVAILABILITY GROUP [$availabilityGroupName] JOIN;
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName] GRANT CREATE ANY DATABASE;
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlSecondaryServer3AdminPassword -S $secondaryServer3Name -Q $joinAvailabilityGroupinSecondaryServer3


      # Add IP Address resource for listener
      Add-ClusterResource -Name $listenerIPName -ResourceType "IP Address" -Group $availabilityGroupName

      # Set the IP resource parameters (static, no DHCP)
      Get-ClusterResource -Name $listenerIPName | Set-ClusterParameter -Multiple @{

          "Network" = "Cluster Network 1";

          "Address" = $listenerIP;

          "SubnetMask" = "255.255.255.0";

          "EnableDHCP" = 0

      }

      # Add the Network Name resource for the listener

      Add-ClusterResource -Name $listenerName -Group $availabilityGroupName -ResourceType "Network Name"

      # Set parameters on the Network Name resource (listener FQDN and RegisterAllProvidersIP)

      Get-ClusterResource -Name $listenerName | Set-ClusterParameter -Multiple @{

          "DnsName" = $listenerName;

          "RegisterAllProvidersIP" = 1

      }

      #Stop Cluster Resource  
      Stop-ClusterResource -Name $availabilityGroupName -Verbose

      # Set the Network Name resource to be dependent on the IP Address resource

      Set-ClusterResourceDependency -Resource $listenerName -Dependency "[$listenerIPName]"
      Set-ClusterResourceDependency -Resource $availabilityGroupName -Dependency "[$listenerName]"

      #Start Cluster Resource
      Start-ClusterResource -Name $availabilityGroupName -Verbose

      # Bring the listener network name resource online

      Start-ClusterResource -Name $listenerName -Verbose

      $ClusterNetworkName = "Cluster Network 1" # The cluster network name. Use Get-ClusterNetwork on Windows Server 2012 or later to find the name.

      $IPResourceName = $listenerIPName # The IP address resource name.

      $ListenerILBIP = $listenerIP # The IP address of the internal load balancer. This is the static IP address for the load balancer that you configured in the Azure portal.

      [int]$ListenerProbePort = 59999

      Import-Module FailoverClusters

      Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ListenerILBIP";"ProbePort"=$ListenerProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"EnableDhcp"=0}

      #Take listener-IP is offline and then online again.

      Stop-ClusterResource -Name $listenerIPName -Verbose
      Start-ClusterResource -Name $listenerIPName -Verbose
      Start-ClusterResource -Name $listenerName -Verbose 


      $ClusterNetworkName = "Cluster Network 1" # The cluster network name. Use Get-ClusterNetwork on Windows Server 2012 or later to find the name.

      $IPResourceName = "Cluster IP Address" # The IP address resource name.

      $ClusterCoreIP = $clusterIP # The IP address of the cluster IP resource. This is the static IP address for the load balancer that you configured in the Azure portal.

      [int]$ClusterProbePort = 58888 # The probe port from WSFCEndPointprobe in the Azure portal. This port must be different from the probe port for the availability group listener.

      Import-Module FailoverClusters

      Get-ClusterResource $IPResourceName | Set-ClusterParameter -Multiple @{"Address"="$ClusterCoreIP";"ProbePort"=$ClusterProbePort;"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"EnableDhcp"=0}

      #Take Cluster IP Address is offline and then online again
      Stop-ClusterResource -Name $IPResourceName -Verbose
      Start-ClusterResource -Name $IPResourceName -Verbose
      Start-ClusterResource -Name "Cluster Name" -Verbose 

      Start-ClusterResource -Name $availabilityGroupName -Verbose

      #Add Listener Port
      $listenerPort = @"
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY LISTENER N'$listenerName' (PORT=1433);
      GO
      "@

      sqlcmd -U $SqlAdminUser -P $SqlPrimaryServerAdminPassword -S $primaryServerName -Q $listenerPort

      #Enable Read Only Routing
      $readOnlyRouting = @"
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer2Name' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$secondaryServer2Name.products.cdk.com:1433'))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer3Name' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$secondaryServer3Name.products.cdk.com:1433'))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$primaryServerName' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$primaryServerName.products.cdk.com:1433'))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer1Name' WITH (SECONDARY_ROLE(READ_ONLY_ROUTING_URL = N'TCP://$secondaryServer1Name.products.cdk.com:1433'))
      GO

      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer2Name' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$primaryServerName',N'$secondaryServer1Name',N'$secondaryServer3Name')))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer3Name' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$primaryServerName',N'$secondaryServer1Name',N'$secondaryServer2Name')))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$primaryServerName' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$secondaryServer1Name',N'$secondaryServer2Name',N'$secondaryServer3Name')))
      GO
      USE [master]
      GO
      ALTER AVAILABILITY GROUP [$availabilityGroupName]
      MODIFY REPLICA ON N'$secondaryServer1Name' WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = (N'$primaryServerName',N'$secondaryServer2Name',N'$secondaryServer3Name')))
      GO

      "@
      sqlcmd -U $SqlAdminUser -P $SqlPrimaryServerAdminPassword -S $primaryServerName -Q $readOnlyRouting
    POWERSHELL
  }
  depends_on = [
    azurerm_virtual_machine_run_command.sql-vm-ha-common-powershell-2
  ]

  tags = merge(var.vm_tags, var.tags)
}

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


## Other resources below

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "password" {
  for_each    = local.replica_instances
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "sql_password" {
  for_each    = local.replica_instances
  length      = 30
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}
