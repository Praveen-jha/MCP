#Creation of Data Disks
module "data_disks" {
  source                         = "../../module/terraform-azure-data-disk-module"
  for_each                       = local.sql_disks_config
  data_disk_name                 = each.value.name
  data_disk_location             = var.location
  data_disk_rg_name              = data.azurerm_resource_group.existing_resource_group_sql_vm[0].name
  data_disk_storage_account_type = each.value.disk_type
  data_disk_zone                 = each.value.zone
  data_disk_size_gb              = each.value.size_gb
  data_disk_iops_read_write      = each.value.iops
  data_disk_mbps_read_write      = each.value.throughput
  data_disk_tags                 = var.tags
}

#Creation of Windows Virtual Machine
module "virtual_machine" {
  source = "../../module/terraform-azure-vritual-machine-module"
  // Virtual Machine Configuration
  windows_vm_name                    = var.virtual_machine_config.name
  windows_vm_rg_name                 = data.azurerm_resource_group.existing_resource_group_sql_vm[0].name
  windows_vm_location                = var.location
  windows_vm_size                    = var.virtual_machine_config.vm_size
  windows_vm_admin_username          = var.virtual_machine_config.admin_username
  windows_vm_admin_password          = var.virtual_machine_config.admin_password
  windows_vm_computer_name           = var.virtual_machine_config.computer_name
  windows_vm_tags                    = var.tags
  windows_vm_vm_zone                 = var.virtual_machine_config.windows_vm_vm_zone
  windows_vm_availability_zone       = var.virtual_machine_config.windows_vm_availability_zone
  windows_vm_os_caching              = var.virtual_machine_config.caching
  windows_vm_os_storage_account_type = var.virtual_machine_config.storage_account_type
  windows_vm_os_disk_size_gb         = var.virtual_machine_config.disk_size_gb
  windows_vm_publisher               = var.virtual_machine_config.publisher
  windows_vm_offer                   = var.virtual_machine_config.offer
  windows_vm_sku                     = var.virtual_machine_config.sku
  windows_vm_image_version           = var.virtual_machine_config.version
  windows_vm_identity_type           = var.virtual_machine_config.identity_type

  // NIC Configuration
  network_interface_card_name                          = local.network_interface_name
  network_interface_card_location                      = var.location
  network_interface_card_rg_name                       = data.azurerm_resource_group.existing_resource_group_sql_vm[0].name
  network_interface_card_ip_configuration_name         = local.nic_ip_configuration_name
  network_interface_card_tags                          = var.tags
  network_interface_card_private_ip_address_allocation = var.virtual_machine_config.private_ip_address_allocation
  network_interface_card_subnet_id                     = data.azurerm_subnet.existing_compute_subnet[0].id

  depends_on = [module.data_disks]
}

module "data_disk_attachment" {
  source                            = "../../module/terraform-azure-data-disk-attachment-module"
  for_each                          = local.sql_disks_config
  virtual_machine_id                = module.virtual_machine.windows_vm_id
  managed_disk_id                   = module.data_disks[each.key].managed_disk_id
  virtual_machine_data_disk_lun     = each.value.lun
  virtual_machine_data_disk_caching = each.value.caching
  depends_on                        = [module.data_disks, module.virtual_machine]
}

# main.tf

#Creation of SQL Virtual Machine
module "sql_virtual_machine" {
  source                             = "../../module/terraform-azure-mssql_virtual-machine-module"
  mssql_vm_virtual_machine_id        = module.virtual_machine.windows_vm_id
  mssql_vm_sql_license_type          = var.sql_vm_config.sql_license_type
  mssql_vm_sqlAuthenticationLogin    = var.sql_vm_config.sql_authentication_login
  mssql_vm_sqlAuthenticationPassword = var.sql_vm_config.sql_authentication_password
  mssql_vm_sqlConnectivityType       = var.sql_vm_config.sql_connectivity_type
  mssql_vm_sqlPortNumber             = var.sql_vm_config.sql_port_number

  # Pass the newly constructed local variable instead of the input variable
  mssql_vm_storage_configuration = local.final_mssql_vm_storage_configuration

  mssql_vm_tags    = var.tags
  data_disk_luns   = local.data_disk_luns
  log_disk_luns    = local.log_disk_luns
  tempdb_disk_luns = local.tempdb_disk_luns
  depends_on       = [module.virtual_machine, module.data_disk_attachment]
}


resource "azuread_directory_role" "directory_reader_role" {

  display_name = "Directory Readers"
  depends_on = [
    module.sql_virtual_machine
  ]
}

resource "azuread_directory_role_assignment" "directory_reader_role_assignment" {

  role_id             = azuread_directory_role.directory_reader_role.template_id
  principal_object_id = module.virtual_machine.windows_vm_identity.principal_id

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

resource "azapi_update_resource" "enable_sql_entra_authentication" {
  type        = "Microsoft.SqlVirtualMachine/sqlVirtualMachines@2023-10-01"
  resource_id = module.sql_virtual_machine.mssql_vm_id
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
    module.sql_virtual_machine,
    time_sleep.wait_for_managed_identity_permissions,
    azuread_directory_role_assignment.directory_reader_role_assignment
  ]
}


resource "azurerm_virtual_machine_extension" "tcpip_domain" {

  name                 = "set-dns-suffix"
  virtual_machine_id   = module.virtual_machine.windows_vm_id
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
  name                       = var.virtual_machine_config.name
  virtual_machine_id         = module.virtual_machine.windows_vm_id
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

resource "azurerm_virtual_machine_run_command" "sql_entra_logins" {
  name               = "configure-sql-entra-logins"
  virtual_machine_id = module.virtual_machine.windows_vm_id
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
    module.sql_virtual_machine,
    azurerm_virtual_machine_extension.aad_login,
    azapi_update_resource.enable_sql_entra_authentication,
    time_sleep.wait_for_aad
  ]
}

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