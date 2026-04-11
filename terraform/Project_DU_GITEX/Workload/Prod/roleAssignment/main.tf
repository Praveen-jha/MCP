# ......................................................
# Creating Role Assignment for key vault
# ......................................................

module "role_assignment_kv_secrets_officer" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_secrets_officer_role_name
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on           = [module.role_assignment_kv_access_admin]
}

# ......................................................
# Creating Role Assignment for key vault
# ......................................................

module "role_assignment_kv_access_admin" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_access_admin_role_name
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = data.azurerm_client_config.current.object_id
}

# ......................................................
# Creating Role Assignment for key vault
# ......................................................

module "role_assignment_kv_secret_user" {
  count                = length(local.kv_secret_user_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_secret_user_role_name
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = element(local.kv_secret_user_principal_id, count.index)
  depends_on           = [module.role_assignment_kv_access_admin]
}

# ......................................................
# Creating Role Assignment for key vault
# ......................................................

module "role_assignment_kv_crypto_officer" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_secret_crypto_officer
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = data.azurerm_client_config.current.object_id
}

# ......................................................
# Assigns the specified role at the **subscription level** to a given principal (e.g., service principal or user).
# ......................................................

module "role_assignment_subscription" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.role_assignment_subscription
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = local.contributor_principal_id
}

# ......................................................
# Grants **Storage Blob Data Contributor** role to a User Assigned Managed Identity (UMI) at the storage account level.
# ......................................................

module "role_assignment_blob_data_contributor_umid" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.role_storage_blob_data_contributor
  scope                = data.azurerm_storage_account.storage_account.id  
  principal_id         = data.azurerm_user_assigned_identity.umid.principal_id
}

# ......................................................
# Assigns **Storage Blob Data Contributor** role to the current service principal at the storage account level.
# ......................................................

module "role_assignment_blob_data_contributor_sp" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.role_storage_blob_data_contributor
  scope                = data.azurerm_storage_account.storage_account.id  
  principal_id         = data.azurerm_client_config.current.object_id
}

# Grants **Storage Blob Data Reader** role to a specific user at the storage account level.
module "role_assignment_blob_data_reader_user" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.role_stoarge_blob_data_reader
  scope                = data.azurerm_storage_account.storage_account.id  
  principal_id         = local.storage_blob_data_reader_user_id
}

# Grants **Key Vault Secrets Officer** role to the user-assigned managed identity at the Key Vault level.
module "role_assignment_kv_secrets_officer_umid" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.kv_secrets_officer_role_name
  scope                = data.azurerm_key_vault.kv.id
  principal_id         = data.azurerm_user_assigned_identity.umid.principal_id
}

# Grants **Storage Blob Data Contributor** role to the current client at the tfstate storage account level.
module "role_assignment_tfstate_blob_data_contributor" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.role_storage_blob_data_contributor
  scope                = data.azurerm_storage_account.tfstate_stoarge.id
  principal_id         = data.azurerm_client_config.current.object_id
}

# ......................................................
# Assigns the specified role at the **subscription level** to a given principal (e.g., service principal or user).
# ......................................................
module "owner_role_assignment_subscription" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.owner_role_assignment_subscription
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = local.subscription_contributor_principal_id
}