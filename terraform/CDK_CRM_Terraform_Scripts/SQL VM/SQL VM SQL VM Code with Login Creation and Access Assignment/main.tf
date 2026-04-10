
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
resource "azurerm_managed_disk" "log_disk" {
  name                 = "vmd-${var.prefix}-${var.name}-log-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  disk_size_gb         = var.db_log_size_gb
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "log_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.log_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
  lun                = 0
  caching            = "None" # Optimal for log files
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "data_disk" {
  name                 = "vmd-${var.prefix}-${var.name}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  disk_size_gb         = var.db_data_size_gb
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
  lun                = 1
  caching            = "ReadOnly" # Optimal for data files
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
resource "azurerm_managed_disk" "tempdb_disk" {
  name                 = "vmd-${var.prefix}-${var.name}-tempdb-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.disk_sku
  create_option        = "Empty"
  disk_size_gb         = var.db_tempdb_size_gb
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment
resource "azurerm_virtual_machine_data_disk_attachment" "tempdb_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.tempdb_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
  lun                = 2
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
  admin_password      = "password@123" //random_password.password.result
  computer_name       = var.name

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  # dynamic "source_image_reference" {
  #   for_each = var.image_version == "sql2022-ws2022" ? [1] : []
  #   content {
  #     publisher = "microsoftsqlserver"
  #     offer     = "sql2022-ws2022"
  #     sku       = "enterprise-gen2"
  #     version   = "latest"
  #   }
  # }

  source_image_reference {
    publisher = "microsoftsqlserver"
    offer     = "sql2022-ws2022"
    sku       = "enterprise-gen2"
    version   = "latest"
  }

  //source_image_id = var.image_version != "sql2022-ws2022" ? data.azurerm_shared_image_version.latest.id : null

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



## 3) then SQL on VM will get created, which will install the IaaS extension (Microsoft.SqlServer.Management.SqlIaaSAgent) on Windows VM by itself.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine
resource "azurerm_mssql_virtual_machine" "this" {
  virtual_machine_id               = azurerm_windows_virtual_machine.this.id
  sql_license_type                 = var.sql_license_type
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = "password@123" //random_password.sql_password.result
  sql_connectivity_update_username = "sqladmin"

  /*
  wsfc_domain_credential {
    cluster_bootstrap_account_password = random_password.sql_password.result
    cluster_operator_account_password  = random_password.sql_password.result
    sql_service_account_password       = random_password.sql_password.result
  }
*/

  storage_configuration {
    disk_type             = "NEW"
    storage_workload_type = "GENERAL"
    data_settings {
      default_file_path = var.db_data_path
      luns              = [azurerm_virtual_machine_data_disk_attachment.data_disk_attachment.lun]
    }

    log_settings {
      default_file_path = var.db_log_path
      luns              = [azurerm_virtual_machine_data_disk_attachment.log_disk_attachment.lun]
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
    azurerm_virtual_machine_data_disk_attachment.data_disk_attachment,
    azurerm_virtual_machine_data_disk_attachment.log_disk_attachment,
    azurerm_virtual_machine_data_disk_attachment.tempdb_disk_attachment,
    # time_sleep.wait_for_aad
  ]

  lifecycle {
    ignore_changes = [tags]
  }
  tags = var.tags
}

## 4) then Role Assignment to Windows VM for Directory Readers will get created.
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

# https://learn.microsoft.com/en-us/azure/templates/microsoft.sqlvirtualmachine/2023-10-01/sqlvirtualmachines?pivots=deployment-language-bicep
## 5) then Entra Authentication will get enabled for SQL VM.
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


resource "azurerm_virtual_machine_extension" "tcpip_domain" {

  name                 = "set-dns-suffix"
  virtual_machine_id   = azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings             = <<SETTINGS
    {
      "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -Command \"reg.exe add HKLM\\SYSTEM\\CurrentControlSet\\services\\Tcpip\\Parameters /v 'Domain' /t REG_SZ /d 'products.cdk.com' /f"
    }
SETTINGS

  depends_on = [
    azapi_update_resource.enable_sql_entra_authentication
  ]
}

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
    # time_sleep.wait_for_vm_boot
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

# SSMS User Login Creation and Roles-Permissions Assignment
resource "null_resource" "sql_permissions" {

  provisioner "local-exec" {
    command = <<-EOT
      $SqlAdminUser = "${var.sql_admin_user}"
      $SqlAdminPassword = "${var.sql_admin_password}"
      $SqlServer = "${var.sql_server_name}"
      $GroupsJson = '${jsonencode(var.sql_groups)}'
      $Groups = $GroupsJson | ConvertFrom-Json

      foreach ($group in $Groups) {
          $groupName = $group.Name

          $loginCmd = "IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = N'$groupName') BEGIN CREATE LOGIN [$groupName] FROM EXTERNAL PROVIDER; END"
          sqlcmd -U $SqlAdminUser -P $SqlAdminPassword -S $SqlServer -Q $loginCmd

          foreach ($srvRole in $group.server_roles) {
              $roleCmd = "ALTER SERVER ROLE [$srvRole] ADD MEMBER [$groupName];"
              sqlcmd -U $SqlAdminUser -P $SqlAdminPassword -S $SqlServer -Q $roleCmd
          }

          foreach ($db in $group.Databases) {
              $dbName = $db.Name
              $dbCmds = @()
              $dbCmds += "USE [$dbName];"
              $dbCmds += "IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = N'$groupName') BEGIN CREATE USER [$groupName] FROM EXTERNAL PROVIDER; END"
              foreach ($dbRole in $db.Roles) {
                  $dbCmds += "ALTER ROLE [$dbRole] ADD MEMBER [$groupName];"
              }
              $fullCmd = $dbCmds -join "`n"
              sqlcmd -U $SqlAdminUser -P $SqlAdminPassword -S $SqlServer -Q $fullCmd
          }
      }
    EOT

    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ time_sleep.wait_for_aad ]
}

