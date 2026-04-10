location = "Central US"
tags     = { environment = "dev" }

# values for the variables defined in the Workload 
name_config = {
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "01"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  kv_resource_group_creation              = "existing"
}

new_kv_resource_group_name = "rg-mr-crm-dev-cus-01"

# existing resources values to fetch - existing network.

existing_resource_group_kv_name              = "rg-mr-crm-dev-cus-01" //Not required if deploying new Resource Group
existing_resource_group_virtual_network_name = "rg-mr-crm-dev-vnet-cus-01"
existing_virtual_network_name                = "vnet-mr-crm-dev-cus-01"
existing_private_endpoint_subnet_name        = "snet-mr-crm-dev-pep-cus-01"

#Key Vault Private Network Accesss
public_network_access_enabled = true

keyvault_mapping = {
  kv1 = {
    name = "kv-cdk-crm"

    key_vault_config = {
      sku_name                    = "standard"
      enabled_for_disk_encryption = true
      create_kv                   = true
      soft_delete_retention_days  = 7
      enable_rbac_authorization   = true
      purge_protection_enabled    = true
    }
  }

  kv2 = {
    name = "kv-cdk-crm"

    key_vault_config = {
      sku_name                    = "standard"
      enabled_for_disk_encryption = false
      create_kv                   = true
      soft_delete_retention_days  = 7
      enable_rbac_authorization   = true
      purge_protection_enabled    = true
    }
  }
}


keyvault_private_endpoint_config = {
  enable_private_dns_zone_group = true
  private_dns_zone_ids          = [""]
}

key_vault_roles = ["Key Vault Secrets Officer","Key Vault Administrator", "Key Vault Crypto User", "Key Vault Reader"]