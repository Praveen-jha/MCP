locals {
  location_primary = "Qatar Central"
  //configurational details of Azure Key Vault
  keyvault = {
    kv_sku_name                 = "standard" //Possible values are "standard" and "premium"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 90    //No. of Days. Possible values are between 7 and 90
    purge_protection_enabled    = false //purge protection is disabled so that keyvault can be recreated with the same name during the dev and test environment
    enable_rbac_authorization   = true
  }
  //configurational details of storage account (ADLS)
  storage_account = {
    account_tier                      = "Standard" //Possible values are "Standard" and "Premium"
    is_hns_enabled                    = true
    account_replication_type          = "ZRS"       //Possible Values are "LRS", "GRS", "RAGRS", "ZRS", "GZRS" and "RAGZRS"
    account_kind                      = "StorageV2" //Possible Values are "BlobStorage", "BlockBlobStorage", "FilStorage", "Storage" and "StorageV2"
    shared_access_key_enabled         = true
    identity_type                     = "SystemAssigned"
    infrastructure_encryption_enabled = true
  }
  //configurational details of eventhub namespace
  eventhub_namespace = {
    sku                          = "Premium" //Possible values are "Basic", "Standard" and "Premium"
    capacity                     = 1
    local_authentication_enabled = true
    auto_inflate_enabled         = false
    max_throughput_units         = 0 //Possible values between 1 and 20
  }

  //configurational details of azure data factory
  data_factory = {
    managed_virtual_network_enabled = false
    identity_type                   = "SystemAssigned"
  }
  //configurational details of access connector for databricks
  databricks_access_connector = {
    identity_type = "SystemAssigned"
  }
  //configurational details of databricks workspace
  databricks_workspace = {
    sku                           = "premium"                //possible values are "standard", "premium" and "trial"
    databricks_nsg_rules_required = "NoAzureDatabricksRules" //possible values are "AllRules", "NoAzureDatabricksRules" and "NoAzureServiceRules"
    custom_parameters = {
      no_public_ip                                         = "true"
      virtual_network_id                                   = data.azurerm_virtual_network.vnet.id
      private_subnet_name                                  = var.databricks_container_subnet_name
      private_subnet_network_security_group_association_id = data.azurerm_subnet.databricks_container_subnet.id
      public_subnet_name                                   = var.databricks_host_subnet_name
      public_subnet_network_security_group_association_id  = data.azurerm_subnet.databricks_host_subnet.id
    }
    infrastructure_encryption_enabled = true
  }
  //configurational details of logic app
  logic_app = {
    account_tier             = "Standard"
    account_replication_type = "LRS"
    sku                      = "WS1"
    service_plan_name        = var.logic_app_service_plan_name
    os_type                  = "Windows"
    identity_type            = "SystemAssigned"
    content_share_name       = "${var.logic_app_name}-content"
    functions_worker_runtime = "node"
    private_dns_zone_ids = [
      "${var.dns_zones_id.storage_blob_id}",
      "${var.dns_zones_id.storage_file_share_id}",
      "${var.dns_zones_id.storage_table_id}",
      "${var.dns_zones_id.storage_queue_id}"
    ]
  }
  //The map defined below is for diagnostic settings
  //Add or remove diagnostic settings objects as per the deployment requirements
  //the object is defined as below - 

  diagnostic_settings = {
    data_factory = {
      name               = "diag-settings-${module.data_factory.data_factory.name}"
      target_resource_id = module.data_factory.data_factory.id
      metric             = ["AllMetrics"]
      category_group     = ["allLogs"]
    }
    databricks_workspace = {
      name               = "diag-settings-${module.databricks_workspace.databricks_workspace.name}"
      target_resource_id = module.databricks_workspace.databricks_workspace.id
      metric             = []
      category_group     = ["allLogs"]
    }
    eventhub_namespace = {
      name               = "diag-settings-${module.eventhub_namespace.eventhub_namespace.name}"
      target_resource_id = module.eventhub_namespace.eventhub_namespace.id
      metric             = ["AllMetrics"]
      category_group     = ["allLogs"]
    }
  }
  //The map defined below is for private endpoints.
  //Add new private endpoint object (or remove) as per the deployment requirements
  //The object attributes are defined as -
  # objetName = {
  #   name                            = the name with which the private endpoint is deployed on Azure
  #   subresource_name                = list of the sub-resurce type of the private endpoint to be deployed. Example - dfs, blob etc
  #   custom_network_interface_name   = name of the network interface that will be attatched to this private endpoint
  #   private_service_connection_name = name of the connection configuration of the private endpoint name.
  #   private_connection_resource_id  = resource ID of the deployed PaaS service for which this private endpoint is being created.
  #   subnet_id                       = id of the subnet where the NIC should be attatched.
  #   location                        = location where you want to deploy the private endpoint. (Not necessarily same as the PaaS service location)
  #   resource_group_name             = Name of the resource group where you want to deploy this private endpoint
  # }
  private_endpoints = {
    dataFactory = {
      name                            = var.datafactory_dataFactory_private_endpoint_name
      subresource_name                = ["dataFactory"]
      custom_network_interface_name   = "nic-${var.datafactory_dataFactory_private_endpoint_name}"
      private_service_connection_name = "datafactory-private-service-connection-01"
      private_connection_resource_id  = module.data_factory.data_factory.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
      location                        = local.location_primary
      resource_group_name             = var.rg_name
      private_dns_zone_group_name     = "rec-dataFactory-${var.data_factory_name}"
      private_dns_zone_ids            = var.dns_zones_id.dataFactory_zone_id
    }
    blob = {
      name                            = var.storage_account_blob_private_endpoint_name
      subresource_name                = ["blob"]
      custom_network_interface_name   = "nic-${var.storage_account_blob_private_endpoint_name}"
      private_service_connection_name = "blob-private-service-connection-01"
      private_connection_resource_id  = module.storage_account.storage_account.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
      location                        = local.location_primary
      resource_group_name             = var.rg_name
      private_dns_zone_group_name     = "rec-blob-${var.storage_account_name}"
      private_dns_zone_ids            = var.dns_zones_id.storage_blob_id
    }
    dfs = {
      name                            = var.storage_account_dfs_private_endpoint_name
      subresource_name                = ["dfs"]
      custom_network_interface_name   = "nic-${var.storage_account_dfs_private_endpoint_name}"
      private_service_connection_name = "dfs-private-service-connection-01"
      private_connection_resource_id  = module.storage_account.storage_account.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
      location                        = local.location_primary
      resource_group_name             = var.rg_name
      private_dns_zone_group_name     = "rec-dfs-${var.storage_account_name}"
      private_dns_zone_ids            = var.dns_zones_id.storage_dfs_id
    }
    vault = {
      name                            = var.keyvault_vault_private_endpoint_name
      subresource_name                = ["vault"]
      custom_network_interface_name   = "nic-${var.keyvault_vault_private_endpoint_name}"
      private_service_connection_name = "vault-private-service-connection-01"
      private_connection_resource_id  = module.keyvault.keyvault.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
      location                        = local.location_primary
      resource_group_name             = var.rg_name
      private_dns_zone_group_name     = "rec-vault-${var.keyvault_name}"
      private_dns_zone_ids            = var.dns_zones_id.key_vault_zone_id
    }
    ui_api = {
      name                            = var.databricks_ui_api_private_endpoint_name
      subresource_name                = ["databricks_ui_api"]
      custom_network_interface_name   = "nic-${var.databricks_ui_api_private_endpoint_name}"
      private_service_connection_name = "uiapi-private-service-connection-01"
      private_connection_resource_id  = module.databricks_workspace.databricks_workspace.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
      location                        = local.location_primary
      resource_group_name             = var.rg_name
      private_dns_zone_group_name     = "rec-databricks_ui_api-${var.databricks_workspace_name}"
      private_dns_zone_ids            = var.dns_zones_id.azure_databricks_dns_zone_id
    }
    namespace = {
      name                            = var.eventhub_namespace_private_endpoint_name
      subresource_name                = ["namespace"]
      custom_network_interface_name   = "nic-${var.eventhub_namespace_private_endpoint_name}"
      private_service_connection_name = "namespace-private-service-connection-01"
      private_connection_resource_id  = module.eventhub_namespace.eventhub_namespace.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
      location                        = local.location_primary
      resource_group_name             = var.rg_name
      private_dns_zone_group_name     = "rec-namespace-${var.eventhub_namespace_name}"
      private_dns_zone_ids            = var.dns_zones_id.service_bus_zone_id
    }
    sites = {
      name                            = var.logic_app_private_endpoint_name
      subresource_name                = ["sites"]
      custom_network_interface_name   = "nic-${var.logic_app_private_endpoint_name}"
      private_service_connection_name = "sites-private-service-connection-01"
      private_connection_resource_id  = module.logic_app.logic_app.id
      subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
      location                        = local.location_primary
      resource_group_name             = var.rg_name
      private_dns_zone_group_name     = "rec-site-${var.logic_app_name}"
      private_dns_zone_ids            = var.dns_zones_id.logicapp_zone_id
    }
  }
  databricks_browser_auth_private_endpoint = {
    name                            = var.databricks_browser_auth_private_endpoint_name
    subresource_name                = ["browser_authentication"]
    custom_network_interface_name   = "nic-${var.databricks_browser_auth_private_endpoint_name}"
    private_service_connection_name = "browser-authentication-private-service-connection-01"
    private_connection_resource_id  = module.databricks_workspace.databricks_workspace.id
    subnet_id                       = data.azurerm_subnet.private_endpoint_subnet.id
    location                        = local.location_primary
    resource_group_name             = var.rg_name
    private_dns_zone_group_name     = "rec-browser_authentication-${var.databricks_workspace_name}"
    private_dns_zone_ids            = var.dns_zones_id.azure_databricks_dns_zone_id
  }
}
