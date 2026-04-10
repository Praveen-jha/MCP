resource "azurerm_storage_account" "cloud_witness_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_mssql_virtual_machine_group" "sql_vm_group" {
  name                = var.failover_cluster_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sql_image_offer     = var.sql_server_image_type
  sql_image_sku       = lower(var.sql_server_sku) == "sqldev" ? "Developer" : var.sql_server_sku

  wsfc_domain_profile {
    fqdn                           = "cdkglobal.org"
    storage_account_url            = azurerm_storage_account.cloud_witness_storage.primary_blob_endpoint
    storage_account_primary_key    = azurerm_storage_account.cloud_witness_storage.primary_access_key
    cluster_subnet_type            = var.cluster_subnet_type
    cluster_bootstrap_account_name = "vm"
    cluster_operator_account_name  = "vm"
    sql_service_account_name       = "vm"
  }
  depends_on = [
    azurerm_storage_account.cloud_witness_storage
  ]
}

data "azurerm_virtual_machine" "vm" {
  count               = length(var.vm_names)
  name                = var.vm_names[count.index]
  resource_group_name = var.resource_group_name
}

resource "azurerm_mssql_virtual_machine" "sql_vm" {
  count                        = length(var.vm_names)
  virtual_machine_id           = data.azurerm_virtual_machine.vm[count.index].id
  sql_virtual_machine_group_id = azurerm_mssql_virtual_machine_group.sql_vm_group.id
  sql_license_type             = var.sql_license_type

  wsfc_domain_credential {
    cluster_bootstrap_account_password = var.domain_user_password
    sql_service_account_password       = var.domain_user_password
    cluster_operator_account_password  = var.domain_user_password
  }
  sql_connectivity_port            = var.sqlPortNumber
  sql_connectivity_type            = var.sqlConnectivityType
  sql_connectivity_update_username = var.sqlAuthenticationLogin
  sql_connectivity_update_password = var.sqlAuthenticationPassword
  
  depends_on = [
    azurerm_mssql_virtual_machine_group.sql_vm_group
  ]
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.existing_virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnets" {
  for_each             = toset(var.subnet_names)
  name                 = each.key
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = var.resource_group_name
}

# --- SQL Availability Group Listener ---
resource "azurerm_mssql_virtual_machine_availability_group_listener" "ag_listener" {
  name                         = var.listener_name
  sql_virtual_machine_group_id = azurerm_mssql_virtual_machine_group.sql_vm_group.id
  port                         = var.sqlPortNumber
  availability_group_name      = var.availability_group

  dynamic "replica" {
    for_each = var.vm_names
    content {
      sql_virtual_machine_id = azurerm_mssql_virtual_machine.sql_vm[replica.key].id
      role                   = var.replica_role_array[replica.key]
      failover_mode          = var.replica_auto_fail_array[replica.key]
      commit                 = var.replica_sync_commit_array[replica.key]
      readable_secondary     = var.replica_readable_sec_array[replica.key]
    }
  }

  dynamic "multi_subnet_ip_configuration" {
    for_each = var.list_of_listener_ips
    content {
      private_ip_address     = multi_subnet_ip_configuration.value
      sql_virtual_machine_id = azurerm_mssql_virtual_machine.sql_vm[multi_subnet_ip_configuration.key].id
      subnet_id              = data.azurerm_subnet.existing_subnets[var.subnet_names[multi_subnet_ip_configuration.key]].id
    }
  }


  depends_on = [
    azurerm_mssql_virtual_machine.sql_vm
  ]
}
