# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "this" {
  name                = "vnic-${var.prefix}-${var.name}"
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
  zone                 = var.vm_zone
  disk_iops_read_write = each.value.iops
  disk_mbps_read_write = each.value.throughput
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "data_log_disk_attachment" {
  for_each           = local.dynamic_disks_config
  managed_disk_id    = azurerm_managed_disk.data_log_disks[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
  lun                = each.value.lun
  caching            = each.value.caching
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "tempdb_disk" {
  name                 = "vmd-${var.prefix}-${var.name}-tempdb-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  zone                 = var.vm_zone
  disk_size_gb         = var.db_tempdb_size_gb
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "tempdb_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.tempdb_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
  lun                = var.db_data_number_of_disks + var.db_log_number_of_disks + 1
  caching            = "ReadWrite" # Optimal for tempdb
}

## 1) Firstly Windows Virtual Machine will be created 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
resource "azurerm_windows_virtual_machine" "this" {
  name                = var.name
  timezone            = var.timezone_id
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = "adminuser"
  admin_password      = random_password.password.result
  computer_name       = var.name

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
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

  source_image_id      = var.image_version != "sql2022-ws2022" ? data.azurerm_shared_image_version.latest.id : null
  disk_controller_type = var.disk_controller_type
  identity {
    type = "SystemAssigned"
  }

  zone         = var.availability_zone ? var.vm_zone : null
  license_type = "Windows_Server"

  tags = merge(
    var.vm_tags,
    var.tags
  )
}

# Time delay to ensure VM is fully ready
resource "time_sleep" "wait_for_vm_boot" {
  depends_on = [
    azurerm_windows_virtual_machine.this
  ]
  create_duration = "120s"
}

## 2) then SQL on VM will get created, which will install the IaaS extension (Microsoft.SqlServer.Management.SqlIaaSAgent) on Windows VM by itself.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine
resource "azurerm_mssql_virtual_machine" "this" {
  virtual_machine_id               = azurerm_windows_virtual_machine.this.id
  sql_license_type                 = var.sql_license_type
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = random_password.sql_password.result
  sql_connectivity_update_username = "sqladmin"

  storage_configuration {
    disk_type             = "NEW"
    storage_workload_type = "GENERAL"
    data_settings {
      default_file_path = var.db_data_path
      luns              = local.dynamic_disk_luns.data
    }
    log_settings {
      default_file_path = var.db_log_path
      luns              = local.dynamic_disk_luns.log
    }

    temp_db_settings {
      default_file_path = var.db_tempdb_path
      luns              = [azurerm_virtual_machine_data_disk_attachment.tempdb_disk_attachment.lun]
    }
  }

  # Keep your critical performance settings
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

  lifecycle { # PCI-7487: Prevent recreation of SQL VM, added by Marabut
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
  role_id             = azuread_directory_role.directory_reader_role.template_id
  principal_object_id = azurerm_windows_virtual_machine.this.identity[0].principal_id

  depends_on = [
    azuread_directory_role.directory_reader_role
  ]
}

# Wait for Managed Identity Permissions to complete
resource "time_sleep" "wait_for_managed_identity_permissions" {
  depends_on = [
    azuread_directory_role_assignment.directory_reader_role_assignment
  ]
  create_duration = "60s"
}

## 4) then Entra Authentication will get enabled for SQL VM.
resource "azapi_update_resource" "enable_sql_entra_authentication" {
  type        = "Microsoft.SqlVirtualMachine/sqlVirtualMachines@2023-10-01"
  resource_id = azurerm_mssql_virtual_machine.this.id
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
  name                 = "set-dns-suffix"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = jsonencode({
    commandToExecute = "powershell.exe -ExecutionPolicy Unrestricted -Command \"reg.exe add HKLM\\SYSTEM\\CurrentControlSet\\services\\Tcpip\\Parameters /v 'Domain' /t REG_SZ /d 'products.cdk.com' /f\""
  })

  depends_on = [
    azapi_update_resource.enable_sql_entra_authentication
  ]
}

## 6) then AAD Login will be created using VM Extension
resource "azurerm_virtual_machine_extension" "aad_login" {
  name                       = "vm-${var.prefix}-${var.name}-AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.this.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = false # Disable auto-upgrade to avoid conflicts
  settings = jsonencode({
    mdmId = ""
  })
  depends_on = [
    azurerm_virtual_machine_extension.tcpip_domain
  ]
}

# Wait for AAD login to complete
resource "time_sleep" "wait_for_aad" {
  depends_on = [
    azurerm_virtual_machine_extension.aad_login
  ]
  create_duration = "60s"
}

## 7) Create Entra login and assign sysadmin server role for SQL Server (PCI-7487) - Added by Marabut
resource "azurerm_virtual_machine_run_command" "sql_entra_logins" {
  name               = "configure-sql-entra-logins"
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
  location           = var.location

  source {
    script = <<EOT
      $sqlAdminUser = 'sqladmin';
      $sqlAdminPassword = '${random_password.sql_password.result}';
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

## Other resources below

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "sql_password" {
  length      = 30
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}
