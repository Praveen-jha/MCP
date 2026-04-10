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
# Creating Role Assignment for contributor
# ......................................................

module "role_assignment_contributor" {
  count                = length(local.contributor_principal_id)
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.contributor_role_name
  scope                = "/subscriptions/d3d875d1-2584-4937-9413-68435881e844"
  principal_id         = element(local.contributor_principal_id, count.index)
}

# ......................................................
# Creating Role Assignment for Owner
# ......................................................

module "role_assignment_owner" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.owner_role_name
  scope                = "/subscriptions/d3d875d1-2584-4937-9413-68435881e844"
  principal_id         = local.owner_principal_id
}

# ......................................................
# Creating Role Assignment Storage Blob Data Contributor
# ......................................................

module "role_assignment_sa_naren" {
  source               = "../../../Modules/roleAssignment"
  role_definition_name = local.sa_role_name
  scope                = "/subscriptions/d3d875d1-2584-4937-9413-68435881e844/resourceGroups/ict-platform-hrbot-prod-data-rg/providers/Microsoft.Storage/storageAccounts/narenstorageac"
  principal_id         = local.owner_principal_id
}